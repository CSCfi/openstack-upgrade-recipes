Testing the db upgrades on a "clean" VM
---------------------------------------

Requirements: a dump of the database

Tested with ansible 2.3.0.0-3.EL7

Usage
-----

setup most things:
<pre> ansibe-playbook 01_install_mitaka_virtualenv.yml --connection=local </pre>

import the database

test that most things are working
<pre> ansibe-playbook 01_install_mitaka_virtualenv.yml --connection=local </pre>
