package dto;

import java.io.Serializable;
import java.util.Arrays;

public class ObjectDto implements Serializable {
	private String name;
	private int age;
	private String fruit[];
	
	public ObjectDto() {
		
	}
	
	
	public ObjectDto(String name, int age, String[] fruit) {
		super();
		this.name = name;
		this.age = age;
		this.fruit = fruit;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public int getAge() {
		return age;
	}


	public void setAge(int age) {
		this.age = age;
	}


	public String[] getFruit() {
		return fruit;
	}


	public void setFruit(String[] fruit) {
		this.fruit = fruit;
	}


	@Override
	public String toString() {
		return "ObjectDto [name=" + name + ", age=" + age + ", fruit=" + Arrays.toString(fruit) + "]";
	}
	
	
}
