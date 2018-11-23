Testing the db upgrades on a "clean" VM
---------------------------------------

Requirements: a dump of the database

Tested with ansible 2.3.0.0-3.EL7

Caveats: 
----
can't install MySQL-python with mariadb 10.3 installed ??


Usage
-----

setup most things:
<pre> ansibe-playbook 01_install_mitaka_virtualenv.yml --connection=local </pre>

import the database

test that most things are working
<pre> ansibe-playbook 01_install_mitaka_virtualenv.yml --connection=local </pre>

Creating the small upper-requirements.txt files:
--------

```
$ grep -e python -e oslo queens.upper-constraints.txt |grep -v -e systemd -e nss -e libvirt > queens.upper-constraints2.txt 
```
