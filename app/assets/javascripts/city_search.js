$( document ).ready(function() {
    $('[id=area_checkbox]').click(function(){
      var checked = false;
      $('[id=area_checkbox]').each(function(a, b) {
        if (($(b).is(':checked'))&&($('[id=area_checkbox]:checked').length < 3)) {
          checked = checked | true;
        } else {
          checked = checked | false;
        }
      });
      if (checked == true){
        $("#btn_area_submit").attr("disabled", false);
      } else{
        $("#btn_area_submit").attr("disabled", true);
      }	
    });
});
