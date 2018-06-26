$('.quantity').focusout(function () {
  self = $(this);
  $.ajax({
    url: '/update_hard_cart',
    method: 'put',
    data: {
      id_product: self.data('product'),
      quantity: self.val()
    }
  });
});
