
/*
* 校验用户输入的手机号码
* 号码格式错误，更改表单提示错误的样式
* */
function checkPhoneNum(num) {
    var re =  /^((0\d{2,3}-\d{7,8})|(1[3584]\d{9}))$/;
    if (!re.test(num)) {
        $('#phone_err').css('display','block');
        $('#phone_input').attr('class','weui-cell weui-cell_warn');
        return false;
    }
    return true;
}

/*
 * 校验用户输入的用户名
 * 格式错误，更改表单提示错误的样式
 * */
function checkName(name) {
    var re = /^[\u4E00-\u9FA5]{2,4}$/;
    if (!re.test(name)) {
        $('#name_err').css('display','block');
        $('#name_input').attr('class','weui-cell weui-cell_warn');
        return false;
    }
    return true;
}

/*
 * 用于表单校验错误后，重新输入内容时把表单错误样式去掉
 * */
function refreshNum(){
    $('#phone_input').attr('class','weui-cell');
    var obj = $('#num_ft');
    if(obj){
        obj.remove();
    }
}

/*
 * 用于表单校验错误后，重新输入内容时把表单错误样式去掉
 * */
function refreshName(){
    $('#name_input').attr('class','weui-cell');
    var obj = $('#name_ft');
    if(obj){
        obj.remove();
    }
}
