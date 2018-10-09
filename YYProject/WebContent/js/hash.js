/**
 * hotkeyword 글씨 빛나게
 *  
 */

//setTimeout은 어떤 시간 뒤에 발생하는 함수이다.
//setInterval은 매 시간동안 발생되는 함수이다.


	$(document).ready(function() {
		setInterval(function() {
			if ($('#hotKeyword').hasClass('black')) { //hotKeyword가 black이라는 클래스를 가지고 있다면
				$('#hotKeyword').removeClass('black');
				$('#hotKeyword').addClass('pink'); //pink라는 클래스명을 주어준다.
				$('#hotKeyword').css('color', 'red');
				$('#hotKeyword').css('font-size', '19px');
			} else if ($('#hotKeyword').hasClass('pink')) {
				$('#hotKeyword').removeClass('pink');
				$('#hotKeyword').addClass('black');
				$('#hotKeyword').css('color', 'black');
				$('#hotKeyword').css('font-size', '18px');
			}
		}, 300);
	});
