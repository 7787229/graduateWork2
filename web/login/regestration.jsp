<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Регестрация</title>
</head>
<body>
	<%@ include file="../head.jsp" %>
	<div id="conteiner">






		<form id="regestrationForm" class="form-horizontal" action="Regestration" method="post" >
				<div class="form-group">
					<label for="inputLogin" class="col-sm-4 control-label">Логин</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="inputLogin" placeholder="Логин" name="login">
					</div>
				</div>
				<div class="form-group">
					<label for="inputPassword" class="col-sm-4 control-label">Пароль</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="inputPassword" placeholder="Пароль" name="password">
					</div>
				</div>
				<div class="form-group">
					<label for="inputConfimPassword" class="col-sm-4 control-label">Повторите пароль</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="inputConfimPassword" placeholder="Повторите пароль" name="confirm_password">
					</div>
				</div>
				<div class="form-group">
					<label for="inputRole" class="col-sm-4 control-label">Выберите роль</label>
					<div class="col-sm-8">
						<select name="role" id="inputRole" class="form-control">
							<option value="pupil">Ученик</option>
							<option value="teacher">Учитель</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-4 col-sm-8">
						<button type="submit" class="btn btn-default">Регестрация</button>
					</div>
				</div>
			</form>

</div>
</body>
</html>