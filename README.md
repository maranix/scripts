# Scripts

# __Install Ansible__

## __Fedora__
```bash
sudo dnf install ansible
```

## __Ubuntu, PopOS, WSL Ubuntu__
```bash
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

# 

## __Ubuntu, PopOS, WSL Ubuntu__
```git
git clone https://github.com/ramanverma2k/scripts
```

# __Execute Playbook__
## __Ubuntu, PopOS__
```bash
ansible-playbook ./setup/setup.yaml --ask-become-pass
```


## __WSL Ubuntu__
```bash
ansible-playbook ./setup/wsl-ubuntu.yaml --ask-become-pass
```