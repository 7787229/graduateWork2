

$(function(){
	
	
	
	$("form#regestrationForm").on("submit",function(e){
		var form =$("form#regestrationForm");
		var psw = $("input[name=password]").val();
		var fieldConfPsw=$("input[name=confirm_password]");
		var conf_psw = fieldConfPsw.val();
		if(psw!==conf_psw){
			e.preventDefault();
			fieldConfPsw.addClass('red');
			if (fieldConfPsw.parent().children('.msgErrInequality').length===0)
					fieldConfPsw.parent().append("<span class='msgErrInequality' style='color:red'>Поля не совпадают</span>");
		} else {
			fieldConfPsw.removeClass('red');
			$(".msgErrInequality").remove();

		}
	});	
	
	$("form").on("submit",function(e){
		var inputs = $("input[type=text]:visible,input[type=password]:visible,textarea").not("[name=answerText]");
		for(var i=0;i<inputs.length;i++) {
			if(inputs.eq(i).val()==="") {
				e.preventDefault();
				inputs.eq(i).addClass('red');
				if (inputs.eq(i).parent().children('.msgErrEmpty').length===0)
					inputs.eq(i).parent().append("<span class='msgErrEmpty' style='color:red'>Заполните поле</span>");
			} else{
				inputs.eq(i).removeClass('red');
				$(".msgErrEmpty").remove();
			}	
		}
		
		
	});
	
	
	
	
	
});

