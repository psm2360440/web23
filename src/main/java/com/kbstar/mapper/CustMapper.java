package com.kbstar.mapper;

import com.github.pagehelper.Page;
import com.kbstar.dto.Cust;
import com.kbstar.dto.Search;
import com.kbstar.dto.Search2;
import com.kbstar.frame.KBMapper;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface CustMapper extends KBMapper<String, Cust> {
    Page<Cust> getpage() throws Exception;
    Page<Cust> getfindpage(Search search) throws Exception;
    Page<Cust> getfindpage2(Search2 search2) throws Exception;
}
