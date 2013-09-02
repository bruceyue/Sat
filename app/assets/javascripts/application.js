// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery-2.0.3.min.js
//= require_tree .

$(document).ready(function() {
    initPage();
});

function initPage() {
    var height = $("#topbar").height();
    $("div.navbar").attr("data-offset-top", function(){
        return ""+height;
    });

    $(".gallery").fancybox({
        openEffect  : 'none',
        closeEffect : 'none',

        helpers : {
            title : {
                type : 'over'
            }
        }
    });

    $(".gallery2").fancybox({
        wrapCSS    : 'fancybox-custom',
        closeClick : true,

        closeEffect : 'elastic',

        helpers : {
            title : {
                type : 'inside'
            },
            overlay : {
                css : {
                    'background' : 'rgba(238,238,238,0.85)'
                }
            }
        }
    });

    $(".galeri").fancybox({
        wrapCSS    : 'fancybox-custom',
        closeClick : true,
        openEffect : 'none',
        closeEffect : 'elastic',

        helpers : {
            title : {
                type : 'inside'
            },
            overlay : {
                css : {
                    'background' : 'rgba(238,238,238,0.85)'
                }
            }
        }
    });


    //Slider
    $("#homeslider").carousel({
        interval: 5000
    });

    $("#workslider").carousel({
        interval: 4000
    });
}