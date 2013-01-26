#!/bin/sh 
DEMO="JBoss World Keynote 2012 Demo"
JBOSS_HOME=./target/jboss-eap-6.0
SERVER_DIR=$JBOSS_HOME/standalone
SRC_DIR=./installs
EAP=jboss-eap-6.0.0.zip
JBWKEYNOTE=git@github.com:eschabell/jboss-keynote-2012.git


echo
echo "Setting up the JBoss EAP 6 ${DEMO} environment..."
echo

# testing for tooling.
if [[ -x /usr/bin/git || -x /usr/bin/mvn ]]; then
	echo Found the necessary GIT and Maven tooling...
	echo
else
	echo Need to install GIT and / or Maven on your system to install this demo...
	echo
	exit
fi

# make some checks first before proceeding.	
if [[ -r $SRC_DIR/$EAP || -L $SRC_DIR/$EAP ]]; then
	echo EAP sources are present...
	echo
else
	echo Need to download $EAP package from the Customer Portal 
	echo and place it in the $SRC_DIR directory to proceed...
	echo
	exit
fi

if [[ -d ./projects/jboss-keynote-2012 ]]; then
	echo Found existing JBoss World Keynote project directory... 
	echo Please clean out the projects directory and re-run this script.
	echo
	exit
else
	# clone the project.
	echo Cloning the JBoss World Keynote project from github...
	echo
	git clone $JBWKEYNOTE ./projects/jboss-keynote-2012
fi

# move down to cloned project.
cd ./projects/jboss-keynote-2012

# build the admin application.
echo Building the admin applicaiton...
echo
mvn clean install -Padmin

# build the leaderboard application.
echo Building the leaderboard application...
echo 
mvn clean install -Pleaderboard

# build the main application.
echo Building the main application...
echo
mvn clean install -DskipTests -Drequirejs

# move back to root of demo.
cd ../../

# Create the target directory if it does not already exist.
if [ ! -x target ]; then
	echo "  - creating the target directory..."
	echo
  mkdir target
else
	echo "  - detected target directory, moving on..."
	echo
fi

# Move the old JBoss instance, if it exists, to the OLD position.
if [ -x $JBOSS_HOME ]; then
	echo "  - existing JBoss Enterprise EAP 6 detected..."
	echo
	echo "  - moving existing JBoss Enterprise EAP 6 aside..."
	echo
  rm -rf $JBOSS_HOME.OLD
  mv $JBOSS_HOME $JBOSS_HOME.OLD

	# Unzip the JBoss EAP instance.
	echo Unpacking JBoss Enterprise EAP 6...
	echo
	unzip -q -d target $SRC_DIR/$EAP
else
	# Unzip the JBoss EAP instance.
	echo Unpacking new JBoss Enterprise EAP 6...
	echo
	unzip -q -d target $SRC_DIR/$EAP
fi

# Add execute permissions to the standalone.sh script.
echo "  - making sure standalone.sh for server is executable..."
echo
chmod u+x $JBOSS_HOME/bin/standalone.sh

echo "  - enabling demo accounts logins in guvnor-users.properties file..."
echo
cp support/guvnor-users.properties $SERVER_DIR/configuration

echo "  - enabling demo accounts role setup in guvnor-roles.properties file..."
echo
cp support/guvnor-roles.properties $SERVER_DIR/configuration

echo "  - enabling guvnor specific components in standalone.xml file..."
echo
cp support/standalone.xml $SERVER_DIR/configuration/standalone.xml

echo "  - copying over drools guvnor, designer and jbwdemo applications..."
echo
cp -v projects/jboss-keynote-2012/distribution/target/drools-guvnor.war $JBOSS_HOME/standalone/deployments/drools-guvnor.war
cp -v projects/jboss-keynote-2012/distribution/target/designer.war $JBOSS_HOME/standalone/deployments/designer.war
cp -v projects/jboss-keynote-2012/distribution/target/jbwdemo-application.ear $JBOSS_HOME/standalone/deployments/jbwdemo-application.ear

echo To watch a screencast of the JBoss World 2012 Keynote demo, see the micro site: http://www.jboss.org/jbw2012keynote
echo

echo "JBoss Enterprise EAP 6 ${DEMO} Setup Complete."
echo

echo ******************************************
echo Start your demo with:
echo
echo target/jboss-eap-6.0/bin/standalone.sh
echo ******************************************
echo
echo
echo ******************************************
echo Accessing the Client Application
echo ******************************************
echo
echo buyer application: localhost:8080/jbossworld-client
echo
echo "approver application: localhost:8080/jbossworld-client/#approver  (password is letmein)"
echo
echo "VP application: localhost:8080/jbossworld-client/#vp    (password is letmein)"
echo 
echo Note: To switch between roles, you must first logout. Once logged out, 
echo you will not be able to return to the previous role so a new role will 
echo be created when you log in again.  
echo 
echo localhost:8080/jbossworld-client/#logout
echo ******************************************
echo
echo
echo ******************************************
echo Running Robots
echo ******************************************
echo
echo Execute the following from within the robots directory:
echo
echo mvn exec:java -Dexec.mainClass=org.jboss.jbw2012.keynote.robots.RobotsClient
echo ******************************************
echo

