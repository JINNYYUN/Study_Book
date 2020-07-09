# 페이지 이동과 값 넘겨주기

**페이지 이동**

[**view1] - a태그로 이동\*\*

```html
<body>
  <h2>여기는 View1입니다</h2>

  <a href="view2.html">View2로 이동</a>
</body>
```

[**view2] - Dom method 활용(location.href 로 페이지 이동)\*\*

```html
<h2>여기는 View2입니다</h2>

<input type="button" value="이전으로 " onclick="history.back()" />

<input type="button" value="현재페이지 갱신" onclick="location.reload()" />

<input type="button" value="진행" onclick="history.forward()" />

<button type="button" onclick="gopage()">View3로 이동</button>

<script>
  function gopage() {
    location.href = "view3.html";
  }
</script>
```

`history.back()` : 브라우저가 세션 기록의 바로 뒤 페이지로 이동

`History.forward()` : 브라우저가 세션 기록의 바로 앞 페이지로 이동

`location.reload()` : 현재 페이지를 새로 고침 `history.go(0)`, `setTimeout()` 으로 대체 가능

`location.href= "이동할 페이지 주소"` : 페이지 이동

[**view3]\*\*

```html
<body bgcolor="#0000ff">
  <h3>여기는 View3입니다</h3>
</body>
```

<br>

### 페이지 이동시 값도 함께 넘겨주기

### a Tag

```html
<a href="NewFile.jsp?name=홍길동&age=24">NewFile.jsp로 이동</a>
```

### form

입력을 안했을 경우를 체크할 수 없다

```html
<form action="NewFile.jsp">
  이름 : <input type="text" name="name" />
  <br />
  나이 : <input type="text" name="age" />
  <br />
  <input type="submit" value="이동" />
</form>
```

### JavaScript

입력을 했는지 안했는지 확인할 수 없다.

```html
이름 : <input type="text" name="name" />
<br />
나이 : <input type="text" name="age" />
<br />
<button type="button" onclick="btnclick()">이동</button>
```

```jsx
function btnclick() {
  let name = document.getElementById("name").value;
  let age = document.getElementBtId("age").value;

  location.href = "NewFile.jsp?name=" + name + "&age" + age;
}
```
