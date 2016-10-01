import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.nio.file.Files;
import java.util.*;

public class PostfixCalculator {

	public static void main(String[] args) throws IOException {

		List<String> lines = Files.readAllLines(new File("sample_input.txt").toPath());
		
		List<Float> outputString = new ArrayList<Float>();
		
		File file = new File("out.txt"); //Your file

		for (int i = 0; i < lines.size(); i++) {
			System.out.println(lines.get(i));
			System.out.println("Here is the postfix result: " + evaluatePostfix(lines.get(i)));
			outputString.add(evaluatePostfix(lines.get(i)));
		}
		
		FileOutputStream fos = new FileOutputStream(file);
		PrintStream ps = new PrintStream(fos);
		System.setOut(ps);
		System.out.println(outputString);
		
		
	}

	public static float evaluatePostfix(String str) {
		/**
		 * Here is the start of the evaluate postfix string, start with create a
		 * empty integer stack.
		 */
		Stack<Integer> s = new Stack<Integer>();
		String[] items = str.split(" ");
		char[] chars = str.toCharArray();
		int number = chars.length;

		/**
		 * Instead of the regular if statement, I use the following statement
		 * for each item in the string items.
		 */
		for (String i : items) {
			// for (i = 0; i < items.length; i++){
			try {
				s.push(Integer.valueOf(i));
			} catch (NumberFormatException e) {
				// If I use s.pop() in the switch statement, it returns a
				// mistake
				int v1 = s.pop();
				int v2 = s.pop();

				// if (items[i].equals("+")) {
				// s.push(v2 + v1);
				// } else if (items[i].equals("-")) {
				// s.push(v2 - v1);
				// } else if (items[i].equals("*")) {
				// s.push(v2 * v1);
				// } else if (items[i].equals("+")) {
				// s.push(v2 / v1);
				// }

				/** Here we use the switch statement */
				switch (i) {
				case "+":
					s.push(v2 + v1);
					break;
				case "-":
					s.push(v2 - v1);
					break;
				case "*":
					s.push(v2 * v1);
					break;
				case "/":
					s.push(v2 / v1);
					break;
				}
			}
		}

		return s.pop();
	}
}
