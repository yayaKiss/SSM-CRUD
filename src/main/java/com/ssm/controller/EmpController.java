package com.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.pojo.Emp;
import com.ssm.pojo.Msg;
import com.ssm.service.EmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmpController {

    @Autowired
    EmpService empService;

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pageNum",defaultValue = "1") Integer pageNum){
        PageHelper.startPage(pageNum,5);
        List<Emp> empList = empService.getAll();
        PageInfo<Emp> pageInfo = new PageInfo<>(empList,5);

        return Msg.success().add("pageInfo",pageInfo);
    }

    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Emp emp, BindingResult result){
        if(result.hasErrors()){
            Map<String,Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for(FieldError fieldError : errors){
                System.out.println("错误的字段："+fieldError.getField());
                System.out.println("错误信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else{
            empService.save(emp);
            return Msg.success();
        }
    }

    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable Integer id){
        Emp emp = empService.getEmp(id);
        return Msg.success().add("emp",emp);
    }

//    @RequestMapping("/emps")
    public String getAllEmp(@RequestParam(value = "pageNum",defaultValue = "1") Integer pageNum, Model model){
        PageHelper.startPage(pageNum,5);
        List<Emp> empList = empService.getAll();
        PageInfo<Emp> pageInfo = new PageInfo<>(empList,5);
        model.addAttribute("pageInfo",pageInfo);
        return "empList";
    }

    @RequestMapping("/checkEmail")
    @ResponseBody
    public Msg checkEmail(@RequestParam("email") String email){
        boolean b = empService.checkEmail(email);
        if(b){
            return Msg.success();
        }else{
            return Msg.fail();
        }
    }

    @RequestMapping(value = "/emp/{eid}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Emp emp){
        System.out.println(emp);
        empService.updateEmp(emp);
        return Msg.success();
    }

    /**
     * 批量单个删除二和一
     * @param ids
     * @return
     */
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmp(@PathVariable String ids){
        if(ids.contains("-")){
            String[] str_id = ids.split("-");
            List<Integer> list = new ArrayList<>();
            for(String id : str_id){
                list.add(Integer.parseInt(id));
            }
            empService.deleteEmps(list);
        }else{
            empService.deleteEmp(Integer.parseInt(ids));
        }
        return Msg.success();
    }

}
