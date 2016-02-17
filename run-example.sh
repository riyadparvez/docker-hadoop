#!/bin/bash

echo "Starting HDFS"
$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-mapred.sh

$HADOOP_HOME/bin/hdfs dfs -mkdir -p /user/root/input
$HADOOP_HOME/bin/hdfs dfs -put $GIRAPH_HOME/data/tiny-graph.txt /user/root/input/tiny-graph.txt

$HADOOP_HOME/bin/hadoop jar \
    $GIRAPH_HOME/giraph-examples/target/giraph-examples-1.2.0-SNAPSHOT-for-hadoop-1.2.1-jar-with-dependencies.jar \
    org.apache.giraph.GiraphRunner org.apache.giraph.examples.SimpleShortestPathsComputation \
    --workers 1 \
    --customArguments giraph.SplitMasterWorker=false \
    --vertexInputFormat org.apache.giraph.io.formats.JsonLongDoubleFloatDoubleVertexInputFormat \
    --vertexInputPath /user/root/input/tiny-graph.txt \
    --vertexOutputFormat org.apache.giraph.io.formats.IdWithValueTextOutputFormat \
    --outputPath /user/root/output
    #--yarnjars giraph-examples-1.1.0-SNAPSHOT-for-hadoop-2.4.1-jar-with-dependencies.jar \
