$( document ).ready(function() {
    $('[id=area_checkbox]').click(function(){
      var checked = false;
      $('[id=area_checkbox]').each(function(a, b) {
        if (($(b).is(':checked'))&&($('[id=area_checkbox]:checked').length == 2)) {
          checked = checked | true;
        } else {
          checked = checked | false;
        }
      });
      if (checked == true){
        $("#btn_area_submit").attr("disabled", false);
        $("#btn_area_submit").prop("value", "検索");
      } else{
        $("#btn_area_submit").attr("disabled", true);
        $("#btn_area_submit").prop("value", "2つ選択して下さい");
      }	
    });
});
