function cancelbtn(cancelid) {
    document.getElementById(cancelid).style.display="none";
}
function newissuebtn() {
    // document.getElementById("call").contentWindow.location.reload();
    document.getElementById("newissue").style.display="block";
}
function lookbtn(objdiv,userid,role) {
    //議題名稱
    document.getElementById("issue1").innerHTML = $(objdiv).parent().children('div:nth-child(1)').children('h3:nth-child(2)').text();
    //議題內容
    document.getElementById("issue2").innerHTML = "&nbsp;&nbsp;議題說明："+$(objdiv).parent().children('div:nth-child(2)').text();
    //創建人
    document.getElementById("issue3").innerHTML = "&nbsp;&nbsp;"+$(objdiv).parent().children('div:nth-child(3)').children('div:nth-child(4)').text();
    //創建時間
    document.getElementById("issue4").innerHTML = "&nbsp;&nbsp;"+$(objdiv).parent().children('div:nth-child(3)').children('div:nth-child(5)').text();
    //議題id
    document.getElementById("issue0").value = $(objdiv).parent().children('div:nth-child(3)').children('p:nth-child(1)').text();
    //議題狀態
    document.getElementById("oristate").value = $(objdiv).parent().children('div:nth-child(3)').children('p:nth-child(2)').text();
    if($(objdiv).parent().children('div:nth-child(3)').children('p:nth-child(2)').text()=="TO DO"){

        //不要顯示textarea 顯示狀態選擇DOING DONE 沒有議題完成提示
        document.getElementById("onlydone").style.display = "none";
        var NewArray = new Array();
        var NewArray = $(objdiv).parent().children('div:nth-child(3)').children('div:nth-child(4)').text().split(":");
        if(NewArray[1] == userid || role=="Project Manager") {
            document.getElementById("inlineFormCustomSelect").innerHTML = "<option value=\"DOING\">DOING</option><option value=\"DONE\">DONE</option>";
            document.getElementById("texta").innerHTML = "";
            document.getElementById("subissue").style.display = "block";
        }
        else {
            document.getElementById("inlineFormCustomSelect").innerHTML="";
            document.getElementById("texta").innerHTML="";
            document.getElementById("subissue").style.display="none";
        }
    }
    else if($(objdiv).parent().children('div:nth-child(3)').children('p:nth-child(2)').text()=="DOING"){
        //顯示議題回復textarea 顯示狀態選擇DONE 沒有議題完成提示
        var NewArray = new Array();
        var NewArray = $(objdiv).parent().children('div:nth-child(3)').children('div:nth-child(4)').text().split(":");
        if(NewArray[1] == userid || role=="Project Manager"){
            document.getElementById("onlydone").style.display="none";
            document.getElementById("inlineFormCustomSelect").innerHTML="<option value=\"DOING\">DOING</option><option value=\"DONE\">DONE</option>";
            document.getElementById("texta").innerHTML="&nbsp;&nbsp;回覆議題內容：<br><textarea id=\"replyid\"name=\"content\" style=\"resize:none;width:450px;height:100px;\"></textarea>";
            document.getElementById("replyid").value = $(objdiv).parent().children('div:nth-child(3)').children('p:nth-child(3)').text();
            document.getElementById("subissue").style.display="block";
        }
        else {
            document.getElementById("inlineFormCustomSelect").innerHTML="";
            document.getElementById("texta").innerHTML="";
            document.getElementById("subissue").style.display="none";
            document.getElementById("onlydone").style.display="block";
            document.getElementById("issuereply").innerHTML="&nbsp;&nbsp;回覆內容";
            document.getElementById("doneresult").value= $(objdiv).parent().children('div:nth-child(3)').children('p:nth-child(3)').text();
        }


    }
    else if($(objdiv).parent().children('div:nth-child(3)').children('p:nth-child(2)').text()=="DONE"){
        //不要顯示textarea 不顯示狀態選擇 提示已完成
        document.getElementById("inlineFormCustomSelect").innerHTML="";
        document.getElementById("texta").innerHTML="";
        document.getElementById("subissue").style.display="none";
        document.getElementById("onlydone").style.display="block";
        document.getElementById("issuereply").innerHTML="&nbsp;&nbsp;回覆內容";
        document.getElementById("doneresult").value= $(objdiv).parent().children('div:nth-child(3)').children('p:nth-child(3)').text();
    }
    else{
    }
    document.getElementById("issueall").style.display="block";
}
function newmember(ID){
    document.getElementById(ID).submit();
}
function isbtn(objdiv) {
    //議題id
    document.getElementById("issue9").value = $(objdiv).parent().parent().children('div:nth-child(3)').children('p:nth-child(1)').text();
    document.getElementById("exampleModal").style.display="block";
}
function cancel() {
    document.getElementById("exampleModal").style.display="none";
}
