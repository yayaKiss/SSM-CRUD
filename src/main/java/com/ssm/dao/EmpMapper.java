package com.ssm.dao;

import com.ssm.pojo.Emp;
import com.ssm.pojo.EmpExample;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

public interface EmpMapper {
    long countByExample(EmpExample example);

    int deleteByExample(EmpExample example);

    int deleteByPrimaryKey(Integer eid);

    int insert(Emp row);

    int insertSelective(Emp row);

    List<Emp> selectByExample(EmpExample example);

    Emp selectByPrimaryKey(Integer eid);

    List<Emp> selectByExampleWithDept(EmpExample example);

    Emp selectByPrimaryKeyWithDept(Integer eid);

    int updateByExampleSelective(@Param("row") Emp row, @Param("example") EmpExample example);

    int updateByExample(@Param("row") Emp row, @Param("example") EmpExample example);

    int updateByPrimaryKeySelective(Emp row);

    int updateByPrimaryKey(Emp row);
}