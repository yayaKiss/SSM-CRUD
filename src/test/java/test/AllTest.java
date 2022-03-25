package test;
import com.ssm.dao.EmpMapper;
import com.ssm.pojo.Emp;
import org.apache.ibatis.session.SqlSession;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import java.util.UUID;


@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class AllTest {

    @Autowired
    EmpMapper empMapper;

    @Autowired
    SqlSession sqlSession;

    public void test1(){
//        Emp emp = empMapper.selectByPrimaryKeyWithDept(1);
//        System.out.println(emp);
        EmpMapper mapper = sqlSession.getMapper(EmpMapper.class);
        for(int i=0;i<100;i++){
            String uuidName = UUID.randomUUID().toString().substring(0,5);
            mapper.insertSelective(new Emp(null,uuidName,23,"男","123@qq.com",2,null));
        }
    }



}
