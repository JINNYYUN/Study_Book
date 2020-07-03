package BOJ;

import java.util.*;

public class BOJ4948 {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		//에라토스테네스의 체 구현 
		final int MAX = 250000; 
		boolean[] isPrime = new boolean[MAX+1];
		
		for (int i = 2; i <= MAX; i++) {
			isPrime[i] = true;
		}
		
		for (int i = 2; i*i <= MAX; i++) {
			for (int j = i*2; j <= MAX ; j+=i) {
				isPrime[j] = false;
			}
		}
		
		//n보다 크고, 2n보다 작거나 같은 소수
		while(true) {
			
			int n = sc.nextInt();
			
			if(n==0) {
				break;
			}
			
			int count = 0;
			for (int i = n+1; i <= n*2; i++) {
				if(isPrime[i]) {
					count++;
				}
			}
			System.out.println(count);
		}
	}
}
