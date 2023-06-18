/**
 * 
 */

 $(function() {
	$('.card').click(function() {
		
		if(confirm('이 좌석을 선택하시겠습니까.'))
		{
			
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
					$(this).addClass('active');
				}
				else {
				}
			},
			error:function(){
				alert("error");
			}
		})
			
		}		
	})
});