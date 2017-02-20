# LogAnalysis

Using Hadoop to analyze the access_log.

1- mvn clean install

2. hadoop jar LogAnalysisFunctions.jar AddressCount short.txt output /favicon.ico

3. hadoop jar LogAnalysisFunctions.jar AddressMax short.txt output1

4. hadoop jar LogAnalysisFunctions.jar IPCount short.txt output2 10.223.157.186

5. hadoop jar LogAnalysisFunctions.jar IPMax short.txt output3  
