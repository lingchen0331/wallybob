import java.util.Map;

/**
 * Use this class to test your BookTracker class.
 * @author AlexBeard
 *
 */
public class BookTrackerTest {
	
    private static double score = 0;

    public static void main(String[] args) {
    	
    	BookTracker.requestBook("Harry Potter and the Chamber of Secrets");
    	BookTracker.requestBook("Harry Potter and the Sorcerer's Stone");
    	BookTracker.requestBook("Harry Potter and the Chamber of Secrets");
    	BookTracker.requestBook("Harry Potter and the Chamber of Secrets");
    	BookTracker.requestBook("Harry Potter and the Goblet of Fire");
    	BookTracker.requestBook("Harry Potter and the Halfblood Prince");
    	BookTracker.requestBook("Harry Potter and the Goblet of Fire");


    	Map<String, Integer> bookSummary = BookTracker.getRequestSummary();
    	
    	adjustScore(bookSummary.get("Harry Potter and the Chamber of Secrets") == 3, "Test 1", 2.5);
    	adjustScore(bookSummary.get("Harry Potter and the Sorcerer's Stone") == 1, "Test 2", 2.5);
    	adjustScore(bookSummary.get("Harry Potter and the Halfblood Prince") == 1, "Test 3", 2.5);
    	adjustScore(bookSummary.get("Harry Potter and the Goblet of Fire") == 2, "Test 4", 2.5);

    	System.out.println("Total score (out of 10): " + score);
    	
    	
    	
    	
    }
    
    public static void adjustScore(boolean test, String successMessage, double points) {
        if(test) {
            System.out.println("Passed test: " + successMessage + ": " + points);
            score += points;
        } else {
            System.out.println("Failed test: " + successMessage);
        }
        
    }


}