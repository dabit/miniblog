$(function() {
  $(".alert-success").fadeTo(2000, 500).slideUp(500, function(){
      $(".alert-success").alert('close');
  });
});
