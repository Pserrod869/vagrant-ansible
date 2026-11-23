#!/usr/bin/env bash
set -xeu

# Instalación de Ansible y herramientas auxiliares
apt-get update
apt-get install -y ansible ansible-lint whois dnsutils curl

# Copia de claves privadas de Vagrant para evitar conflictos de permisos en Windows
mkdir -p ./private_keys
cp -vf /vagrant/.vagrant/machines/dns/virtualbox/private_key ./private_keys/dns.key.rsa
cp -vf /vagrant/.vagrant/machines/negocio/virtualbox/private_key ./private_keys/negocio.key.rsa
chown -R vagrant:vagrant ./private_keys
chmod 600 ./private_keys/*

# Copia de configuración global, inventario y dependencias
cp -vf /vagrant/ansible.cfg .
chown vagrant:vagrant ./ansible.cfg

cp -vf /vagrant/inventory.yml .
chown vagrant:vagrant ./inventory.yml

cp -vf /vagrant/requirements.yml .
chown vagrant:vagrant ./requirements.yml

# Copia de los playbooks y ficheros de cada servicio
cp -vrf /vagrant/dns .
chown -R vagrant:vagrant ./dns

cp -vrf /vagrant/web .
chown -R vagrant:vagrant ./web

cp -vrf /vagrant/ftp .
chown -R vagrant:vagrant ./ftp

# Copia de la clave maestra de Ansible Vault
cp -vf /vagrant/vault_pass.txt ./.vault_pass.txt
chown vagrant:vagrant ./.vault_pass.txt
chmod 600 ./.vault_pass.txt

# Instalación de colecciones necesarias de Ansible Galaxy
su - vagrant -c "ansible-galaxy collection install -r requirements.yml"

# Ejecución de playbooks de aprovisionamiento
su - vagrant -c "ansible-playbook dns/dns.yml"
su - vagrant -c "ansible-playbook web/web.yml"
su - vagrant -c "ansible-playbook ftp/ftp.yml --vault-password-file ./.vault_pass.txt"