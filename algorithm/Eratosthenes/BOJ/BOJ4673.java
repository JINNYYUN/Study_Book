package BOJ;

public class BOJ4673 {
	//i를 받아서 생성한 값들을 넘겨준다.
	public static int getNum(int i) {
		int sum =i;
		
		while(i>=10) {
			sum = sum + i%10;
			i = i/10;
		}
		
		sum += i;
		
		return sum;
	}
	
	public static void main(String[] args) {
		//배열 생성
		boolean[] check = new boolean[10001];

		for (int i = 1; i < 10001; i++) {
			if(getNum(i)<=10000) {
				check[getNum(i)] = true;
			}
		}
		
		for (int i = 1; i < 10001; i++) {
			if (!check[i]) {
				System.out.println(i);
			}
		}
	}
}
