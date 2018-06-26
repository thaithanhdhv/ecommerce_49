(function($) {
  'use strict';
  var Shop = window.Shop || {};
  window.Shop = Shop;

  Shop.header = {
    init: function() {
      this.header_scoll();
      this.input_quantity();
      this.ranger_price();
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
    ranger_price: function() {
      $( '#the_slider' ).slider({
        range: true,
        min: 0,
        max: 50,
        values: [0, 50],
        slide: function( event, ui ) {
          $( '#amount' ).val( '$' + ui.values[0] + ' - $' + ui.values[1] );
          $('#price_min_value').val(ui.values[0]);
          $('#price_max_value').val(ui.values[1]);
        }
      });
      $('#amount').val('$' + $('#the_slider').slider('values', 0) +
        ' - $' + $('#the_slider').slider('values', 1));

      $('#price_min_value').val($('#the_slider').slider('values')[0]);
      $('#price_max_value').val($('#the_slider').slider('values')[1]);
    }
  };
  $(document).ready(function() {
    Shop.header.init();
  });
})
(jQuery);
