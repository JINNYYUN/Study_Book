# break와 continue 활용

## **break문**

- 반복문 실행 중 break문이 실행되면 블록을 빠져나가서 다음 처리로 이동한다.

- 단독으로 사용불가하고 반복문 혹은 switch문 내에서 빠져나오기 위해 사용된다.

```java
for(int i = 0;i < 10; i++) {
	System.out.println("i = " + i);
	if(i == 4) {
		break;
	}
}
System.out.println("탈출후");
        
/*
 실행결과 : 
i = 0
i = 1
i = 2
i = 3
i = 4
탈출후
*/
char charArr[] = { 'A', 'B', 'C', 'D', 'E' };

for(int i = 0;i < charArr.length; i++) {
	System.out.println(i + ":" + charArr[i]);

	if(charArr[i] == 'C') {
		System.out.println("C문자를 찾았습니다");
		break;
	}
}

/* 실행결과
0:A
1:B
2:C
C문자를 찾았습니다
*/
```

break문은 근접한 단 하나의 반복문만 벗어날 수 있다. 아래의 이중 for문의 경우 내부에 있는 반복문만 벗어나게 된다.

```java
for(int i = 0;i < 10; i++) {			
	System.out.println("i = " + i);			
	for(int j = 0;j < 5; j++) {
		System.out.println("  j = " + j);				
		if(i == 4 && j == 3) {
			break;
		}
	}			
}
```

1. 키워드를 통해 탈출 : 중첩 반복문 앞에 이름을 붙이고 break문에 이름을 지정해 줌으로써 하나 이상의 반복문을 벗어날 수 있다.

```java
//for문 앞에 loopout이라는 사용자 지정 이름을 붙였다.
loopout:for(int i = 0;i < 10; i++) {			
	System.out.println("i = " + i);			
	for(int j = 0;j < 5; j++) {
		System.out.println("  j = " + j);				
		if(i == 2 && j == 1) {
			break loopout;  //loopout으로 지정된 반복문을 벗어난다.
		}
	}			
}
```

2. loop문의 갯수에 맞게 break를 설정함으로써 조건문을 하나씩 탈출 할 수 있도록 한다.

```java
boolean b = false;
for(int i = 0;i < 10; i++) {			
	System.out.println("i = " + i);
			
	for(int j = 0;j < 5; j++) {
		System.out.println("j = " + j);	
            
		if(i == 4 && j == 3) {
			b = true; //1)조건이 성립하면, 논리형 변수 B를 true로 지정.
		}
		if(b == true) {
			break; // 2) 첫번째 조건문을 먼저 탈출하고
		}
	}	
    
		if(b == true) {
			break; //  3)두번째 조건문을 탈출한다.
        }
}
```

</br>


## **continue문**


- 자신이 포함된 반복문의 끝으로 이동한 후, 다시 반복으로 넘어간다.

- 반복문 전체를 벗어나지 않고 다음 반복을 계속 수행한다는 점이 break문과 다르다.

- 전체 반복 중에 특정 조건을 만족하는 경우를 제외하고자 할 때 유용하다.

다음은 1과 10사이의 숫자 중 2의 배수는 출력하지 않도록 하는 코드이다. 'i%2==0'이 성립되면 조건문의 끝으로 이동하게 되어, 출력이 되지 않는 것이다.

```java
for(int i=0; i<10; i++) {
	if(i%2==0) {
		continue; //조건식이 참이 되어 continue문이 수행되면 블럭의 끝으로 이동한다.
	}
	system.out.println(i); //이 부분을 건너뛰게 됨!
}	

/* 실행결과
1
3
5
7
9
*/
```
