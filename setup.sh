#!/bin/bash

set -e

default=dev_env
SETUP_TYPE="${1:-$default}"
OS="$( \
  grep -m1 "ID=" /etc/os-release \
  | sed 's/ID=//')"

echo "Current OS is $OS"

execute() {
  echo "Configuring setup for $OS"

  case "$OS" in
    fedora)
      fedora_install
      ;;
    ubuntu)
      ubuntu_install
      ;;
    *)
      echo >&2 "Unsupported OS $*"
      exit 1
      ;;
  esac
}

fedora_install() {
  if [[ $(grep -rl "max_parallel_downloads" /etc/dnf/dnf.conf) = '' ]]; then
    update_dnf_conf
  fi

  sudo dnf install -y ansible git
  
  clear

  echo "Executing playbook"

  # TODO
  # Make this a menu choice for complete setup from scratch (fedora server + rice + dev_env) or only dev_env
  # read either from script arguments or give a prompt when no arguments have been provided
  case "$SETUP_TYPE" in
    server)
      ansible-playbook ./playbooks/fedora/server.yaml --ask-become-pass
      ;;
    dev_env)
      ansible-playbook ./playbooks/fedora/dev_env.yaml --ask-become-pass
      ;;
    rice)
      ansible-playbook ./playbooks/fedora/rice.yaml --ask-become-pass
      ;;
  esac
}

update_dnf_conf() {
  sudo sh -c 'echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf'
  sudo sh -c 'echo "fastestmirror=True" >> /etc/dnf/dnf.conf'
}

execute "$@"
