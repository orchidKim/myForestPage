<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Map.Entry"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/layout.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/mapResource/domestic.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/mapResource/raphael_min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-3.5.0.min.js"></script>

<script type="text/javascript">

	$(function(){

	<!-- 헤더랑 topBtn 숨기고 드러내는 기능 -->
		$("#main_header").hide();
		$("#topToBtn").hide();
		$(window).on("scroll", function() { 
			if($(window).scrollTop() > window.innerHeight-200) {
				$("#main_header").show();
				$("#topToBtn").show();
			} else {
				$("#main_header").hide();
				$("#topToBtn").hide();
			}
		});	
		/* $(".headerArea").on("mouseover", function() { 
			$("#main_header").show();
		});	 */
	
		<!-- 메인비주얼 전체보기 -->
		function funcThisSize() {
		   $(".main_visual").css( "height",window.innerHeight);   
		}	
	
	    $(window).resize( funcThisSize );
	    funcThisSize();
	    
	    <!--메인비주얼 하단 버튼 누르면 아래로 이동하게-->
	    $(".main_bottomBtn").on("click", function() {	
	        $('html, body').animate({scrollTop :window.innerHeight-85}, 250);
	    });  
	    
	    <!--버튼 누르면 맨 위로 이동하게-->
	    $("#topToBtn").on("click", function() {	
	        $('html, body').animate({scrollTop :0}, 250);
	    });  
	    
	    
	    <!--헤더 유저정보-->
	   /*  $(".user_info .infoList").hide(); 
	    
		$(".user_info").hover(function () { 
			$(".infoList").slideDown("fast"); 
		});
		
		$(".user_info .infoList").mouseout(function () { 
			$(".infoList").slideUp("fast");  
		}); */
		
	   
	});			
</script>
<!-- 맨 위로 이동하는 버튼 -->
<p id="topToBtn">
	<img src="${pageContext.request.contextPath}/resources/images/main_topBtn.png" alt="맨 위로 이동"/>
</p>


<!-- 메인 배경 (숲) -->
<div class="main_visual">
	<div class="main_visual_shadow">
		<c:if test="${empty user_id}">
			<div class="main_btn">
				<ul>
					<li><a
						href="${pageContext.request.contextPath}/member/login.do">로그인</a></li>
					<li><a
						href="${pageContext.request.contextPath}/member/register.do">회원가입</a></li>
				</ul>
			</div>
		</c:if>
		<div class="title">
			<p class="tit">
				<b>코로나</b>로_상처받은<br> 사람은_<b>휴양림</b>으로_가자<span>코상휴가</span>
			</p>
			<hr style="border: solid 2px #fff;">
			<p class="txt">
				코상휴가란? 실시간으로 전국의 코로나 확진자 수를 알려드리고,<br> 가장 확진자 수가 적은 지역의 휴양림을
				추천해드리는 사이트입니다.
			</p>
		</div>
		<a class="main_bottomBtn"> <img
			src="${pageContext.request.contextPath}/resources/images/main_bottomBtn.png"
			alt="아래로 이동" />
		</a>
	</div>
</div>
<!-- //메인 배경 (숲) -->





<!-- 메인 컨텐츠(지도랑, 확진자적은 지역 순위)-->
<div class="main_body_bg">
<div class="main_content">
	<div class="mapRankArea">
		<script type="text/javascript">
			window.onload = function() {
			<%String urlPath = "http://ncov.mohw.go.kr/bdBoardList_Real.do?brdId=1&brdGubun=13&ncvContSeq=&contSeq=&board_id=&gubun=";
			String pageContents = "";
			StringBuilder contents = new StringBuilder();

			//데이터 파싱 변수
			String str = null;
			Map<String, Integer> myMap = null;
			String[] pairs;

			try {
				URL url = new URL(urlPath);
				URLConnection con = (URLConnection) url.openConnection();
				InputStreamReader reader = new InputStreamReader(con.getInputStream(), "utf-8");

				BufferedReader buff = new BufferedReader(reader);

				while ((pageContents = buff.readLine()) != null) {
					if (pageContents.contains("RPSBaseData")) {
						contents.append(pageContents);
					}
				}

				buff.close();

				str = contents.toString().replace("RPSBaseData = [{", "").replace("}];", "").replace("},{", ",")
						.replace("\"", "").replaceAll("\\p{Z}", "").replace("name:", "").replace(",count:", ":").trim();

				myMap = new HashMap<String, Integer>();

				pairs = str.split(",");

				//울산 충청북도 서울 전라북도 경기 충청남도 부산 강원 경상북도 대전 세종 제주 대구 인천 전라남도 광주 경상남도 (17)
				for (int i = 0; i < pairs.length; i++) {
					String pair = pairs[i];
					String[] keyValue = pair.split(":");

					if (!keyValue[0].equals("검역")) {
						if (keyValue[0].equals("충북")) {
							myMap.put("충청북도", Integer.valueOf(keyValue[1]));
						} else if (keyValue[0].equals("충남")) {
							myMap.put("충청남도", Integer.valueOf(keyValue[1]));
						} else if (keyValue[0].equals("전북")) {
							myMap.put("전라북도", Integer.valueOf(keyValue[1]));
						} else if (keyValue[0].equals("전남")) {
							myMap.put("전라남도", Integer.valueOf(keyValue[1]));
						} else if (keyValue[0].equals("경북")) {
							myMap.put("경상북도", Integer.valueOf(keyValue[1]));
						} else if (keyValue[0].equals("경남")) {
							myMap.put("경상남도", Integer.valueOf(keyValue[1]));
						} else {
							myMap.put(keyValue[0], Integer.valueOf(keyValue[1]));
						}
					}
				}

				//System.out.println("afterParse : " + myMap);

			} catch (Exception e) {
				System.out.println("parse error");
				e.printStackTrace();
			}

			//울산 충청북도 서울 전라북도 경기 충청남도 부산 강원 경상북도 대전 세종 제주 대구 인천 전라남도 광주 경상남도(17)
			if (myMap.containsKey("서울")) {
				request.setAttribute("seoul", myMap.get("서울"));
			}
			if (myMap.containsKey("강원")) {
				request.setAttribute("gangwon", myMap.get("강원"));
			}
			if (myMap.containsKey("경기")) {
				request.setAttribute("gygg", myMap.get("경기"));
			}
			if (myMap.containsKey("인천")) {
				request.setAttribute("incheon", myMap.get("인천"));
			}
			if (myMap.containsKey("충청남도")) {
				request.setAttribute("chungnam", myMap.get("충청남도"));
			}
			if (myMap.containsKey("충청북도")) {
				request.setAttribute("chungbuk", myMap.get("충청북도"));
			}
			if (myMap.containsKey("대전")) {
				request.setAttribute("daejeon", myMap.get("대전"));
			}
			if (myMap.containsKey("세종")) {
				request.setAttribute("sejong", myMap.get("세종"));
			}
			if (myMap.containsKey("전라북도")) {
				request.setAttribute("jeonbuk", myMap.get("전라북도"));
			}
			if (myMap.containsKey("광주")) {
				request.setAttribute("gwangju", myMap.get("광주"));
			}
			if (myMap.containsKey("전라남도")) {
				request.setAttribute("jeonnam", myMap.get("전라남도"));
			}
			if (myMap.containsKey("경상북도")) {
				request.setAttribute("gyeongbuk", myMap.get("경상북도"));
			}
			if (myMap.containsKey("대구")) {
				request.setAttribute("daegu", myMap.get("대구"));
			}
			if (myMap.containsKey("경상남도")) {
				request.setAttribute("gyeongnam", myMap.get("경상남도"));
			}
			if (myMap.containsKey("울산")) {
				request.setAttribute("ulsan", myMap.get("울산"));
			}
			if (myMap.containsKey("부산")) {
				request.setAttribute("busan", myMap.get("부산"));
			}
			if (myMap.containsKey("제주")) {
				request.setAttribute("jeju", myMap.get("제주"));
			}

			//Map.Entry 리스트 작성
			List<Entry<String, Integer>> covMapCntList = new ArrayList<Entry<String, Integer>>(myMap.entrySet());

			//비교함수 Comparator를 사용하여 내림 차순으로 정렬
			Collections.sort(covMapCntList, new Comparator<Entry<String, Integer>>() {
				//compare로 값을 비교
				public int compare(Entry<String, Integer> obj1, Entry<String, Integer> obj2) {
					// 내림 차순으로 정렬
					return obj1.getValue().compareTo(obj2.getValue());
				}
			});

			//결과 출력
			for (Entry<String, Integer> tmp : covMapCntList) {
				if (tmp.getKey().equals(""))
					System.out.print(tmp.getKey() + "=" + tmp.getValue() + ", ");
			}

			//순위(1-10), 지역명
			request.setAttribute("loc1", covMapCntList.get(0).toString().split("=")[0]);
			request.setAttribute("loc2", covMapCntList.get(1).toString().split("=")[0]);
			request.setAttribute("loc3", covMapCntList.get(2).toString().split("=")[0]);
			request.setAttribute("loc4", covMapCntList.get(3).toString().split("=")[0]);
			request.setAttribute("loc5", covMapCntList.get(4).toString().split("=")[0]);
			request.setAttribute("loc6", covMapCntList.get(5).toString().split("=")[0]);
			request.setAttribute("loc7", covMapCntList.get(6).toString().split("=")[0]);
			request.setAttribute("loc8", covMapCntList.get(7).toString().split("=")[0]);
			request.setAttribute("loc9", covMapCntList.get(8).toString().split("=")[0]);
			request.setAttribute("loc10", covMapCntList.get(9).toString().split("=")[0]);%>
			//위치텍스트 색상 (색깔명 또는 색상코드 입력, 검정색의 색상코드는 #000000)
			//최초의 로드시 지역의 배경색
			var defaultLocColor = "white";
			//"rgba(255,0,0,0.2)";
			//최초의 로드시 지역의 테두리색
			var defaultLocStrockColor = "#111";
			//마우스 오버된 지역의 배경색
			var mouseOverLocColor = "#ccc";
			//마우스 오버된 지역의 테두리색
			var mouseOverLocStrockColor = "#111";

			var R = Raphael("location_map", 320, 400);
			var attr = {
				fill : defaultLocColor,
				stroke : defaultLocStrockColor,
				"stroke-width" : 0.5,
				"stroke-linejoin" : "round"
			};
			var locArray = {};

			//경기 : 좌상단 부터 시작 
			locArray.gygg = R
					.path(
							"M69,74 76,76 78,74 78,68 81,67 83,64 94,67 98,62 102,60 111,58 114,68 119,68 122,72 128,74 130,79 140,88 140,90 134,94 137,100 135,107 154,116 148,118 150,124 147,129 146,139 144,145 139,146 134,152 127,153 125,159 120,162 109,158 107,161 94,160 98,157 97,153 92,156 93,146 87,147 85,141 91,143 95,137 91,136 89,133 92,131 97,131 97,123 108,125 112,120 120,113 120,112, 117,110 112,107 112,105 111,104 113,102, 109,98 102,104 89,102 86,96 82,99 71,92 73,87 69,85 71,82 69,79 69,74z")
					.attr(attr);
			//서울 : 우하단 경기도와 경계에서 오른쪽시계방향으로 시작
			locArray.seoul = R
					.path(
							"M112,118 118,112 111,108 110,104 111,102 109,100 102,106 98,109 99,113 104,116 110,118 112,118z")
					.attr(attr);
			//인천 : 서울왼쪽상단 경계에서 아래쪽으로 시작
			locArray.incheon = R
					.path(
							"M96,109 98,115 102,117 108,119 110,120 107,123.5 98,121, 97,122 95,120 96,119 90,110 89,110 89,104 99,105z M79,105 84,105 85,107 85,111 80,110 79,105z")
					.attr(attr);
			//locArray.ganghwa = R.path("M79,105 84,105 85,107 85,111 80,110 79,105z").attr(attr);
			//강원 : 서울오른쪽상단겹치는부분에서 시작
			locArray.gangwon = R
					.path(
							"M98,60 104,58 113,56 116,68 121,68 124,72 130,74 132,79 142,88 142,90 136,94 139,100 137,107 156,116 150,118 152,124 149,129 148,139 146,145 152,150 152,150 153.5,145 157,137 160,135 161,138 169,141 181,140 175,146 189,147 192,149 199,148 205,153 207,148 211,153 224,150 231,154 239,143 234,139 234,132 225,118 222,108 199,81 180,33 175,34 151,6 147,7 142,4 145,18 137,16 134,22 130,23 131,30 125,29 124,20 121,18 123,8 120,5 115,11 117,17 108,20 106,18 105,24 99,25 93,30 86,31 90,40 87,45 89,47 91,53 98,60 z")
					.attr(attr);
			locArray.chungbuk = R
					.path(
							"M145,148 152,152 154,152 155,148 157,140 159,138 161,140 169,143 176,142 171.5,148 189,149 192,151 199,150 186,160 184,169 175,167 162,171 163,175 156,175 156,185 151,182 149,185 154,191 155,200 150,207 158,208 164,215 159,217 155,226, 146,227 140,224 135,218 136,213 133,209 133,208 132,203 140,199 124,193 127,186 131,182 127,178 128,173 121,163 128,160 128,155 133,155 135,155 140,147z")
					.attr(attr);
			locArray.daejeon = R
					.path(
							"M131,209 131,208 130,203 135,199 122,195 116,204 116,214 118,215 121,211 124,214 z")
					.attr(attr);
			locArray.sejong = R
					.path(
							"M125,186 129,182 125,178 126,173 121,166 118,170 117,181 123,190 z")
					.attr(attr);
			locArray.chungnam = R
					.path(
							"M119,166 116,170 115,181 121,190 119,196 114,204 113,214 118,218 121,214 125,216 132,211 135,218 139,225 134,225 131,231 120,219 115,222 112,220 107,223 102,216 93,216 91,222 80,227 73,221 76,217 73,207 75,206 71,202 75,198 71,190 72,183 68,175 65,182 57,173 65,164 71,168 77,167 74,160 75,153 81,163 88,162 90,174 100,166 101,162.5 106,164 110,161 117,163.5 120,164 z")
					.attr(attr);
			locArray.jeonbuk = R
					.path(
							"M142,227 136,227 131,233 120,221 115,224 112,222 107,225 102,218 93,218 91,224 80,229 77,238 85,238 83,242 84,248 77,249 65,259 78,264 70,268 71,274 75,276 81,273 86,264 95,268 101,267 102,271 101,277 104,279 116,277 122,280 128,275 137,279 139,273 139,265 135,258 138,252 148,237 154,235 155,228 150,230 z")
					.attr(attr);
			locArray.gwangju = R
					.path(
							"M77,292 78,284 84,283 90,285 94,281 101,288 98,298 92,298 89,300 85,298 85,294 80,291 78,293 77,292z")
					.attr(attr);
			locArray.jeonnam = R
					.path(
							"M68,270 70,276 75,278 81,275 86,266 95,270 101,269 102,273 101,279 104,281 116,279 122,282 128,277 137,281 135,290 144,301 144,310 140,309 138,315 132,313 135,321 141,319 140,328 134,326 133,333 131,333 130,319 120,325 121,329 125,337 115,345 106,339 111,337 111,332 115,334 116,327 105,330 98,333 93,334 94,346 87,347 81,336 78,343 70,355 63,354 63,343 66,341 63,336 71,335 64,326 74,321 69,313 61,319 62,306 58,305 61,300 55,288 63,277 63,273 68,270z M77,292 78,293 80,291 85,294 85,298 89,300 92,298 98,298 101,288 94,281 90,285 84,283 78,284 77,292z")
					.attr(attr);
			locArray.gyeongbuk = R
					.path(
							"M198,153 188,160 186,171 177,169 165,172 166,177 158,177 158,187 152,185 151,185 156,191 157,200 153,205 161,207 166,216 161,218 157,226 156,236 160,241 168,241 173,253 180,256 178,252 183,250 182,246 189,241 184,238 186,232 193,232 200,230 203,233 207,241 200,249 194,248 191,254 193,259 201,260 207,264 215,258 220,259 229,249 238,255 240,251 246,255 250,240 252,232 248,235 241,235 244,227 242,213 246,176 245,157 241,144 233,154 230,156 224,152 211,155 208,151 206,155.5 200,151 198,153z M273,145 276,142 278,141 283,140 280,148 276,147 275,145 273,145z M306,150 310,150 309,152z M311,152 315,150 314,152z")
					.attr(attr);
			//locArray.ulleung = R.path("M273,145 276,144 283,140 280,148 276,147 275,145 273,145 z").attr(attr);
			//locArray.dokdo = R.path("M312,150 316,150 315,152z M317,152 321,150 320,152z").attr(attr);
			locArray.daegu = R
					.path(
							"M184,258 180,253 185,251 184,247 191.5,241 185.5,237 187.5,234 193,234 200,232 201.5,235 205.5,241 199.5,247 193,247 189.5,253 191,259 186,256 184,258 z")
					.attr(attr);
			locArray.gyeongnam = R
					.path(
							"M147,301 138,288 141,275 142,264 138,258 142,251 146,244 152,238 155,238 159,243 166,244 172,256 180,258 184,261 186,259 192,262 198,262 208,267 213,262 219,260 216,264 221,268 229,272 229,276 220,284 213,287 205,300 194,296 194,302 184,301 181,307 186,308 181,315 181,318 175,315 168,317 162,313 161,304 157,304 154,309 151,308 146,312 z")
					.attr(attr);
			locArray.ulsan = R
					.path(
							"M224,258 229.5,251 238,257 241,253 245,257 245,272 241,271 238,278 231,274 232,271 224,267 219,264 222,260 z")
					.attr(attr);
			locArray.busan = R
					.path(
							"M232,277 224,284 215,289 213,293 209,298 212,299 217,299 220,303 225,302 231,296 232,290 239,282 235,279 z")
					.attr(attr);
			locArray.jeju = R
					.path(
							"M96,377 105,367 120,368 126,365 134,365 142,370 136,380 127,384 114,386 104,384 100,385 94,377 z")
					.attr(attr);

			var current = null;

			//state : 선택한 지역명 (gygg,seoul,incheon...)
			for ( var state in locArray) {

				switch (state) {
				case "seoul":
					document.getElementById(state).append("${seoul}");
					break;
				case "gygg":
					document.getElementById(state).append("${gygg}");
					break;
				case "incheon":
					document.getElementById(state).append("${incheon}");
					break;
				case "gangwon":
					document.getElementById(state).append("${gangwon}");
					break;
				case "chungbuk":
					document.getElementById(state).append("${chungbuk}");
					break;
				case "chungnam":
					document.getElementById(state).append("${chungnam}");
					break;
				case "daejeon":
					document.getElementById(state).append("${daejeon}");
					break;
				case "sejong":
					document.getElementById(state).append("${sejong}");
					break;
				case "jeonbuk":
					document.getElementById(state).append("${jeonbuk}");
					break;
				case "gwangju":
					document.getElementById(state).append("${gwangju}");
					break;
				case "jeonnam":
					document.getElementById(state).append("${jeonnam}");
					break;
				case "gyeongbuk":
					document.getElementById(state).append("${gyeongbuk}");
					break;
				case "daegu":
					document.getElementById(state).append("${daegu}");
					break;
				case "gyeongnam":
					document.getElementById(state).append("${gyeongnam}");
					break;
				case "ulsan":
					document.getElementById(state).append("${ulsan}");
					break;
				case "busan":
					document.getElementById(state).append("${busan}");
					break;
				case "jeju":
					document.getElementById(state).append("${jeju}");
				}

				locArray[state].color = Raphael.getColor();
				
				//document.getElementById(state).style.display = "block";

				(function(st, state) {
					//마우스를 특정 지역에 올리면 손가락 모양으로 변경
					st[0].style.cursor = "pointer";

					//특정 지역에 마우스를 올렸을 때
					st[0].onmouseover = function() {
						//A지역에서 B지역으로 마우스를 옮긴 경우, A지역의 설정
						current
								&& locArray[current].animate({
									fill : defaultLocColor,
									stroke : defaultLocStrockColor
								}, 500)
								//이전에 확인한 지역의 텍스트 감추기		
								&& (document.getElementById(current).style.display = "");

						//A지역에서 B지역으로 마우스를 옮긴 경우, B지역의 설정
						//fill : 마우스 오버된 지역의 배경색,  stroke : 마우스 오버된 지역의 테두리색 
						st.animate({
							fill : mouseOverLocColor,
							stroke : mouseOverLocStrockColor
						}, 500);
						document.getElementById(state).style.transform = "selecLocle(1.2)";
						//st.toFront();
						R.safari();
						//지역명 텍스트가 보이기
						document.getElementById(state).style.display = "block";

						current = state;
					}

					//특정 지역에 마우스를 올렸다가, 지도 밖으로 마우스를 옮긴 경우
					st[0].onmouseout = function() {
						//A지역에 마우스를 올렸다가, 지도 밖으로 마우스를 옮겼다면  A 지역의 설정은 다시 디폴트(최초의 설정)로 변경
						st.animate({
							fill : defaultLocColor,
							stroke : defaultLocStrockColor
						}, 500);
						//st.toFront();
						R.safari();
						//지역명 텍스트 감추기
						document.getElementById(state).style.display = "none";
					};

					//마우스를 특정 지역에 올려 지역명 텍스트가 떴을 때, 지역명 위에 마우스를 올린 경우
					document.getElementById(state).onmouseover = function() {
						current
								&& locArray[current].animate({
									fill : mouseOverLocColor,
									stroke : mouseOverLocStrockColor
								}, 500)
								//지역명 텍스트 보이기		
								&& (document.getElementById(current).style.display = "block");

						//특정 지역과 해당 지역명 텍스트에 동시에 마우스를 올린 경우, 강원도 지역안에서 지역명 텍스트(강원)를 동시에 마우스 오버 가능
						st.animate({
							fill : mouseOverLocColor,
							stroke : mouseOverLocStrockColor
						}, 500);
						//마우스를 특정 지역에 올리면 손가락 모양으로 변경
						document.getElementById(state).style.cursor = "pointer";
						document.getElementById(state).style.transform = "selecLocle(1.2)";
					}

					//지역명 텍스트에 마우스를 올린 다음, 다른 지역을 거치지 않고 지도 범위 밖으로 마우스 위치를 바꿨을 때
					document.getElementById(state).onmouseout = function() {
						st.animate({
							fill : defaultLocColor,
							stroke : defaultLocStrockColor
						}, 500);
						//지역명 텍스트 감추기
						document.getElementById(current).style.display = "none"
						document.getElementById(state).style.transform = "selecLocle(1)";
					}

					//클릭한 지역명 텍스트에 따라 다른 파라미터 넘기기
					document.getElementById(state).onclick = function() {
						switch (state) {
						case "seoul":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=서울"
							current = state;
							break;
						case "gygg":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=경기"
							current = state;
							break;
						case "incheon":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=인천"
							current = state;
							break;
						case "gangwon":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=강원"
							break;
						case "chungbuk":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=충청북도"
							break;
						case "chungnam":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=충청남도"
							break;
						case "daejeon":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=대전"
							break;
						case "sejong":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=세종"
							break;
						case "jeonbuk":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=전라북도"
							break;
						case "gwangju":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=광주"
							break;
						case "jeonnam":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=전라남도"
							break;
						case "gyeongbuk":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=경상북도"
							break;
						case "daegu":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=대구"
							break;
						case "gyeongnam":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=경상남도"
							break;
						case "ulsan":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=울산"
							break;
						case "busan":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=부산"
							break;
						case "jeju":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=제주"
							break;
						default:
							location.href = "#";
							break;
						}
					}

					//울산 충청북도 서울 전라북도 경기 충청남도 부산 강원 경상북도 대전 세종 제주 대구 인천 전라남도 광주 경상남도 (17)
					if ((selecLoc == '서울' && state == "seoul")
							|| (selecLoc == '강원' && state == "gangwon")
							|| (selecLoc == '경기' && state == "gygg")

							|| (selecLoc == '인천' && state == "incheon")
							|| (selecLoc == '충청남도' && state == "chungnam")
							|| (selecLoc == '충청북도' && state == "chungbuk")

							|| (selecLoc == '대전' && state == "daejeon")
							|| (selecLoc == '세종' && state == "sejong")
							|| (selecLoc == '전라북도' && state == "jeonbuk")

							|| (selecLoc == '광주' && state == "gwangju")
							|| (selecLoc == '전라남도' && state == "jeonnam")
							|| (selecLoc == '경상북도' && state == "gyeongbuk")

							|| (selecLoc == '대구' && state == "daegu")
							|| (selecLoc == '경상남도' && state == "gyeongnam")
							|| (selecLoc == '울산' && state == "ulsan")

							|| (selecLoc == '부산' && state == "busan")
							|| (selecLoc == '제주' && state == "jeju")) {
						st[0].onmouseover();
					}

					//클릭한 지역에 따라 다른 파라미터 넘기기
					st[0].onclick = function() {
						switch (state) {
						case "seoul":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=서울"
							current = state;
							break;
						case "gygg":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=경기"
							current = state;
							break;
						case "incheon":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=인천"
							current = state;
							break;
						case "gangwon":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=강원"
							break;
						case "chungbuk":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=충청북도"
							break;
						case "chungnam":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=충청남도"
							break;
						case "daejeon":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=대전"
							break;
						case "sejong":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=세종"
							break;
						case "jeonbuk":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=전라북도"
							break;
						case "gwangju":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=광주"
							break;
						case "jeonnam":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=전라남도"
							break;
						case "gyeongbuk":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=경상북도"
							break;
						case "daegu":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=대구"
							break;
						case "gyeongnam":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=경상남도"
							break;
						case "ulsan":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=울산"
							break;
						case "busan":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=부산"
							break;
						case "jeju":
							location.href = "${pageContext.request.contextPath}/forest/forestList.do?location=제주"
							break;
						default:
							location.href = "#";
							break;
							}
						};

					})(locArray[state], state);
				}
			};
		</script>

	
	
		<!-- 지도 부분 -->
		<div id="main_map">
			<div id="canvas">
				<div id="location_map"></div>
				<div id="domestic">
					<!-- 특정 지역 마우스 오버시 h2 태그안의 내용(지역명) 출력 -->
					<div id="seoul">
						<h2>서울</h2>
					</div>
					<div id="gygg">
						<h2>경기</h2>
					</div>
					<div id="incheon">
						<h2>인천</h2>
					</div>
					<div id="gangwon">
						<h2>강원</h2>
					</div>
					<div id="chungbuk">
						<h2>충청북도</h2>
					</div>
					<div id="chungnam">
						<h2>충청남도</h2>
					</div>
					<div id="daejeon">
						<h2>대전</h2>
					</div>
					<div id="sejong">
						<h2>세종</h2>
					</div>
					<div id="gwangju">
						<h2>광주</h2>
					</div>
					<div id="jeonbuk">
						<h2>전라북도</h2>
					</div>
					<div id="jeonnam">
						<h2>전라남도</h2>
					</div>
					<div id="gyeongbuk">
						<h2>경상북도</h2>
					</div>
					<div id="gyeongnam">
						<h2>경상남도</h2>
					</div>
					<div id="daegu">
						<h2>대구</h2>
					</div>
					<div id="busan">
						<h2>부산</h2>
					</div>
					<div id="ulsan">
						<h2>울산</h2>
					</div>
					<div id="jeju">
						<h2>제주</h2>
					</div>
				</div>
			</div>
			<script>
				var selecLoc = '';
			</script>
		</div>
		<!-- //지도 부분 -->

		



		<!-- 확진자 지역 순위 부분 -->
		<div id="main_topArea">
			<h2>확진자 적은 지역 <span>TOP 10</span></h2>
			<h3 class="top">
				<a
					href="${pageContext.request.contextPath}/forest/forestList.do?location=${loc1}"><span class="num">1</span>
					${loc1}</a>
			</h3>
			<h3 class="top">
				<a
					href="${pageContext.request.contextPath}/forest/forestList.do?location=${loc2}"><span class="num">2</span>
					${loc2}</a>
			</h3>
			<h3 class="top">
				<a
					href="${pageContext.request.contextPath}/forest/forestList.do?location=${loc3}"><span class="num">3</span>
					${loc3}</a>
			</h3>
			<h3 class="second">
				<a
					href="${pageContext.request.contextPath}/forest/forestList.do?location=${loc4}"><span class="num">4</span>
					${loc4}</a>
			</h3>
			<h3 class="second">
				<a
					href="${pageContext.request.contextPath}/forest/forestList.do?location=${loc5}"><span class="num">5</span>
					${loc5}</a>
			</h3>
			<h3 class="second">
				<a
					href="${pageContext.request.contextPath}/forest/forestList.do?location=${loc6}"><span class="num">6</span>
					${loc6}</a>
			</h3>
			<span class="others">
			<h3>
				<a
					href="${pageContext.request.contextPath}/forest/forestList.do?location=${loc7}"><span class="num">7</span>
					${loc7}</a>
			</h3>
			<h3>
				<a
					href="${pageContext.request.contextPath}/forest/forestList.do?location=${loc8}"><span class="num">8</span>
					${loc8}</a>
			</h3>
			</span>
			<span class="others">
			<h3>
				<a
					href="${pageContext.request.contextPath}/forest/forestList.do?location=${loc9}"><span class="num">9</span>
					${loc9}</a>
			</h3>
			<h3>
				<a
					href="${pageContext.request.contextPath}/forest/forestList.do?location=${loc10}"><span class="num">10</span>
					${loc10}</a>
			</h3>
			</span>
		</div>
	</div>
	<!-- //확진자 지역 순위 부분 -->
	
	
	
	
	
	<iframe width="1280" height="720" style="margin:0 auto" src="https://www.youtube.com/embed/QWb9yhqag9Q" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	
	
	
	
	
	
	
	
	
	
	
	<!-- 인기휴양림 -->
	<div class="popularityForest">
		<h2 style="clear: both;">인기 휴양림</h2>
		<c:if test="${!empty pickRankList}">
			<table>
				<tr>
					<c:forEach var="rank" items="${pickRankList}" begin="0" end="3">
						<!-- 해당 휴양림의 이미지가 존재x, 샘플 이미지로 출력 -->
						<c:if test="${empty rank.p_img}">
							<td><img
								src="${pageContext.request.contextPath}/upload/sample.PNG"
								style="max-width: 200px"></td>
						</c:if>
						<!-- 해당 휴양림의 이미지 존재, 출력 -->
						<c:if test="${!empty rank.p_img}">
							<td><img
								src="${pageContext.request.contextPath}/upload/${rank.p_img}"
								style="max-width: 200px"></td>
						</c:if>
					</c:forEach>
				</tr>
				<tr>
					<c:forEach var="rank" items="${pickRankList}" begin="0" end="3">
						<td><a
							href="${pageContext.request.contextPath}/forest/forestDetail.do?p_num=${rank.p_num}">${rank.p_name}</a></td>
					</c:forEach>
				</tr>
				<tr>
					<c:forEach var="rank" items="${pickRankList}" begin="4">
						<!-- 해당 휴양림의 이미지가 존재x, 샘플 이미지로 출력 -->
						<c:if test="${rank.p_img == null}">
							<td><img
								src="${pageContext.request.contextPath}/upload/sample.PNG"
								style="max-width: 200px"></td>
						</c:if>
						<!-- 해당 휴양림의 이미지 존재, 출력 -->
						<c:if test="${rank.p_img != null}">
							<td><img
								src="${pageContext.request.contextPath}/upload/${forest.p_img}"
								style="max-width: 200px"></td>
						</c:if>
					</c:forEach>
				</tr>
				<tr>
					<c:forEach var="rank" items="${pickRankList}" begin="4">
						<td><a
							href="${pageContext.request.contextPath}/forest/forestDetail.do?p_num=${rank.p_num}">${rank.p_name}</a></td>
					</c:forEach>
				</tr>
			</table>
		</c:if>
		<c:if test="${empty pickRankList}">아직 인기휴양림이 존재하지 않습니다.</c:if>
	</div>
	<!-- //인기휴양림 -->



	<!-- Q&A -->
	<div class="qnaArea">
		<h2>Q&amp;A</h2>
		<c:if test="${!empty qnaList}">
			<table class="qnaAreaTable">
				<tr>
					<th>번호</th>
					<th style="width:500px;">제목</th>
					<th>작성자</th>
					<th>답변여부</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
				<c:forEach var="qna" items="${qnaList}">
					<tr>
						<td>${qna.q_num}</td>
						<td><a
							href="${pageContext.request.contextPath}/qna/questAnswerDetail.do?num=${qna.q_num}">${qna.q_title}</a></td>
						<td>${qna.id}</td>
						<c:choose>
							<c:when test="${qna.answer eq 'no answer'}">
								<td>처리중</td>
							</c:when>
							<c:otherwise>
								<td>처리완료</td>
							</c:otherwise>
						</c:choose>
						<td>${qna.q_reg_date}</td>
						<td>${qna.q_hit}</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
		
	   <c:if test="${empty qnaList}">
         <table>
         	<tr>
               <th>번호</th>
               <th width="200">제목</th>
               <th>작성자</th>
               <th>답변여부</th>
               <th>작성일</th>
               <th>조회수</th>
            </tr>
            <tr>
            	<td colspan="6">작성된 Q&A 글이 없습니다.</td>
            </tr>
         
         </table>
      </c:if>
		
		<a class="moreBtn" href="${pageContext.request.contextPath}/qna/questAnswerList.do"><span>더보기</span></a>
	</div>
	<!-- //Q&A -->
	
	
	
	
	
	<!-- 공지사항 -->
	<div class="noticeArea">
		<h2>공지사항</h2>
		<c:if test="${!empty boarList}">
			<table class="noticeAreaTable">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
				<c:forEach var="board" items="${boarList}" begin="0" end="4">
					<tr>
						<td>${board.n_num}</td>
						<td><a
							href="${pageContext.request.contextPath}/board/boardView.do?n_num=${board.n_num}">${board.n_title}</a></td>
						<td>${board.id}</td>
						<td>${board.reg_date}</td>
						<td>${board.n_hit}</td> 
					</tr>
				</c:forEach>
			</table>
		</c:if>
		<%-- <c:if test="${empty boarList}">현재 공지사항에 글이 존재하지 않습니다.</c:if> --%>
		
		
	<c:if test="${empty boarList}">
	<table class="noticeAreaTable">
		<tr>
			<th>번호</th>
			<th width="500">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<tr>
			<td colspan="5">작성된 게시글이 없습니다.</td>
		</tr>
		
	</table>
</c:if>
		<a class="moreBtn" href="${pageContext.request.contextPath}/board/boardList.do"><span>더보기</span></a>
	</div>
	<!-- //공지사항 -->


	

</div>
</div>




