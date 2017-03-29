#****************************************************
#* Install and Run Spark 2.x on multi-node cluster – 
#* A Step by Step Guide By mharbi@me.com
#****************************************************

sudo apt-get update

# Install Scala
sudo apt-get install scala

nano /etc/hosts
# In the file, add:
	<YOUR-GIVEN-IP1> master
    <YOUR-GIVEN-IP2> slave

ssh localhost
exit
ssh 0.0.0.0
exit
ssh master
exit
ssh slave
exit

cd ~

# Install Spark on Master
wget http://d3kbcqa49mib13.cloudfront.net/spark-2.1.0-bin-hadoop2.7.tgz
sudo mv ~/spark-2.1.0-bin-hadoop2.7.tgz /usr/local
cd /usr/local
sudo tar -xzvf spark-2.1.0-bin-hadoop2.7.tgz
sudo rm spark-2.1.0-bin-hadoop2.7.tgz
mv /usr/local/spark-* /usr/local/spark

# ADD SPARK VARIABLES
nano ~/.bashrc
    export SPARK_HOME=/usr/local/spark
    export PATH=$PATH:$SPARK_HOME/bin
source ~/.bashrc

sudo chown -R root:root $SPARK_HOME

# Spark configuration
cp $SPARK_HOME/conf/spark-env.sh.template $SPARK_HOME/conf/spark-env.sh
nano $SPARK_HOME/conf/spark-env.sh
    # add/edit the following:
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
    HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
    # this variable defines the amount of parallelism each Spark Worker node has.
    # it represents the number of Spark tasks (or threads) a Spark Worker can give to its Spark Executors.
    SPARK_WORKER_CORES=8 

# Add salves
# Create configuration file slaves
nano $SPARK_HOME/conf/slaves
    # add following entries:
    slave

COPY Hadoop-Config\*.xml to /usr/local/hadoop/etc/hadoop/

# ----------------------------------------------------------------------------------------------
# “Apache Spark has been installed successfully on Master, now deploy Spark on all the Slaves”
# ----------------------------------------------------------------------------------------------

# Copy setups from master to all the slaves
    # Create tar-ball of configured setup:
    cd /usr/local
    sudo tar -czf spark.tar.gz spark

    # Copy the configured tar-ball on all the slaves
    scp spark.tar.gz slave:~

# Install Spark On Slave
# Setup Pre-requisites on all the slaves:
    # Run following steps on all the slaves (or worker nodes):
        # “1. Add Entries in hosts file”
        # “2. Install Java 8”
        # “3. Install Scala”

sudo mv ~/spark.tar.gz /usr/local
cd /usr/local
sudo tar -xzvf spark.tar.gz

# ---------------------------------------------------------------------------------------------------------
# “Congratulations Apache Spark has been installed on all the Slaves. Now Start the daemons on the Cluster”
# ---------------------------------------------------------------------------------------------------------

# BACK TO MASTER AND RUN THIS COMMANDs:
    # Start Spark Cluster
    $SPARK_HOME/sbin/start-all.sh

    # Check whether daemons services have been started
    jps

    # Spark Master UI
    http://MASTER-IP:8080/

    # Spark application UI
    http://MASTER-IP:4040/


# TEST
run-example --master yarn SparkPi 10