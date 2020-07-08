# javaScript

- 객체 기반의 스크립트 언어. 주로 웹 브라우저에서 사용되나 Node.js와 같은 프레임워크를 사용하면 서버 측 프로그래밍에서도 사용할 수 있다. 현재 컴퓨터나 스마트폰 등에 포함된 대부분의 웹 브라우저에는 자바스크립트 인터프리터가 내장되어 있다.

**인터프리터**
인터프리터 언어는 컴파일 작업을 거치지 않고, 소스 코드를 바로 실행할 수 있는 언어. **자바스크립트**는 웹 브라우저에 포함된 자바스크립트 인터프리터가 소스 코드를 직접 해석하여 바로 실행해준다.

<br>

### 출력

```jsx
//window.alert() 메소드는 브라우저와는 별도의 대화 상자를 띄워 사용자에게 데이터를 전달
alert("Java Script 실행");

//console.log() 메소드는 웹 브라우저의 콘솔을 통해 데이터를 출력
console.log("Java Script 실행되었음");
```

```jsx
<body>
<P id="demo"> p태그입니다. id는 demo입니다.</P>

<script type="text/javascript">
//document 객체의 getElementByID()나 getElementsByTagName() 등의 메소드를 사용하여 HTML 요소를 선택
var v= document.getElementById("demo").innerHTML;  //getter

alert(v);

//innerHTML 프로퍼티를 이용하면 선택된 HTML 요소의 내용(content)이나 속성(attribute)값 등을 손쉽게 변경할 수 있습니다.
document.getElementById("demo").innerHTML = "p tag id meno" //setter

</script>
```

<br>

### 변수

[var, let, const 차이점](https://gist.github.com/LeoHeo/7c2a2a6dbcf80becaaa1e61e90091e5d)

```jsx
var v;
```

```jsx
let nn = "5" + 3 + 1;	// 531
console.log(nn);
	
nn = 3 + 1 + "5";	// 45
console.log(nn);
```

```jsx
document.getElementById("demo").innerHTML = "홍길동 " + typeof"홍길동" + "<br>"
																					+ "325 " + typeof 325 + "<br>"
																					+ "3.141592 " + typeof 3.141592 + "<br>"
																					+ "true " + typeof true + "<br>"
																					+ "array" + typeof[1,2,3] + "<br>"
																					+ "object " + typeof {num:1, name:'abc'};
```

<br>

### 함수

```jsx
function func(){
	alert('func() 호출'); //대화상자를 통해 호출
};
func();
```

```html
<body>
<p id="demo"> p tag id demo </p>
<input type="button" value="input버튼" onclick="btnFunc()">
<br><br>

<button type="button" onclick="btnFunc()">button버튼</button>

<script type="text/javascript">
function btnFunc(){
	alert('button click');
};
</script>

</body>
```

매개변수도 사용 가능하다.

```html
<body>
<!--  <p id = "demo" onclick="alert('p 태그 클릭')">여기가 p태그</p>-->

<p id = "demo" onclick="func()">여기가 p태그</p>

<script type = "text/javascript">

function func(){
	alert("function() 호출");	
}

</script>
```

```html
<body>
<button type="button" onclick="btnclick()">버튼</button>

<script type="text/javascript">
function sum(x, y){
	return x+y;
}

function btnclick(){
	document.getElementById('demo').innerHTML = sum(2, 3);
}
</script>
</body>
```

```html
<body>

<!--  <p id = "demo" onclick="alert('p 태그 클릭')">여기가 p태그</p>-->

<p id = "demo" onclick="func()">여기가 p태그</p>

<script type = "text/javascript">

function func(){
	alert("function() 호출");	
}

</script>
```

<br>

### 배열

```jsx
let cars = [ "Saab", "Volvo", "BMW" ];
console.log( cars[1] );
```

```jsx
let cars = new Array(3);
cars[0] = '사브';
cars[1] = '볼보';
cars[2] = '비엠';

console.log( cars[0] );

//반복문
for(i = 0;i < cars.length; i++){
	console.log( cars[i] );
}

//for each문 (자바의 경우 : for(Object obj : cars){} )
for(i in cars){
	console.log(cars[i]);
}
```

<br>

### 객체

```jsx
let obj = {
	firstname:'길동',
	lastname:'홍',
	age : 24,
	func:function(){
		console.log("func호출");
		console.log("lastname:" + this.lastname);
	}
}

console.log(obj.firstname);
console.log(obj.lastname);
obj.func();
```



### onclick() 이벤트

```jsx
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<p id="demo">p tag id demo</p>

<p id="demo">p tag id demo</p>

<input type="button" value="input버튼" onclick="btnFunc1(1)">
<br><br>

<button type="button" onclick="btnFunc1(2)">button버튼</button>
<br><br>

<button type="button" onclick="btnclick()">버튼</button>

<script type="text/javascript">
function func() {
	alert('func() 호출');
}

function btnFunc() {
	alert('button click');
}

function btnFunc1( num ) {
	let name;
	if(num == 1){
		name = 'input tag button';
	}else{
		name = 'button tag';
	}
	alert( name );
	
	document.getElementById('demo').innerHTML = name;	
}

function sum(x, y) {
	return x + y;	
}
/* 
int sum(int x, int y){
	return x + y;
}
 */

function btnclick() {
	document.getElementById('demo').innerHTML = sum(2, 3);
}
 

</script>
</body>
</html>
```

<br>

### Date객체

```html
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<p id="demo"></p>
<br><br>

<input type="text" id="text" size="70">
<br><br>

<button type="button" onclick="displayDate()">지금 시간은?</button>

<script type="text/javascript">
function displayDate(){
	document.getElementById('demo').innerHTML = Date();
	document.getElementById('text').value = Date();
}

setInterval("displayDate()", 1000); //초단위 이동
</script>

</bodyror
</html>
```



```jsx
let d = new Date();	//현재 시각을 get

d= new Date(2020, 10, 26, 6, 5, 20, 0);	//setter
//		    	연도  월  일  시 분 초  밀초

document.getElementById("demo").innerHTML = d;
```

