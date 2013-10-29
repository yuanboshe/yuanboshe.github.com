//浮动函数
$.fn.smartFloat = function () {
    var position = function (element) {
        var top = element.position().top, pos = element.css("position");
        $(window).scroll(function () {
            var scrolls = $(this).scrollTop();
            if (scrolls > top) {
                if (window.XMLHttpRequest) {
                    element.css({
                        position: "fixed",
                        top: 0
                    });
                } else {
                    element.css({
                        top: scrolls
                    });
                }
            } else {
                element.css({
                    position: "absolute",
                    top: top
                });
            }
        });
    };
    return $(this).each(function () {
        position($(this));
    });
};

// Jquery with no conflict
jQuery(document).ready(function ($) {

    //##########################################
    // My Code
    //##########################################
    $("nav").smartFloat(); // 绑定导航栏浮动
    $("div.tip p.admonition-title").prepend("<i class='icon-info-sign icon-large' /> ");
    $("div.note p.admonition-title").prepend("<i class='icon-exclamation-sign icon-large' /> ");
    $("div.warning p.admonition-title").prepend("<i class='icon-warning-sign icon-large' /> ");

    //##########################################
    // Superfish
    //##########################################

    $("ul.sf-menu").superfish({
        animation: {height: 'show'},   // slide-down effect without fade-in
        delay: 200,              // 1.2 second delay on mouseout
        autoArrows: false,
        speed: 200
    });

    //##########################################
    // HOME SLIDER
    //##########################################

    $('.home-slider').flexslider({
        animation: "fade",
        controlNav: false,
        keyboardNav: true
    });

    //##########################################
    // PROJECT SLIDER
    //##########################################

    $('.project-slider').flexslider({
        animation: "fade",
        controlNav: true,
        directionNav: false,
        keyboardNav: true
    });

    //##########################################
    // Top Widget
    //##########################################

    var topContainer = $("#top-widget");
    var topTrigger = $("#top-open");

    topTrigger.click(function () {
        topContainer.animate({
            height: 'toggle'
        });

        if (topTrigger.hasClass('tab-closed')) {
            topTrigger.removeClass('tab-closed');
        } else {
            topTrigger.addClass('tab-closed');
        }

        return false;

    });

    //##########################################
    // PrettyPhoto
    //##########################################

    $('a[data-rel]').each(function () {
        $(this).attr('rel', $(this).data('rel'));
    });

    $("a[rel^='prettyPhoto']").prettyPhoto();


    //##########################################
    // Create Combo Navi
    //##########################################

    // Create the dropdown base
    $("<select id='comboNav' />").appendTo("#combo-holder");

    // Create default option "Go to..."
    $("<option />", {
        "selected": "selected",
        "value": "",
        "text": "Navigation"
    }).appendTo("#combo-holder select");

    // Populate dropdown with menu items
    $("#nav a").each(function () {
        var el = $(this);
        var label = $(this).parent().parent().attr('id');
        var sub = (label == 'nav') ? '' : '- ';

        $("<option />", {
            "value": el.attr("href"),
            "text": sub + el.text()
        }).appendTo("#combo-holder select");
    });

    //##########################################
    // Combo Navigation action
    //##########################################

    $("#comboNav").change(function () {
        location = this.options[this.selectedIndex].value;
    });

//close			
});
