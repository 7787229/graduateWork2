
//
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
        var inputs = $("input[type=text]:visible,input[type=password]:visible,textarea").not("[name=answerText]").not("[name=new_title_group]");
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

    $(".int-value").parents("form").on("submit",function(e){
    	var input = $(this).find(".int-value:visible");
		if (!isFinite(input.val()) && input.val()!==undefined ) {
            e.preventDefault();
            input.addClass('red');
            if (input.parent().children('.msgErrInt').length===0)
                input.parent().append("<span class='msgErrInt' style='color:red'>Введите число</span>");
		} else{
            input.removeClass('red');
            $(".msgErrInt").remove();
        }

    });

});
function checkQuestion(current) {
    var type = $("select[name=type]");
    var inputs = $("input[name^=answer]");
    var countSelect = $("input[name^=answer]:checked").length;
    var countInputs = $("input[name^=answer]").length;
    if (countInputs!=0) {
        if (type.val() === "r" || type.val() === "n") {
            if (countSelect !== 1) {
                showErr("У данного вопроса может быть только 1 правильный ответ");
            } else {
            	$(current).attr("type","submit");
			}
        }
        if (type.val() === "c") {
            if (countSelect === 0) {
                showErr("Вопрос не может быть без ответов");
            } else {
                $(current).attr("type","submit");
			}
        }
    }
}

function addVariant(current){
    var type = $("select[name=type]");
    var inputs = $("input[name^=answer]").add("input[name=new_answer]");
    var countSelect = $("input[name^=answer]:checked").add("input[name=new_answer]:checked").length;
    var countInputs = inputs.length;
    if (countInputs!=0) {
        if (type.val() === "r"){
            if (countSelect !== 1) {
                showErr("У данного вопроса может быть только 1 правильный ответ");
            } else {
                $(current).attr("type","submit");
            }
		}
        if (type.val() === "n"){
            if (countSelect !== 1 || countInputs!==1) {

                showErr("У данного вопроса может быть только 1 ответ");
            } else {
                $(current).attr("type","submit");
            }
        }
	} else {
        $(current).attr("type","submit");
	}


}

function showErr(msg) {
	var html=" <div style='background-color: rgba(173, 57, 22, 0.5)' class='modal fade' id='errMsg'  tabindex='-1' role='dialog' aria-labelledby='myModalLabel'> <div class='modal-dialog' role='document'> <div style='background-color: #00FFFF' class='modal-content'> <div class='modal-header'> <button type='button' class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button> <h4 class='modal-title' >Ошибка!!!</h4> </div> <div class='modal-body'> <table class='table modal-table'> <tr> <td><label class='control-label'>"+msg+"</label></td> </tr> </table> </div> <div class='modal-footer'> <button type='button' class='btn btn-default' data-dismiss='modal'>Close</button> </div> </div> </div> </div>";
	$("#errMsg").remove();
	$("body").append(html);
	$("#errMsg").modal('show');

}
