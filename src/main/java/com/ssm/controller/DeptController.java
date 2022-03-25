package com.ssm.controller;

import com.ssm.pojo.Dept;
import com.ssm.pojo.Msg;
import com.ssm.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DeptController {

    @Autowired
    DeptService deptService;
    /**
     * 返回所有部门信息
     * @return
     */
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getAllDept(){
        List<Dept> allDept = deptService.getAllDept();
        return Msg.success().add("depts",allDept);
    }
}
