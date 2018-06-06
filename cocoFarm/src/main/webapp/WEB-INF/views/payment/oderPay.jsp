<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>    
        
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link rel="stylesheet" type="text/css" href="/css/sellerstyle.css">
<link rel="stylesheet" type="text/css" href="/css/oderstyle.css">


<script type="text/javascript"
	src="https://code.jquery.com/jquery-2.2.4.js"></script>
<!--우편번호 주소 검색 관련  -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>


<!--아임 포트 결제   -->
<script src="https://service.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>
			
<script type="text/javascript">
/*총 가격 초기화  */
var allsum=0;
/* 총수량 초기화 */
var allamount=0;
<c:forEach items="${pro}" var="pro_data" varStatus="status1">
var sumcon=[];
var amountcon=[];
var sum${status1.count}=0;
var allamount${status1.count}=0;
	<c:forEach items="${opt}" var="data" varStatus="status">
	var option_num${status.index}=Number(${data.idx});
	var option${status.index}=Number(${data.price});	
	var amount${status.index}=Number(${amount.get(status.index)});
	sum${status1.count}+=(option${status.index})*(amount${status.index});
	allamount${status1.count}+=amount${status.index};
	</c:forEach>
	sumcon.push(sum${status1.count});
	amountcon.push(allamount${status1.count});
</c:forEach>

$(document).ready(function() {
	
	
	
	
	
	
	//합산 금액 배열로 만든거 
	<c:set var="sumcon" value="sumcon"/> 
	
	console.log(${pro.size()});
	
	/*총 수량 갯수  */
	<c:set var="amountcon" value="amountcon"/>
	
	/*금액 합계금액  */
	console.log(${opt.size()});
	console.log("배열"+${sumcon}.length);
	for(var i=0; i<${pro.size()} ;i++){
		$(".product_orderpay"+i).text(${sumcon}[i]);
	} ;
	
	for(var i=0; i<${pro.size()} ;i++){
		$(".product_amount"+i).text(${amountcon}[i]);
	} ;
	
	/*총 가격 합산  */
	for(var i=0; i<${sumcon}.length ;i++){
		allsum+=Number(sumcon[i]);
	};
	
	/*총 수량 갯수 아직 안쓰고 있음*/
	for(var i=0; i<${amountcon}.length ;i++){ 
		allamount+=Number(amountcon[i]);
	};
	
	console.log("총수량"+allamount);
	<c:set var="allsum" value="allsum"/>
	<c:set var="allamount" value="allamount"/>
	
	
	//날짜 변수 만들기 
	var date = new Date(); 
	var year = date.getFullYear(); 
	var month = new String(date.getMonth()+1); 
	var day = new String(date.getDate()); 
	
	// 한자리수일 경우 0을 채워준다. 
	if(month.length == 1){ 
	  month = "0" + month; 
	} 
	if(day.length == 1){ 
	  day = "0" + day; 
	} 
	
	//오늘 날짜 
	var today=year+month+day;
	
	//주문번호  날짜+글번호+
	 var unit_num= Math.floor(Math.random() * 100) + 1;
	 //각자 상담 코드 넣어야됨 + 고객 sesson + 상품idx 
	 //우리 주분 번호 +고객 sesson 
	 var oder_num=today+unit_num+1541;
	<c:set var="today" value="today"/>
	<c:set var="oder_num" value="oder_num"/>
	console.log(${today});
	console.log("옵션번호"+option_num0);
	console.log("주문번호"+oder_num);
	
	
	
	
	
	
	
	
	// iamport 변수 초기화
	var IMP = window.IMP;
	IMP.init('imp97619342');	// 가맹점 식별코드
	
	
	
	
	
	
	
	
	
	
	// 결제 모듈 불러오기
	
	
	$("#pay").click(function() {
		/*수령인 */
		var mem_name =$(".mem_name").val();
		/*수령장소  */
		var mem_deliver=$(".mem_deliver").val();
		
		//핸드폰번호
		var phone_a=$(".phone_a").val();
		var phone_b=$(".phone_b").val();
		var phone_c=$(".phone_c").val();
		
		//우편번호
		var postcodify_postcode5=$(".postcodify_postcode5").val();
	
		//상세 주소 
		var postcodify_address=$(".postcodify_address").val();
		
		//상세 주소 
		var postcodify_details=$(".postcodify_details").val();
		
		//배송 메모
		var deliver_memo=$(".deliver_memo").val();
		
		
		//각각의 idx = ${data.idx} // saleOptions[${status.index}].proAmount
		//각각의 수량 amount= amount${status.index}

		
		console.log("배송지명"+mem_name);
		console.log("배송지" +mem_deliver);
		console.log("배송지" +mem_deliver);
		
		
		requestPayment();
	
		
		

		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	});

	
});

	


// 결제 요청 - 결제 모듈 불러오기
function save() {
	/*수령인 */
	var mem_name =$(".mem_name").val();
	/*수령장소  */
	var mem_deliver=$(".mem_deliver").val();
	
	console.log("들어가긴 함?");
	
		$.ajax({
           type : "POST",
           url : "/paycomple.do",
           dataType : "json",
           data : {
        	  memname: mem_name
           },
           success : function(data) {
              console.log(data.result);
              
              alert("성공");
           },
           error : function(e) {
        	  console.log(e.responseText);
        	   
        	   alert("실패"); 
           }
        });
}


function requestPayment() {
	save();
	   
	   IMP.request_pay({
	    pg : 'html5_inicis', //PG사 - 'kakao':카카오페이, 'html5_inicis':이니시스(웹표준결제), 'nice':나이스페이, 'jtnet':제이티넷, 'uplus':LG유플러스, 'danal':다날, 'payco':페이코, 'syrup':시럽페이, 'paypal':페이팔
	    pay_method : 'card', //결제방식 - 'samsung':삼성페이, 'card':신용카드, 'trans':실시간계좌이체, 'vbank':가상계좌, 'phone':휴대폰소액결제
	    merchant_uid : 'merchant_'+new Date().getTime(), //고유주문번호 - random, unique
	    name : '주문명:결제테스트', //주문명 - 선택항목, 결제정보 확인을 위한 입력, 16자 이내로 작성
	    amount : ${allsum}, //결제금액 - 필수항목
	    buyer_email : 'iamport@siot.do', //주문자Email - 선택항목
	    buyer_name : '구매자이름보내기 김환민', //주문자명 - 선택항목
	    buyer_tel : '010-1234-5678', //주문자연락처 - 필수항목, 누락되면 PG사전송 시 오류 발생
	    buyer_addr : '서울특별시 강남구 삼성동', //주문자주소 - 선택항목
	    buyer_postcode : '123-456', //주문자우편번호 - 선택항목
	    m_redirect_url : 'https://www.yourdomain.com/payments/complete' //모바일결제후 이동페이지 - 선택항목, 모바일에서만 동작
	}, function(rsp) { // callback - 결제 이후 호출됨, 이곳에서 DB에 저장하는 로직을 작성한다

		if ( rsp.success ) { // 결제 성공 로직
	        var msg = '결제가 완료되었습니다.';
	        msg += '고유ID :' + rsp.imp_uid;
	        msg += '상점 거래ID :' + rsp.merchant_uid;
	        msg += '결제 금액 :' + rsp.paid_amount;
	        msg += '카드 승인번호 :' + rsp.apply_num;
	        
	        // 결제 완료 처리 로직
			//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
			jQuery.ajax({
				url: "/paycomple.do", //cross-domain error가 발생하지 않도록 동일한 도메인으로 전송
				type: 'POST',
				dataType: 'json',
				data: {
					
					imp_uid : rsp.imp_uid,
					buyer_name :rsp.buyer_name
					}
			}).done(function(data) {
				//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
				if ( everythings_fine ) {
					var msg = '결제가 완료되었습니다.';
					msg += '\n고유ID : ' + rsp.imp_uid;
					msg += '\n상점 거래ID : ' + rsp.merchant_uid;
					msg += '\결제 금액 : ' + rsp.paid_amount;
					msg += '카드 승인번호 : ' + rsp.apply_num;
					
					alert(msg);
	    		} else {
	    			//[3] 아직 제대로 결제가 되지 않았습니다.
	    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
	    		}
	    	});
	        
	    } else { // 결제 실패 로직
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	    }
	    alert(msg);
	});
}

$(function() {
	$(".address_btn").postcodifyPopUp(); 
});


</script>
</head>
<body>
<div id="header_detail">

	<div id="header_top">
	<div class="container">
		<ul class="rigth_list">
			<li><a href="#">고객</a></li>
			<li><a href="#">사업자</a></li>
			<li><a href="#">관리자</a></li>
		</ul>
		
		<ul class="left_list">
			<li><a href="#">로그인</a></li>
			<li><a href="#">회원가입</a></li>
			<li><a href="#">알림</a></li>	
			<li><a href="/product/insert.do">마이페이지</a></li>	
		</ul>
	</div>
	</div>
	<div class="container">
		<div id="header_boby">
				<div class="logo"><img src="/img/main/logo_color.png" alt="코코팜 로고"></div>
				<!--2018년 5월 25일 hwanmin 추가   -->
				<div class="search">
					<form action="/seller.do" method="post">
						<input type="text" name="search_name" placeholder="농산물 검색하기"><button class="search_icon" style="cursor:pointer">
						</button>
					</form> 
				</div>
		
		</div>
		<div id="header_nav">
			<ul class="nav">
				<li><a href="/seller.do">농수산물</a></li>
				<li><a href="#">경매</a></li>
				<li><a href="#">농부 스토리</a></li>	
				<li><a href="#">자주 묻는 질문</a></li>	
				<li><a href="#">공지사항</a></li>
				<li><a href="#">회사소개</a></li>
			</ul>
		</div>
	</div>
</div>
<div class="container">
	<div class="odberheader">
		<h1>주문/결제</h1>
		<div class="nav_map">
		<span><strong><a href="">장바구니</a>
		</strong></span>
		<span>></span>
		<span><a href="">주문/결제</a></span>
		<span>></span>
		<span>완료</span>
		</div>
	</div>
	<div class="oder_content">
		<div class="product_area">
			<table cellspacing="0" class="tb_product">
				<caption>주문내역</caption>
				<colgroup>
					<col width="500">
					<col width="135">
					<col width="120">
					<col width="90">
					<col width="110">
					<col width="110">	
				</colgroup>
				<thead>
					<tr>
						<th scope="col" class="product">상품정보</th>
						<th scope="col">판매자</th>
						<th scope="col">배송비</th>
						<th scope="col">수량</th>
						<th scope="col" class="">할인</th>
						<th scope="col" class="">주문금액</th>
					</tr>
				</thead>
				<tbody>
					
				<c:forEach items="${pro}" var="pro_data" varStatus="status1">					
					<tr>
				
				 
				 
						<td class="product_info">
							<a href="" >
							<img src="/proimg/${pro_data.faceImg}" style="width: 92px">
							</a>
							<div class="product_dsc">
								<strong class="product_bn">[농수산물 판매자] 법인명</strong>
								<a href="#" class="product_name">
									<strong>[${today}]${pro_data.title}</strong>
								</a>
								<div class="option">
									<span class="option_icon">옵션</span>
									
									<c:forEach items="${opt}" var="data" varStatus="status">
									<ul>
										
										<li>${data.idx}/ ${data.optionName}/수량 ${amount.get(status.index)}개/${data.price}</li>
										<!--사용자 선택 옵션 -->
										<li><input type="hidden" name="saleOptions[${status.index}].idx" value="${data.idx}" ></li>
										<!--사용자 선택  수량  -->
										<li><input type="hidden" name="saleOptions[${status.index}].proAmount" value="${amount.get(status.index)}" ></li>
									</ul>
									</c:forEach>
									
								</div>
							</div>
						</td>
						
						
						<td>
						<a class="who_parmer" href="">판매자판매자</a>
						</td>
						<td>
						<span class="img_deliver_icon"></span>
						<span class="sum_deliver">무료</span>
						</td>
						<td>
						<em class="product_amount${status1.index}">48,000</em>
						</td>
						<td>
						-
						</td>
						<td>
						<em class="product_orderpay${status1.index}">48,000</em>
						</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>	<!--end product_area -->
		<div class="deliver_userarea">
			
			<div class="deliver_info">
				<h1>배송지 정보</h1>	
				<div class="deliver_check">
					<span class="reap">
					배송지선택
					</span>
					<input type="radio"  class="radio_r1" name="deliver_radio" value="1"/><label for="r1">신규배송지</label>
					<input type="radio"  class="radio_r1" name="deliver_radio" value="2" checked="checked"/><label for="r2">김환민</label>
				</div>
				<div class="delive_reci new_reci">
					<span class="reap ">
					수령인
					</span>
					<input type="text" class="mem_name" value="수령인 수령인" > 
				
				</div>
				<div class="delive_reci">
					<span class="reap">
					배송지명
					</span>
					<input type="text" class="mem_deliver" value="수령인 수령인" > 
				
				</div>
				
				<div class="delive_reci">
					<div class="cellphone_group">
					<span class="reap">
					연락처
					</span>
					<input type="text" class="phone_a" value="010" > -
					<input type="text" class="phone_b" value="0000" > -
					<input type="text" class="phone_c" value="0000" > 
					</div>
				</div>
				<div class="delive_reci deli_address">
					<span class="reap">
					배송지 주소
					</span>
					<div class="deliver_option">
					<input type="text" class="postcodify_postcode5" value="" > <button class="address_btn">우편번호</button><br />
						<div class="addr_detail">
							<input type="text" name="" class="postcodify_address" value="" />
							상세주소 :<input type="text" name="" class="postcodify_details" value="" />
						</div>
					</div>
				</div>	
				<div class="delive_reci">
					<span class="reap">
					배송 메모
					</span>
					<input type="text" class="deliver_memo" value="수령인 수령인" > 
				
				</div>	
				<p class="extra_info">
				<span class="ico_ext"></span><strong>2016년 8월 1일부터는 5자리 우편번호 사용이 의무화</strong>됩니다.
				<br>도로명주소+5자리 우편번호로 등록하셔서 코코팜 이용에 불편함이 없도록 하시길 바랍니다.</p>
            	<p class="extra_info">
				<span class="ico_ext"></span>도서산간 지역의 경우 추후 수령 시 추가 배송비가 과금될 수 있습니다.</p>
				
			
			</div>
			
			
			<div class="user_info">
			
			<h1>유저 정보</h1>
			<button id="pay">결제하기</button>
			<button id="pay11" name="pay11">통신하기</button>
			</div>
		</div>
	
	</div>
	
</div>
</body>

</html>