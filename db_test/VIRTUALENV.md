This is the virtualenv way and hasn't been tested after python pip domain was moved in 2019
------


Usage virtualenv
-----

setup most things:
<pre> ansibe-playbook 01_install_mitaka_virtualenv.yml --connection=local </pre>

import the database

test that most things are working
<pre> ansibe-playbook 01_install_mitaka_virtualenv.yml --connection=local </pre>

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
