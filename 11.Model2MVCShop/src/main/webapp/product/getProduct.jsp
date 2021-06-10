<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR" 
    pageEncoding="EUC-KR"%>
 <!DOCTYPE html>

<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<jsp:include page="/layout/toolbar.jsp" />

<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">

	$(function() {
		$( "button.btn.btn-primary:contains('구매')" ).on("click" , function() {
			alert("개발중입니다.");
		});
	});	

	$(function() {
		$( "button.btn.btn-primary:contains('이전')" ).on("click" , function() {
			alert("개발중입니다.");
		});
	});	
	
</script>

<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">상품상세조회</h3>
	    </div>
	
	
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품번호</strong></div>
			<div class="col-xs-8 col-md-4">${ product.prodNo}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품명</strong></div>
			<div class="col-xs-8 col-md-4">${ product.prodName}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품이미지</strong></div>
			<div class="col-xs-8 col-md-4">${user.addr}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품상세정보</strong></div>
			<div class="col-xs-8 col-md-4">${ product.prodDetail}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
			<div class="col-xs-8 col-md-4">${ product.manuDate}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>가격</strong></div>
			<div class="col-xs-8 col-md-4">${product.price}</div>
		</div>
		
		<hr/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>등록일자</strong></div>
			<div class="col-xs-8 col-md-4">${product.regDate}</div>
		</div>
		<hr/>
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
	  		<c:choose>
				<c:when test ="${user.role == 'user'}">
	  				<button type="button" class="btn btn-primary">
				구매
					</button>
				</c:when>	
				
	  			
				
				<c:otherwise></c:otherwise>
				</c:choose>
				
				<button type="button" class="btn btn-primary">
				이전
				</button>
				
				
	  		</div>
		</div>
 	
<!--  		<div class="row"> -->
<!-- 	  		<div class="col-md-12 text-center "> -->
<!-- 	  			<button type="button" class="btn btn-primary"> -->
<!-- 				이전 -->
<!-- 				</button> -->
<!-- 			</div> -->
<!-- 		</div> -->
		<br/>
 	</div>	
				
				
 	
				
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
					<a href="javascript:history.go(-1)">이전</a>
				
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23">
				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>
</form>

</body>
</html>