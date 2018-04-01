### 阿里巴巴分布式数据库同步系统(解决中美异地机房)

- [project otter @github](https://github.com/alibaba/otter)
- [sub-project canal @github](https://github.com/alibaba/canal)


### User Manual

> download releases, https://github.com/alibaba/otter/releases, recommend more stable version:4.2.14

- [How to install a otter manager?](https://github.com/alibaba/otter/wiki/Manager_Quickstart)
- [How to install a otter node?](https://github.com/alibaba/otter/wiki/Node_Quickstart)
- ["Hello World" example](https://github.com/alibaba/otter/wiki/QuickStart)
- [Manager Usage Intro](https://github.com/alibaba/otter/wiki/Manager%E4%BD%BF%E7%94%A8%E4%BB%8B%E7%BB%8D)
- [Manager Config Intro](https://github.com/alibaba/otter/wiki/Manager%E9%85%8D%E7%BD%AE%E4%BB%8B%E7%BB%8D)
- [what's more..](https://github.com/alibaba/otter/wiki)


### Prerequisite

1. enable `ROW` type binary log 
	```
	[mysqld]
	log-bin=mysql-bin #添加这一行就ok
	binlog-format=ROW #选择row模式
	server_id=1 #配置mysql replaction需要定义，不能和canal的slaveId重复
	```
2. enable a slave replication account (*canal的原理是模拟自己为mysql slave，所以这里一定需要做为mysql slave的相关权限*)
	``` sql
	CREATE USER canal IDENTIFIED BY 'canal';  
	GRANT SELECT, REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO 'canal'@'%';
	-- GRANT ALL PRIVILEGES ON *.* TO 'canal'@'%' ;
	FLUSH PRIVILEGES;
	```


### filter data sync (extend EventProcessor)

``` java
public class TestProcessor extends AbstractEventProcessor  {
    public boolean process(EventData eventData) {
        EventColumn testColumn = getColumn(eventData,"test_column");
        if("1".equals(testColumn.getColumnValue())){
            return true;
        }
        return false;
    }
}
```

``` java
import com.alibaba.otter.shared.etl.model.EventColumn;
import com.alibaba.otter.shared.etl.model.EventData;
import com.alibaba.otter.shared.etl.model.EventType;

public class TestProcessor extends AbstractEventProcessor  {
    public boolean process(EventData eventData) {
        EventColumn testColumn = getColumn(eventData,"id");
        //if("1".equals(testColumn.getColumnValue())){
        if(Integer.valueOf(testColumn.getColumnValue()) < 1000){
            return true;
        }
        return false;
    }
} 

```

### Q & A

1. PipeException: download_error
	```
	pid:1 nid:3 exception:setl:com.alibaba.otter.node.etl.common.pipe.exception.PipeException: download_error
	Caused by: com.alibaba.otter.node.etl.common.io.download.exception.DataRetrieveException: aborted for some configration error.
	```

> [install aria2c on node](https://github.com/alibaba/otter/issues/78), `whereis aria2c`

2. canal elapsed seconds no data 

> https://github.com/alibaba/otter/issues?utf8=%E2%9C%93&q=canal+elapsed+seconds+no+data

3. pid:1 nid:2 exception:canal:工商数据canal:java.nio.channels.ClosedByInterruptException (*use 4.2.14*, https://github.com/alibaba/otter/releases)

4. `开启canal 心跳线 ＆ HA 之后:` pid:1 nid:2 exception:canal:工商数据canal:no standby config, just do nothing, will continue try:10.100.24.25/10.100.24.25:3306

5. 点击node页面，打开出错，提示为Connection refused to host: 127.0.0.1; nested exception is: java.net.ConnectException: Connection refused
	```
	# https://github.com/alibaba/otter/issues/24
	
	补充一个奇葩的问题: 有些hostname为localhost, 就算修改了/etc/hosts, 还是会指向 127.0.0.1, 所以需要先修改hostname
	
	e.g. ReaHat:
	$hostnamectl set-hostname otter-node
	再修改/etc/hosts 新增:
	<ifconfig ip> <new hostname>
	```
6. **window.opener.xxx is not a function**, clear browser data

7. channel --> pipeline --> mapping delete have to be done from inside to outside (*必须按照：映射关系 < pipeline < channel 的顺序删除*)

8. reset canal binlog position (重置同步,使用新的位点开始同步)
> https://github.com/alibaba/otter/wiki/Faq
http://blog.csdn.net/lijingkuan/article/details/50380272

9. canal:java.lang.OutOfMemoryError: Java heap space

10. can't add oracle 12c as data source(添加数据源，无法连接oracle12ca)
	```
	ORA-28040: No matching authentication protocol

	jdbc driver版本过低
	
	lib/ojdbc14-10.2.0.3.0.jar 替换为 lib/ojdbc6.jar
	```


