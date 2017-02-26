# LogAnalysis

Using Hadoop to analyze the access_log.

## JAVA Files Build
You can use _Maven_ to build the codes as:
```
mvn clean install
```

## Answering Questions
1- How many hits were made to the website item “/assets/img/home-logo.png”?
```
# hadoop jar LogAnalysis.jar AddressHitsCount input_file output_file "/path/to/count"
hadoop jar LogAnalysis.jar AddressHitsCount access_log output1 "/assets/img/home-logo.png"
```

2- How many hits were made from the IP: 10.153.239.5?
```
# hadoop jar LogAnalysis.jar IPCount input_file output_file "0.0.0.0"
hadoop jar LogAnalysis.jar IPCount access_log output2 "10.153.239.5"
```

3- Which path in the website has been hit most? How many hits were made to the path?
```
# hadoop jar LogAnalysis.jar AddressHitsMost input_file output_file
hadoop jar LogAnalysis.jar AddressHitsMost access_log output3
```

4- Which IP accesses the website most? How many accesses were made by it?
```
# hadoop jar LogAnalysis.jar IPMax input_file output_file
hadoop jar LogAnalysis.jar IPMax access_log output4
```

## Check Answers
To check the results, you may run the following code:
```
hdfs dfs -cat output1/*
hdfs dfs -cat output2/*
hdfs dfs -cat output3/*
hdfs dfs -cat output4/*
```