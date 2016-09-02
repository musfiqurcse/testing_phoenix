$(document).ready(function(){
  alert("ajax is loading");
  $("#addMore").on("click",function(e){
    e.preventDefault();
    mainContent=$(".itemList").html();
    console.log(mainContent)
    item=$(".itemList").children().last("permissionItem");
    dataIndex=item.data("index");
    dataIndex+=1;
    item.find("input.controllerItem").attr("name","session[permission]["+(dataIndex)+"][controllerName]")
    item.find("input.actionItem").attr("name","session[permission]["+(dataIndex)+"][actionName]")
    tag=item.find("input.permissionItem").attr("name","session[permission]["+(dataIndex)+"][permissions]").siblings("input").attr("name","session[permission]["+(dataIndex)+"][permissions]")
    //console.log(tag);
    item=item.html();
    $(".itemList")
      .html('')
        .html(mainContent+'<div class="permissionItem" data-index="'+dataIndex +'">'+item+'</div>')

    console.log(item.html())
  });
});
