<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="/css/table.css">
<link rel="stylesheet" href="/css/pro-jh.css">
<style>
.light.btn-primary {
    background-color: rgb(128 0 0 / 0%);
    border-color: #888888;
    margin-bottom: 4px;
    height : 10px;
   }
   .table thead th {
	border: none;
    padding: 8px;
    font-size: 16px;
	color: #fff;
}
.table tbody th, .table tbody td {
    border: none;
    padding: 9px;
    font-size: 15px;
    color: black;
}
.container {
  display: flex; 
}

.section {
  flex: 1;
  border:1px solid gray; 
  border-radius:20%; 
  height:150px; 
  padding-top:5px;
  margin-right: 20px; 
  margin-left: 20px; 
}
.card-body {
	overflow: scroll;
}
.tblSpan{
	font-size:18px;"
}
.products {
    display: flex;
    align-items: center;
    justify-content: space-evenly;
}
</style>

<div class="content-body" style="min-height: 975px;">
	<div class="page-titles">
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="javascript:void(0)">클래스룸 메인</a></li>
			<li class="breadcrumb-item active"><a href="javascript:void(0)">클래스룸</a></li>
		</ol>		
	</div>
	<div class="container-fluid" style="padding-top: 1rem;">
		<div class="row">
		<input type="hidden" name="lecapNo" id="lecapNo" value="${lecapNo }">	
			<p style="font-size:18px; color:black; margin-bottom: 0px;">${subNm }</p>
			<!-------------출결현황 --------------->
			<div class="col-xl-5 col-lg-5 bbb"
				style="width: 100%; height:330px;">
				<div class="card">
					<div class="card-header aaa" style="height: 60px;">
						<h4 class="card-title"
							style="font-weight: bold; font-size: 1.2em; color: #800000;">
							출결현황</h4>
						<div>
							<!-- Button trigger modal -->
							<button type="button" id="attendDmr" class="btn btn-primary btn-sm"
								data-bs-toggle="modal" data-bs-target="#exampleModal">
								출석이의신청</button>
						</div>
					</div>
					<div class="card-body p-0">
						<div
							class="table-responsive active-projects style-1 attendance-tbl">
							<div id="attendance-tbl_wrapper"
								class="dataTables_wrapper no-footer">
								<table id="attendance-tbl" class="table dataTable no-footer"
									role="grid" aria-describedby="attendance-tbl_info" style="height:180px; margin-top: 20px;">
									<thead>
										<tr>
											<th 
												aria-controls="attendance-tbl" rowspan="1" colspan="1"
												style="width: 158.7px; text-align: center;"><span style="font-size:16px;">성명 | 학과</span>
											</th>
											<c:forEach var="i" begin="1" end="15" step="1">
											<th class="sorting" tabindex="0"
												aria-controls="attendance-tbl" rowspan="1" colspan="1"
												aria-label="
															1
															MO
														: activate to sort column ascending"
												style="width: 16.9125px;"><span style="font-size:15px;">${i }주차</span>
											</th>
											</c:forEach>
											<th class="text-center sorting" tabindex="0"
												aria-controls="attendance-tbl" rowspan="1" colspan="1"
												aria-label="
															Total
															MO
														: activate to sort column ascending"
												style="width: 35.8px;"><span style="font-size:15px;">총 출석일수</span>
											</th>
											</thead>
									<tbody>
										<tr role="row" class="odd">
											<td class="sorting_1">
												<div class="products" style="text-align: center;">
													<img src="/resources/images/profile11.png"
														class="avatar avatar-md" alt="">
													<div style="text-align: center;">
														<h6 style="font-size: 15px;">${std.stdNm }</h6>
														<span style="font-size: 15px;">${std.stdNo }</span>
													</div>
												</div>
											</td>
											<c:set var="myAtd" value="0"/>
											<c:forEach items="${attendList }" var="list">
												<c:if test="${list.atdcYnCd eq 'Y' }">
													<c:set var="myAtd" value="${myAtd+1}"/>
													<td><span class="text-success" style="width:15px;">
														<i class="fa-solid fa-check"></i>
													</span></td>
												</c:if>	
												<c:if test="${list.atdcYnCd eq 'N' }">
													<td><span class="text-danger"><i
													class="fa-regular fa-xmark"></i></span></td>
												</c:if>							
												<c:if test="${list.atdcYnCd eq 'x' }">
													<td><span>
														<img src="/resources/images/jshminus.png" style="width:12px;">
													</span></td>
												</c:if>	
											</c:forEach>
											<td class="text-center">
												<span style="font-size: 15px;">${myAtd }/15</span>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
						
			<!------------- 공지사항 --------------->
			<div class="col-xl-6 col-lg-6 bbb" style="width: 50%; height:460px;" >
				<div class="card">
					<div class="card-header aaa">
						<h4 class="card-title"
							style="font-weight: bold; font-size: 1.2em; color: #800000;">
							공지사항</h4>
							<button type="button" id="noticeMore" class="btn btn-primary light sharp" data-bs-toggle="dropdown" aria-expanded="false">
								<svg width="18px" height="18px" viewBox="0 0 24 24" version="1.1">
								<g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
								<rect x="0" y="0" width="24" height="24"></rect>
								<circle fill="#000000" cx="5" cy="12" r="2"></circle>
								<circle fill="#000000" cx="12" cy="12" r="2"></circle>
								<circle fill="#000000" cx="19" cy="12" r="2"></circle></g></svg>
							</button>
					</div>
						<div class="card-body ccc" style="padding-top: 0;">
						<table class="table">
							<thead>
								<tr>
									<th>No</th>
									<th>제목</th>
									<th>작성일시</th>
								</tr>
							</thead>
							<tbody id="tbtb">
								<c:choose>
									<c:when test="${not empty noticeList}">
										<c:forEach items="${noticeList}" var="notice" varStatus="status">
											<tr class="tbtr">
												<td class="">${status.index + 1}</td>
												<td class="">	
													<a href="/hku/student/detailNotice/${notice.lecntNo}">${notice.lecntTtl}</a>
												</td>
												<td class="">${notice.lecntRegdate }</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="5">등록된 게시글이 없습니다</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
			</div>

			<!------------- 과제관리 --------------->
			<div class="col-xl-6 col-lg-6 bbb" style="width: 50%; height:460px;">
				<div class="card">
					<div class="card-header aaa">
						<h4 class="card-title"
							style="font-weight: bold; font-size: 1.2em; color: #800000;">
							과제목록</h4>
							<button type="button" id="assignMore" class="btn btn-primary light sharp" data-bs-toggle="dropdown" aria-expanded="false">
								<svg width="18px" height="18px" viewBox="0 0 24 24" version="1.1">
								<g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
								<rect x="0" y="0" width="24" height="24"></rect>
								<circle fill="#000000" cx="5" cy="12" r="2"></circle>
								<circle fill="#000000" cx="12" cy="12" r="2"></circle>
								<circle fill="#000000" cx="19" cy="12" r="2"></circle></g></svg>
							</button>
					</div>
					<div class="card-body ccc" style="padding-top: 0;">
						<table class="table">
							<thead>
								<tr>
									<th>No</th>
									<th>제목</th>
									<th>작성일시</th>
								</tr>
							</thead>
							<tbody id="tbtb">
								<c:set value="${list }" var="list"/>
								<c:choose>
									<c:when test="${not empty list }">
										<c:forEach items="${list}" var="list" varStatus="status">
											<tr class="tbtr">
												<td class="">${status.index + 1}</td>
												<td class="">	
													<a href="/hku/student/assignmentDetail/${list.asmNo}">${list.asmTtl }</a>
												</td>
												<td class="">${list.asmRegdate }</td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="5">등록된 게시글이 없습니다</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
$(function(){
	
	var assignMore = document.querySelector("#assignMore");
	assignMore.addEventListener("click", function(){
		location.href = `/hku/student/stdAssignmentList/${lecapNo}`;
	})
	
	var attendDmr = document.querySelector("#attendDmr");
	attendDmr.addEventListener("click", function(){
		location.href = `/hku/student/attendanceDmr`;
	})
	var noticeMore = document.querySelector("#noticeMore");
	noticeMore.addEventListener("click",function(){
		location.href = `/hku/student/noticeList`;
	})
	
})
</script>
