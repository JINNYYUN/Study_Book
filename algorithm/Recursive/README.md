# 재귀(recursive)

**자기 자신을 호출하는 함수**

- 복잡한 알고리즘을 단순하고 알기 쉽게 표현하는 것을 가능하게 함
- 함수 호출에 따른 오버해드가 있음(매개변수 전달, 액티베이션 프레임 생성 등)

```java
public Class Recursive{
	public static void main(String[] args){
		func();
	}
	public static void func(){
		...
		func(...);
		...
	}
}

void func(){
		...
		func(...);
		...
}
```

자신의 메서드를 끝없이 호출하는 무한루프에 빠지는 것을 막기 위해 순환되지 않고 종료되는 case가 있어야 한다. 모든 case는 결국 basecase로 수렴해야 한다.

```java
public class Recursion {
	//무한루프
	public static void main(String[] args) {
		int n= 4;
		func(n);
	}
	
	//무한 루프가 되지 않기 위해 base case를 통해 resursion에서 빠져 나갈 수 있도록 한다
	public static void func(int k) {
		if(k<=0) { //Recursion을 반복 하다보면 결국 base case로 수렴해야 한다
			return;
		}else {
			System.out.println("Hello");
			func(k-1);
		}
	}
}
```

**0~n까지의 합을 구하는 순환함수**

```java
public static int fun(int n){
	if(n==0)
		return 0;
	else
		retrun n+ func(n-1); 
		//n이 0보다 크다면 0에서 n까지의 합은 0에서 n-1까지의 합에 n을 더한 것이다.
}
```

**Factorial** 0부터 n까지의 곱

Factorial
0! = 1
n! = n*(n-1)!  n>0

```java
public static int factorial(int n){
	if(n==0)
		return 1;
	else
		return n*factorial(n-1);
}
```

**X의 n승을 계산**

```java
public static double power(double x, int n){
	if(n==0)
		return 1;
	else
		return x*power(x,n-1)
}
```

**Fibonacci Number**

```java
public int fibonacci(int n){
	if(n<2)
		return n
	else
		return fibonacci(n-1) + fibonacci(n-2);
}
```

**최대공약수 : Euclid Method(유클리드)**

m≥n인 두 양의 정수 m과 n에 대해서 m이 n의 배수이면 gcd(m,n) = n이고, 그렇지 않으면 gcd(m,n) = gcd(n,m%n)이다.

```java
public static int gcd(int p, int q){
	if(q==0)
		return p;
	else
		return gcd(q, p%q);
}
```

</br>

수학 함수 뿐만 아니라 다른 많은 문제들을 recursion으로 해결할 수 있으며, 모든 반복문은 recursion으로 표현 가능하다.

**문자열의 길이 계산**

```java
public static int length(String str) {
	if(str.equals(""))
		return 0;
	else
		return 1+ length(str.substring(1));
}
```

**문자열의 프린트**

```java
public static void printChars(String str) {
	if(str.length()==0) {
		return;
	}
	else {
		System.out.println(str.charAt(0));
		printChars(str.substring(1));
	}
}
```

**2진수로 변환하여 출력**

```java
public void printInBinart(int n) {
	if(n<2) {
		System.out.print(n);
	}
	else {
		printInBinart(n/2);	//n을 2로 나눈 몫을 먼저 2진수로 변환하여 인쇄한 후 
		System.out.print(n%2);	//n을 2로 나눈 나머지를 인쇄한다.
	}
}
```

**배열의 합 구하기**

```java
//data[0]에서 data[n-1]까지의 합을 구하여 반환한다.
public static int sum(int n, int[] data) {
	if(n<=0) {
		return 0;
	}
	else
		return sum(n-1, data) + data[n-1];
}
```

**데이터파일로 부터 n개의 정수 읽어오기**

```java
//Scanner in이 참조하는 파일로 부터 n개의 정수를 입력받아 배열 data의 data[0], ... , data[n-1]에 저장한다.
public void readFrom(int n, int[] data, Scanner in) {
	if(n==0) {
		return;
	}else {
		readFrom(n-1, data, in);
		data[n-1] = in.nextInt();
	}
}
```


**최대값 찾기** 

```java
//최대값 찾기 1
public int findMax(int[] data, int begin, int end) {
	if(begin == end) {
		return data[begin];
	}
	
	else
		return Math.max(data[begin], findMax(data, begin+1, end));
}

//최대값 찾기 다른버전
public int findMax2(int[] data, int begin, int end) {
	if(begin==end) {
		return data[begin];
	}
	else {
		int middle = (begin+end)/2;
		int max1 = findMax(data, begin, middle);
		int max2 = findMax(data, middle+1, end);
		return Math.max(max1, max2);
	}
}
```

</br>

### **미로찾기 알고리즘**

현재 위치에서 출구까지 가는 경로가 있으려면

1) 현재 위치가 출구이거나 혹은

2) 이웃한 셀들 중 하나에서 **현재 위치를 지나지 않고** 출구까지 가는 경로

```java
public class Maze {
	public static void main(String[] args) {
		printMaze();
		findMazePath(0,0);
		printMaze();
	}
	
	
	private static int N= 8;
	private static int[][] maze= {
		{0, 0, 0, 0, 0, 0, 0, 1},
		{0, 1, 1, 0, 1, 1, 0, 1},
		{0, 0, 0, 1, 0, 0, 0, 1},
		{0, 1, 0, 0, 1, 1, 0, 0},
		{0, 1, 1, 1, 0, 0, 1, 1},
		{0, 1, 0, 0, 0, 1, 0, 1},
		{0, 0, 0, 1, 0, 0, 0, 1},
		{0, 1, 1, 1, 0, 1, 0, 0}
	};
	
	private static final int PATHWAY_COLOUR = 0; // 이동이 가능한 cell
	private static final int WALL_COLOUR = 1; // 벽으로 되어있는 cell
	private static final int BLOCKED_COLOUR = 2; // 방문했으며 출구까지의 경로상에 있지 않음이 밝혀진 cell
	private static final int PATH_COLOUR = 3; // 방문했으며 아직 출구로 가는 경로가 될 가능성이 있는 cell
	
	public static void printMaze() {
		for (int i = 0; i < maze.length; i++) {
			for (int j = 0; j < maze.length; j++) {
				System.out.print(maze[i][j]);
			}
			System.out.println();
		}
	}
	
	public static boolean findMazePath(int x, int y) {
		//좌표가 유효한 범위인가를 확인(0 ~ N-1)
		if(x<0 || y<0 || x >=N || y>=N) {
			return false;
		//cell이 벽인경우(막혀있는 경우) flase 반환
		}else if(maze[x][y] != PATHWAY_COLOUR) {
			return false;
		//출구의 경우  
		}else if(x==N-1 && y ==N-1) {
			maze[x][y]= PATH_COLOUR;
			return true;

		}else {
			maze[x][y]= PATH_COLOUR;
			// 동서남북으로 끝없이 이동하면서 조건 확인
			if(findMazePath(x-1,y) || findMazePath(x,y+1) || findMazePath(x+1, y) || findMazePath(x, y-1)) {
				return true;
			}
			
			//출구까지 가는 경로를 찾지못하면 이곳으로 이동.
			maze[x][y]= BLOCKED_COLOUR;	//dead end
			return false;
		}	
	}	
}
```
