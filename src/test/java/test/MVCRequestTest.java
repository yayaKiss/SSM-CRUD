package test;

import com.github.pagehelper.PageInfo;
import com.ssm.pojo.Emp;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.Arrays;
import java.util.List;


@ContextConfiguration(locations = {"classpath:applicationContext.xml", "file:src/main/webapp/WEB-INF/SpringMVC.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
public class MVCRequestTest {
    //创建虚拟mockMvc
    MockMvc mockMvc;
    //传入SpringMVc的ioc
    @Autowired
    WebApplicationContext context;
    @Before
    public void initMockMVC(){
        mockMvc= MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟请求拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNum", "1")).andReturn();
        //得到请求对象，到请求域中拿数据
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo =(PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码："+pageInfo.getPageNum());
        System.out.println("总页码："+pageInfo.getPages());
        int[] navigatepageNums = pageInfo.getNavigatepageNums();
        List<Emp> list = pageInfo.getList();

        list.forEach(emp -> System.out.println(emp));
    }
}
