/**
 * 별점구현
 * 
 */

$(document).ready(function(){
	$('.one').on('click', function(){
		/*사용자가 5개줬다가 하나 줄 수있기 때문에 */
		
		$('.score').val('1');
		$('.one').css('font-weight', 'bold');
		$('.two').css('font-weight', 'normal');
		$('.three').css('font-weight', 'normal');
		$('.four').css('font-weight', 'normal');
		$('.five').css('font-weight', 'normal');
	})
	$('.two').on('click', function(){
		$('.score').val('2');
		$('.one').css('font-weight', 'bold');
		$('.two').css('font-weight', 'bold');
		$('.three').css('font-weight', 'normal');
		$('.four').css('font-weight', 'normal');
		$('.five').css('font-weight', 'normal');
	})
	$('.three').on('click', function(){
		$('.score').val('3');
		$('.one').css('font-weight', 'bold');
		$('.two').css('font-weight', 'bold');
		$('.three').css('font-weight', 'bold');
		$('.four').css('font-weight', 'normal');
		$('.five').css('font-weight', 'normal');
	})
	$('.four').on('click', function(){
		$('.score').val('4');
		$('.one').css('font-weight', 'bold');
		$('.two').css('font-weight', 'bold');
		$('.three').css('font-weight', 'bold');
		$('.four').css('font-weight', 'bold');
		$('.five').css('font-weight', 'normal');
	})
	$('.five').on('click', function(){
		$('.score').val('5');
		$('.one').css('font-weight', 'bold');
		$('.two').css('font-weight', 'bold');
		$('.three').css('font-weight', 'bold');
		$('.four').css('font-weight', 'bold');
		$('.five').css('font-weight', 'bold');
	})
});
