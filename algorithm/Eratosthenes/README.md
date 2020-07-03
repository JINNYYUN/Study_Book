# 소수와 에라토스테네스의 체

### 1) **기본적인 접근**

소수는 1과 자기 자신 외에는 어떤 수로도 나누어지 않기 때문에 2부터 N-1까지의 수로 나누었을 때 나눠지는 수가 있으면 false를 반환하고, 반복문을 종료한다.


```java
public class Main {
	public static void main(String[] args) {
		long start = System.currentTimeMillis();

		boolean isPrime; //소수를 판별할 변수
		
		int num = 2; //소수인지 판별할 수. 1과 자기 자신 외에 다른 수로 나누어 떨어지면 소수가 아니다.
		while(num <= 100){
			isPrime = true;
			
			for(int i = 2; i < num; i++) { //2부터 n-1사이의 수로 나누어 떨어지지면 소수가 아니다.
				if(num % i == 0) {
					isPrime = false;
					break; //나누어 지는 수가 있으면 반복문을 종료한다.
				}
			}
			
			if(isPrime) {
				System.out.println(num);
			}
			
			num++; //다음 숫자를 판변하기 위해 수를 올린다. 
		}
		long end = System.currentTimeMillis();

		System.out.println( "실행 시간 : " + ( end - start )/1000.0 );
	}
}
```

</br>

### 2) **제곱근까지만 검사하여 소수 판별**

‘N이 소수이기 위한 필요 충분 조건은 N이 N의 제곱근보다 크지 않은 어떤 소수로도 나누어 지지 않는다.’는 개념을 활용한다. 예를 들어, 8의 경우 2 * 4 = 4 * 2의 계산으로 1, 2, 4, 8을 약수로 가진다. 여기서 sqrt(8)(=2.xx)보다 큰 값이 있다면, 반드시 sqrt(8)보다 작은 약수도 존재하는 점을 확인할 수 있다. (sqrt(8)보다 큰 값들의 곱은 8을 넘어가기 때문) . 따라서 sqrt(n) 즉, 제곱근 까지만 검사해도 약수가 있는지 없는지 확인할 수 있다.

```java
public class Main {
	public static void main(String[] args) {
		long start = System.currentTimeMillis();
		
		boolean isPrime; //소수를 판별할 변수
		
		int num = 2; //소수인지 판별할 수. 1과 자기 자신 외에 다른 수로 나누어 떨어지면 소수가 아니다.
		while(num <= 1000000){
			isPrime = true;
			
			for(int i = 2; i*i <= num; i++) { //2부터 sqrt(i)사이의 수로 나누어 떨어지지면 소수가 아니다.
				if(num % i == 0) {
					isPrime = false;
					break; //나누어 지는 수가 있으면 반복문을 종료한다.
				}
			}
			
			if(isPrime) {
				System.out.println(num);
			}
			
			num++; //다음 숫자를 판변하기 위해 수를 올린다. 
		}
		long end = System.currentTimeMillis();

		System.out.println( "실행 시간 : " + ( end - start )/1000.0 );
	}
}
```

</br>


### 3) **에라토스테네스의 체**

에라토스테네스의 체란, 어떤 수 이하의 범위에 존재하는 소수를 찾고 싶은 경우 ‘그 수의 제곱근보다 작은 소수의 배수를 없애면 남은 수가 소수다’ 라는 생각을 바탕으로 소수를 찾는 방법을 말합니다. 대량의 소수를 한꺼번에 판별하고자 할 때 사용됩니다.

```java
public class Main3 {
	public static void main(String[] args) {
		final int MAX = 100;
		boolean[] isPrime = new boolean[MAX+1]; //100까지의 소수를 구하기 위해 101까지 선언

		
		for(int i=2; i<=MAX; i++) {
			isPrime[i] = true;
		}
		// 소수는 true
		
		// 소수의 배수를 모두 체크
		for(int i=2; i*i<=MAX; i++) {	//10이하의 소수의 배수만 검사하면 된다.
			if(isPrime[i]==true) {	//check[i]가 소수라면
				for(int j=i+i; j<=MAX; j=j+i) {
					isPrime[j] = false;	//소수의 배수를 false로 변환하면서 거른다.
				}
			}
		}

		// 소수출력
		for(int i=2; i<=MAX; i++) {
			if(isPrime[i]) {	
				System.out.println(i);
			}
		}
	}
}
```