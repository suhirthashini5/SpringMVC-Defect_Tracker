<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:include page="../../fragments/htmlhead.jsp" />
<jsp:include page="../../fragments/topnav.jsp" />

<div class="container-fluid">
	<div class="row">
		<jsp:include page="../../fragments/sidebar.jsp" />
		<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
		<div
			class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
			<h1 class="h2">Project List</h1>

		</div>

		<div class="container">
			<table border="2" width="70%" cellpadding="2">
				<tr>
					<th>Project Name</th>
					<th>Project Description</th>
				</tr>
				<c:forEach var="project" items="${list}">
					<tr>
						<td>${project.ProjectName}</td>
						<td>${project.ProjectDescription}</td>
					</tr>
				</c:forEach>
			</table>

			<!-- Json project data goes here -->
		</div>

		</main>
	</div>
</div>

<script>
	function loadDoc() {
		var xhttp = new XMLHttpRequest();
		xhttp.onresdystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				let projects = JSON.parse(this.responseText);

				let tableStr = "";
				projects.forEach(function(project) {
					tableStr = tableStr + "<tr>";
					tableStr = tableStr + "<td>" + project.name + "</td><td>"
							+ project.description + "</td>"
					tableStr = tableStr + "<td><button onclick='deleteProject("
							+ project.id + ")'>Delete</button></td>";
					tableStr = tableStr + "<tr>"
				});

				console.log(tableStr);

				document.getElementById("table_project").innerHTML = tableStr;
			}
		};
		xhttp.open("GET", "project", true);
		xhttp.send();
	}

	function deleteProject(projectId) {
		alert(projectId);
		var xhttp = new XMLHttpRequest();
		xhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.state == 200) {
				var resObj = JSON.parse(this.responseText);

				if (resObj.response == "success") {
					loadDoc();
				}
			}
		};
		xhttp.open("DELETE", "project?id=" + projectid, true);
		xhttp.send();
	}

	loadDoc();
</script>

<jsp:include page="../../fragments/footer.jsp" />