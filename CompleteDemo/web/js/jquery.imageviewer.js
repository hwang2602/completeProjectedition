/*
 * ImageViewer jQuery plugin
 * version 1.0
 *
 * Copyright (c) 2011 Hrant Levonyan (http://levonyan.com)
 *
 * Dual licensed under the MIT (MIT-LICENSE.txt) or GPL (GPL-LICENSE.txt) licenses.
 *
 * http://jquery.levonyan.com/imageviewer/
 *
 */

(function($)
{
	var methods =
	{
		options : function(opts)
		{
			var $this = $(this);

			if( opts )
			{
				if( opts['mode'] )
					$this.data('mode', opts['mode']);

				if( opts['fade_dur'] && !isNaN(opts['fade_dur']) )
					$this.data('fade_dur', parseInt(opts['fade_dur']));
			
				if( opts['size'] && opts['size']['w'] && opts['size']['h'] && !isNaN(opts['size']['w']) && !isNaN(opts['size']['h']) )
				{
					$this.data( 'width',  parseInt(opts['size']['w']) );
					$this.data( 'height', parseInt(opts['size']['h']) );
				}

				if( opts['header'] && opts['h_height'] && !isNaN(opts['h_height']) )
				{
					$this.data('header', opts['header']);
					$this.data('h_height', parseInt(opts['h_height']));
				}

				if( opts['h_show'] )
				{
					$this.data('h_show', opts['h_show']);
					$this.data('h_show_dur', !isNaN(opts['h_show_dur']) ? parseInt(opts['h_show_dur']) : 0 );
				}

				if( opts['footer'] && opts['f_height'] && !isNaN(opts['f_height']) )
				{
					$this.data('footer', opts['footer']);
					$this.data('f_height', parseInt(opts['f_height']));
				}

				if( opts['f_show'] )
				{
					$this.data('f_show', opts['f_show']);
					$this.data('f_show_dur', !isNaN(opts['f_show_dur']) ? parseInt(opts['f_show_dur']) : 0 );
				}
			}

			var ivObj = $this.data('ImageViewer');
			if( ivObj )
			{
				if( $this.data('fade_dur') >= 0 )
				{
					ivObj.SetFadeDuration( $this.data('fade_dur') );
					$this.removeData('fade_dur');
				}

				if( $this.data('width') && $this.data('height') )
				{
					ivObj.SetSize( $this.data('width'), $this.data('height') );
					$this.removeData('width');
					$this.removeData('height');
				}

				if( $this.data('header') && $this.data('h_height') )
				{
					ivObj.SetFloatingPanel( $this.data('header'), $this.data('h_height'), true );
					$this.removeData('header');
					$this.removeData('h_height');
				}

				if( $this.data('h_show') )
				{
					ivObj.ShowFloatingPanel( ($this.data('h_show') == 'show') ? true : false, $this.data('h_show_dur'), true );
					$this.removeData('h_show');
					$this.removeData('h_show_dur');
				}

				if( $this.data('footer') && $this.data('f_height') )
				{
					ivObj.SetFloatingPanel( $this.data('footer'), $this.data('f_height'), false );
					$this.removeData('footer');
					$this.removeData('f_height');
				}

				if( $this.data('f_show') )
				{
					ivObj.ShowFloatingPanel( ($this.data('f_show') == 'show') ? true : false, $this.data('f_show_dur'), false );
					$this.removeData('f_show');
					$this.removeData('f_show_dur');
				}
			}
		},

		show : function(img, href, target)
		{
			var $this = $(this);

			var ivObj = $this.data('ImageViewer');
			if( !ivObj )
			{
				if( this.tagName.toLowerCase() != 'div' )
					return;

				if( $this.data('mode') == 'popup' ) {
					ivObj = new ClassImageViewer( $('<div></div>').appendTo($("body")), true );
				} else {
					ivObj = new ClassImageViewer( $this, false );
				}

				$this.removeData('mode');
				$this.data('ImageViewer', ivObj);

				methods.options.apply( this, new Array() );
			}

			ivObj.ShowImage(img, href, target);
		},

		hide : function()
		{
			var $this = $(this);

			var ivObj = $this.data('ImageViewer');
			if( ivObj )
			{
			    if( ivObj.m_bPopupMode )
				{
					// unbind prevously binded events
					$(window).unbind('resize scroll');

					// this is the "div" object we have created in "show" function
					ivObj.m_dvWrapPanel.remove();
				}

				$this.empty();
				$this.removeData('ImageViewer');
			}
		}
	};

    $.fn.imageviewer = function( method )
    {
        var ivArgs = arguments;
        return this.each( function()
        {
			if( methods[method] ) {
			  return methods[method].apply( this, Array.prototype.slice.call(ivArgs, 1) );
			} else if( typeof method === 'object' || !method ) {
			  return methods.options.apply( this, ivArgs );
			} else {
			  $.error( 'Method \'' +  method + '\' does not exist in jQuery.imageviewer' );
			} 
        });
    }

    function ClassImageViewer(dvWrapper, bPopupMode)
    {
	    var pViewerObj = this;
        if( !(pViewerObj instanceof ClassImageViewer) )
	        return false;

	    // if no wrapper DIV found
	    if( dvWrapper.length == 0 )
		    return false;

	    var css_wrapper       = {position:'relative', top:0, left:0, overflow:'hidden'};
	    var css_wrapper_popup = {position:'absolute', top:0, left:0, overflow:'hidden'};
	    var css_bglayer       = {position:'absolute', top:0, left:0, width:'100%', height:'100%', opacity:0.4};
	    var css_mainpanel     = {position:'absolute', top:0, left:0, width:'100%', height:'100%', overflow:'hidden'};
	    var css_imageslayer   = {position:'absolute', top:0, left:0, width:'50%', height:'100%'};
	    var css_loadlayerbg   = {position:'absolute', top:0, left:0, width:'100%', height:'100%', opacity:0.6};
	    var css_loadlayerfg   = {position:'absolute', top:0, left:0, width:'100%', height:'100%'};

	    pViewerObj.m_dvWrapPanel = dvWrapper;
	    pViewerObj.m_nViewerW = 0.5;
	    pViewerObj.m_nViewerH = 0.5;
	    pViewerObj.m_bFixedSize = false;
	    pViewerObj.m_bPopupMode = bPopupMode;
	    pViewerObj.m_nImageFadeDuration = 0;
	    pViewerObj.m_FloatPanels     = [];
	    pViewerObj.m_FloatPanelsStat = [];

	    pViewerObj.mTmpHref = "";
	    pViewerObj.mTmpTarget = "";
	    pViewerObj.mTmpImage = new Image();
	    pViewerObj.mTmpImage.onload = function() {
		    pViewerObj.ShowImage(pViewerObj.mTmpImage, pViewerObj.mTmpHref, pViewerObj.mTmpTarget);
	    }

	    var interfaceHTML = ''
	    interfaceHTML += '<div class="wrappanellayer ivImageBgColor">'
	    interfaceHTML +=   '<div class="mainpanellayerimg"></div>'
	    interfaceHTML +=   '<div class="mainpanellayerimg"></div>'
	    interfaceHTML +=   '<div class="mainpanellayerload ivLoadingBgColor"></div>'
	    interfaceHTML +=   '<div class="mainpanellayerload ivLoadingImage"></div>'
	    interfaceHTML += '</div>'

	    pViewerObj.m_dvWrapPanel.empty().append( $(interfaceHTML) );
	    pViewerObj.m_dvMainPanel  = pViewerObj.m_dvWrapPanel.find('div.wrappanellayer').css(css_mainpanel);
	    pViewerObj.m_dvImgBgLayer = pViewerObj.m_dvMainPanel.find('div.mainpanellayerimg').eq(0).css(css_imageslayer);
	    pViewerObj.m_dvImgFgLayer = pViewerObj.m_dvMainPanel.find('div.mainpanellayerimg').eq(1).css(css_imageslayer);
	    pViewerObj.m_dvLoadLayers = pViewerObj.m_dvMainPanel.find('div.mainpanellayerload').eq(0).css(css_loadlayerbg).end()
																					       .eq(1).css(css_loadlayerfg).end().hide();

	    if( pViewerObj.m_bPopupMode )
	    {
			bgDivObj = $('<div class="ivDisableColor"></div>').css(css_bglayer);
		    pViewerObj.m_dvWrapPanel.prepend(bgDivObj); // background layer
		    pViewerObj.m_dvWrapPanel.css(css_wrapper_popup).width($(document).width()).height($(document).height());

		    // setup browser resize and scroll events
		    $(window).bind('resize scroll', function(e) {
			    pViewerObj.m_dvWrapPanel.width($(document).width()).height($(document).height());
			    ClassImageViewer.routines.calcPositions(pViewerObj, null);
		    });
	    }
	    else
	    {
		    pViewerObj.m_dvWrapPanel.css(css_wrapper).width(pViewerObj.m_nViewerW).height(pViewerObj.m_nViewerH);
	    }

	    // perform all necessary calculations
	    ClassImageViewer.routines.calcPositions(pViewerObj, null);

	    // clean up
	    $(window).bind( 'unload', function() {pViewerObj.m_dvWrapPanel.empty()} );
    }

    ClassImageViewer.prototype =
    {
	    ShowImage:function(pImageObj, sHref, sTarget)
	    {
		    var pViewerObj = this;
		    if( !(pViewerObj instanceof ClassImageViewer) )
			    return false;

	        // we use "if( !pImageObj.width )" because
	        // qaqot IE throws an error on "if( !(pImageObj instanceof Image) )"
	        if( !pImageObj.width )
	        {
			    // fade in "Loading..."
			    pViewerObj.m_dvLoadLayers.stop(true,true).fadeIn(0);

			    // if the image is already loaded Chrome will not call "Image.onload" second time
			    if( navigator.userAgent.toLowerCase().indexOf('chrome') > -1 )
			    {
				    // Image object '.src' actually does convert relative paths to absolute.
				    // Example: var a = new Image(); a.src = '/a/../b'; alert(a.src) will return full path
				    var sCurImageFullPath = pViewerObj.mTmpImage.src;
				    pViewerObj.mTmpImage.src = pImageObj;			
				    var sNewImageFullPath = pViewerObj.mTmpImage.src;

				    if( sNewImageFullPath == sCurImageFullPath )
				    {
					    pViewerObj.ShowImage(pViewerObj.mTmpImage, sHref, sTarget)
					    return;
				    }
			    }

			    pViewerObj.mTmpHref = sHref;
			    pViewerObj.mTmpTarget = sTarget;
			    pViewerObj.mTmpImage.src = pImageObj;
			    return;
	        }

		    // to prevent trigger "Image.onload" event if any previously queued images are still loading.
		    if( pImageObj != pViewerObj.mTmpImage )
		    {
			    pViewerObj.mTmpImage.src = "";
		    }

		    // fade out "Loading..."
		    pViewerObj.m_dvLoadLayers.stop(true,true).fadeOut(pViewerObj.m_nImageFadeDuration)

		    // perform all necessary calculations
		    ClassImageViewer.routines.calcPositions(pViewerObj, pImageObj);

		    var layerHTML = "";
		    layerHTML += '<table width="100%" height="100%" cellpadding="0" cellspacing="0">'
		    layerHTML +=   '<tr>';
		    layerHTML +=     '<td align="center" valign="middle">'
		    if( sHref && (sHref != "") ) {
			    layerHTML +=   '<a href="'+sHref+'" target="'+sTarget+'">';
			    layerHTML +=	'<img oncontextmenu="return false;"  onclick="$(\'#ex_popup_viewer\').imageviewer(\'hide\');return false;" src="'+pImageObj.src+'" style="border-width:0" width="'+pViewerObj.m_nViewerW+'" height="'+pViewerObj.m_nViewerH+'" />'
			    layerHTML +=   '</a>';
		    } else {
			    layerHTML +=   '<img oncontextmenu="return false;"  onclick="$(\'#ex_popup_viewer\').imageviewer(\'hide\');return false;" src="'+pImageObj.src+'" style="border-width:0" width="'+pViewerObj.m_nViewerW+'" height="'+pViewerObj.m_nViewerH+'" />'
		    }
		    layerHTML +=     '</td>';
		    layerHTML +=   '</tr>';
		    layerHTML += '</table>';

		    // finalizing all the animations
		    pViewerObj.m_dvImgFgLayer.stop(true,true);
		    pViewerObj.m_dvImgBgLayer.stop(true,true);

		    // start image showing proccess
		    pViewerObj.m_dvImgBgLayer.empty().append($(layerHTML)).css({opacity: 0}).show(); //background layer becomes foreground

		    var dvTmpLayer = pViewerObj.m_dvImgBgLayer;
		    pViewerObj.m_dvImgBgLayer = pViewerObj.m_dvImgFgLayer;
		    pViewerObj.m_dvImgFgLayer = dvTmpLayer;

		    pViewerObj.m_dvImgFgLayer.animate( {opacity:1}, pViewerObj.m_nImageFadeDuration, function() {pViewerObj.m_dvImgBgLayer.empty().hide()} );	// we use 'hide()' because of z-index (images with 'sHref' working meku mej)
            pViewerObj.m_dvImgBgLayer.animate( {opacity:0}, pViewerObj.m_nImageFadeDuration );
	    },

	    SetFloatingPanel:function(content, nHeight, isTopPanel)
	    {
		    var css_panel   = {position:'absolute', top:0, left:0, width:'100%', height:0, overflow:'hidden'};
		    var css_layerbg = {position:'absolute', top:0, left:0, width:'100%', height:'100%', opacity:0.5};
		    var css_layerfg = {position:'absolute', top:0, left:0, width:'100%', height:'100%'};

		    var pViewerObj = this;
		    if( !(pViewerObj instanceof ClassImageViewer) )
			    return false;

		    var interfaceHTML = ''
		    interfaceHTML += '<div>'
		    interfaceHTML +=   '<div class="floatingpanellayer ivFloatBgColor"></div>'
		    interfaceHTML +=   '<div class="floatingpanellayer">'+content+'</div>'
		    interfaceHTML += '</div>'

		    var dvPanel = $(interfaceHTML).css(css_panel).height(nHeight)
		    dvPanel.find('div.floatingpanellayer').eq(0).css(css_layerbg).end()
											      .eq(1).css(css_layerfg).end()

		    if( pViewerObj.m_FloatPanels[isTopPanel] )
		    {
			    pViewerObj.m_FloatPanels[isTopPanel].remove();
			    pViewerObj.m_FloatPanels[isTopPanel] = null;
		    }
		    pViewerObj.m_FloatPanels[isTopPanel] = dvPanel;

		    pViewerObj.m_dvMainPanel.append( pViewerObj.m_FloatPanels[isTopPanel] );
		    pViewerObj.ShowFloatingPanel(false, 0, isTopPanel);
	    },

	    ShowFloatingPanel:function(bVisible, nDuration, isTopPanel)
	    {
		    var pViewerObj = this;
		    if( !(pViewerObj instanceof ClassImageViewer) )
			    return false;

		    if( pViewerObj.m_FloatPanels[isTopPanel] )
		    {
			    var nFloatPanelTop = 0;

			    if( isTopPanel ) {
				    nFloatPanelTop = bVisible ? 0 : (-1)*pViewerObj.m_FloatPanels[isTopPanel].height()
			    } else {
				    nFloatPanelTop = bVisible ? (pViewerObj.m_dvMainPanel.height() - pViewerObj.m_FloatPanels[isTopPanel].height()) : pViewerObj.m_dvMainPanel.height()
			    }

			    pViewerObj.m_FloatPanels[isTopPanel].stop(true, false).animate( {top:nFloatPanelTop}, nDuration )
			    pViewerObj.m_FloatPanelsStat[isTopPanel] = bVisible;
		    }
	    },

	    SetSize:function(w, h)
	    {
		    var pViewerObj = this;
		    if( !(pViewerObj instanceof ClassImageViewer) )
			    return false;

		    if( !isNaN(w) && !isNaN(h) )
		    {
			    pViewerObj.m_nViewerW = Math.max( 0.5, parseInt(w) ); // minimal width is 100
			    pViewerObj.m_nViewerH = Math.max( 0.5, parseInt(h) ); // minimal height is 100
			    pViewerObj.m_bFixedSize = true;

			    ClassImageViewer.routines.calcPositions(pViewerObj, null);
		    }
	    },

	    SetFadeDuration:function(dur)
	    {
		    var pViewerObj = this;
		    if( !(pViewerObj instanceof ClassImageViewer) )
			    return false;

		    if( !isNaN(dur) && (parseInt(dur) >= 0) )
		    {
			    pViewerObj.m_nImageFadeDuration = parseInt(dur);
		    }
	    }
    }

    ClassImageViewer.routines =
    {
	    calcPositions:function(pViewerObj, pImageObj)
	    {
		    var bUpdateFloatingPanels = false;

		    // check whether the image already loaded. we don't use "pImageObj.complete" because this function called from "Image.onload" function and in IE it is not completed yet
		    if( !pViewerObj.m_bFixedSize && pImageObj && pImageObj.width && pImageObj.height )
		    {
			    pViewerObj.m_nViewerW = pImageObj.width;
			    pViewerObj.m_nViewerH = pImageObj.height;
		    }

		    if( pViewerObj.m_bPopupMode )
		    {
			    // set 'mainpanel' width, height, top and left if they were changed
			    var t = Math.round( ($(window).height() - pViewerObj.m_nViewerH) / 2 ) + $(window).scrollTop()  + 'px'
			    var l = Math.round( ($(window).width()  - pViewerObj.m_nViewerW) / 2 ) + $(window).scrollLeft() + 'px'

			    if( (pViewerObj.m_dvMainPanel.width()  != pViewerObj.m_nViewerW) ||
				    (pViewerObj.m_dvMainPanel.height() != pViewerObj.m_nViewerH) ||
				    (pViewerObj.m_dvMainPanel.css('top')  != t) ||
				    (pViewerObj.m_dvMainPanel.css('left') != l) )
			    {
				    pViewerObj.m_dvMainPanel.width(pViewerObj.m_nViewerW).height(pViewerObj.m_nViewerH);
				    pViewerObj.m_dvMainPanel.css({top:t, left:l});
				    bUpdateFloatingPanels = true;
			    }
		    }
		    else
		    {
			    // set 'wrapperdiv' width and height if they were changed
			    if( pViewerObj.m_dvWrapPanel.width()  != pViewerObj.m_nViewerW ||
				    pViewerObj.m_dvWrapPanel.height() != pViewerObj.m_nViewerH )
			    {
				    pViewerObj.m_dvWrapPanel.width(pViewerObj.m_nViewerW).height(pViewerObj.m_nViewerH)
				    bUpdateFloatingPanels = true;
			    }
		    }

		    // set floating panels new positions
		    if( bUpdateFloatingPanels )
		    {
			    if( pViewerObj.m_FloatPanels[true] )
				    pViewerObj.ShowFloatingPanel(pViewerObj.m_FloatPanelsStat[true], 0, true);
			    if( pViewerObj.m_FloatPanels[false] )
				    pViewerObj.ShowFloatingPanel(pViewerObj.m_FloatPanelsStat[false], 0, false);
		    }
	    }
    };
})(jQuery);
