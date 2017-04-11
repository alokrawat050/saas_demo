$(function() {
  var stripeResponseHandler, $cardForm;
//tok_ANhXTsvDKxpoEU
  $cardForm = $('#card-details');
  stripeResponseHandler = function(status, response) {
    if (response.error) {
      $cardForm.find('.payment-errors').text(response.error.message);
      $cardForm.find('input[type=submit]').prop('disabled', false);
    } else {
      var token = response.id;
      
      $cardForm.append($('<input type="hidden" name="stripe_token" />').val(token));
      $cardForm.get(0).submit();
    }
  };

  $cardForm.submit(function() {
    Stripe.card.createToken(this, stripeResponseHandler);

    return false;
  });
});

// var r = $("#card-details"),
//     t = $(".alert-danger", r),
//     i = $(".alert-success", r);
//     r.validate({
//         doNotHideMessage: !0,
//         errorElement: "span",
//         errorClass: "help-block help-block-error",
//         focusInvalid: !1,
//         rules: {
//             card_name: {
//                 required: !0
//             },
//             card_number: {
//                 minlength: 16,
//                 maxlength: 16,
//                 required: !0
//             },
//             card_cvc: {
//                 digits: !0,
//                 required: !0,
//                 minlength: 3,
//                 maxlength: 4
//             },
//             card_expiry_date: {
//                 required: !0
//             },
//             "payment[]": {
//                 required: !0,
//                 minlength: 1
//             }
//         },
//         messages: {
//             "payment[]": {
//                 required: "Please select at least one option",
//                 minlength: jQuery.validator.format("Please select at least one option")
//             }
//         },
//         errorPlacement: function(e, r) {
//             "gender" == r.attr("name") ? e.insertAfter("#form_gender_error") : "payment[]" == r.attr("name") ? e.insertAfter("#form_payment_error") : e.insertAfter(r)
//         },
//         invalidHandler: function(e, r) {
//             i.hide(), t.show(), App.scrollTo(t, -200)
//         },
//         highlight: function(e) {
//             $(e).closest(".form-group").removeClass("has-success").addClass("has-error")
//         },
//         unhighlight: function(e) {
//             $(e).closest(".form-group").removeClass("has-error")
//         },
//         success: function(e) {
//             "gender" == e.attr("for") || "payment[]" == e.attr("for") ? (e.closest(".form-group").removeClass("has-error").addClass("has-success"), e.remove()) : e.addClass("valid").closest(".form-group").removeClass("has-error").addClass("has-success")
//         },
//         submitHandler: function(e) {
//             i.show(), t.hide(), e[0].submit()
//         }
//     });