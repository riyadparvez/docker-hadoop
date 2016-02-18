#!/bin/bash

echo "Starting HDFS"
$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-mapred.sh

$HADOOP_HOME/bin/hadoop dfs -copyFromLocal $GIRAPH_HOME/tiny-graph.txt /user/root/input/tiny-graph.txt
$HADOOP_HOME/bin/hadoop dfs -ls /user/root/input

$HADOOP_HOME/bin/hadoop jar \
  $GIRAPH_HOME/giraph-examples/target/giraph-examples-1.2.0-SNAPSHOT-for-hadoop-0.20.203.0-jar-with-dependencies.jar \
  org.apache.giraph.GiraphRunner org.apache.giraph.examples.SimpleShortestPathsComputation \
  -vif org.apache.giraph.io.formats.JsonLongDoubleFloatDoubleVertexInputFormat \
  -vip /user/root/input/tiny-graph.txt \
  -vof org.apache.giraph.io.formats.IdWithValueTextOutputFormat \
  -op /user/root/output/shortestpaths \
  -w 1

$HADOOP_HOME/bin/hadoop dfs -cat /user/root/output/shortestpaths/p* | less
