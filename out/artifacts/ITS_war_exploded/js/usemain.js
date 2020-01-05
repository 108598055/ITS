//側欄位tree_view button
function show(showID) {
    top.document.getElementById(showID).style.display='block';
}
//新增div button
function hide(showID) {
    document.getElementById(showID).style.display='none';
}

function new_pj_confirm(){

    document.getElementById("call").contentWindow.location.reload();
    document.getElementById("form1").submit();
    // document.getElementById('popId').style.display='none';
}
function password_confirm(){

    document.getElementById("call").contentWindow.location.reload();
    document.getElementById("form2").submit();
    // document.getElementById('popId').style.display='none';
}
function alertpjname(obja) {
    var node_id = $(obja).closest("li").attr("data-nodeid");
    // closest("li").attr('data-node-id');

    if((node_id % 4)==2){
        node_id = node_id-1;
    }
    else if((node_id % 4)==3){
        node_id = node_id-2;
    }
    else if((node_id % 4)==0){
        node_id = node_id-3;
    }
    var pjname = $("li[data-nodeid="+node_id+"]").children("a").text();
    var temp = document.createElement("form");
    temp.action = '/pjnameget';//提交的地址
    temp.method = "post";//也可指定为get
    temp.style.display = "none";
    var opt = document.createElement("textarea");
    opt.name = "key";
    opt.value = pjname;
    temp.appendChild(opt);
    document.body.appendChild(temp);
    temp.submit();
}
