sudo ansible-playbook -i hosts 05_install_ocata_yum.yml
sudo ansible-playbook -i hosts ../41_upgrade_to_ocata.yml
sudo ansible-playbook -i hosts 07_install_pike_yum.yml
sudo ansible-playbook -i hosts ../42_upgrade_to_pike.yml
sudo ansible-playbook -i hosts 09_install_queens_yum.yml
sudo ansible-playbook -i hosts ../43_upgrade_to_queens.yml
sudo ansible-playbook -i hosts 11_install_rocky_yum.yml
sudo ansible-playbook -i hosts ../44_upgrade_to_rocky.yml
