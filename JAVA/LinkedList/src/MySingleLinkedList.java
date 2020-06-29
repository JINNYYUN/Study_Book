/*SingleLinkedLink - 단방향 연결*/

/*하나의 리스트를 구현하기 위한 클래스*/
public class MySingleLinkedList<T> {
	
	/*첫번째 노드의 주소는 가지고 있어야 한다.*/
	public Node<T> head; //첫번째 노드의 주소 
	public int size = 0; //현재 연결되어 있는 노드의 개수
	
	/*생성자 초기화*/
	public MySingleLinkedList() {
		head = null;
		size = 0;
	}
	
	/*연결리스트의 index번째 주소를 반환하다*/
	public Node<T> getNode(int index) {
		if(index<0 || index>size)
			return null;
		
		Node<T> p = head;
		
		for (int i = 0; i < index; i++) {
			p = p.next;
		}
		
		return p;
	}
	
	/*index번째 노드에 저장된 데이터를 반환한다.*/
	public T get(int index) {
		if(index<0 || index>size) {
			return null;
		}
		Node<T> p = head;
		for (int i = 0; i < index; i++) {
			p = p.next;
		}
		return p.data;
	}
	
	/*search*/
	public int indexOf(T item) {
		Node<T> p = head;
		
		int index = 0;
		while(p==null) {
			if(p.data.equals(item))
				return index;
			else {
				p = p.next;
				index ++;
			}
		}
		return -1;
	}
	
	/*입력받은 item을 저장하는 새로운 노드를 만들어 연결리스트의 맨 앞에 추가한다.*/
	public void addFirst(T item) {
		Node<T> temp = new Node<T>(item);
		temp.next = head;
		head = temp;
		size++;
	}
	
	public void addAfter(Node<T> before, T item) {
		Node<T> temp = new Node<T>(item);
		temp.next = before.next;
		before.next = temp;
		size++;
	}
	
	/*연결리스트의 index번째 위체에 새로운 데이터를 삽입한다.*/
	public void add(int index, T item) {	
		if(index<0 || index > size) {
			return;
		}
		if(index ==0 ) {
			addFirst(item);
		}
		
		else {
			Node<T> temp = getNode(index-1);
			addAfter(temp, item);
		}
	}
	
	public T removeFirst() {
		if(head == null) {
			return null;
		}
		
		T temp = head.data;
		head = head.next;
		size--;
		return temp;
	}
	
	public T removeAfter(Node<T> before) {
		if(before.next == null) {
			return null;
		}
		T temp = before.next.data;
		before.next = before.next.next;
		size--;
		return temp;
		
	}
	
	public T remove(T item) {	//delete
		Node<T> p = head;
		Node<T>	q = null;
		//q는 항상 p의 직전 노드를 가르킴. p가 첫번째 노드일 경우 q는 null임 
		while(p!=null && !p.data.equals(item)) {
			q= p;
			p = p.next;
		}
		if(p==null) {
			return null;
		}
		if(q==null) {
			return removeFirst();
		}
		else {
			return removeAfter(q);
		}
	}
	
	
	public static void main(String[] args) {
		MySingleLinkedList<String> list = new MySingleLinkedList<>();
		list.add(0,"saturday");
		list.add(1, "Friday");
		list.add(0, "Monday"); //M, S, F
		list.add(2, "tuesday");	// M, S, T, F
		
		String str = list.get(2); //str = "Tuesday";
		int pos = list.indexOf("Friday");	//pos = 3
	}
}
