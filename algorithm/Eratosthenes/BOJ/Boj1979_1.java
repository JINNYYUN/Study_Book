package BOJ;
import java.util.*;

public class Boj1979_1 {
	public static final int MAX = 10000;
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		boolean check[] = new boolean[MAX+1];
		for(int i=2; i<=MAX; i++) {
			check[i] = true;
		}
		
		for (int i = 2; i*i <= MAX; i++) {
			if(check[i]==true) {
				for (int j = i*2; j <= MAX ; j=j+i) {
					check[j] = false;
				}
			}
		}
		
		int n = sc.nextInt();
		int count = 0;
		for (int i = 0; i < n; i++) {
			int num = sc.nextInt();
			if(check[num]) {
				count++;
			}
		}
		System.out.println(count);
	}
}
