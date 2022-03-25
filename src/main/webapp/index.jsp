<%@ page isELIgnored="false" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!-- web路径：
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306)；需要加上项目名
            http://localhost:3306/crud
     -->
    <script type="text/javascript"
            src="${APP_PATH }/static/js/jquery-3.6.0.js"></script>
    <link
            href="${APP_PATH }/static/bootstrap-3.4.1-dist/css/bootstrap.min.css"
            rel="stylesheet">
    <script
            src="${APP_PATH }/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>

</head>
<body>
    <!-- 搭建显示页面 -->
    <div class="container">
        <!-- 标题 -->
        <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>
        <!-- 按钮 -->
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary" id="add_emp_model">新增</button>
                <button class="btn btn-danger" id="delete_emp_model">删除</button>
            </div>
        </div>
        <!-- 显示表格数据 -->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="emps_table">
                    <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id="check_all"/>
                            </th>
                            <th>ID</th>
                            <th>EmpName</th>
                            <th>Age</th>
                            <th>Gender</th>
                            <th>Email</th>
                            <th>DeptName</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>

                </table>
            </div>
        </div>
        <%--    显示分页--%>
        <div class="row" >
            <div class="col-md-6" id="page_info">

            </div>
            <div class="col-md-6" id="page_nav">

            </div>
        </div>

<%--        添加员工模态框--%>
        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label for="add_empName" class="col-sm-2 control-label">EmpName</label>
                                <div class="col-sm-10">
                                    <input type="text" name="empName" class="form-control" id="add_empName" placeholder="EmpName">
                                    <span class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="add_email" class="col-sm-2 control-label">Email</label>
                                <div class="col-sm-10">
                                    <input type="text" name="email" class="form-control" id="add_email" placeholder="Email">
                                    <span class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="add_age" class="col-sm-2 control-label">Age</label>
                                <div class="col-sm-10">
                                    <input type="text" name="age" class="form-control" id="add_age" placeholder="age">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Gender</label>
                                    <label class="radio-inline">
                                        <input type="radio" name="sex" id="add_gender1" value="男"> 男
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="sex" id="add_gender2" value="女"> 女
                                    </label>
                            </div>
                            <div class="form-group">
                                <label for="add_dept" class="col-sm-2 control-label">Dept</label>
                                <div class="col-sm-5">
                                    <select class="form-control" name="did" id="add_dept">
                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="save_emp">保存</button>
                    </div>
                </div>
            </div>
        </div>


        <%--        编辑员工模态框--%>
        <!-- Modal -->
        <div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="updateModalLabel">Modal title</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label for="add_empName" class="col-sm-2 control-label">EmpName</label>
                                <div class="col-sm-10">
                                    <p class="form-control-static" id="empName_update_static"></p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="add_email" class="col-sm-2 control-label">Email</label>
                                <div class="col-sm-10">
                                    <input type="text" name="email" class="form-control" id="update_email" placeholder="Email">
                                    <span class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="add_age" class="col-sm-2 control-label">Age</label>
                                <div class="col-sm-10">
                                    <input type="text" name="age" class="form-control" id="update_age" placeholder="age">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Gender</label>
                                <label class="radio-inline">
                                    <input type="radio" name="sex" id="update_gender1" value="男"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="sex" id="update_gender2" value="女"> 女
                                </label>
                            </div>
                            <div class="form-group">
                                <label for="add_dept" class="col-sm-2 control-label">Dept</label>
                                <div class="col-sm-5">
                                    <select class="form-control" name="did" id="update_dept">
                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="update_emp_btn">更新</button>
                    </div>
                </div>
            </div>
        </div>

    <script type="text/javascript" >
<%--    页面加载完成之后发送ajax请求，要到分页数据    --%>
        var totalRecord,curPageNum;
        $(function (){
            toPage(1);
        });
        function toPage(pageNum){
            $.ajax({
                url : "${APP_PATH }/emps",
                data:"pageNum="+pageNum,
                type:"post",
                success:function (data){
                    build_emps_table(data);
                    build_page_info(data);
                    build_page_nav(data);
                }
            });
        }
        //解析显示列表
        function build_emps_table(data) {
            //我们是进行追加的，每次去不同的页面，先进行清空
            $("#emps_table tbody").empty();

            var emps = data.extend.pageInfo.list;
            $.each(emps,function (index,emp){
                var checkbox = $("<td><input type='checkbox' class='check_item'/></td>")
                var eid = $("<td></td>").append(emp.eid);
                var empName = $("<td></td>").append(emp.empName);
                var sex = $("<td></td>").append(emp.sex);
                var age = $("<td></td>").append(emp.age);
                var email = $("<td></td>").append(emp.email);
                var deptName = $("<td></td>").append(emp.dept.deptName);
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
                    .append("<span></span>").addClass("glyphicon glyphicon-pencil edit_emp").append("编辑")
                editBtn.attr("editId",emp.eid);
                var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_emp")
                    .append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除")
                var btn = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                $("<tr></tr>").append(checkbox).append(eid).append(empName).append(age).append(sex).append(email).append(deptName).append(btn)
                .appendTo("#emps_table tbody");
            });

        }
        //解析显示左侧分页信息
        function build_page_info(data){
            $("#page_info").empty();
            $("#page_info")
                .append("当前第"+data.extend.pageInfo.pageNum +"页，共计"+data.extend.pageInfo.pages +"页，总共"+data.extend.pageInfo.total+"条记录");
            totalRecord = data.extend.pageInfo.pages;
            curPageNum = data.extend.pageInfo.pageNum;
        }

        //解析显示分页条
        function build_page_nav(data) {
            $("#page_nav").empty();
            var ul = $("<ul></ul>").addClass("pagination");

            var firstNum = $("<li></li>").append($("<a></a>").append("首页"));
            var prePage = $("<li></li>").append($("<a></a>").append("&laquo;"));
            if(data.extend.pageInfo.hasPreviousPage == false){
                firstNum.addClass("disabled");
                prePage.addClass("disabled");
            }else{
                firstNum.click(function (){
                    toPage(1);
                });
                prePage.click(function (){
                    toPage(data.extend.pageInfo.pageNum - 1)
                });
            }

            var nextPage = $("<li></li>").append($("<a></a>").append("&raquo;"));
            var lastNum = $("<li></li>").append($("<a></a>").append("末页"));
            if(data.extend.pageInfo.hasNextPage == false){
                nextPage.addClass("disabled");
                lastNum.addClass("disabled");
            }else{
                nextPage.click(function (){
                    toPage(data.extend.pageInfo.pageNum + 1)
                });
                lastNum.click(function (){
                    toPage(data.extend.pageInfo.pages)
                });
            }

            ul.append(firstNum).append(prePage);
            $.each(data.extend.pageInfo.navigatepageNums,function (index,num){
                var numLi = $("<li></li>").append($("<a></a>").append(num))
                if(data.extend.pageInfo.pageNum == num){
                    numLi.addClass("active")
                }
                ul.append(numLi);
                numLi.click(function (){
                    toPage(num);
                })
            })
            ul.append(nextPage).append(lastNum);

            var navEle = $("<nav></nav>").append(ul);
            $("#page_nav").append(navEle);
        }

        function reset_form(ele){
            $(ele)[0].reset();
            //清空表单样式
            $(ele).find("*").removeClass("has-error has-success");
            $(ele).find(".help-block").text("");
        }
        //点击新增弹出模态框
        $("#add_emp_model").click(function (){
            //清除表单数据
            reset_form("#myModal form");
            //查询所有部门信息显示在下拉列表中
            getDepts("#myModal select");
            //弹出模态框
            $("#myModal").modal()
        });
        function getDepts(ele){
            $(ele).empty();
            $.ajax({
                url: "${APP_PATH }/depts",
                type: "post",
                success:function (data){
                    $.each(data.extend.depts, function (){
                        $(ele).append($("<option></option>").append(this.deptName).attr("value",this.did));
                    })
                }
            });
        }

        //校验邮箱是否可用
        $("#add_email").change(function (){
            //发送ajax请求校验验证码是否可用
            var emailText = this.value;
            $.ajax({
               url: "${APP_PATH }/checkEmail",
                type:"post",
                data:"email="+emailText,
                success:function (data){
                    if(data.code == 200){
                        show_validate_msg("#add_email","error","邮箱已存在")
                        $("#save_emp").attr("existsEmail","success");
                    }else{
                        show_validate_msg("#add_email","success","邮箱可用")
                    }
                }
            });

        });

        function validate_add_emp(){
            //验证用户名是否合法
            var empNameText = $("#add_empName").val();
            var empNameObj = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
            if(!empNameObj.test(empNameText)){
                show_validate_msg("#add_empName","error","2-5位中文或6-16位字母数字组合")
                return false;
            }else{
                show_validate_msg("#add_empName","success","");
            }

            //验证邮箱是否合法
            var emailText = $("#add_email").val();
            var emailObj = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
            if(!emailObj.test(emailText)){
                show_validate_msg("#add_email","error","邮箱格式不正确")
                return false;
            }else{
                show_validate_msg("#add_email","success","")
            }

            return true;
        }

        function show_validate_msg(ele,status,msg){
            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("");
            if("success" == status){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg);
            }else if("error" == status){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg);
            }
        }

        //点击保存
        $("#save_emp").click(function (){
            // alert($("#myModal form").serialize());
            // 1.先对数据进行校验
            if(!validate_add_emp()){
                return false;
            }
            // 2.对邮箱判断是否存在
            if($(this).attr("existsEmail")== "success"){
                return false;
            }
            //3.发送ajax请求保存数据
            $.ajax({
               url:"${APP_PATH }/emp",
               type:"POST",
                data: $("#myModal form").serialize(),
                success:function (data){
                   // alert(data.msg);
                    //后端校验
                    if(data.code == 100){
                        //关闭模态框
                        $("#myModal").modal('hide');
                        //跳转最后一页
                        toPage(totalRecord + 1);
                    }else{
                        //有哪个字段的错误信息就显示哪个字段的；
                        if(undefined != data.extend.errorFields.email){
                            //显示邮箱错误信息
                            show_validate_msg("#add_email", "error", data.extend.errorFields.email);
                        }
                        if(undefined != data.extend.errorFields.empName){
                            //显示员工名字的错误信息
                            show_validate_msg("#add_empName", "error", data.extend.errorFields.empName);
                        }
                    }

                }
            });
        });

        //给编辑按钮绑上事件
    $(document).on("click",".edit_emp",function (){
        $("#updateModal").modal();
        //获取部门信息，显示在下拉列表
        getDepts("#updateModal select");
        //发送ajax请求获取员工信息，显示在modal中
        getEmp($(this).attr("editId"));
        //把员工id传递到更新上
        $("#update_emp_btn").attr("editId",$(this).attr("editId"))


    });
    function getEmp(id){
        $.ajax({
            url:"${APP_PATH }/emp/"+id,
            type:"get",
            data:id,
            success:function (data){
                // console.log(data)
                var empData = data.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#update_email").val(empData.email);
                $("#update_age").val(empData.age)
                $("#updateModal input[name=sex]").val([empData.sex]);
                $("#updateModal select").val([empData.did]);
            }
        })
    }

    //给更新按钮绑定单击事件
    $("#update_emp_btn").click(function (){
        // 1.验证邮箱格式是否正确
        var emailText = $("#update_email").val();
        var emailObj = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
        if(!emailObj.test(emailText)){
            show_validate_msg("#update_email","error","邮箱格式不正确")
            return false;
        }else{
            show_validate_msg("#update_email","success","")
        }
        $.ajax({
            url:"${APP_PATH }/emp/"+$(this).attr("editId"),
            type:"post",
            data:$("#updateModal form").serialize()+"&_method=PUT",
            success:function (data){
                $("#updateModal").modal('hide');
                toPage(curPageNum);
            }
        });

    });

    //给删除绑上单击事件
    $(document).on("click",".delete_emp",function () {
        var deleteId = $(this).parents("tr").find("td:eq(1)").text();
        var deleteName = $(this).parents("tr").find("td:eq(2)").text();
        // alert(deleteId)
        if(confirm("您确定要删除【"+deleteName+"】吗")){
            $.ajax({
                url:"${APP_PATH }/emp/"+deleteId,
                type:"delete",
                success:function (data){
                    toPage(curPageNum);
                }
            })
        }
    });

    //完成全选/全不选功能
    $("#check_all").click(function(){
        //attr获取checked是undefined;
        //我们这些dom原生的属性；attr获取自定义属性的值；
        //prop修改和读取dom原生属性的值
        $(".check_item").prop("checked",$(this).prop("checked"));
    });
    //check_item
    $(document).on("click",".check_item",function(){
        //判断当前选择中的元素是否5个
        var flag = $(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });

    //给批量删除绑上单击事件
    $("#delete_emp_model").click(function (){
        var empName = "";
        var del_idstr = "";

        $.each($(".check_item:checked"),function(){
            //this
            empName += $(this).parents("tr").find("td:eq(2)").text()+",";
            //组装员工id字符串
            del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        empName = empName.substring(0,empName.length-1);
        del_idstr = del_idstr.substring(0,del_idstr.length-1);

        if(confirm("你确定要删除【"+empName+"】吗")){
            $.ajax({
                url:"${APP_PATH }/emp/"+del_idstr,
                type:"delete",
                success:function (data){
                    toPage(curPageNum);
                }
            })
        }
    });
    </script>
</body>
</html>