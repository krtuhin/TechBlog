function doLike(pId,uId){
    console.log(pId +","+ uId);
    
    const d = {
        uid: uId,
        pid: pId,
        operation: "like",
    }
    
    $.ajax({
        url: "LikeServlet",
        data: d,
        success: function (data, textStatus, jqXHR) {
            console.log(data);
            if(data.trim()=="true"){
                let c = $(".like-count").html();
                c++;
                $(".like-count").html(c);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(data);
        },
    });
}