#!/bin/bash

echo "Starting HDFS"
$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-mapred.sh

cd /tmp
wget http://www.gutenberg.org/cache/epub/132/pg132.txt
$HADOOP_HOME/bin/hadoop dfs -copyFromLocal /tmp/pg132.txt /user/root/input/pg132.txt
$HADOOP_HOME/bin/hadoop dfs -ls /user/root/input

$HADOOP_HOME/bin/hadoop jar \
  $HADOOP_HOME/hadoop-examples-0.20.203.0.jar wordcount \
  /user/hduser/input/pg132.txt \
  /user/hduser/output/wordcount

$HADOOP_HOME/bin/hadoop dfs -cat /user/hduser/output/wordcount/p* | tail
