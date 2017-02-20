import java.io.IOException;
import org.apache.commons.lang.StringUtils;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class AddressCountMapper
  extends Mapper<LongWritable, Text, Text, IntWritable> {
  
  @Override
  public void map(LongWritable key, Text value, Context context)
      throws IOException, InterruptedException {
    
        String line = value.toString();
        line = line.replace("\"\"","-");
        // line=line.split("GET ")[1];
        // System.out.println(line);
        String request = StringUtils.substringBetween(line , "\"", "\"");
        String[] request_s = request.split(" ");
        String address = "";
        try{
        if(request_s.length >= 1)
        	address = request_s[1];
	    }
	    catch(Exception e)
	    {
	    	System.out.println("=============================================================================================================================");
	    	System.out.println(line);
	    	System.out.println("=============================================================================================================================");
	    	
	    }
  
        context.write(new Text(address), new IntWritable(1));
    
  }
}