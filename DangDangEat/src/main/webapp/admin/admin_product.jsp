<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>DangDangEAT Admin - Admin_product</title>

<!-- Custom fonts for this template -->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/sb-admin-2.min.css" rel="stylesheet">

<!-- Custom styles for this page -->
<link href="vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap"
	rel="stylesheet">
	
<!-- 폰트 설정 -->
<style>
@font-face {
    font-family: 'GmarketSans';
    font-weight: normal;
    font-style: normal;
    src: url('https://cdn.jsdelivr.net/gh/webfontworld/gmarket/GmarketSansLight.eot');
    src: url('https://cdn.jsdelivr.net/gh/webfontworld/gmarket/GmarketSansLight.eot?#iefix') format('embedded-opentype'),
         url('https://cdn.jsdelivr.net/gh/webfontworld/gmarket/GmarketSansLight.woff2') format('woff2'),
         url('https://cdn.jsdelivr.net/gh/webfontworld/gmarket/GmarketSansLight.woff') format('woff'),
         url('https://cdn.jsdelivr.net/gh/webfontworld/gmarket/GmarketSansLight.ttf') format("truetype");
    font-display: swap;
} 
  @font-face { /*지마켓 산스*/
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}    

body {
    font-family: 'GmarketSansMedium';
/*     vertical-align: middle; */
}

#accordionSidebar{
font-family: 'GmarketSans';
}


.main-icon {
    padding: 1%;
    height: 40px;
    width: auto;
   margin-right: 3%;
   padding: 5px;
}

</style>


<%
// 세션 아이디가 null 이거나 "admin" 이 아닐 경우 "잘못된 접근입니다!" 출력 후 메인페이지로 이동
String sId = (String) session.getAttribute("sId");
// System.out.println(sId);
// 잘못된 접근일 때 바로 main.jsp 로 보내기
if (sId == null || !sId.equals("admin")) {
%>
<script>
	alert("잘못된 접근입니다!");
	location.href = "./";
</script>
<%
}
%>

</head>
<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">

			<!-- Sidebar - Brand -->

			<a
				class="sidebar-brand d-flex align-items-center justify-content-center"
				href="AdminMain.ad">
				<div class="div-top-icon">
					<img class="main-icon" src="img/maindog_white.png">
					<!--                     <i class="fas fa-laugh-wink"></i> -->
				</div>

				<div class="sidebar-brand-text mx-3">DangDangEat Admin</div>
			</a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->

			<li class="nav-item active"><a class="nav-link"
				href="AdminMain.ad"> <i class="fas fa-fw fa-tachometer-alt"></i>
					<span>관리자 메인 페이지</span></a></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">관리 페이지</div>

			<!-- Nav Item - Tables -->
			<li class="nav-item active"><a class="nav-link"
				href="AdminProductList.ad"> <i class="fas fa-fw fa-calendar"></i>
					<span>상품 관리</span></a></li>
			<!-- Nav Item - Tables -->
			<li class="nav-item active"><a class="nav-link"
				href="AdminMemberList.ad"> <i class="fas fa-fw fa-table"></i> <span>회원
						관리</span></a></li>
			<!-- Nav Item - Tables -->
			<li class="nav-item active"><a class="nav-link"
				href="AdminOrderList.ad"> <i class="fas fa-fw fa-dollar-sign"></i>
					<span>주문 관리</span></a></li>
			<!-- Nav Item - Tables -->
			<li class="nav-item active"><a class="nav-link"
				href="AdminCouponList.ad"> <i
					class="fas fa-fw fa-clipboard-list"></i> <span>쿠폰 관리</span></a></li>
			<!-- Nav Item - Tables -->
			<li class="nav-item active"><a class="nav-link"
				href="AdminBoardList.ad"> <i class="fas fa-fw fa-comments"></i>
					<span>게시판 관리</span></a></li>

			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">

			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle"></button>
			</div>

		</ul>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

					<!-- Sidebar Toggle (Topbar) -->
					<form class="form-inline">
						<button id="sidebarToggleTop"
							class="btn btn-link d-md-none rounded-circle mr-3">
							<i class="fa fa-bars"></i>
						</button>
					</form>

					<!-- Topbar Search -->
					<form
						class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
						<div class="input-group">
<!-- 							<input type="text" class="form-control bg-light border-0 small" -->
<!-- 								placeholder="Search for..." aria-label="Search" -->
<!-- 								aria-describedby="basic-addon2"> -->
							<div class="input-group-append">
<!-- 								<button class="btn btn-primary" type="button"> -->
<!-- 									<i class="fas fa-search fa-sm"></i> -->
<!-- 								</button> -->
							</div>
						</div>
					</form>

					<!-- Topbar Navbar -->
					<ul class="navbar-nav ml-auto">

						<!-- Nav Item - Search Dropdown (Visible Only XS) -->
						<li class="nav-item dropdown no-arrow d-sm-none"><a
							class="nav-link dropdown-toggle" href="#" id="searchDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <i class="fas fa-search fa-fw"></i>
						</a> <!-- Dropdown - Messages -->
							<div
								class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
								aria-labelledby="searchDropdown">
								<form class="form-inline mr-auto w-100 navbar-search">
									<div class="input-group">
										<input type="text"
											class="form-control bg-light border-0 small"
											placeholder="Search for..." aria-label="Search"
											aria-describedby="basic-addon2">
										<div class="input-group-append">
											<button class="btn btn-primary" type="button">
												<i class="fas fa-search fa-sm"></i>
											</button>
										</div>
									</div>
								</form>
							</div></li>



                       <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 font-weight-bold">Admin</span>
                                <img class="img-profile rounded-circle"
                                    src="img/dangprofile.png">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="./">
                                    <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Member Main
                                </a>
                                <a class="dropdown-item" href="CheckPassForm.me">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Profile
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="MemberLogout.me">
                                    <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
                            </div>
                        </li>

                    </ul>

                </nav>
                <!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->
					<h1 class="h3 mb-2 text-gray-800 font-weight-bold">상품 관리</h1>
					<p class="mb-4">
						상품 목록 페이지 <a target="_blank"> <!--                             href="https://datatables.net">주문 검색, 필터 기능 등 필요 -->
						</a>
					</p>

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">상품 목록</h6>

						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered table-striped" id="dataTable"
									width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>상품 등록일자</th>
											<th>상품 코드</th>
											<th>상품명</th>
											<th>카테고리</th>
											<th>브랜드</th>
											<th>상품 재고</th>
											<th>상품 가격</th>
											<th>상품 판매여부</th>
											<th>관리</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="product" items="${productList }"> 
											<tr>
												<td>
													<c:out value="${fn:substring(product.pro_date, 0, 10)}" />
												</td>
												<td class="pro_code">${product.pro_code }</td>
												<td>${product.pro_name }</td>
												<%--<td>${product.cate_code }</td>--%>
												<td class="form" id="cate_code" name="cate_code"><c:if
														test="${product.cate_code eq '1'}">사료</c:if> <c:if
														test="${product.cate_code eq '2'}">간식</c:if> <c:if
														test="${product.cate_code eq '3'}">파우더 · 토핑</c:if> <c:if
														test="${product.cate_code eq '4'}">껌 · 츄르</c:if> <c:if
														test="${product.cate_code eq '5'}">건강보조제</c:if></td>
												<td>${product.pro_brand }</td>
												<td>${product.pro_qty }개</td>
												<td><fmt:formatNumber value="${product.pro_price}"
														pattern="#,###" /> 원</td>
												<td class="form" name="pro_yn" id="pro_yn"><c:if
														test="${product.pro_yn eq '1'}">판매중</c:if> <c:if
														test="${product.pro_yn eq '2'}">판매중단</c:if> <c:if
														test="${product.pro_yn eq '3'}">재고없음</c:if></td>

												<td><input type="button" value="수정"
													class="form-control text-center"
													onclick="window.open('ProductModifyForm.pd?pro_code=${product.pro_code}','ProductInsertForm','width=700, height=920,location=no,status=no,scrollbars=yes');">

												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<button type="button" class="btn btn-outline-secondary"
									onclick="window.open('ProductInsertForm.pd', 'ProductInsertForm','width=700,height=920,location=no,status=no,scrollbars=yes');">상품
									등록</button>
							</div>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->
			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright &copy; Your Website 2020</span>
					</div>
				</div>
			</footer>
			<!-- End of Footer -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

	<!-- Logout Modal-->
	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">Select "Logout" below if you are ready
					to end your current session.</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"
						data-dismiss="modal">Cancel</button>
					<a class="btn btn-primary" href="login.html">Logout</a>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap core JavaScript-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script src="vendor/datatables/jquery.dataTables.min.js"></script>
	<script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="js/demo/datatables-demo.js"></script>


</body>

</html>
