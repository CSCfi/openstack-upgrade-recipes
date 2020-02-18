Testing the db upgrades on a "clean" VM
---------------------------------------

Requirements: a dump of the database

Tested with:
 - ansible 2.7 on EL7
 - a db with instances from 2015, running Newton (upgraded from Liberty at least, maybe further back)
   - upgraded to Rocky

Caveats: 
----
can't install MySQL-python with mariadb 10.3 installed

MySQL-python is not in upper-requirements.txt after Pike - one should use mysql+pymysql most likely

( Basically don't install mariadb 10 if you still have mysql:// db connections )

Maybe also want to tune my.cnf to improve performance

Virtualenv
-----

At first this testing was done with virtualenv, but after pip domain move in 2019 and the archival/removal of old versions 
it has not been tested. Some more details in [VIRTUALENV.MD]

Usage yum and chroot - beware, puts ~1.6GB in each version's /root/rpm/ directory
-----

setup most things:
<pre> sudo ansibe-playbook 05_install_ocata_yum.yml </pre>

import the newton database

setup most things:
<pre> sudo ansibe-playbook 05_install_ocata_yum.yml </pre>

prep the db:
<pre> sudo ansibe-playbook ../29_prep_db.yml </pre>

purge instances marked as deleted:
<pre> python nova-db-purge.py .. </pre>

upgrade the things
<pre> sudo ansibe-playbook ../41_upgrade_to_ocata.yml </pre>

fix a keystone user manually ? see ../29_prep_db.yml:
<pre> sudo ansibe-playbook ../41_upgrade_to_ocata.yml </pre>

setup most things:
<pre> sudo ansibe-playbook 07_install_pike_yum.yml </pre>
upgrade to next version:
<pre> sudo ansibe-playbook ../42_upgrade_to_ocata.yml </pre>

Manual yum and chroot example demo from newton to ocata on an monolith API node
--------

Using ansible?

```
$ virtualenv venv_ansible
$ source venv_ansible/bin/active
$ #export proxy
$ pip install -U ansible pip setuptools
$ git clone https://github.com/CSCfi/openstack-liberty-newton-upgrade
$ cd openstack-liberty-newton-upgrade
$ #git checkout branch
$ cd db_test
$ # read the 05_install_ocata_yum.yml
$ # modify it as appropriate, for a demo one can remove most things or just run the commands manually that are needed
$ # modify rpm_installroot to where you have more space?
$ # modify to not start database?
```

manual commands needed after some packages were archived..:
```
$ sudo -i
# mkdir -p rpm_ocata/var/lib/rpm    
# rpm --rebuilddb --root=/root/rpm_ocata/
# rpm -i --root=/root/rpm_ocata --nodeps http://www.nic.funet.fi/pub/Linux/INSTALL/Centos/7/os/x86_64/Packages/centos-release-7-7.1908.0.el7.centos.x86_64.rpm
# yum --installroot=/root/rpm_ocata/ install git python-devel libffi-devel openssl-devel mariadb-devel python-virtualenv MySQL-python centos-release-openstack-ocata    
# curl http://vault.centos.org/centos/7.5.1804/extras/x86_64/Packages/centos-release-openstack-ocata-1-2.el7.noarch.rpm -O
# curl http://vault.centos.org/centos/7.5.1804/extras/x86_64/Packages/centos-release-qemu-ev-1.0-3.el7.centos.noarch.rpm -O
# curl http://vault.centos.org/centos/7.5.1804/extras/x86_64/Packages/centos-release-storage-common-2-2.el7.centos.noarch.rpm -O
# curl http://vault.centos.org/centos/7.5.1804/extras/x86_64/Packages/centos-release-virt-common-1-1.el7.centos.noarch.rpm -O
# curl http://vault.centos.org/centos/7.5.1804/extras/x86_64/Packages/centos-release-ceph-jewel-1.0-1.el7.centos.noarch.rpm -O
# rpm -i --root=/root/rpm_ocata /root/centos-release-*
warning: /root/rpm_ocata/var/tmp/rpm-tmp.NUQUne: Header V3 RSA/SHA256 Signature, key ID f4a80eb5: NOKEY
# # THEN change the mirrors in /root/rpm_ocata/etc/yum.repos.d/CentOS-*openstack*.repo to your local mirror of vault_centos_org_cloud
# # change the paths to the GPG keys:
# sed -i 's#///etc#///root/rpm_ocata/etc#' /root/rpm_ocata/etc/yum.repos.d/CentOS-*.repo
# yum --installroot=/root/rpm_ocata/ install openstack-barbican openstack-cinder openstack-glance openstack-heat-common openstack-keystone openstack-magnum-common openstack-neutron openstack-nova
```

Using keystone-manage command:
```
# keystone-manage --version
10.0.3
# mount --bind /dev /root/rpm_ocata/dev
# chroot /root/rpm_ocata/
# keystone-manage --version
11.0.4
# exit
# umount /root/rpm_ocata/dev

```

Branches
---------

When releases go EOL then branch names change. This means once or twice a year would have to update the playbooks
