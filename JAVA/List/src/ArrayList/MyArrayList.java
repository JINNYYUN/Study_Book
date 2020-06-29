package ArrayList;

import java.util.Arrays;

public class MyArrayList<E> {
	
	private static final int INIT_CAPACITY = 10;
	private E[] theData;
	private int size;
	private int capacity = INIT_CAPACITY; //배열의 크기 
	
	public MyArrayList() {
		theData = (E []) new Object[INIT_CAPACITY];//generic객체는 new를 써주지 못하기때문에 Object로 생성 후 형변환을 해준다.
		size =0;
	}
	
	public void add(E enEntry) {
		add(size, enEntry);	//사이에 맞게 뒤에 추가 
	}
	
	/*배열의 index번째의 위치에 넣는다.*/
	public void add(int index, E anEntry) {
		/*사이즈가 배열의 크기보다 커지면, 배열의 크기를 늘려줘야 한다.*/
		if(index<0||index>size) {	//유효하지 않은 인덱스가 들어 올 경우 = error, exception
			/*exception핸들*/
			throw new ArrayIndexOutOfBoundsException(index);	//배열 인덱스가 유효한 범위를 벗어났다. catch를 구현하여 어떻게 실행할지 결정한다.
		}
		if(size>=capacity) {
			rellocate();
		}
		for (int i = size; i > index ; i--) {
			theData[i] = theData[i-1];
		}
		theData[index]  = anEntry;
		size++; 
	}
	
	public E remove (int index) {
		if(index < 0|| index >=size) {
			throw new ArrayIndexOutOfBoundsException(index);
		}
		E returnValue = theData[index];
		for (int i = index+1; i < size; i++) {
			theData[i-1] = theData[i];
		}
		size--;
		return returnValue;
	}
	
	
	private void rellocate() {
		/* 1번
		E[] tmpArray = (E []) new Object [capacity*2];
		for (int i = 0; i < capacity; i++) {
			tmpArray[i] = theData[i];
		}
		theData = tmpArray;
		capacity *=2;
		*/
		
		//2번. 자바에서 제공하는 함수를 통해서 표현할 수 있다.
		capacity *=2;
		theData = Arrays.copyOf(theData, capacity);
		
	}
	
	public int indexOf(E enEntry) {
		for (int i = 0; i < size; i++) {
			if(theData[i].equals(enEntry)) {	//중요
				return i;
			}
		}
		return -1;
	}
	
	public E get(int index) {
		if(index<0||index>=size) {
			throw new ArrayIndexOutOfBoundsException(index);
		}
		return theData[index];
	}
	
	public E set(int index, E newValue) {
		if(index<0 || index>=size) {
			throw new ArrayIndexOutOfBoundsException(index);
		}
		E oldValue = theData[index];
		theData[index] = newValue;
		return oldValue;
	}
	
}
