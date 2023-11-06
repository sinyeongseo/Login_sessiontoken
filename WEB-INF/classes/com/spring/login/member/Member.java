package com.spring.login.member;

public class Member {	//계층간 데이터 교환을 하기 위해 사용하는 객체이다.
	private String Id;
	private String Pw;
	private String Name;
	private int Age;
	
	public String getId() {
		return Id;
	}

	public void setId(String id) {
		Id = id;
	}

	public String getPw() {
		return Pw;
	}

	public void setPw(String pw) {
		Pw = pw;
	}

	public String getName() {
		return Name;
	}

	public void setName(String name) {
		Name = name;
	}

	public int getAge() {
		return Age;
	}

	public void setAge(int age) {
		Age = age;
	}

	public Member(String id, String pw, String name, int age) {
		super();
		Id=id;
		Pw=pw;
		Name=name;
		Age=age;
	}
	  @Override
	    public String toString() {
	        return "Member [Id=" + Id + ", Pw=" + Pw + ", Name=" + Name + ", Age=" + Age + "]";
	    }
}
