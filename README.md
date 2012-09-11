JBoss Keynote Demo from JBossWorld 2012 Quickstart Guide
========================================================

A fully automated setup project to allow you to locally demo the JBoss World Keynote 2012 application. You want to be a JBoss Rock Star? Now you can!

Demo based on JBoss EAP6 and the existing code base of the Keynote demo.

Setup and Configuration
-----------------------

This is now completely automated, just run the init.sh script provided. Note you need to download JBoss EAP 6 as stated in the
README found in the installs directory. 

The init.sh script is designed to test for the needed tooling before running, so pay attention to the messages it gives you should
it terminate without finishing the installation. 

Start your demo with:

target/jboss-eap-6.0/bin/standalone.sh

Accessing the Client Application

buyer application: localhost:8080/jbossworld-client

approver application: localhost:8080/jbossworld-client/#approver  (password is letmein)

VP application: localhost:8080/jbossworld-client/#vp    (password is letmein)

Note: To switch between roles, you must first logout. Once logged out, you will not be able to return to the previous role so a new
role will be created when you log in again.  

localhost:8080/jbossworld-client/#logout

Running Robots

Execute the following from within the robots directory:

mvn exec:java -Dexec.mainClass=org.jboss.jbw2012.keynote.robots.RobotsClient

The action plan is to check for GIT, Maven and then clone a keynote source repository, build all components, install EAP 6, install
configuration files into EAP 6, install built components into EAP 6 and then end with a descriptive explaination of how to start the
demo, what to access to get started and a link to the keynote mico site for more information. 

Future work, get this to work with BRMS 5.3.

Enjoy!

