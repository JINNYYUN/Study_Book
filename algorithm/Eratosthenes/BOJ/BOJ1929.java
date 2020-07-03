package BOJ;

import java.util.*;

public class BOJ1929 {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		final int MAX = 1000000;
		boolean isPrime[] = new boolean[MAX+1];
		
		for (int i = 2; i <= MAX; i++) {
			isPrime[i] = true; 
		}
		
		for (int i = 2; i*i <= MAX ; i++) {
			if(isPrime[i]) {
				for (int j = i*2; j <= MAX; j=j+i) {
					isPrime[j] = false;
				}
			}
		}
		
		int M = sc.nextInt();
		int N = sc.nextInt();
		for (int i = M; i <= N; i++) {
			if(isPrime[i]) {
				System.out.println(i);
			}
		}
	}
}
