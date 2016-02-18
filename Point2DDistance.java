
import javafx.geometry.Point2D;


public class Point2DDistance {
	public static void main(String[] args){
		Point2D pt1 = new Point2D(1,7);
		Point2D pt2 = new Point2D(23,92);
		System.out.println("The first point is " + pt1);
		System.out.println("The second point is " + pt2);
		double dis;
		dis = pt1.distance(pt2);
		
		System.out.println("The distance between the two points is " + dis);
		
	}
}