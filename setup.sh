#!/bin/bash

set -e

default=dev_env
SETUP_TYPE="${1:-$default}"
OS="$( \
  grep '^ID=.*' /etc/os-release \
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
  local ansible
  local dnf

  ansible="$(which ansible)"
  dnf="$(grep -rl "max_parallel_downloads" /etc/dnf/dnf.conf)"

  _install_deps() {
    if [ "$ansible" = '' ]; then
      sudo dnf install -y ansible git
    fi
  }

  _update_dnf_conf() {
    if [ "$dnf" = '' ]; then
      sudo sh -c 'echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf'
      sudo sh -c 'echo "fastestmirror=True" >> /etc/dnf/dnf.conf'
    fi
  }

  _update_dnf_conf

  _install_deps

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

execute "$@"
