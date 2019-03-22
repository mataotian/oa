import com.qf.oa.entity.SysOrg;
import com.qf.oa.service.IBaseService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring/applicationContext-*.xml")
public class SysOrgTest {
    @Autowired
    private IBaseService<SysOrg> service;
    @Test
    public void getOrg(){
        SysOrg sysOrg= service.selectByPrimaryKey(1L);
        System.out.println(sysOrg);
    }
}
