(function($) {
  'use strict';
  var Shop = window.Shop || {};
  window.Shop = Shop;

  Shop.header = {
    init: function() {
      this.header_scoll();
      this.input_quantity();
    },
    header_scoll: function() {
      var didScroll;
      var lastScrollTop = 0;
      var delta = 5;
      var navbarHeight = $('header').outerHeight();

      $(window).scroll(function(event) {
        didScroll = true;
      });

      setInterval(function() {
        if (didScroll) {
          hasScrolled();
          didScroll = false;
        }
      }, 250);

      function hasScrolled() {
        var st = $(window).scrollTop();

        // Make scroll more than delta
        if (Math.abs(lastScrollTop - st) <= delta)
          return;

        // If scrolled down and past the navbar, add class .nav-up.
        if (st > lastScrollTop && st > navbarHeight) {
          // Scroll Down
          $('header').removeClass('nav-down').addClass('nav-up');
        } else {
          // Scroll Up
          if (st + $(window).height() < $(document).height()) {
            $('header').removeClass('nav-up').addClass('nav-down');
          }
        }
        if (st <= 80) {
          $('header').removeClass('nav-down');
        }
        lastScrollTop = st;
      }
    },
    input_quantity: function() {
      $('.btn-number').on('click', function() {

        var $button = $(this);
        var oldValue = $button.parent().find('input').val();

        if ($button.hasClass('fa-plus')) {
          var newVal = parseFloat(oldValue) + 1;
        } else {
          if (oldValue > 0) {
            var newVal = parseFloat(oldValue) - 1;
          } else {
            newVal = 0;
          }
        }

        $button.parent().find('input').val(newVal);
      });
    },
    admin_menu: function() {
      $('.sub-menu').click(function() {
        $(this).toggleClass('submenu-open').parent('li').siblings('li').children('h4.submenu-open').removeClass('submenu-open');
        $(this).parent().toggleClass('submenu-open').children('ul').slideToggle(500).end().siblings('.submenu-open').removeClass('submenu-open').children('ul').slideUp(500);
        $('html, body').animate({
          scrollTop: (0),
        }, "fast"); /*this will scroll upto the top, not sure if I want to use this yet */
      });
    }
  };
  $(document).ready(function() {
    Shop.header.init();
  });
})
(jQuery);
