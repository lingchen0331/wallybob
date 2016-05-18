import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

public class BookTracker {

	static HashMap<String, Integer> bookTitle = new HashMap<String, Integer>();

	public static void requestBook(String title) {
		
		if (!bookTitle.containsKey(title)){
			bookTitle.put(title, 1);
		}
		else{
			int value = bookTitle.get(title);
			value++;
			bookTitle.put(title, value);
		}
	}

	public static Map<String, Integer> getRequestSummary() {
		return bookTitle;
	}

}