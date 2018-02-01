import java.io.*;

public class Run {

	static Test test = new Test();
	static String readFile,writeFile;

	public Run(String readFile, String writeFile){
		this.readFile = readFile;
		this.writeFile = writeFile;
	}
	//注意：上面的例子由于写入的文本很少，使用FileWrite类就可以了。但如果需要写入的
     //内容很多，就应该使用更为高效的缓冲器流类BufferedWriter。
		        /**
          * 使用BufferedWriter类写文本文件
         */
	public static void writeMethod(){

		try{
			BufferedWriter out=new BufferedWriter(new FileWriter(writeFile));
			out.write("   Up Down Left Right TopLeft BottomRight TopRight BottomLeft");
			out.newLine();  //注意\n不一定在各种计算机上都能产生换行的效果
			String readResult = readMethod();
			while (!readResult.equals("")){
				out.write(readResult);
				out.newLine();
			}
			//String imgName = new File(fileName).getName();
			//out.write("  My name is coolszy!\n");
			//out.write("  I like you and miss you。");
			out.close();
		} catch (IOException e){
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 使用BufferedReader类读文本文件
	 */
	public static String readMethod(){

		String line = "";
		String result = "";
		try{
			BufferedReader in=new BufferedReader(new FileReader(readFile));
			String imgLine=in.readLine();
			String imgName = new File(imgLine).getName();//only name,no path
			result = imgName;
			 //while (line!=null){
			 //	System.out.println(line);
			 //	line=in.readLine();
			 //}
			for(int i=0; i<8; i++){
				line = in.readLine();
				String matchResult = String.valueOf(test.FeatureSurfBruteforce(imgLine,line));
				result += matchResult;
			}
			 in.close();
		} catch (IOException e){
			e.printStackTrace();
			}

		return result;
	}

	public static void main(String[] args) {
		//writeMethod();fileName ="D:/write.txt";
		//readMethod();fileName = "D:/read.txt";
		//System.out.println(String.valueOf(false));
		Run run = new Run("D:/read.txt","D:/write.txt");
		run.readMethod();
		run.writeMethod();
	}

	//img1 img1Up img1Down img1Left img1Right img1TopLeft img1BottomRight img1TopRight img1BottomLeft

}
