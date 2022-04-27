<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@page import="com.mentees.web.entity.Likes"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="menteePoint" value="${fn:length(getRecommend)}"/>
<fmt:parseNumber var="level" value="${menteePoint/100}" integerOnly="true"/>
<div class="flex-grow-1">
	
	<div class="container-fluid container-lg mb-3">
		<div class="container">
			<div class="border p-3 rounded">
				<div class="d-flex justify-content-between">
					<span class="h5 mb-0">${mentee.id}님의 프로필</span>
					<span><a href="/mentees/setting" class="btn btn-sm btn-success">설정</a></span>
				</div>
				<hr>
				<div class="d-flex flex-wrap">
					<div class="col-lg-3 col-12 text-center">
						<span class="profile">
						<img class="img-fluid rounded-circle" src="/resources/img/sample.jpg" alt="sample">
						</span>
					</div>
					<div class="col-lg-9 col-12 mt-4 mt-lg-0 d-lg-flex flex-column justify-content-center text-center text-lg-start">
						<span class="h5">
						${mentee.id}
						<span class="vr d-inline-block border-start" style="width: 1px; height: 1rem;"></span>
						${mentee.email}
						</span>
						<p>
							${mentee.msg}
						</p>
					</div>
				</div>
				<hr>
				<div class="my-2">
					<span>멘티 레벨 <span class="point badge bg-success"></span></span>
                    <span data-graph="bar" data-value="${level}"></span>
				</div>
				<div class="my-2">
					<span>멘티 점수 <span class="point badge bg-success"></span></span>
                    <span data-graph="bar" data-value="${menteePoint}"></span>
				</div>
				<hr>
				<div>
					<span>관심 분야</span>
					<c:set var="interest" value="${fn:split(mentee.interest,'_')}"/>
								
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
				<hr id="나의-멘토/멘티">
				<div class="my-2">
					<div class="mb-2">
						<span class="h4">나의 멘토/멘티</span>
					</div>
					<span class="border-start border-3 ps-2">내가 추천한 멘티</span>
					<div class="mb-3">
					
						<c:if test="${fn:length(doRecommend)==0}">
						<button class="badge mentor mentor-danger">
							추천한 멘티가 없습니다
						</button>
						</c:if>
					
						<c:forEach var="mentees" items="${doRecommend}">
						<button class="badge mentor mentor-prime" data-pop="profile" data-opened="false" data-id="${mentees.id}">
							${mentees.id}
						</button>
						</c:forEach>
						
					</div>
				</div>
				<div class="my-2">
					<span class="border-start border-3 ps-2">나를 추천한 멘티</span>
					<div class="mb-3">
					
						<c:if test="${fn:length(getRecommend)==0}">
						<button class="badge mentor mentor-danger">
							받은 추천이 없습니다
						</button>
						</c:if>
						
						<c:forEach var="mentees" items="${getRecommend}">
						<button class="badge mentor mentor-mentee" data-pop="profile" data-opened="false" data-id="${mentees.id}">
							${mentees.id}
						</button>
						</c:forEach>
						
					</div>
				</div>
				<div class="my-2">
					<div class="mb-2">
						<span class="h4">관심 있는 활동</span>
					</div>
					<div class="${empty userLikeList?'d-block':'d-flex flex-wrap  justify-content-md-start justify-content-around'}">
					
						<c:if test="${empty userLikeList}">
						<div>
							<div class="alert alert-warning">
								관심을 둔 활동이 없습니다.
							</div>
						</div>
						</c:if>
						<c:forEach var="like" items="${userLikeList}">
						
						<c:set var="idx" value="0"/>
               		 	<c:forEach var="item" items="${allLikeList}">
						<c:if test="${like.num == item.pnum}">
						<c:set var="idx" value="${idx+1}"/>
						</c:if>
		                </c:forEach>
		                
						<div class="m-2 position-relative overflow-hidden rounded" style="width: 18rem;">
							<img class="img-fluid rounded position-absolute top-0 start-0" style="filter: blur(1rem);z-index: -1;" alt="cardCover" src="${like.cover}">
							<div class="border border-2 rounded py-2 px-3">
								<span class="fw-bold text-wrap"><a class="stretched-link" href="/program/list/${like.num}"></a>${like.title}</span>
								<br>
								<span>
									<span class="badge bg-danger view">
										<i class="fas fa-heart"></i> ${idx}
									</span>
									<span class="badge bg-secondary view">
										<i class="fas fa-eye"></i> ${like.view}
									</span>
								</span>
								<hr>
								<div class="badge bg-secondary">개최자 ${like.id}</div>
								<br>
								<c:set var="now" value="<%=new Date()%>"/>
								<fmt:formatDate value="${like.start}" pattern="yyyy-MM-dd HH:mm" var="start"/>
								<fmt:formatDate value="${like.end}" pattern="yyyy-MM-dd HH:mm" var="end"/>
								<fmt:formatDate value="${like.until}" pattern="yyyy-MM-dd HH:mm" var="until"/>
								<div class="badge bg-secondary">시작 ${start}</div>
								<br>
								<div class="badge bg-secondary">종료 ${end}</div>
								<br>
								<div class="badge bg-secondary">마감 ${until>now?until:'종료'}</div>
								
							</div>
						</div>
						
						</c:forEach>
					</div>
				</div>
			</div>
			<hr id="멘티활동-기록">
			<div>
				<div class="h5">멘티활동 기록 <span class="badge bg-success fs-6">${fn:length(myReserve)+fn:length(myFeedList)}</span></div>
				<div>
					<span>참여한 세미나/강연 <span class="badge bg-success">${fn:length(myReserve)}</span></span>
					<div class="d-flex justify-content-md-start justify-content-around my-3">
					
						<!-- card -->
						<c:forEach var="reserve" items="${myReserveAsProduct}">
						<div class="card p-3 m-3 border" style="width: 18rem;">
							<span style="height: 10rem;">
								<img class="img-fluid" src="${reserve.cover}" alt="sample" draggable="false"/>
							</span>
							<hr>
							<div>
								<div class="fw-bold fs-5">
									<a href="/program/list/${reserve.num}">${reserve.title}</a>
									<span class="badge bg-${reserve.type=='lecture'?'success':'primary'}">${reserve.type=='lecture'?'강연':'세미나'}</span>
								</div>
								<div>
									<fmt:formatDate value="${reserve.start}"/> ~
									<fmt:formatDate value="${reserve.end}"/>
									<span class="badge bg-success">
										${reserve.end.day - reserve.start.day + 1}일 과정
									</span>
								</div>
								<div>
									<c:set var="c" value="0"/>
					        		<c:forEach var="r" items="${allReserve}">
					        		<c:if test="${r.pnum==reserve.num}">
					        		<c:set var="c" value="${c+1}"/>
					        		</c:if>
					        		</c:forEach>
									<div>
										<span class="badge bg-success">
						        		신청 현황
						        		</span>
						        		<span class="badge text-dark">
						        		${c}/${reserve.capacity}
						        		</span>
									</div>
								</div>
								
								<c:set var="until" value="${reserve.until}"/>
					        	<%
					        		Timestamp times = (Timestamp) pageContext.getAttribute("until");
					        		LocalDateTime until = times.toLocalDateTime();
					        		LocalDateTime now = LocalDateTime.now();
					        		LocalDateTime curs = LocalDateTime.from(now);
					        		long month = curs.until(until, ChronoUnit.MONTHS);
					        		curs = curs.plusMonths(month);
					        		// 더해줘야 달,일,시,분 단위로 환산됨
					        		// 안그러면 총 시간, 총 일수 총 달수 등으로 나옴
					        		long day = curs.until(until, ChronoUnit.DAYS);
					        		curs = curs.plusDays(day);
					        		long hour = curs.until(until, ChronoUnit.HOURS);
					        		curs = curs.plusHours(hour);
					        		long minute = curs.until(until, ChronoUnit.MINUTES);
					        		curs = curs.plusMinutes(minute);
					        		pageContext.setAttribute("month", month);
					        		pageContext.setAttribute("day", day);
					        		pageContext.setAttribute("hour", hour);
					        		pageContext.setAttribute("minute", minute);
					        	%>
					        	<c:if test="${minute>0}"></c:if>
					        	<span class="badge bg-danger">
					        	D - 
					        	<c:if test="${month>0}">
					        	${month}달 
					        	</c:if>
					        	<c:if test="${day>0}">
					        	${day}일
					        	</c:if>
					        	<c:if test="${day==0 and minute>0}">
					        	오늘 마감하는 프로그램입니다
					        	</c:if>
					        	<c:if test="${minute<0}">
				        		마감
					        	</c:if>
					        	</span>
							</div>
						</div>
						</c:forEach>
						
						
					</div>
				</div>
				<hr>
				<div>
					<span>저장한 피드백 <span class="badge bg-success">${fn:length(myFeedList)}</span></span>
					<div class="d-flex justify-content-md-start justify-content-around my-3">
						<c:if test="${empty myFeedList}">
							<div class="alert alert-secondary col">
								저장한 피드백이 없습니다.
							</div>
						</c:if>
						<!-- card -->
						<c:forEach var="item" items="${myFeedList}">
						<div class="card p-3 m-3 border" style="width: 18rem;">
							<span class="d-flex justify-content-center align-items-center" style="height: 10rem;">
								<i class="far fa-comment-dots fa-5x"></i>
							</span>
							<hr>
							<div class="card-body">
								<div class="card-title h5">
									<a href="/feedback/list/${item.num}">
										${item.title}
									</a>
								</div>
								<div class="card-subtitle mb-2 text-muted badge">${item.author!=''?item.author:'admin'}</div>
								<div class="card-text" data-card="text">
									${item.content}
								</div>
							</div>
							<ul class="list-group list-group-flush">
	                            <li class="list-group-item">
	
	                                <span class="badge text-muted">tags</span>
					                <div class="d-flex flex-wrap">
					               	<c:forTokens var="tag" items="${item.tags}" delims="_" end="2">
					               		<span class="badge tag tag-green">
					                        ${tag}
					                    </span>
					               	</c:forTokens>
					               	<c:set var="rest" value="${fn:length(fn:split(item.tags,'_'))-3}"></c:set>
					               	<c:if test="${rest>0}">
					               	<span class="badge tag-n text-muted">+ ${rest}</span>
					               	</c:if>
					                </div>
	
	                            </li>
	                        </ul>
	                        <div class="card-footer">
		                        <%
									Timestamp now = Timestamp.valueOf(LocalDateTime.now());
									LocalDateTime limit = LocalDateTime.now().minusDays(1);
									Timestamp limits = Timestamp.valueOf(limit);
									pageContext.setAttribute("limit", limits);
									pageContext.setAttribute("now", now);
								%>
								<c:set var="regdate" value="${feed.regdate}"/>
								<c:set var="minus" value="${now.time-regdate.time}"/>
								<c:if test="${regdate>limit}">
									<div class="position-absolute top-0 start-0 user-select-none">
										<div class="badge bg-primary">New</div>
									</div>
								</c:if>
								<!-- 등록한지 얼마 안 됐을 때 -->
								<small class="text-muted">
									<time>
										<fmt:parseNumber var="h" value="${minus/60000/60}" integerOnly="true"/>
										<fmt:parseNumber var="m" value="${minus/60000}" integerOnly="true"/>
										<fmt:formatDate var="reg" value="${regdate}" pattern="yyyy-MM-dd"/>
										<c:if test="${h>20}">
											${reg}
										</c:if>
										<c:if test="${h>0 and h<=20}">
											${h}시간 ${m-(h*60)>=0?m-(h*60):''}${m-(h*60)>=0?'분':''} 전
										</c:if>
										<c:if test="${m>0 and m<60}">
											<fmt:parseNumber value="${minus/60000}" integerOnly="true"/> 분 전
										</c:if>
									</time>
								</small>
	                        </div>
						</div>
						</c:forEach>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	
</div>