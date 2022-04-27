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
<c:if test="${empty feed}">
<jsp:forward page="/feedback/list"/>
</c:if>
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
                <div class="container-fluid">
                	<div class="d-flex justify-content-between">
                		<div class="py-2">
    	            		<span class="h2 fw-bold">${feed.title}</span>
                		</div>
<%--                 		<c:set var="idx" value="0"/> --%>
<%--                		 	<c:forEach var="item" items="${allLikeList}"> --%>
<%-- 						<c:if test="${feed.num == item.pnum}"> --%>
<%-- 						<c:set var="idx" value="${idx+1}"/> --%>
<%-- 						</c:if> --%>
<%-- 		                </c:forEach> --%>
<!--                 		<div class="lh-lg py-2"> -->
<!--                 			<span class="my-1"> -->
<!-- 	               				<span class="badge bg-danger fs-6"> -->
<%-- 	                                <i class="fas fa-heart"></i> <span class="likes">${idx}</span> --%>
<!-- 	                            </span> -->
<!-- 		                		<span class="badge bg-secondary fs-6"> -->
<%-- 		                			<i class="fas fa-eye"></i> ${product.view} --%>
<!-- 		                		</span> -->
<!--                 			</span> -->
<!--                 		</div> -->
                	</div>
                	<div class="d-flex justify-content-between">
              			<jsp:useBean id="cur" class="java.util.Date"/>
              			<fmt:formatDate var="cur" value="${cur}" pattern="yyyy-MM-dd HH:mm"/>
               			<fmt:formatDate var="reg" value="${feed.regdate}" pattern="yyyy-MM-dd HH:mm"/>
               			<span>
               				<span>${feed.author==''?'admin':feed.author}</span>
               				<time class="text-muted badge">
               					${reg}
               				</time>
               			</span>
                	</div>
                	<hr>
                	<div>
                		<div>
                			<p>
                				${feed.content}
                			</p>
                		</div>
                		<div class="mt-3 d-flex justify-content-between">
                			<div class="tags">
                				<!-- tags -->
								<c:forEach var="tag" items="${fn:split(feed.tags, '_')}">
								<span class="badge tag tag-info">${tag}</span>
								</c:forEach>
                				<!-- tags -->
							</div>
							<c:if test="${mentee.id!=feed.author}">
							<div>
								<c:set var="nums" value="${null}"/>
								<c:forEach var="item" items="${allFeedList}">
									<c:if test="${item.fnum == feed.num}">
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
                	<hr>
                	
                </div>
                
            </div>
            
        </div>

    </div>
</div>