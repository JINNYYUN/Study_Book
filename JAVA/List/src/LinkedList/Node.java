package LinkedList;
public class Node<T> { //generics
	public T data;	//하나의 데이터 객체를 저장할 필드 data
	public Node<T> next; //다음 노드의 주소를 저장할 링크. 나와 똑같은 타입의 객체이기때문에 next의 타입도 Node<t>가 된다.
	
	/*데이터 필드 data의 값을 받아서 초기화하는 가장 기본적인 생성자*/
	public Node(T item) {
		data = item;
		next=null;
	}
}
