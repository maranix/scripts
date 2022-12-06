#!/bin/bash

set -e

OS=$(lsb_release -si)

install() {
  echo "Installing ansible & Executing playbook"

  case "$OS" in
    Fedora)
    set -x
    sudo dnf update -y
    sudo dnf install -y ansible
    ansible-playbook ./playbooks/fedora.yaml --ask-become-pass
    set +x
    ;;
    *)
    echo "Unsupported OS"
    ;;
  esac
}

install
