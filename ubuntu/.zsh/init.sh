# Protect against non-zsh execution of Oh My Zsh (use POSIX syntax here)
[ -n "$ZSH_VERSION" ] || {
  # ANSI formatting function (\033[<code>m)
  # 0: reset, 1: bold, 4: underline, 22: no bold, 24: no underline, 31: red, 33: yellow
  omz_f() {
    [ $# -gt 0 ] || return
    IFS=";" printf "\033[%sm" $*
  }
  # If stdout is not a terminal ignore all formatting
  [ -t 1 ] || omz_f() { :; }

  omz_ptree() {
    # Get process tree of the current process
    pid=$$; pids="$pid"
    while [ ${pid-0} -ne 1 ] && ppid=$(ps -e -o pid,ppid | awk "\$1 == $pid { print \$2 }"); do
      pids="$pids $pid"; pid=$ppid
    done

    # Show process tree
    case "$(uname)" in
    Linux) ps -o ppid,pid,command -f -p $pids 2>/dev/null ;;
    Darwin|*) ps -o ppid,pid,command -p $pids 2>/dev/null ;;
    esac

    # If ps command failed, try Busybox ps
    [ $? -eq 0 ] || ps -o ppid,pid,comm | awk "NR == 1 || index(\"$pids\", \$2) != 0"
  }

  {
    shell=$(ps -o pid,comm | awk "\$1 == $$ { print \$2 }")
    printf "$(omz_f 1 31)Error:$(omz_f 22) Oh My Zsh can't be loaded from: $(omz_f 1)${shell}$(omz_f 22). "
    printf "You need to run $(omz_f 1)zsh$(omz_f 22) instead.$(omz_f 0)\n"
    printf "$(omz_f 33)Here's the process tree:$(omz_f 22)\n\n"
    omz_ptree
    printf "$(omz_f 0)\n"
  } >&2

  return 1
}

# If ZSH is not defined, use the current script's directory.
[[ -z "$ZSH" ]] && export ZSH="${${(%):-%x}:a:h}"

# Load all stock functions (from $fpath files) called below.
autoload -U compaudit compinit

# Set ZSH_CUSTOM to the path where your custom config files
# and plugins exists, or else we will use the default custom/
if [[ -z "$ZSH_CUSTOM" ]]; then
    ZSH_CUSTOM="$ZSH/zsh-plugins/custom"
fi

# Set default plugins to path
if [[ -z "$ZSH_PLUGINS_PATH" ]]; then
    ZSH_PLUGINS_PATH="$ZSH/zsh-plugins/plugins"
fi

is_plugin() {
  local base_dir=$1
  local name=$2
  builtin test -f $base_dir/$name/$name.plugin.zsh || builtin test -f $base_dir/$name/_$name
}

# Add all defined plugins to fpath. This must be done
# before running compinit.
for plugin ($plugins); do
  if is_plugin "$ZSH_CUSTOM" "$plugin"; then
    fpath=("$ZSH_CUSTOM/$plugin" $fpath)
  elif is_plugin "$ZSH_PLUGINS_PATH" "$plugin"; then
    fpath=("$ZSH_PLUGINS_PATH/$plugin" $fpath)
  else
    echo "plugin '$plugin' not found"
  fi
done

# Figure out the SHORT hostname
if [[ "$OSTYPE" = darwin* ]]; then
  # macOS's $HOST changes with dhcp, etc. Use ComputerName if possible.
  SHORT_HOST=$(scutil --get ComputerName 2>/dev/null) || SHORT_HOST="${HOST/.*/}"
else
  SHORT_HOST="${HOST/.*/}"
fi

# Load all of the config files in ~/oh-my-zsh that end in .zsh
# TIP: Add files you don't want in git to .gitignore
for config_file ("$ZSH"/zsh-lib/*.zsh); do
  custom_config_file="$ZSH_CUSTOM/lib/${config_file:t}"
  [[ -f "$custom_config_file" ]] && config_file="$custom_config_file"
  source "$config_file"
done
unset custom_config_file

# Load all of the plugins that were defined in ~/.zshrc
for plugin ($plugins); do
  if [[ -f "$ZSH_CUSTOM/$plugin/$plugin.plugin.zsh" ]]; then
    source "$ZSH_CUSTOM/$plugin/$plugin.plugin.zsh"
  elif [[ -f "$ZSH_PLUGINS_PATH/$plugin/$plugin.plugin.zsh" ]]; then
    source "$ZSH_PLUGINS_PATH/$plugin/$plugin.plugin.zsh"
  fi
done
unset plugin