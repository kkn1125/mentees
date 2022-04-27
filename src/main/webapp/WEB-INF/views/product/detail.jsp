<%@page import="java.util.UUID"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="menteePoint" value="${fn:length(getRecommend)}"/>
<fmt:parseNumber var="level" value="${menteePoint/100}" integerOnly="true"/>
<c:if test="${empty product}">
<jsp:forward page="/program/list"/>
</c:if>
<div class="flex-grow-1">
	<div class="w-100 position-relative overflow-hidden" style="height: 50vh;">
		<img class="img-fluid" alt="cover" src="${product.cover}">
	</div>
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
        <!-- main content start -->
        <div class="${mentee!=null?'col-lg-9 ':null}col-12 px-lg-3 mt-3 mt-lg-0" style="padding-top: 56px;">

           	<!-- card detail start -->
            <div class="mb-3 pb-3">
                <div class="container-fluid">
                	<div class="d-flex justify-content-between">
                		<div class="py-2">
    	            		<span class="h2 fw-bold">${product.title}</span>
                		</div>
                		<c:set var="idx" value="0"/>
               		 	<c:forEach var="item" items="${allLikeList}">
						<c:if test="${product.num == item.pnum}">
						<c:set var="idx" value="${idx+1}"/>
						</c:if>
		                </c:forEach>
                		<div class="lh-lg py-2">
                			<span class="my-1">
	               				<span class="badge bg-danger fs-6">
	                                <i class="fas fa-heart"></i> <span class="likes">${idx}</span>
	                            </span>
		                		<span class="badge bg-secondary fs-6">
		                			<i class="fas fa-eye"></i> ${product.view}
		                		</span>
                			</span>
                		</div>
                	</div>
                	<div class="d-flex justify-content-between">
                		<span>
                			<c:set var="until" value="${product.until}"/>
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
	               			<jsp:useBean id="cur" class="java.util.Date"/>
	               			<fmt:formatDate var="cur" value="${cur}" pattern="yyyy-MM-dd HH:mm"/>
	               			<fmt:formatDate var="untils" value="${product.until}" pattern="yyyy-MM-dd HH:mm"/>
	               			<fmt:formatDate var="reg" value="${product.regdate}" pattern="yyyy-MM-dd HH:mm"/>
	               			<span class="badge bg-info">${untils}까지</span>
	               			<span class="badge bg-danger">
				        	<c:if test="${minute>0}">
				        	D - 
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
               			<span>
               				<span>${product.id==''?'admin':product.id}</span>
               				<time class="text-muted badge">
               					${reg}
               				</time>
               			</span>
                	</div>
                	<hr>
                	<div>
                		<div class="mb-3">
                       		<span class="text-muted">${product.address}</span>
                        </div>
                		<div>
                			<p>
                				${product.content}
                			</p>
                			<div>
                				<span>시작</span>
                				<span class="badge bg-primary">
                				<fmt:formatDate value="${product.start}" pattern="yyyy-MM-dd"/>
                				</span>
           					</div>
           					<div>
                				<span>종료</span>
                				<span class="badge bg-primary">
                				<fmt:formatDate value="${product.end}" pattern="yyyy-MM-dd"/>
                				</span>
                			</div>
           					<div>
                				<span>프로그램 종류</span>
                				<span class="badge bg-primary">
                				${product.type=='lecture'?'강연':'세미나'}
                				</span>
                			</div>
                		</div>
                		<div class="mt-3 d-flex justify-content-between">
                			<div class="tags">
                				<!-- tags -->
								<c:forEach var="tag" items="${fn:split(product.tags, '_')}">
								<span class="badge tag tag-info">${tag}</span>
								</c:forEach>
                				<!-- tags -->
							</div>
							<c:if test="${mentee.id!=product.id}">
							<div>
								<c:forEach var="item" items="${likeList}">
									<c:if test="${item.pnum == product.num}">
									<c:set var="nums" value="${item}"/>
									</c:if>
								</c:forEach>
								<c:forEach var="r" items="${myReserve}">
								<c:if test="${r.pnum==product.num}">
								<c:set var="reserve" value="${r}"/>	
								</c:if>
								</c:forEach>
								<c:set var="isLike" value="${nums!=null?'dislike':'like'}"/>
								<c:set var="isClick" value="${nums!=null?'관심 +1':'관심'}"/>
								<c:set var="isColor" value="${nums!=null?'danger':'success'}"/>
								<input type="hidden" name="num" value="${mentee.num}-${product.num}">
								<button class="btn btn-${isColor}" data-btn="${isLike}">${isClick}</button>
								<button class="btn btn-primary" data-btn="reserve" data-bs-toggle="modal" data-bs-target="#reserve">${reserve!=null?'✔':'' }신청</button>
							</div>
							</c:if>
							<c:if test="${mentee.id==product.id}">
							<div>
                          		<button type="button" class="btn btn-sm btn-info" data-edt="${product.num}">수정</button>
                          		<button type="button" class="btn btn-sm btn-danger" data-del="${product.num}">삭제</button>
							</div>
                          	</c:if>
                		</div>
                	</div>
                	<hr>
                	<!-- comment start -->
                	
                	<!-- comment list start -->
                	<div id="comment">
                		<div class="my-3 p-3 overflow-hidden">
                			
               				<!-- comment card -->
							<c:if test="${empty commentList}">
							<div class="alert alert-warning">
							등록된 댓글이 없습니다.
							</div>
							</c:if>
               				<c:forEach var="card" items="${commentList}" varStatus="status">
               					
	               				<div class="comment d-flex justify-content-between flex-wrap py-3 ${not status.last?'border-bottom':''}">
	               					<c:if test="${card.layer>0}">
<%-- 	               					<c:forEach var="i" begin="0" end="${card.layer-1}"> --%>
<!-- 	               					<span style="width: .5rem;"></span> -->
<%-- 	               					</c:forEach> --%>
	               					<span style="margin-left: ${card.layer}rem;" class="align-self-center"><i class="text-success fab fa-replyd fa-2x"></i></span>
	               					</c:if>
	               					<div class="col">
		               					<div class="badge d-flex justify-content-start">
		               						<span class="text-muted">${card.author}</span>
		               						<time class="ms-3 text-muted fw-light">
		               							<fmt:formatDate value="${card.regdate}"/>
		               						</time>
		               					</div>
		               					<div class="ps-2">
		          							${card.content}
		               					</div>
	               					</div>
	               					<div class="col-3 d-flex justify-content-end align-items-center">
	               						<span>
	               							<button class="btn btn-sm btn-primary" data-comment-n="${card.num}" data-program-n="${product.num}" data-btn-comment="re">re:</button>
	               						<c:if test="${mentee.id==card.author}">
	               							<button class="btn btn-sm btn-primary">수정</button>
	               							<button class="btn btn-sm btn-danger" data-comment-n="${card.num}" data-btn-comment="del">삭제</button>
	               						</c:if>
	               						</span>
	               					</div>
	               				</div>
               				</c:forEach>
               				
                			<!-- comment card -->
                			
                		</div>
                	</div>
                	<!-- comment list end -->
                	
                	<!-- comment input start -->
                	<div data-frm="origin">
                		<form action="/comment/${product.num}" method="post">
	                		<div class="border rounded">
	                			<div class="p-3">
	                				<div class="mb-3 row align-items-center">
								    	<label for="author" class="col-sm-1 col-form-label">ID</label>
								    	<div class="col-sm-6">
							      			<input type="text" readonly class="form-control-plaintext" name="author" id="author" value="${mentee!=null?'':'user-'}${mentee!=null?mentee.id:UUID.randomUUID()}">
							    		</div>
								  	</div>
	                				<div class="form-floating">
								  		<textarea class="form-control" placeholder="Leave a comment here" name="content" id="floatingTextarea2" style="height: 100px"></textarea>
								  		<label for="floatingTextarea2">Comments</label>
									</div>
									<div class="mt-3">
										<div class="row g-3">
									  		<div class="col">
										    	<button type="submit" class="btn btn-success mb-3">댓글</button>
										  	</div>
											<div class="form-check col-sm-2">
										  		<input class="form-check-input" type="checkbox" name="vis" id="vis" checked>
										  		<label class="form-check-label" for="vis">
									    			공개
										  		</label>
											</div>
										</div>
									</div>
	                			</div>
	                		</div>
                		</form>
                	</div>
                	<!-- comment input end -->
                	
                	<!-- comment end -->
                </div>
            </div>
            <!-- card detail end -->
        </div>
		<!-- main content end -->
    </div>
</div>
<!-- Vertically centered scrollable modal -->
<div class="modal fade" id="reserve" tabindex="-1" aria-labelledby="reserveLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
	  	<div class="modal-content">
	      	<div class="modal-header">
		        <h5 class="modal-title" id="reserveLabel">${product.type=='lecture'?'강연':'세미나'} 신청</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      	</div>
	      	<div class="modal-body">
	        <div class="fw-bold">
	        	${product.title}
	        </div>
	        <div class="badge bg-primary">
	        	<fmt:formatDate value="${product.start}"/> ~
	        	<fmt:formatDate value="${product.end}"/>
	        </div>
        	<span class="badge text-dark">
        		${product.end.day - product.start.day + 1}일 과정
        	</span>
        	<div>
        		<c:set var="c" value="0"/>
        		<c:forEach var="r" items="${allReserve}">
        		<c:if test="${r.pnum==product.num}">
        		<c:set var="c" value="${c+1}"/>
        		</c:if>
        		</c:forEach>
        		<span class="badge bg-success">
        		신청 현황
        		</span>
        		<span class="badge text-dark">
        		<span class="capa">${c}</span>
        		/
        		<span>${product.capacity}</span>
        		</span>
        	</div>
	        <div>
	        	<span class="badge bg-danger">
	        	<c:if test="${minute>0}">
	        	D - 
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
	        </div>
	      	</div>
	      	<div class="modal-footer">
		        <input type="hidden" value="${mentee.num}-${product.num}">
<!-- 		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button> -->
				
		        <button type="button" class="btn btn-primary" data-reserve="${reserve==null?'true':'false'}" ${minute<0?'disabled':''}>${reserve==null?'신청하기':'신청취소'}</button>
	      	</div>
	    </div>
	</div>
</div>
