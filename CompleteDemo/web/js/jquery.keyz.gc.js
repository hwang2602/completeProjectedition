/* Demo code:
<script type="text/javascript">
$(function(){
            $('pre#code').hide();
	    $('#area')
		.focusin(function() { $(this).addClass('redborder');})
		.focusout(function() {$(this).removeClass('redborder'); })
		. keyz({
                	'enter': function(ctl,sft,alt) {
                    $('<span />', {text: 'enter pressed'}).insertAfter(this).prepend('<br />');
                    return false;
                },
                "f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12 ": function() {
                    $('<span />', {text: 'F Key pressed'}).insertAfter(this).prepend('<br />');
                    return false;
                },
                'tab':function(ctl,sft,alt) {
                  $('<span />', {text: 'tab pressed'}).insertAfter(this).prepend('<br />');
                    return false;
                },
                'windows': function() {
                    $('<span />', {text: 'Windows key pressed'}).insertAfter(this).prepend('<br />');
                    return false;
                },
		'default' : function(code,ctl,sft,alt) {
			 $('<span />', {text: 'key with key code ' + code + ' was pressed'}).insertAfter(this).prepend('<br />');
			return true;
		}
            });
	    $('#showdemo').click(function(e){
		e.preventDefault();
		$('pre#code').toggle();
		$(this).blur();
	    });
        });
</script>

*/
	
	

typeof jQuery!="undefined"&&jQuery(function(e){e.fn.extend({keyz:function(k,l,h){var g={up:{},down:{},press:{},chain:{}},i=function(a){var b={};for(var c in a)for(var m=e.trim(c).toLowerCase().replace("-","").split(" "),f=0,n=m.length;f<n;f++){var d=m[f];if(isNaN(d)){if(typeof e.fn.keyz.keymap[d]!="undefined"){d=e.fn.keyz.keymap[d];if(e.isArray(d)){f=0;for(var o=d.length;f<o;f++)b[d[f]]=a[c]}else b[d]=a[c]}}else b[d]=a[c]}return b},j=function(a,b,c){if(typeof c[b]!="undefined"){b=c[b];if(false===
b)a.preventDefault();else e.isFunction(b)&&false===b.call(this,a.ctrlKey,a.shiftKey,a.altKey,a)&&a.preventDefault()}else typeof c["default"]!="undefined"&&e.isFunction(c["default"])&&c["default"].call(this,b,a.ctrlKey,a.shiftKey,a.altKey,a)};g.down=i(k);this.bind("keydown.keyz",function(a){j.call(this,a,a.which,g.down)});if(typeof h!="undefined"&&typeof h=="object"){g.up=i(h);this.bind("keyup.keyz",function(a){j.call(this,a,a.which,g.up)})}if(typeof l!="undefined"&&typeof l=="object"){g.press=i(k);
this.bind("keypress.keyz",function(a){j.call(this,a,a.which,g.press)})}return this}});e.fn.keyz.keymap={enter:13,"return":13,esc:27,escape:27,numerics:[48,49,50,51,52,53,54,55,56,57],upper:[65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90],lower:[97,98,99,100,101],alphanumeric:[65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,48,49,50,51,52,53,54,55,56,57],tab:9,shift:16,alt:17,ctrl:18,f1:112,f2:113,f3:114,f4:115,f5:116,f6:117,f7:118,f8:119,
f9:120,f10:121,f11:122,f12:123,caps:20,capslock:20,numlock:144,winflag:91,winkey:91,windows:91,scrolllock:145,left:37,up:38,right:39,down:40,volumeup:175,volumedown:174,menu:93,contextmenu:93,backspace:8,pause:19,"break":19,pausebreak:19,pageup:33,pagedown:34,end:35,home:36,insert:45,del:46,"delete":46,numpad0:96,numpad1:97,numpad2:98,numpad3:99,numpad4:100,numpad5:101,numpad6:102,numpad7:103,numpad8:104,numpad9:105,"*":106,multiply:106,"+":107,add:107,"-":109,subtract:109,".":[110,190],fullstop:[110,
190],decimal:[110,190],"/":[111,191],divide:[111,191],";":59,semicolon:59}});