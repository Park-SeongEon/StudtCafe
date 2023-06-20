/**
 * 
 */

 $(function() {
	$('.card').click(function() {
		
		if(confirm('이 좌석을 선택하시겠습니까.'))
		{
			
			var thics=$(this);
			var SeatNo = $(this).children(".card-head").children("p").children("span").text();
			var userId = $("#userId").val();
						
			
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
					thics.addClass('active');
				 	thics.children(".card-main").children("p").text("사용중");
				 	location.href = '/main/main.do'
				}
			},
			error:function(){
				alert("error");
			}
		})
			
		}		
	})
});