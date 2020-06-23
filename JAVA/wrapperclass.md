# WrapperClass

기본 타입의 데이터를 하나의 객체로 포장해주는 클래스이다. 기본 자료형으로 표현된 데이터를 객체로 저장해야 할 때, 혹은 특정 메소드에서 참조 자료형을 인자로 받을 때, 객체간의 비교가 필요한 경우에 사용된다.

```java
Object [] array = new Object[100];
int a = 20;
Integer age = new Integer(a);  //wrapping

array[0] = a;  //정수값을 오브젝트 타입의 배열에 저장을 해둬야 하기때문에 포장하는 것이다.

int b = age.intValue();    //wrapping
System.out.println(b);
```

- 오토박싱(autoboxing)과 언박싱(unboxing)

    위의 예시와 아래의 예시를 비교하면서 보자! 객체의 배열에 기본형의 값을 넣었는데 오류 없이 실행된다. 이는 컴파일러가 자동으로 변환하는 코드를 넣어주기 때문이다. 이처럼 기본형 값을 래퍼 클래스의 객체로 자동 변환해 주는 것을 오토박싱이라고 한다. 

    ```java
    Object [] array = new Object[100];
    int a = 20;  
    array[0] = a; //[autoboxing] 20은 정수이지만, java컴파일러가 자동으로 이것을 Integer객체로 변환해준다.

    int b = (Integer)array[0]; //[unboxing]array[0]에 저장된 것은 Integer객체이지만 java컴파일러가 자동으로 정수로 변환해준다.
    ```

</br>

### 생성방법

```java
Double dou = 235.789;
Double dou1 = new Double("345.678"); 
//두 개 모두 동일한 문법
//wrapperclass는 자동으로 잡아줌, wrapper클래스의 특징
```

Wrapper클래스의 부모인 **Number클래스**는 객체가 가지고 있는 값을 숫자와 관련된 기본형으로 변환하여 반환하는 메서드들을 정의하고 있다. 즉 Wrapper클래스는 데이터 타입간의 변환 기능을 가지고 있다.

</br>

### 문자열 → 숫자

valueOf()와 동일한 기능

```java
String strNum = "234";
int snum = Integer.parseInt(strNum);
System.out.println("cnum = "+(snum+1));
//cnum = 235

String dstrNum = "123.456";
double dnum = Double.parseDouble(dstrNum);
System.out.println("dnum = " + (dnum + 1.1));
//dnum = 124.556
```

</br>

### 숫자 → 문자열  toString();

```java
Double dou1 = new Double("345.678");

String str =  dou1.toString();

System.out.println(str); //345.678
System.out.println(dou1 + " "); //345.678, autoboxing
```

</br>

### 진법 전환

```java
int i = 127;
 
String binaryString = Integer.toBinaryString(i); //10진수 > 2진수
String octalString = Integer.toOctalString(i);   //10진수 > 8진수
String hexString = Integer.toHexString(i);       //10진수 > 16진수
 
System.out.println(binaryString); //1111111
System.out.println(octalString);  //177
System.out.println(hexString);    //7f
 
int binaryToDecimal = Integer.parseInt(binaryString, 2); //2진수 > 10진수
int binaryToOctal = Integer.parseInt(octalString, 8);  //8진수 > 10진수
int binaryToHex = Integer.parseInt(hexString, 16);  //16진순 > 10진수
 
System.out.println(binaryToDecimal); //127
System.out.println(binaryToOctal);   //127
System.out.println(binaryToHex);     //127
```

- [참고](https://dpdpwl.tistory.com/92)

</br>

### 다른 진법에서 10진수로 변환

```java
//s는 radix의 수
static int parseInt(String s, int radix)
static integer valueOf(String s, int radix)
```
