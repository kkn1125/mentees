<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="menteePoint" value="${fn:length(recommenders)}"/>
<fmt:parseNumber var="level" value="${menteePoint/100}" integerOnly="true"/>
<div class="flex-grow-1">
	
	<div class="container-fluid container-lg mb-3">
		<div class="container">
			<div class="border p-3 rounded">
				<div class="h5">${mentee.id}님의 프로필</div>
				<hr>
				<div class="d-flex flex-wrap">
					<div class="col-lg-3 col-12 text-center">
						<span class="profile">
						<img class="img-fluid rounded-circle" src="/resources/img/sample.jpg" alt="sample">
						</span>
					</div>
					<div class="col-lg-9 col-12 mt-4 mt-lg-0 d-lg-flex flex-column justify-content-center text-center text-lg-start">
						<span class="h5">
						${mentee.name}
						<span class="vr d-inline-block border-start" style="width: 1px; height: 1rem;"></span>
						${mentee.email}
						</span>
						<p>
							Lorem ipsum dolor sit amet, consectetur adipisicing elit. Perferendis esse deserunt quae quos odio suscipit quasi necessitatibus nulla praesentium aperiam eum cum voluptate qui similique ab nisi corrupti ad quia?
						</p>
					</div>
				</div>
				<hr>
				<div>
					<span>멘티 레벨 <span class="point badge bg-success"></span></span>
                    <span data-graph="bar" data-value="${level}"></span>
				</div>
				<div>
					<span>멘티 점수 <span class="point badge bg-success"></span></span>
                    <span data-graph="bar" data-value="${menteePoint}"></span>
				</div>
				<hr>
				<div>
					<span>관심 분야</span>
					<c:set var="interest" value="${fn:split(mentee.interest,',')}"/>
								
					<!-- mentees tags -->
					<c:if test="${fn:length(interest)==0}">
			    		<span class="badge text-white tag tag-purple">
					    아직 등록된 관심분야가 없습니다.
					</span>
			     	</c:if>
			     	
					<c:forEach var="item" items="${interest}">
					<span class="badge text-white tag tag-purple">
					${item}
					</span>
			     	</c:forEach>
			     	
				</div>
				<div>
					<span>나의 멘토</span>
					<div>
						<button class="badge mentor mentor-prime">
							test
						</button>
					</div>
				</div>
			</div>
			<hr>
			<div>
				<div class="h5">멘티활동 기록 <span class="badge bg-success fs-6">2</span></div>
				<div>
					<span>참여한 세미나/강연 <span class="badge bg-success">1</span></span>
					<div class="d-flex justify-content-around my-3">
					
						<!-- card -->
						
						<div class="card p-3 border" style="width: 18rem;">
							<span style="height: 10rem;">
								<img class="img-fluid" src="/resources/img/sample.jpg" alt="sample" draggable="false"/>
							</span>
							<hr>
							<div>
								<p>
								Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nostrum nisi quae consequuntur perferendis ea officia sunt reiciendis molestias similique saepe?
								</p>
							</div>
						</div>
						
						
					</div>
				</div>
				<hr>
				<div>
					<span>멘티 모임 <span class="badge bg-success">1</span></span>
					<div class="d-flex justify-content-around my-3">
					
						<!-- card -->
						
						<div class="card p-3 border" style="width: 18rem;">
							<span style="height: 10rem;">
								<img class="img-fluid" src="/resources/img/sample.jpg" alt="sample" draggable="false"/>
							</span>
							<hr>
							<div>
								<p>
								Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nostrum nisi quae consequuntur perferendis ea officia sunt reiciendis molestias similique saepe?
								</p>
							</div>
						</div>
						
						
					</div>
				</div>
				<hr>
				<div>
					<span>저장한 피드백 <span class="badge bg-success">1</span></span>
					<div class="d-flex justify-content-around my-3">
					
						<!-- card -->
						
						<div class="card p-3 border" style="width: 18rem;">
							<span style="height: 10rem;">
								<img class="img-fluid" src="/resources/img/sample.jpg" alt="sample"/>
							</span>
							<hr>
							<div>
								<p>
								Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nostrum nisi quae consequuntur perferendis ea officia sunt reiciendis molestias similique saepe?
								</p>
							</div>
						</div>
						
						
					</div>
				</div>
			</div>
		</div>
	</div>
	
</div>