<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
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

	function fncGetProductList(currentPage){
		$("#currentPage").val(currentPage)
	   	//document.detailForm.submit();
		$("form").attr("method" , "POST").attr("action" , "/product/listProduct?"+"${url}").submit();
	
	}
	
	$(function() {
		 
		//==> �˻� Event ����ó���κ�
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����. 
		 $( "td.ct_btn01:contains('�˻�')" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('�˻�')" ).html() );
			alert($(this).val().html());
// 			fncGetProductList(1);
		});
		
		$("td.status").on("click", function(){
			
			var prodNo = $(this).parent().find("input").val();
			alert($(this).parent().find("input").val());
// 			alert("/product/getProduct?${url}&prodNo="+prodNo)
// 			$("form").attr("method", "GET").attr("action", "/product/getProduct?${url}&prodNo="+prodNo ).submit();
			self.location = "/product/getProduct?${url}&prodNo="+prodNo;
			
		});
		

		$( "td.prodNo" ).on("click" , function() {
				
				//Debug..
// 				alert( $( this ).html().trim() );
// 				alert( $(this).find('input').val());
				//prodNo ����
				var prodNo = $(this).find('input').val();
// 				alert(prodNo);
// 				// tranCode null���� ���� if�� 
// 				if(prodNo !=null){
// 				self.location = "/product/getProduct?prodNo="+prodNo+"&"+"${url}";
				
				$.ajax( 
						{
							url : "/product/json/getProduct/"+prodNo ,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {

// 								Debug...
// 								alert(status);
// 								Debug...
// 								alert("JSONData : \n"+JSONData);
								
								var displayValue = "<h4>"
															+"��ǰ��ȣ : "+JSONData.prodNo+"<br/>"
															+"��ǰ�̸� : "+JSONData.prodName+"<br/>"
															+"�󼼼��� : "+JSONData.prodDetail+"<br/>"
															+"��ǰ���� : "+JSONData.fileName+"<br/>"
															+"��ǰ���� : "+JSONData.price+"<br/>"
															+"</h4>"
								//Debug...									
								//alert(displayValue);
								$("h4").remove();
								$( "#"+prodNo+"" ).html(displayValue);
							}
					});
					////////////////////////////////////////////////////////////////////////////////////////////
		});
		
		//==> UI ���� �߰��κ�  :  userId LINK Event End User ���� ���ϼ� �ֵ��� 
		$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
		$("h7").css("color" , "red");
		
		
		//==> �Ʒ��� ���� ������ ������ ??
		//==> �Ʒ��� �ּ��� �ϳ��� Ǯ�� ���� �����ϼ���.					
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
	//		console.log ( $(".ct_list_pop:nth-child(1)" ).html() );
// 		console.log ( $(".ct_list_pop:nth-child(2)" ).html() );
	});	



</script>
</head>
<div class="container">
	
		<div class="page-header text-info">
			  <h3>${ title}</h3>
		  </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">			
							
		 <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0" ${ !empty search.searchCondition && search.searchCondition == '0' ? "selected" : ""}>��ǰ��ȣ</option>
						<option value="1" ${ !empty search.searchCondition && search.searchCondition == '1' ? "selected" : ""}>��ǰ��</option>
						<option value="2" ${ !empty search.searchCondition && search.searchCondition == '2' ? "selected" : ""}>��ǰ����</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				</form>
	    	</div>
		</div>

		  <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >��ǰ��</th>
            <th align="left">����</th>
            <th align="left">
           <c:if test="${url == 'menu=manage'}" >
			����
			</c:if>
			<c:if test="${url == 'menu=search'}">
			����
			</c:if>
            </th>
            <th align="left">�������</th>
            <th align="left">��������</th>
          </tr>
        </thead>
       
		<tbody>
			
			<c:set var="i" value="0" />
				<c:forEach var="product" items="${ list }">
				<c:set var="i" value="${ i+1 }"/>
				
				<tr>
				<td align="center"> ${i}</td>
				<td align="left">
		 		${product.prodName}
			 	</td>
				<td align="left">${product.price}</td>
				<td align="left" class="status">
				<c:if test= "${ empty product.proTranCode || product.proTranCode == '0  '}">
					<c:if test= "${ url =='menu=manage' }">
					<i class="glyphicon glyphicon-pencil">�����ϱ�</i>
<!-- 					<button type="button" class="btn btn-default">����</button>	 -->
					</c:if>
					<c:if test=  "${ url =='menu=search' }">
					<i class="glyphicon glyphicon-gift" >�����ϱ�</i>
					
<!-- 					<button type="button" class="btn btn-default">����</button> -->
					</c:if>
				</c:if>
				<c:if test= "${ !empty product.proTranCode && product.proTranCode !='0  '}">
				�ǸſϷ�
			 	</c:if>
				</td>
				<td align="left">
				
				<c:if test= "${ empty product.proTranCode || product.proTranCode =='0  '}">
			 		�Ǹ���
			 	</c:if>
				
				<c:if test= "${ !empty product.proTranCode && product.proTranCode =='1  '}">
			 		 
			 		<c:if test="${ !empty url && url =='menu=search' }">
			 		����غ���  <a href="/updateTranCode.do?tranNo=${ product.prodNo}&tranCode=2">��� ����</a>
			 		 </c:if>
			 		<c:if test="${ !empty url && url =='menu=manage' }">
			 		����غ���  
			 		 </c:if>
			 	</c:if>			
				<c:if test= "${ !empty product.proTranCode && product.proTranCode =='2  '}">
			 		�����
			 	</c:if>			
				<c:if test= "${ !empty product.proTranCode && product.proTranCode =='3  '}">
			 		��ۿϷ� 
			 	</c:if>			
				</td>
				<td align="left" class="prodNo">
					  	<i class="glyphicon glyphicon-zoom-in" id= "${product.prodNo}"></i>
					  	<input class="prodNo" name="prodNo" type="hidden" value="${product.prodNo}">
				</td>	
			</tr>
			</c:forEach>
		
		</tbody>		
	
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		 <input type="hidden" id="currentPage" name="currentPage" value=""/>
<%-- 			<c:if test="${ resultPage.currentPage <= resultPage.pageUnit }"> --%>
<!-- 			�� ���� -->
<%-- 	</c:if> --%>
<%-- 	<c:if test="${ resultPage.currentPage > resultPage.pageUnit }"> --%>
<%-- 			<a href="javascript:fncGetProductList('${ resultPage.currentPage-1}')">�� ����</a> --%>
<%-- 	</c:if> --%>
	
<%-- 	<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1"> --%>
<%-- 		<a href="javascript:fncGetProductList('${i}');">${i}</a> --%>
<%-- 	</c:forEach> --%>
	
<%-- 	<c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }"> --%>
<!-- 			���� �� -->
<%-- 	</c:if> --%>
<%-- 	<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }"> --%>
<%-- 			<a href="javascript:fncGetProductList('${resultPage.endUnitPage+1}')">���� ��</a> --%>
<%-- 	</c:if> --%>
			
			<jsp:include page="../common/pageNavigator.jsp"/>
			
    	</td>
	</tr>
</table>
<!--  ������ Navigator �� -->

</form>

</div>
</body>
</html>