# Timer

**시간 선택 option tag**

```html
<select id="selid" name="myChoice">
  <option value="180">원하는 시간을 선택해주세요(기본 시간 3분)</option>
  <option value="300">5분 </option>
  <option value="180">3분 </option>
  <option value="150">2분 30초 </option>
  <option value="120">2분 </option>
  <option value="60">1분 </option>
  <option value="30">30초 </option>
</select>
```

<br>

**value 취득방법1**

```jsx
let value = document.getElementById("selid").value;
count = value;
```

**value 취득방법2**

```jsx
choice = document.frm.myChoice.selectedIndex; //0~n-1
count = parseInt(document.frm.myChoice.options[choice].value);
```

<br>

**scheduling a call(호출 스케줄링)**

- `setTimeout` : 일정 시간이 지난 후에 함수를 실행하는 방법
- `setInterval` : 일정 시간 간격을 두고 함수를 실행하는 방법

```jsx
let time = 0;

clearInterval(time); //timer initialize
time = setInterval("myTimer()", 1000); //1초마다 myTimer()함수 실행

function myTimer() {
  count = count - 1;

  document.getElementById("countdown").innerHTML =
    "완료까지 <b>" + count + "초 남았습니다.";

  if (count == 0) {
    clearInterval(time);
    alert("시간이 완료되었습니다");
  }
}
```

<br>

**창** **종료버튼**

```html
<button type="button" onclick="window.close()">close</button>
```
