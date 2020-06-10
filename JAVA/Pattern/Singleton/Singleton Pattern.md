# Singleton Pattern

단 하나의 인스턴스만 생성하고, 접근하여 데이터를 송수신할 수 있는 패턴.(생성 패턴 중 하나)

### 사용하는 이유

- 객체를 여러 번 생성할 필요가 없기 때문에 **불필요한 자원 낭비를 방지할 수 있음**
- 인스턴스가 1개밖에 존재하지 않는 다는 것을 보증하고 싶을 때 → 복수의 인스턴스 생성과 존재로 발생할 수 있는 문제 예방

### 구조

![Singleton%20Pattern/Singleton_Diagram.jpg.jpg](Singleton%20Pattern/Singleton_Diagram.jpg)

- SingletonClass의 객체인 instance를 static 변수로 지정한다 > 메모리 할당된 instance를 초기화 하지 않고 계속해서 리턴하기 위함.
- 생성자에 private접근 제어자를 지정함으로써 외부 클래스에서 new를 실행할 수 없도록 한다.
- getInstance라는 static메서드를 이용해 SingletonClass객체를 돌려 받는다.

```java
public class mainClass{
	public static void main(String[] args) {
		private int number = 12;

		//getter로 객체를 받아온다.
		SingletonClass object = SingletonClass.getInstance();
		//최초의 인스턴스인 'instance'가 계속해서 호출 됨.
		//SingletonClass object = new SingletonClass(); 는 불가능. SingletonClass클래스의 생성자가 private이기 때문

		object.snumber = this.number; //인스턴스의 값 변경
	}
}
```

```java
public class SingletonClass {
	//전역(static) 인스턴스 생성
	private static SingletonClass instance= null;
	public int snumber;

	//생성자 호출 제한 > 외부 클래스로 부터 new되지 않도록 생성자를 private로 지정한다.
	private SingletonClass() {

	}

	//유일한 인스턴스를 얻기 위한 static메소드 > 언제나 동일한 인스턴스를 반환한다.
	public static SingletonClass getInstance() {
		//최초로 getInstance메소드를 호출했을 때 Singleton클래스는 초기화된다.
		//그리고 이때 static필드의 초기화가 이루어지고 유일한 인스턴스가 만들어 진다
		if(instance==null) { //최초로 메소드를 호출할 때만 실행되고, 그 뒤엔 인스턴스가 null이 아니기 때문에 if문을 건너 뛴다.
			instance= new SingletonClass();
		}
		return instance; //동일한 인스턴스 반환
	}
}
```

```java
public class SingletonClass {
	private static SingletonClass instance = new SingletonClass(); //정적필드, 인스턴스 생성

	private SingletonClass() {	//생성자 호출 제한
	}

	public static SingletonClass getInstance() {
		return instance //인스턴스 반환
	}
}
```

### 문제점

- 싱글톤 인스턴스가 너무 많은 일을 하거나 많은 데이터를 공유시킬 경우 다른 클래스의 인스턴스 간의 결합도가 높아진다. >SRP(단일 책임 원칙), OCP(개방-폐쇄 원칙) 원칙에 위배
- 멀티쓰레드환경에서 동시에 접근하는 경우 인스턴스가 두개가 생성되는 하는 경우가 발생

### 안전한 싱글톤 객체를 만들기 위한 코드

LazyHolder를 이용한 싱글톤 객체 생성

```java
public class SingletonClass {

    private SingletonClass() {}

    private static class LazyHolder{
        public static final SingletonClass INSTANCE=new SingletonClass (); //final을 사용해 다시 값이 할당되지 않도록 한다.
    }

    public static SingletonClass getInstance() {
        return LazyHolder.INSTANCE;
    }   
}
```
