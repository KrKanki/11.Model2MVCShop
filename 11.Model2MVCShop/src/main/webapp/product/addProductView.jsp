<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>



<style>
.ui-datepicker{ font-size: 12px; width: 200px; }
.ui-datepicker select.ui-datepicker-month{ width:30%; font-size: 11px; }
.ui-datepicker select.ui-datepicker-year{ width:40%; font-size: 11px; }
</style>
<script>
$(function() {
  $( "#manuDate" ).datepicker({
    dateFormat: 'yymmdd'
  });
});
</script>
  
<title>상품등록</title>
</head>
<body>
<link rel="stylesheet" href="/css/admin.css" type="text/css">

</script>
<jsp:include page="/layout/toolbar.jsp" />
<script type="text/javascript">
// <!--


	function fncAddProduct(){
		
		var name = $("input[name=prodName]");
		var detail = $("input[name=prodDetail]");
		var manuDate = $("input[name=manuDate]");
		var price = $("input[name=price]");
		
		if(name == null|| name.length <1 ){
			alert("상품이름을 입력하세요.")
			return;
		}
		if(detail == null || detail.length<1){
			alert("상품상세정보는 반드시 입력하여야 합니다.");
			return;
		}
		if(manuDate == null || manuDate.length<1){
			alert("제조일자는 반드시 입력하셔야 합니다.");
			return;
		}
		if(price == null || price.length<1){
			alert("가격은 반드시 입력하셔야 합니다.");
			return;
		}
		
		$("form").attr("method", "POST").attr("action", "/product/addProduct").submit();
		
// 		document.detailForm.action='/product/updateProduct';
// 		document.detailForm.submit();
	}
	
	$(function(){
		$("#aaa").on("click", function(){
			fncAddProduct();
		});
	});
	
	$(function(){
		$("#bbb").on("click", function(){
			$("form").reset();
		})
	})
	
	
	
</script>
</head>
	<div class="navbar  navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
   		</div>
   	</div>


	<div class="container">
	
		<h1 class="alert alert-info text-center">상품등록</h1>
		
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		  
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" placeholder="상품명">
		    </div>
		  </div>
		  
		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="price" name="price" placeholder="가격">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세설명</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail" placeholder="상품상세설명">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="manuDate" name="manuDate" placeholder="제조일자">
		    </div>
		  </div>
		  
		  
		   <div class="form-group">
		    <label for="fileName" class="col-sm-offset-1 col-sm-3 control-label">상품사진</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="fileName" name="fileName" placeholder="상품사진">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary" id="aaa"  >등록</button>
			  <button type="button" class="btn btn-primary" id="bbb" >취소</button>
			  
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->

</body>
</html>