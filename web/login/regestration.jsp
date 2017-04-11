<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="../head.jsp" %>
	<div id="content">
	<form id="regestrationForm" action="Regestration" method="post">
		<table>
			<tr>
				<td><span>Логин</span></td>
				<td><input type="text" name="login"></td>
			</tr>
			<tr>
				<td><span>Пароль</span></td>
				<td><input type="password" name="password"></td>
			</tr>
			<tr>
				<td><span>Повторите пароль</span></td>
				<td><input type="password" name="confirm_password"></td>
			</tr>
			<tr>
				<td><span>Ваша роль</span></td>
				<td>
					<select name="role">
						<option value="pupil">Ученик</option>
						<option value="teacher">Учитель</option>
					</select>
				</td>
			</tr>
			<tr>
				<td><input type="submit" value="регистрация"></td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>