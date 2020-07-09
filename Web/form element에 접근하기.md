# form의 element에 접근하기

폼 요소를 **DOM으로 접근** 후, 이어서 폼 내부 인터페이스 요소들을 name 또는 type의 속성값을 식별자하여 접근하거나 form안의 요소의 인덱스를 참조하여(배열) 접근

<br>

**점표기법**과 **배열로 접근**

```html
<form name="formname">
  <input type="checkbox" id="ch1" value="20000" onclick="sum(0)" />야간
  조명(20,000원)<br />
  <input type="checkbox" id="ch2" value="4000" onclick="sum(1)" />배구네트
  *2면(4,000원)<br />
  <input
    type="checkbox"
    id="ch3"
    value="5000"
    onclick="sum(2)"
  />배구*10개(5,000원)<br /><br />

  합계금액 <input type="text" id="text" size="20" value="40800" /> 원
</form>
<script type="text/javascript">
  //첫번째 체크박스 이벤트 발생 시
  function sum(num) {
    //요소 이름을 속성으로 해서 접근
    alert(document.formname.ch1.value);

    //Tag Element 요소 접근
    alert(document.formname.elements[0].value);
  }
</script>
```

<br>

**활용 - checkbox 체크여부에 따라 합계금액의 value값 변화**

```html
<body>
  <br />
  기본사용료(2면,4시간) 40,800원

  <form name="formname">
    <input type="checkbox" id="ch1" value="20000" onclick="sum(0)" />야간
    조명(20,000원)<br />
    <input type="checkbox" id="ch2" value="4000" onclick="sum(1)" />배구네트
    *2면(4,000원)<br />
    <input
      type="checkbox"
      id="ch3"
      value="5000"
      onclick="sum(2)"
    />배구*10개(5,000원)<br /><br />

    합계금액 <input type="text" id="text" size="20" value="40800" /> 원
  </form>

  <h1>감사합니다</h1>

  <script type="text/javascript">
    let total = parseInt(document.getElementById("text").value);
    let arr = new Array(3);

    for (i = 0; i < arr.length; i++) {
      arr[i] = parseInt(document.getElementById("ch" + (i + 1)).value);
    }

    function sum(num) {
      //체크박스의 체크 여부확인
      if (document.formname.elements[num].checked == true) {
        total = total + arr[num];
      } else {
        total = total - arr[num];
      }

      //4번째 요소에 접근
      document.formname.elements[3].value = total;
    }
  </script>
</body>
```

<br>

**추가 - 태그별 접근**

```html
<body>
  <h1>체육관 이용 요금</h1>
  <br />
  기본사용료(2면,4시간) 40,800원

  <form name="formname">
    <input type="checkbox" id="ch1" value="20000" onclick="sum(0)" />야간
    조명(20,000원)<br />
    <input type="checkbox" id="ch2" value="4000" onclick="sum(1)" />배구네트
    *2면(4,000원)<br />
    <input
      type="checkbox"
      id="ch3"
      value="5000"
      onclick="sum(2)"
    />배구*10개(5,000원)<br /><br />

    합계금액 <input type="text" id="text" size="20" value="40800" /> 원
  </form>

  <h1>감사합니다</h1>

  <script type="text/javascript">
    let obj = document.getElementsByTagName("body")[0];
    alert(obj.getElementsByTagName("h1")[0].innerHTML);

    obj.getElementsByTagName("h1")[1].innerHTML = "안녕히 가십시오";
  </script>
</body>
```
