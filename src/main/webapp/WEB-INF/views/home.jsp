<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="com.mentees.web.entity.Recommend"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Set"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="menteePoint" value="${fn:length(getRecommend)}"/>
<fmt:parseNumber var="level" value="${menteePoint/100}" integerOnly="true"/>

<div class="flex-grow-1">
    <!-- slide -->
<!--     <img alt="" src="/resources/img/cover/ab01.png" style="height: 200px; width: 100%;"> -->
    <div class="container-fluid container-lg mb-3">
        <div id="mainSlide" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active" data-bs-interval="10000">
                    <img src="/resources/img/cover/ab01.jpg" class="d-block w-100" alt="...">
                </div>
                <div class="carousel-item" data-bs-interval="10000">
                    <img src="/resources/img/cover/ab02.jpg" class="d-block w-100" alt="...">
                </div>
                <div class="carousel-item" data-bs-interval="10000">
                    <img src="/resources/img/cover/ab03.jpg" class="d-block w-100" alt="...">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#mainSlide"
                data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#mainSlide"
                data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
    </div>

    <!-- Main Section -->
    <div class="container d-lg-flex row-reverse">
    	${test}
		<c:if test="${mentee!=null}">
        <!-- SNB -->
        <!-- 로그인만 보이기 -->
        <div class="col-lg-3 col-12" data-aos="fade-left">
            <div class="sticky-top" style="padding-top: 56px;">
                <div class="bg-light border p-3 rounded">
                    <div class="clearfix">
	                    <span class="h6 my-2 d-inline-block">${mentee.id}님의 정보</span>
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

            <div>
                <div class="lh-lg clearfix" id="Mentees-프로그램">
                    <span class="h5">Mentees 프로그램</span>
                    <span class="badge bg-dark" data-bs-toggle="tooltip" data-bs-placement="right"
                        title="Mentees 프로그램은 멘티들의 스터디 일정을 공유하고 참여하는 시스템입니다.">?</span>
                    <span class="float-end">
                        <a class="btn btn-outline-success" href="/program/list">더 보기</a>
                    </span>
                </div>
                <c:if test="${empty productList}">
                <div class="mt-3">
                	<div class="alert alert-warning">등록된 프로그램이 없습니다.</div>
                </div>
                </c:if>
                <c:forEach var="card" items="${productList}" end="2">
                
				<c:set var="idx" value="0"/>
                <c:forEach var="item" items="${allLikeList}">
				<c:if test="${card.num == item.pnum}">
				<c:set var="idx" value="${idx+1}"/>
				</c:if>
                </c:forEach>
                
                <div class="card my-3 w-100">
                    <div class="row g-0">
                        <div class="col-md-4">
                            <img src="${card.cover}" class="img-fluid rounded-start" alt="sample">
                        </div>
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

            <div>
                <div class="lh-lg mt-5" id="지금-뜨는-멘티">
                    <span class="h5">지금 뜨는 멘티</span>
                    <span class="badge bg-dark" data-bs-toggle="tooltip" data-bs-placement="right"
                        title="가장 많은 관심을 받는 멘티 정보가 게시됩니다.">?</span>
<!--                     <span class="float-end"> -->
<!--                         <a class="btn btn-outline-success" href="#">더 보기</a> -->
<!--                     </span> -->
                </div>
                <jsp:useBean id="set" class="java.util.HashSet"/>
                <c:forEach var="item" items="${allMemberList}">
<%--                 <c:if test="${status.first}">
                	<c:set var="tagList" value="${item.interest}"/>
                </c:if>
                <c:if test="${not status.first}">
                	<c:set var="tagList" value="${tagList}_${item.interest}"/>
                </c:if> --%>
               	<c:set var="token" value="${item.interest}"/>
               	<c:forTokens var="tag" items="${token}" delims="_">
               		${set.add(tag)?'':''}
               	</c:forTokens>
                </c:forEach>
                
                <!-- tags -->
                <div class="d-flex flex-wrap mt-3">

                    <c:forEach var="s" items="${set}">
                    <span class="badge tag tag-green">
                        ${s}
                    </span>
                    </c:forEach>
                    
                </div>
                <div>
	                <!-- long card -->
	                <c:forEach var="mem" items="${allMemberList}" varStatus="status" end="4">
	                <div class="card my-3 w-100">
	                    <div class="row g-0">
	                        <div class="col-md-3 p-3" style="width: 10rem; height: 10rem;">
	                            <img src="/resources/img/sample.jpg" class="img-fluid rounded-circle" alt="sample"">
	                        </div>
	                        <div class="col">
	                            <div class="card-body">
	                            	<div class="d-flex justify-content-between">
		                                <div class="card-title h5">
		                                    ${mem.email}
		                                </div>
		                                <div class="order" data-order-idx="${status.index}">
		                                	<c:set var="count" value="0"/>
		                                	<c:forEach var="item" items="${allRecommender}">
			                                	<c:if test="${mem.num == item.referral}">
			                                	<c:set var="count" value="${count+1}"></c:set>
			                                	</c:if>
		                                	</c:forEach>
		                                	<span class="badge bg-info">
			                                	${count}
		                                	</span>
		                                </div>
	                            	</div>
	                                
	                                <div class="card-text">
	                                	<div class="fs-7 border-bottom text-muted">Message</div>
	                                	<div ${mem.msg==null?'class="alert alert-secondary m-0 my-1 p-1" ':''}data-card="text">
		                                    ${mem.msg!=null?mem.msg:'등록된 메세지가 없습니다.'}
	                                	</div>
	                                </div>
	                                <div class="d-flex justify-content-end">
	                                	<div>
	                                		<c:set var="refl" value="false"/>
	                                		<c:forEach var="referral" items="${myReferralList}">
	                                		<c:if test="${referral.referral==mem.num}">
	                                		<c:set var="refl" value="true"/>
	                                		</c:if>
	                                		<c:set var="refs" value="${referral.referral==mem.num?referral:''}"/>
	                                		</c:forEach>
	                                		<c:if test="${mentee.num!=mem.num}">
	                                		<button class="btn btn-sm btn-outline-success" data-info="${mentee.num}-${mem.num}" data-recommend="${refl?'false':'true'}">${refl=='true'?'추천 + 1':'추천'}</button>
	                                		</c:if>
	                                	</div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                </c:forEach>
                </div>
                
            </div>

            <div>
                <div class="lh-lg mt-5" id="추천-피드백">
                    <span class="h5">추천 피드백</span>
                    <span class="badge bg-dark" data-bs-toggle="tooltip" data-bs-placement="right"
                        title="멘티에게 큰 도움을 준 사례를 추려 표시됩니다.">?</span>
                    <span class="float-end">
                        <a class="btn btn-outline-success" href="/feedback/list">더 보기</a>
                    </span>
                </div>
                <div class="d-flex justify-content-start w-100">

                    <!-- long card -->
                    <c:if test="${empty allFeedbackList}">
                    <div class="col my-3">
                    	<div class="alert alert-warning">
                    	등록된 피드백이 없습니다.
                    	</div>
                    </div>
                    </c:if>
                    <c:forEach var="feed" items="${allFeedbackList}">
                    
                    <div class="card my-3 col mx-2" style="min-width: 215px;max-width: 215px;font-size: .7rem;">
                        <div class="d-flex justify-content-between align-items-center">
                       		<c:set var="idx" value="0"/>
	               		 	<c:forEach var="item" items="${allFeedList}">
							<c:if test="${feed.num == item.fnum}">
							<c:set var="idx" value="${idx+1}"/>
							</c:if>
			                </c:forEach>
	                        <div class="px-3">
	                            <i class="far fa-comment-dots fa-2x"></i>
				                <span>
	                                <span class="badge bg-danger">
		                                <i class="fas fa-heart"></i> <span class="likes">${idx}</span>
		                            </span>
	                                <span class="badge bg-secondary view">
	                                    <i class="fas fa-eye"></i> ${card.view}
	                                </span>
                                </span>
	                        </div>
							<div class="">
								<c:if test="${mentee.id!=feed.author}">
								<div>
									<c:set var="nums" value="${null}"/>
									<c:forEach var="item" items="${allFeedList}">
										<c:if test="${item.fnum == feed.num and item.mnum == mentee.num}">
											<c:set var="nums" value="${item}"/>
										</c:if>
									</c:forEach>
									<c:set var="isSolid" value="${nums!=null?'s':'r'}"/>
									<c:set var="isFeed" value="${nums!=null?'unfeed':'feed'}"/>
									<c:set var="isColor" value="${nums!=null?'danger':'success'}"/>
									<input type="hidden" name="num" value="${mentee.num}-${feed.num}">
									<button class="btn btn-${isColor}" data-btn="${isFeed}">
										<i class="fa${isSolid} fa-bookmark"></i>
									</button>
								</div>
								</c:if>
								<c:if test="${mentee.id==feed.author}">
								<div>
									<button type="button" class="btn btn-sm btn-info" data-type="feed" data-edt="${feed.num}">수정</button>
									<button type="button" class="btn btn-sm btn-danger" data-type="feed" data-del="${feed.num}">삭제</button>
								</div>
								</c:if>
							</div>
						</div>
                        <div class="card-body">
                            <div class="card-title h5"><a href="/feedback/list/${feed.num}">${feed.title}</a></div>
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
                            <div class="card-text" data-card="text">
                            	${feed.content}
                            </div>
                        </div>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">

                                tags
				                <div class="d-flex flex-wrap">
				               	<c:forTokens var="tag" items="${feed.tags}" delims="_" end="2">
				               		<span class="badge tag tag-green">
				                        ${tag}
				                    </span>
				               	</c:forTokens>
				               	<c:set var="rest" value="${fn:length(fn:split(feed.tags,'_'))-3}"></c:set>
				               	<c:if test="${rest>0}">
				               	<span class="badge tag-n text-muted">+ ${rest}</span>
				               	</c:if>
				                </div>

                            </li>
                        </ul>
                        <div class="card-footer">
                            <div class="badge text-muted">
                                <div>
                                    <span class="d-inline-block rounded-circle border"
                                        style="width: 26px; height: 26px">
                                        <img class="img-fluid rounded-circle" src="/resources/img/sample.jpg"
                                            alt="sample">
                                    </span>
                                    <span>${feed.author }</span>
                                </div>
                            </div>
                            <div data-copy="true" class="badge float-end bg-dark p-2" data-bs-toggle="tooltip"
                                data-bs-placement="right" title="복사">
                                <i class="fas fa-link"></i>
                            </div>
                        </div>
                    </div>
                    
                    </c:forEach>
					
                </div>

            </div>
			<c:if test="${mentee!=null}">
            <div>

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