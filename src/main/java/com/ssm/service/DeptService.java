package com.ssm.service;

import com.ssm.dao.DeptMapper;
import com.ssm.pojo.Dept;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeptService {

    @Autowired
    DeptMapper deptMapper;

    public List<Dept> getAllDept(){
        List<Dept> depts = deptMapper.selectByExample(null);
        return depts;
    }
}
