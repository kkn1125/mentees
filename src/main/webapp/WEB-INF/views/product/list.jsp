<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="menteePoint" value="${fn:length(getRecommend)}"/>
<fmt:parseNumber var="level" value="${menteePoint/100}" integerOnly="true"/>
<div class="flex-grow-1">

    <!-- Main Section -->
    <div class="container d-lg-flex row-reverse">
		<c:if test="${mentee!=null}">
        <!-- SNB -->
        <!-- 로그인만 보이기 -->
        <div class="col-lg-3 col-12" data-aos="fade-left">
            <div class="sticky-top" style="padding-top: 56px;">
                <div class="bg-light border p-3 rounded">
                    <div class="clearfix">
	                    <span class="h6 my-2 d-inline-block">${mentee.id}의 정보</span>
	                    <span class="float-end">
	                    	<a class="btn btn-outline-success text-capitalize" href="/mentees">
	                    		<span class="d-lg-none d-inline-block">settings</span> <i class="fas fa-user-cog"></i>
	                    	</a>
	                    </span>
                    </div>
                    <hr>
                    <div class="d-flex flex-row flex-lg-column flex-wrap">
                        <div class="col-6 col-lg-12 px-3 px-lg-0">
                            <span>멘티 레벨 <span class="point badge bg-success"></span></span>
                            <span data-graph="bar" data-value="${level}"></span>
                        </div>
                        <div class="col-6 col-lg-12 px-3 px-lg-0">
                            <span>멘티 점수 <span class="point badge bg-success"></span></span>
                            <span data-graph="bar" data-value="${menteePoint}"></span>
                        </div>
                        <div class="col-12">
                            <hr>
                        </div>
                        <div class="col-12 px-3 px-lg-0">
                            <span>관심 분야</span>
                            <div class="mt-2">
								<c:set var="interest" value="${fn:split(mentee.interest,'_')}"/>
								
                            	<!-- mentees tags -->
                            	<c:if test="${fn:length(interest)==0}">
                           		<span class="badge tag tag-purple">
			                        아직 등록된 관심분야가 없습니다.
			                    </span>
                            	</c:if>
                            	<c:forEach var="item" items="${interest}">
                            	<span class="badge tag tag-purple">
			                        ${item}
			                    </span>
                            	</c:forEach>
			                    
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
		</c:if>

        <!-- main content -->
        <div class="${mentee!=null?'col-lg-9 ':null}col-12 px-lg-3 mt-3 mt-lg-0" style="padding-top: 56px;">

            <div class="mb-3 pb-3">
                <div class="lh-lg">
                    <span class="h5">Mentees 프로그램</span>
                    <span class="badge bg-dark" data-bs-toggle="tooltip" data-bs-placement="right"
                        title="Mentees 프로그램이란?">?</span>
                    <c:if test="${mentee!=null}">
                    <span class="float-end">
                        <a class="btn btn-outline-success" href="/program/form">등록</a>
                    </span>
                    </c:if>
                </div>
                <c:if test="${empty productList}">
                <div class="mt-3">
                	<div class="alert alert-warning">등록된 프로그램이 없습니다.</div>
                </div>
                </c:if>
                <!-- card -->
                <c:forEach var="card" items="${productList}">
                <div class="card my-3 w-100">
                    <div class="row g-0">
                        <div class="col-md-4">
                            <img src="${card.cover}" class="img-fluid rounded-start" alt="sample">
                        </div>
                        <c:set var="idx" value="0"/>
               		 	<c:forEach var="item" items="${allLikeList}">
						<c:if test="${card.num == item.pnum}">
						<c:set var="idx" value="${idx+1}"/>
						</c:if>
		                </c:forEach>
                        <div class="col-md-8">
                            <div class="card-body">
                                <div class="card-title d-flex justify-content-between align-items-center">
	                                <span class="h5 mb-0"><a class="card-link" href="/program/list/${card.num}">${card.title}</a></span>
	                                <span>
		                                <span class="badge bg-danger">
			                                <i class="fas fa-heart"></i> <span class="likes">${idx}</span>
			                            </span>
		                                <span class="badge bg-secondary view">
		                                    <i class="fas fa-eye"></i> ${card.view}
		                                </span>
	                                </span>
                                </div>
                                <div class="mb-3">
                                	<span class="text-muted">${card.address}</span>
                                	<span class="badge bg-${card.type=='lecture'?'success':'primary'}">
	                				${card.type=='lecture'?'강연':'세미나'}
	                				</span>
                                </div>
                                <div class="card-subtitle mb-2 text-muted">${card.id!=''?card.id:'admin'}</div>
                                <div class="card-text" style="min-height: 72px" data-card="text">
                                	${card.content}
                                </div>
                                <div class="mt-2">
                                
                                	<c:forEach var="tag" items="${fn:split(card.tags, '_')}">
                                	<span class="badge tag tag-info">
                                		${tag}
                                	</span>
                                	</c:forEach>
                                	
                                </div>
                                <div class="d-flex justify-content-between">
                                	<%
                                		Timestamp now = Timestamp.valueOf(LocalDateTime.now());
                                		LocalDateTime limit = LocalDateTime.now().minusDays(1);
                                		Timestamp limits = Timestamp.valueOf(limit);
                                		pageContext.setAttribute("limit", limits);
                                		pageContext.setAttribute("now", now);
                                	%>
                                	<c:set var="regdate" value="${card.regdate}"/>
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
                                			<c:if test="${m==0}">
                                				지금
                                			</c:if>
                                		</time>
                                		<span>
                                			<c:set var="until" value="${card.until}"/>
								        	<%
								        		Timestamp times = (Timestamp) pageContext.getAttribute("until");
								        		LocalDateTime until = times.toLocalDateTime();
								        		LocalDateTime now2 = LocalDateTime.now();
								        		LocalDateTime curs = LocalDateTime.from(now2);
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
								        	<span class="badge bg-danger">
								        	<c:if test="${minute>0}">
								        	마감 - 
								        	</c:if>
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
							        		마감되었습니다.
								        	</c:if>
								        	</span>
                                		</span>
                                	</small>
                                	<c:if test="${mentee.id!=card.id}">
									<div>
										<c:forEach var="item" items="${likeList}">
											<c:if test="${item.pnum == card.num}">
											<c:set var="nums" value="${item}"/>
											</c:if>
										</c:forEach>
										<c:set var="isLike" value="${nums!=null?'dislike':'like'}"/>
										<c:set var="isClick" value="${nums!=null?'관심 +1':'관심'}"/>
										<c:set var="isColor" value="${nums!=null?'danger':'success'}"/>
										<input type="hidden" name="num" value="${mentee.num}-${card.num}">
										<button class="btn btn-${isColor}" data-btn="${isLike}">${isClick}</button>
									</div>
									</c:if>
									<c:if test="${mentee.id==card.id}">
		                          		<button type="button" class="btn btn-sm btn-danger" data-del="${card.num}">삭제</button>
		                          	</c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                </c:forEach>
                
                
            </div>
            
            <div class="pb-5">
            	<nav aria-label="Page navigation">
				  <ul class="pagination justify-content-center">
				    <c:set var="total" value="${fn:length(productList)}"/>
				    <fmt:parseNumber var="totalPages" value="${total/5+0.9}" integerOnly="true"></fmt:parseNumber>
				    <li class="page-item">
				      <a class="page-link" href="?page=${param.page==1 or param.page==null?1:p-1}" aria-label="Previous">
				        <span aria-hidden="true">&laquo;</span>
				      </a>
				    </li>
				    <c:forEach var="p" begin="1" end="${totalPages}">
				    <li class="page-item"><a class="page-link" href="?page=${p}">${p}</a></li>
				    </c:forEach>
				    <li class="page-item">
				      <a class="page-link" href="?page=${param.page==totalPages?param.page:p+1}" aria-label="Next">
				        <span aria-hidden="true">&raquo;</span>
				      </a>
				    </li>
				  </ul>
				</nav>
            </div>


			<c:if test="${mentee!=null}">
            <div class="mt-5 pt-3">

                <div class="p-3 border bg-white rounded mt-4">
                    <div>

                        <div class="h6 lh-lg">
                            <span class="">관심분야 스킬</span>
                        </div>

                        <div class="text-muted">
                            다양한 멘티활동을 통해 자신이 원하는 분야 지식을 습득하고 공유하며 발전하세요!
                            지금 찾는 멘토가 누군가에게 도움 받던 멘티였을 수 있습니다. 멘티로 시작해서 멘토에 도전 해보세요!
                        </div>

                        <div class="rounded bg-light p-2 my-3 text-muted">
                            <div class="d-flex">
                                <div class="p-3">
                                    <i class="fas fa-icons fa-2x"></i>
                                </div>
                                <div class="p-3">
                                    <div class="h5">웹개발</div>
                                    <p>
                                        인터넷이나 인트라넷을 위한 웹사이트를 개발하는 일
                                    </p>
                                    <div class="h6">보유 스킬</div>
                                    <p class="fs-5">
                                    
                                    	<!-- mentees tags -->
		                            	<c:if test="${fn:length(interest)==0}">
		                           		<span class="badge tag tag-1 tag-secondary">
					                        아직 등록된 관심분야가 없습니다.
					                    </span>
		                            	</c:if>
		                            	<c:forEach var="item" items="${interest}">
		                            	<span class="badge tag tag-1 tag-secondary">
					                        ${item}
					                    </span>
		                            	</c:forEach>
		                            	
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div>

                        </div>

                    </div>
                </div>
            </div>
			</c:if>

        </div>

    </div>
</div>