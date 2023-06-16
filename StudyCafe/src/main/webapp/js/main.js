/**
 * 
 */

 $(function() {
	$('.card').click(function() {
		
		if(confirm('이 좌석을 선택하시겠습니까.'))
		{
			$(this).addClass('active');			
			
			var SeatNo = $(this).children(".card-head").children("p").text();

			var userId = $("#userId").val();
			
			console.log(SeatNo + ", " + userId );
			$.ajax({
			url:"/main/change.do",		// servlet 
			type: "post",
			datatype:"text",
			data: {"userId" : userId, "SeatNo": SeatNo},
			success:function(data){
				//alert("s");
				//int, string, 다수의 데이터
				
				//var data = JSON.parse(obj);
				//console.log(data.id);
				//alert(json.str);
				/* var data = JSON.parse(json.map);
				alert(data); */
				//alert(json.map.title);
				if(data === 'success'){
					$('input[name=checkID]').val("ok");
					alert("사용 가능한 아이디입니다.")
					$('#message').text('사용할 수 있는 ID입니다.')   
					$('#message').css('color','green')
					
				}
				else {
					alert("사용 불가능한 아이디입니다.")
					$('#message').text('이미 사용 중인 아이디입니다.')
					$('#message').css('color','red')					
				}
			},
			error:function(){
				alert("error");
			}
		})
			
		}		
	})
});