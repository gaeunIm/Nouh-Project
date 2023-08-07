<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/student/study-pjs.css">
<link rel="stylesheet" href="/css/table.css">
<style>
@media only screen and (min-width: 1199px) and (max-width: 1920px) {
	.customeoff {
		width: 600px !important;
	}
}

.form-control {
	width: 450px;
}
.nav-link {
    color: #000;
}
.custom-tab-1 .nav-link:focus, .custom-tab-1 .nav-link:hover, .custom-tab-1 .nav-link.active {
    font-weight: 800;
}
.st-wrap{
	overflow: scroll;
	height: 663px;
	margin-top: 15px;
}
.thead-dark{
      position: sticky;
      top: 0px;
}
</style>
<div class="content-body">
	<div class="page-titles">
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="javascript:void(0)">Home</a></li>
			<li class="breadcrumb-item active"><a href="javascript:void(0)">스터디룸</a></li>
		</ol>
	</div>
	<div class="container-fluid">
		<div class="card" id="card-title-1">
			<div class="card-body">
					<div class="custom-tab-1">
						<ul class="nav nav-tabs">
							<li class="nav-item">
								<a class="nav-link active" data-bs-toggle="tab" href="#home1">가입중인스터디</a>
							</li>
							<li class="nav-item">
								<a class="nav-link" data-bs-toggle="tab" href="#profile1">승인 대기목록</a>
							</li>
						</ul>
						
						<div style="display: flex; justify-content: end; position: relative;" >
							<a class="btn btn-primary" data-bs-toggle="offcanvas"
								href="#offcanvasExample" role="button"
								aria-controls="offcanvasExample" style="position:absolute; background: #0070c0; border-color: #0070c0; top: -44px; padding: 9px 20px; height: 37px;">스터디 개설</a>
						</div>
					</div>					
				
				<div class="tab-content">
					<div class="tab-pane fade show active" id="home1" role="tabpanel">
						
							<div class="row" id="studyListDiv" style="margin-top: 23px; padding-top: 14px; margin-left: 15px; height:640px; overflow:scroll; width: 100%;">
								<c:choose>
									<c:when test="${empty studyList }">
										<p>현재 가입되어있는 스터디가 없습니다.</p>
									</c:when>
									<c:otherwise>
										<c:forEach items="${studyList }" var="study">
									
											
											<div class="studycard-wrap" style="width: 24%;">
												<div class="study-top">
													<span class="study-text">[ 스터디명 : </span>
													<div class="study-name">${fn:substring(study.studyName,0,13) } ]</div>
												</div>
												<hr>
												<div class="study-title">${fn:substring(study.studyIntro,0, 50) }</div>
												<hr>
												<div class="study-bottom">
													<div class="bottom1">
														<span class="date-text">생성일 :</span>
														<div class="reg-date">												
															<fmt:parseDate value="${study.studyRegdate }" var="regDate" pattern="yyyy-MM-dd HH:mm:ss"/>
	                             							<fmt:formatDate value="${regDate }" pattern="yyyy-MM-dd"/>
														</div>
														<div style="margin-left: 55px;">
															<a href="/hku/student/studyRoom?studyNo=${study.studyNo }">
																<button class="end-button">입장</button>
															</a>
														</div>
													</div>
													<div class="bottom2">
														<img alt="" src="/images/왕관.png" class="crownImg">
														<div class="master-name">${study.stdNm }</div>
														<div class="hit-con">
															<img alt="" src="/images/조회수.png" class="hitImg">
															
															<div class="cnt-text">인원:</div>
															<div class="study-cnt">${study.count} / ${study.studyCpcy }</div>
														</div>
													</div>
												</div>
											</div>
											
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</div>		
					</div>
				
				<!-- 승인대기중인 스터디 목록 -->
				<div class="tab-pane fade" id="profile1">
					<div class="st-wrap">
						<table class="table" style="margin-top: -16px; ">
							<thead class="thead-dark">
								<tr>
									<th style="width:180px;">스터디번호</th>
									<th style="width:450px;">스터디명</th>
									<th style="width:280px;">가입신청일</th>
									<th style="width:350px;">스터디장</th>
									<th style="width:400px;">신청사유</th>
									<th style="width:200px;">승인여부</th>
								</tr>
							</thead>
							<tbody>
								<c:choose>
									<c:when test="${empty waitStudy }">
										<td colspan="6">가입승인 대기중인 스터디가 없습니다</td>
									</c:when>
	
									<c:otherwise>
										<c:set value="0" var="count"/>
										<c:forEach items="${waitStudy }" var="waitStudy">								
											<tr>
												<td><c:out value="${waitStudy.studyNo }"></c:out></td>
												<td><c:out value="${waitStudy.studyName }"></c:out></td>
												<td><c:out value="${waitStudy.joinRegdate }"></c:out></td>
												<td><c:out value="${waitStudy.stdNm }"></c:out></td>
												<td><c:out value="${waitStudy.joinReason }"></c:out></td>
												<c:if test="${waitStudy.aprvSttsCd == 'wait' }">
													<td><button type="button" class="btn btn-danger" id="regBtn" style=" margin-bottom: 12px; padding: 8px 15px; background: #0070c0; border-color: #0070c0;">대기</button> </td>												
												</c:if>	
												<c:if test="${waitStudy.aprvSttsCd == 'rej' }">
													<td><a href="#" class="btn btn-danger" id="regBtn" style=" margin-bottom: 12px; padding: 8px 15px; background: #ff4343; border-color: #ff4343;">반려</a></td>																							
												</c:if>								
											<tr>	
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
						</div>				
					</div>
				</div>
				<!-- end tab -->
				</div>

				<div class="offcanvas offcanvas-end customeoff" tabindex="-1"
					id="offcanvasExample">
					<div class="offcanvas-header">
						<h5 class="modal-title" id="#gridSystemModal">스터디 개설</h5>
						<button type="button" class="btn-close"
							data-bs-dismiss="offcanvas" aria-label="Close">
							<i class="fa-solid fa-xmark"></i>
						</button>
					</div>
					<div class="offcanvas-body">
						<div class="container-fluid">
							<form name="addStudyForm" >
								<div>
									<div class="col-xl-6 mb-3">
										<label for="exampleFormControlInput1" class="form-label">
										스터디 이름 <span class="text-danger">*</span>
										</label> <input type="text" class="form-control" id="studyName" name="studyName"
										
											id="exampleFormControlInput1" placeholder="">
									</div>
									<div class="col-xl-6 mb-3">
										<label for="exampleFormControlInput2" class="form-label">
											인원수 <span class="text-danger">*</span>
										</label>
										<input type="text" class="form-control" id="exampleFormControlInput2" name="studyCpcy" placeholder="">
									</div>
									<div class="col-xl-6 mb-3">
										<label for="exampleFormControlInput2" class="form-label">
										스터디 소개글<span class="text-danger">*</span>
										</label>
										<textarea cols="10" rows="10" class="form-control" name="studyIntro" id="studyIntro" placeholder=""></textarea>
									</div>
									<div>
										<input type="button" class="btn btn-primary" onclick="addStudy()" value="개설">
										<button class="btn btn-danger light ms-1">취소</button>
										<button class="btn btn-danger light ms-1" onclick="auto()">자동완성</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
</div>
<script>

function studyList(){
	var stdNo = {
			"stdNo":"${sessionScope.std.stdNo}"
	};
	console.log("보낸 stdNo: ", stdNo);
	var body = $("#studyListDiv");
	$.ajax({
		type:"get",
		data:stdNo,
		url:"/hku/student/getStudyList",
		dataType:"json",
		success:function(res){
			console.log("res: ",res);
			
			var data = '';
			for(var i = 0; i < res.length; i++){
				data += `	<div class="studycard-wrap" style="width: 24%;">
									<div class="study-top">
									<span class="study-text">[ 스터디명 : </span>
									<div class="study-name">\${res[i].studyName.substring(0, 13) } ]</div>
								</div>
								<hr>
								<div class="study-title">\${res[i].studyIntro.substring(0, 50) }</div>
								<hr>
								<div class="study-bottom">
									<div class="bottom1">
										<span class="date-text">생성일 :</span>
										<div class="reg-date">	
											\${res[i].studyRegdate.substring(0, 10)}										
										</div>
										<div style="margin-left: 55px;">
											<a href="/hku/student/studyRoom?studyNo=\${res[i].studyNo }">
												<button class="end-button">입장</button>
											</a>
										</div>
									</div>
									<div class="bottom2">
										<img alt="" src="/images/왕관.png" class="crownImg">
										<div class="master-name">\${res[i].stdNm }</div>
										<div class="hit-con">
											<img alt="" src="/images/조회수.png" class="hitImg">
											
											<div class="cnt-text">인원:</div>
											<div class="study-cnt">\${res[i].count} / \${res[i].studyCpcy }</div>
										</div>
									</div>
								</div>
							</div>`;
			}
			body.html(data);
		}
	})
}


function addStudy(){
	var addStudyForm = document.forms.addStudyForm;
	
	var studyName = addStudyForm.studyName.value;
	var studyCpcy = addStudyForm.studyCpcy.value;
	var studyIntro = addStudyForm.studyIntro.value;
	studyIntro = studyIntro.replaceAll(/(\n|\r\n)/g, "<br>");
	console.log("체킁 : ", studyIntro)
	let data = {
		"studyName" : studyName,
		"studyCpcy" : studyCpcy,
		"studyIntro" : studyIntro
	}
	let xhr = new XMLHttpRequest();
	xhr.open("POST","/hku/student/study", true);
	xhr.setRequestHeader("Content-Type","application/json; charset=utf-8");
	xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			if(xhr.responseText === "SUCCESS"){
				console.log("성공");
// 				location.reload(true);
				studyList();
				$(".btn-close").click();
		      	swal({
		          title: "스터디 개설에 성공했습니다.!", 
		          icon: "success"
		        });
		      	$(".btn-close").click();
			} else if(xhr.responseText === "FAILED"){
				console.log(" 실패");
// 				location.reload(true);
			}
		}
	}
	xhr.send(JSON.stringify(data));
// 	studyList();
// 	location.reload(true);
}

function auto(){
	
	str ='2023 3회 정보처리기사 필기 시험에 맞춰서 스터디를 구성해서 자격증을 준비해보려고 합니다.\n\r';
	str+= '스터디 주제 : 정보처리기사 실기\n\r스터디 목표 : 2023 3회 정보처리기사 실기 합격\n\r'
	str+= '예상 스터디 일정(횟수) : 매주 월,수,금 오후 9시\n\r'
	str+= '스터디 내용 : 20년 이후 기출문제 스터디  풀이 및 공유와 신기술 문제 스터디\n\r 이후 각자 문제집으로 호흡맞춰 스터디예정\n\r '
	str+= '스터디 관련 주의사항 :3회 이상 불참시 스터디 탈퇴 조건입니다. \n\r모두 같이 열심히 해봐요!'
	
	event.preventDefault();
	document.querySelector('#studyName').value = '정보처리기사 스터디';
	document.querySelector('#exampleFormControlInput2').value  = '5';
	document.querySelector('#studyIntro').value  = str;
}
</script>

