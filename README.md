# Ansible in a box

The purpose of this project is ship an ansible installation to run from your host.

## Warning

This container is not meant to run isolated from the host.

The scripts provided in the git repository to run the container will mount some host directories inside the container.
The $HOME/.ssh is mounted read-only and the currently directory is mounted with write access.

The user running ansible inside the container should get the same id and group id than the user running the container.

To sum-up, by using this, *it is possible to break things on your host system*. Use with care.

## Usage

```
docker pull vidiben/ansible

cd adirectory
git clone https://github.com/vidiben/docker-ansible.git
``̀

From your ansible playbook directory, you should not be able to call /a/directory/docker-ansible/ansible and ansible-playbook.
