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

Usage virtualenv
-----

setup most things:
<pre> ansibe-playbook 01_install_mitaka_virtualenv.yml --connection=local </pre>

import the database

test that most things are working
<pre> ansibe-playbook 01_install_mitaka_virtualenv.yml --connection=local </pre>

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

For Virtualenv: Creating the small upper-requirements.txt files:
--------

```
$ grep -e python -e oslo queens.upper-constraints.txt |grep -v -e systemd -e nss -e libvirt > queens.upper-constraints2.txt 

```

For Virtualenv: Figuring out pip / python stack traces errors
-----------

If you see something like this from the neutron-db-manage command:

```
    'router': constants.L3,", "AttributeError: 'module' object has no attribute 'L3'"], "stdout": "Running current for neutron ...", "stdout_lines": ["Running current for neutron ..."]}
```

This probably means that one of the neutron libraries are too new. Check "pip list|grep neutron" and compare output with the version in the https://raw.githubusercontent.com/openstack/requirements/stable/queens/upper-constraints.txt - maybe something in any of the project's requirements.txt updated it?


Branches
---------

When releases go EOL then branch names change. This means once or twice a year would have to update the playbooks
