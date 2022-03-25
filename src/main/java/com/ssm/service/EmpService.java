package com.ssm.service;

import com.ssm.dao.EmpMapper;
import com.ssm.pojo.Emp;

import com.ssm.pojo.EmpExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.ArrayList;
import java.util.List;

@Service
public class EmpService {
    @Autowired
    EmpMapper empMapper;

    public List<Emp> getAll() {
        List<Emp> emps = empMapper.selectByExampleWithDept(null);
        return emps;
    }

    public void save(Emp emp) {
        empMapper.insertSelective(emp);
    }

    public boolean checkEmail(String email) {
        EmpExample example = new EmpExample();
        EmpExample.Criteria criteria = example.createCriteria();
        criteria.andEmailEqualTo(email);
        long count = empMapper.countByExample(example);
        return count == 0;
    }

    public Emp getEmp(Integer id) {
        Emp emp = empMapper.selectByPrimaryKeyWithDept(id);
        return emp;
    }

    public void updateEmp(Emp emp) {
        empMapper.updateByPrimaryKeySelective(emp);
    }

    public void deleteEmp(Integer id) {
        empMapper.deleteByPrimaryKey(id);
    }

    public void deleteEmps(List<Integer> list) {
        EmpExample example = new EmpExample();
        EmpExample.Criteria criteria = example.createCriteria();
        criteria.andEidIn(list);
        empMapper.deleteByExample(example);
    }
}
