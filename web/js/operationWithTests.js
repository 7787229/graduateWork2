function changeTest(current,id_test,time,title){
			$(".removed").remove();
			var html ="<table class = 'change_test removed' >" +
				"<tr>" +
					"<td><span>Название</span></td>" +
					"<td> <input type='text' name='new_title_test' value="+title+"></td>" +
				"</tr>" +
				"<tr>" +
					"<td><span>Время выполнения</span> </td>" +
					"<td><input type='text' name='new_time' value="+time+"></td>" +
				"</tr>" +
				"<tr style='display:none'><td><input type='text' name='id_test' value="+id_test+"></td></td>" +
				"<tr><td><button name='change_test' value='chanhe_test'>Изменить  </button></td></td>" +
			"</table>";
			$(current).parent().append(html);
	}

	function changeGroup(current,id_group,title){
		$(".removed").remove();
		var html ="<table class = 'change_group removed' >" +
			"<tr>" +
				"<td><span>Название</span></td>" +
				"<td> <input type='text' name='new_title_group' value="+title+"></td>" +
			"</tr>" +
			"<tr style='display:none'><td><input type='text' name='id_group' value="+id_group+"></td></td>" +
			"<tr><td><button name='change_group' value='chanhe_group'>Изменить  </button></td></td>" +
		"</table>";
		$(current).parents(".group").append(html);
}
	
	function addQuestion (current, id_test) {
		$(".removed").remove();
		var options = "";
		for (var i=1;i<=10;i++) {
			options = options + "<option value='"+i+"'>"+i+" </option> ";
		}
		var html ="<table class = 'add_question removed' >" +
			"<tr>" +
				"<td><span>Текст вопроса</span></td>" +
				"<td> <textarea rows='2' cols='30' name='text_question'></textarea></td>" +
			"</tr>" +
			"<tr>" +
				"<td><span>Количество очков</span></td>" +
				"<td> <input type='text' name='score' ></td>" +
			"</tr>" +
			"<tr>" +
				"<td><span>Тип вопроса</span> </td>" +
				"<td><span>одиночный выбор</span><input type='radio' name='type' value='r' onclick='toggleCountVariants(this)'></td>" +
				"<td><span>множественный выбор</span><input type='radio' name='type' value='c' onclick='toggleCountVariants(this)'></td>" +
				"<td><span>без вариантов</span><input type='radio' name='type' value='n' onclick='toggleCountVariants(this)'></td>" +
			"</tr>" +
			"<tr id ='count_variants'>" +
				"<td><span>Количество ответов</span> </td>" +
				"<td>" +
					"<select name='count_variants' id='count_variants' onchange='changeCountVariants(this)'>" +
						options +
					"</select>" +
				"</td>" +
			"</tr>" +
			"<tr style='display:none'><td><input type='text' name='id_test' value="+id_test+"></td></tr>" +
			
		"</table>";
		$(current).parent().append(html);
	}
	

		function changeCountVariants(current){ 
			$(".add_variants").remove();
			var variants ="<div class = 'add_variants' >";
			for (var i=1;i<=$(current).val();i++) {
				variants = variants + "<table class = 'add_variant' >"+
					"<tr>" +
						"<td><span>Текст варианта"+i+"</span></td>" +
						" <td><textarea rows='2' cols='30' name='text_variant"+i+"'></textarea></td>" +
					"</tr>"+
					"<tr>" +
						"<td><span>Эо ответ?</span> </td>" +
							"<td><span>Да</span><input type='radio' name='answer"+i+"' value='yes'></td>" +
							"<td><span>Нет</span><input type='radio' name='answer"+i+"' value='no'></td>" +
					"</tr>" +
				"</table>"
			}
			var html =variants+"<button name='add_question' value='add_question'>Добавить вопрос  </button> </div>" ;
			//$(current).val()
			$(current).parents('.test').append(html);
		}	
		function showQuestions(current){
			$(current).siblings('ul').toggleClass('hidden');
		}
		function showGroups(current){
			$(current).siblings('table').toggleClass('hidden');
		}
		function showResult(current){
			$(current).siblings('table').toggleClass('hidden');
		}
	    function addTest () {
	    	$('#add_test').toggleClass('hidden');
	    }
	    function addGroup () {
	    	$('#add_group').toggleClass('hidden');
	    }
	    
	    function toggleCountVariants(current){
	    	
	    	if ($("input[name='type']:checked").val() == 'n'){
	    			$('.add_variants').remove();
		    		$('#count_variants').css('display','none');
		    		var html = "<input type='text' name='text_variant'><br>";
		    		html +="<button name='add_question' value='add_question'>Добавить вопрос  </button> </div>" ;
		    		$(current).parents('.add_question').append(html);
	    		}
	    	else { 
	    		$('#count_variants').css('display','table-row');
	    		$(".add_question button, br, input[name=text_variant]").remove();
	 
	    	}
	    }
	    
	   function addTestInGroup(current,id_group) {
		   $(".removed").remove();
			var html ="<table class = 'add_test_in_group removed' >" +
				"<tr>" +
					"<td><span>id теста</span></td>" +
					"<td> <input type='text' name='id_test_group'></td>" +
				"</tr>" +
				"<tr style='display:none'><td><input type='text' name='id_group' value="+id_group+"></td></td>" +
				"<tr><td><button name='add_test_in_group' value='add_test_in_group'>ок  </button></td></td>" +
			"</table>";
			$(current).parents('.group').append(html);
	   }
	   function addPupilInGroup(current,id_group) {
		   $(".removed").remove();
			var html ="<table class = 'add_pupil_in_group removed' >" +
				"<tr>" +
					"<td><span>Логин ученика</span></td>" +
					"<td> <input type='text' name='login_pupil'></td>" +
				"</tr>" +
				"<tr style='display:none'><td><input type='text' name='id_group' value="+id_group+"></td></td>" +
				"<tr><td><button name='add_pupil_in_group' value='add_pupil_in_group'>ок  </button></td></td>" +
			"</table>";
			$(current).parents('.group').append(html);
	   }
	    
	 
	    
	    
	    