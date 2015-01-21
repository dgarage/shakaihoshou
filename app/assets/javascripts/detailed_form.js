$( document ).ready(function() {
    
    $('.scene_checkbox').click(function(){
      var checked = false;
      $('.scene_checkbox').each(function(a, b) {
        if ($(b).is(':checked')) {
          checked = checked | true;
        } else {
          checked = checked | false;
        }
      });
      if (checked == true){
        $("#btn_detailed_submit").attr("disabled", false);
      } else{
        $("#btn_detailed_submit").attr("disabled", true);
      }	
    });
    
});
