$(function() {
	
	$('#search').click(function() {


		var $form = $('#frmSearch');
		var $loadTarget = $('#baordList');
		var url = '/board/searchlist.do';
		
		// 데이터 파싱
		var data = $form.serialize();
		
		console.log(data);
		$loadTarget.load(url, data, function(){
			
			
		});	

	})
});
