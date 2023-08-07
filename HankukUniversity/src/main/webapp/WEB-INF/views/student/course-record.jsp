<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/css/table.css">
<link rel="stylesheet" href="/css/student/course-info.css">
<div class="content-body">
	<div class="page-titles">
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="javascript:void(0)">수강정보</a></li>
			<li class="breadcrumb-item active"><a href="javascript:void(0)">수강이력</a></li>
		</ol>
    </div>
	<div class="container-fluid searchCon">
		<div class="card" id="card-title-1">
			<div class="card-body" style="color: black; font-size: 18px;	padding: 0.75rem;">
				<div class="myInfo">
					학과:&nbsp;&nbsp;&nbsp;
					<input type="text" class="deptText" value="${std.deptNm }" disabled>
					학번:&nbsp;&nbsp;&nbsp;
					<input type="text" class="noText" value="${std.stdNo }" disabled>
					이름:&nbsp;&nbsp;&nbsp;
					<input type="text" class="nameText" value="${std.stdNm }" disabled>
					학년:&nbsp;&nbsp;&nbsp;
					<input type="text" class="gradeText" value="${std.grade }학년" disabled>
					생년월일:&nbsp;&nbsp;&nbsp;
					<input type="text" class="birthText" value="${std.stdBrdt }" disabled>
				</div>
			</div>
		</div>
	</div>
	<div class="container-fluid subCon">
		<div class="card" id="card-title-1">
			<div class="card-body" style="padding-top: 0px; color: black; font-size: 18px;	padding: 0.75rem;">
				<div class="recordMain">
					<div class="recordLeft">
						<div class="lTitle">
							<div style="color: maroon;  font-weight: 900; margin-bottom: -10px;">학점이수현황</div>
							<div class="totalCnt">
								<span>총이수학점&nbsp;:&nbsp;&nbsp;</span><div class="totalLeft"></div>
							</div>
						</div>
						<div class="record-wrap1" style="margin-top: 10px;">
							<table class="table" style="margin-top: -22px;">
								<thead class="thead-dark">
									<tr>
										<th style="width: 150px;">이수구분</th>
										<th style="width: 150px;">신청학점</th>
										<th style="width: 150px;">이수학점</th>
									</tr>
								</thead>
								<tbody id="craditBody">
									<!-- 동적추가 -->
									<tr>
										<td class="crs aa" style="padding:11px;">전필</th>
										<td class="aa" style="padding:11px;">0</td>
										<td class="aa" style="padding:11px;">0</td>
									</tr>
									<tr>
										<td class="crs aa" style="padding:11px;">전선</th>
										<td class="aa" style="padding:11px;">0</td>
										<td class="aa" style="padding:11px;">0</td>
									</tr>
									<tr>
										<td class="crs aa" style="padding:11px;">교필</th>
										<td class="aa" style="padding:11px;">0</td>
										<td class="aa" style="padding:11px;">0</td>
									</tr>
									<tr>
										<td class="crs aa" style="padding:11px;">교선</th>
										<td class="aa" style="padding:11px;">0</td>
										<td class="aa" style="padding:11px;">0</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="bottomTitle">
							<div style="color: maroon;  font-weight: 900; margin-bottom: -10px;">학점이수현황 도표</div>
						</div>
					    <div style="width:445px; height:300px; margin-top: 12px;">
					        <canvas id="myChart" style="width:445px; height:300px;"></canvas>
					    </div>
					</div>
					<div class="recordRight">
						<div class="lTitle" style="margin-bottom: 19px;">
							<div style="color: maroon;  font-weight: 900; margin-bottom: -10px;">과목이수현황</div>
						</div>
						<div class="record-wrap2" style="margin-top: 10px;">
							<table class="table" style="margin-top: -22px;">
								<thead class="thead-dark">
									<tr>
										<th style="width: 330px;">교과목명</th>
										<th style="width: 130px;">이수구분</th>
										<th style="width: 130px">학점</th>
										<th style="width: 130px;">등급</th>
										<th style="width: 250px;">이수학기</th>
									</tr>
								</thead>
								<tbody id="subBody">
									<!-- 동적추가 -->
									<tr>
										<td colspan="5" style="padding:11px; text-align: center">이수구분을 선택하세요.</th>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
<script>
$(function(){
	craditList();
	getMyChart();
	
	$(document).on("click","tr", function(){
		$('tr').css('background', '');
		$(this).css('background', '#6e6e6e26');
		var crs = $(this).find('.crs');
		
		var crsClassfCd = crs.attr("id")
		
		var dataObj = {
			"crsClassfCd" : crsClassfCd
		}
		
		subRecordList(dataObj)

	})
})

// 학점이수현황 가져오는 함수
function craditList(){
	var craditBody = $("#craditBody");
	
	$.ajax({
		type:"get",
		url : "/hku/cradit-history",
		dataType : "json",
		beforeSend : function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success : function(res){
			console.log("res:",res)

			var data = '';
			var sum = 0;
			var mSum = 0;
			var sSum = 0;
			
			if(res.length > 0){
				for(var i = 0; i < res.length; i++){
					
					if(`\${res[i].crsClassfCd}` == 'MR' || `\${res[i].crsClassfCd}` == 'MS'){
						mSum += parseInt(`\${res[i].crdSum}`);
					}else{
						sSum += parseInt(`\${res[i].crdSum}`);
					}
					
					sum += parseInt(`\${res[i].crdSum}`);
					
					data += `<tr>
								<td id="\${res[i].crsClassfCd}" class="crs aa" style="padding:11px;">\${res[i].crsClassfNm}</th>
								<td id="\${res[i].crsClassfCd}" class="aa" style="padding:11px;">\${res[i].reqCrdSum}</td>
								<td id="\${res[i].crsClassfCd}" class="aa" style="padding:11px;">\${res[i].crdSum}</td>`
					data +=	`</tr>`;
				}
				craditBody.html(data);
				$('.totalLeft').text(sum+"학점")
				initSubList();
				dataSetAdd(mSum, sSum)
			}
			
		}
	})
}

// 과목이수현황 가져오기
function subRecordList(obj){
	var subBody = $("#subBody");
	$.ajax({
		type:"post",
		data:JSON.stringify(obj),
		url:"/hku/sub-history",
		dataType:"json",
		beforeSend : function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		contentType:"application/json; charset=utf-8",
		success:function(res){
			console.log(res);
			
			var data = '';
			if(res.length > 0){
				for(var i = 0; i < res.length; i++){
					let score = scoreChange(`\${res[i].crsScr}`)
					data += `<tr>
								<td style="padding:11px;">\${res[i].subNm}</th>
								<td style="padding:11px;">\${res[i].crsClassfNm}</td>
								<td style="padding:11px;">\${res[i].crsScr}</td>
								<td style="padding:11px;">\${score}</td>
								<td style="padding:11px;">\${res[i].lecapYr}년 &nbsp; \${res[i].lecapSem}학기</td>`
					data +=	`</tr>`;
				}
			}else{
				data += `<tr>
							<td colspan="5" style="padding:11px; text-align:center">과목이수현황이 존재하지 않습니다.</th>
						</tr>`
			}
			subBody.html(data);
		}
	})
}

function initSubList(){
	var dataObj = {
			"crsClassfCd" : 'MR'
		}
	var firstTr = document.querySelectorAll('#craditBody tr')[0]
	console.log(firstTr)
	$(firstTr).css('background', '#6e6e6e26');
	subRecordList(dataObj);
}

var myChart;

// 이수학점 막대그래프 가져오기
function getMyChart(){
	const ctx = document.querySelector('#myChart');
		myChart = new Chart(ctx, {
		  type: 'bar',
		  data: {
		    labels: ['전공', '교양'],
		    datasets: [
		      {
		        label: '졸업이수학점',
		        data: [70, 60],
		        borderWidth: 1,
		        barPercentage: 0.6, // 막대 간격 조정
		        categoryPercentage: 0.6, // 막대 너비 조정
		        backgroundColor: 'rgba(54, 162, 235, 0.5)'
		      }
		    ]
		  },
		  options: {
			    indexAxis: 'x', // x축에 대한 설정
			    responsive: false,
			    scales: {
			      x: {
			        beginAtZero: true,
			        grid: {
			          offset: true
			        },
			        ticks: {
			          stepSize: 10 // 눈금 간격 조정
			        }
			      },
			      y: {
			        beginAtZero: true,
			        barThickness: 0.5 // 막대 두께 조정
			      },
					yAxes: [{
						ticks: {
							beginAtZero: true,
							stepSize : 10,
							fontSize : 14,
						}
					}]
			    },
				hover: {
					animationDuration: 0
				},
				animation: {
					duration: 1,
					onComplete: function () {
						var chartInstance = this.chart,
							ctx = chartInstance.ctx;
						ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, Chart.defaults.global.defaultFontStyle, Chart.defaults.global.defaultFontFamily);
						ctx.fillStyle = 'black';
						ctx.textAlign = 'center';
						ctx.textBaseline = 'middle';
						ctx.font = '16px Arial'; // 폰트 굵기 및 크기 조정

						this.data.datasets.forEach(function (dataset, i) {
							var meta = chartInstance.controller.getDatasetMeta(i);
							meta.data.forEach(function (bar, index) {
								var data = dataset.data[index];							
								ctx.fillText(data, bar._model.x, bar._model.y +30);
							});
						});
					}
				},
			    plugins: {
			        datalabels: {
			          align: 'end',
			          anchor: 'end',
			          font: {
			            size: 14,
			            weight: 'bold'
			          },
			          color: 'black',
			          formatter: function(value) {
			            return value.toString() + '학점';
			          }
			        }
			      },
			  }
		});
}

function dataSetAdd(mSum, sSum){
    var myDataset =  {
	        label: '나의이수학점',
	        data: [mSum, sSum],
	        borderWidth: 1,
	        barPercentage: 0.6, // 막대 간격 조정
	        categoryPercentage: 0.6, // 막대 너비 조정
	        backgroundColor: 'rgba(255, 99, 132, 0.5)'
	    }

    myChart.data.datasets.push(myDataset);
 
    myChart.update(); // 이걸 꼭 해줘야함!
}



function scoreChange(data){
	let score;
	switch (data) {
	  case '4.5':
		score = "A+";
		break;
	  case '4.0':
		score = "A0";	    
	    break;
	  case '3.5':
		score = "B+";
		break;
	  case '3.0':
		score = "B0";
		break;
	  case '2.5':
		score = "C+";
		break;
	  case '2.0':
		score = "C0";
		break;
	  case '1.5':
		score = "D+";
		break;
	  case '1.0':
		score = "D0";
		break;
	  default:
		score = "F";
	  	break;
	}
	return score;
}
</script>