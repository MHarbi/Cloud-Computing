import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.conf.*;
public class AddressCount {

  public static void main(String[] args) throws Exception {
    if (args.length != 3) {
      System.err.println("Usage: Access_log <input path> <output path> <Address>");
      System.exit(-1);
    }
    Configuration conf = new Configuration();
    conf.set("address", args[2]);

    Job job = new Job(conf);
    job.setJarByClass(AddressCount.class);
    job.setJobName("AddressCount");

    FileInputFormat.addInputPath(job, new Path(args[0]));
    FileOutputFormat.setOutputPath(job, new Path(args[1]));
    
    job.setMapperClass(AddressCountMapper.class);
    job.setReducerClass(AddressCountReducer.class);

    job.setOutputKeyClass(Text.class);
    job.setOutputValueClass(IntWritable.class);
    
    System.exit(job.waitForCompletion(true) ? 0 : 1);
  }
}
