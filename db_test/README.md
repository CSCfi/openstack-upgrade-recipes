Testing the db upgrades on a "clean" VM
---------------------------------------

Requirements: a dump of the database

Tested with ansible 2.3.0.0-3.EL7

Caveats: 
----
can't install MySQL-python with mariadb 10.3 installed ??

MySQL-python is not in upper-requirements.txt after Pike - one should use mysql+pymysql ??


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

Figuring out pip / python stack traces errors
-----------

If you see something like this from the neutron-db-manage command:

```
    'router': constants.L3,", "AttributeError: 'module' object has no attribute 'L3'"], "stdout": "Running current for neutron ...", "stdout_lines": ["Running current for neutron ..."]}
```

This probably means that one of the neutron libraries are too new. Check "pip list|grep neutron" and compare output with the version in the https://raw.githubusercontent.com/openstack/requirements/stable/queens/upper-constraints.txt - maybe something in any of the project's requirements.txt updated it?


Branches
---------

When releases go EOL then branch names change. This means once or twice a year would have to update the playbooks
