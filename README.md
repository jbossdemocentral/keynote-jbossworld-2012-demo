JBoss Keynote Demo from JBossWorld 2012 Quickstart Guide
========================================================

A fully automated setup project to allow you to locally demo the JBoss World Keynote 2012 application. You want to be a JBoss Rock Star? Now you can!

Demo based on JBoss EAP6 and the existing code base of the Keynote demo.

Setup and Configuration
-----------------------

This is now completely automoated, just run the init.sh script provided. Note you need to download JBoss EAP 6 as stated in the
README found in the installs directory. 

The init.sh script is designed to test for the needed tooling before running, so pay attention to the messages it gives you should
it terminate without finishing the installation. 

The action plan is to check for GIT, Maven and then clone a keynote source repository, build all components, install EAP 6, install
configuration files into EAP 6, install built components into EAP 6 and then end with a descriptive explaination of how to start the
demo, what to access to get started and a link to the keynote mico site for more information. 

Future work, get this to work with BRMS 5.3.

Enjoy!

