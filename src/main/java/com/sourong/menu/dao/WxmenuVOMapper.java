package com.sourong.menu.dao;

import com.sourong.menu.domain.WxmenuVO;
import com.sourong.menu.domain.WxmenuVOExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface WxmenuVOMapper {
    int countByExample(WxmenuVOExample example);

    int deleteByExample(WxmenuVOExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(WxmenuVO record);

    int insertSelective(WxmenuVO record);

    List<WxmenuVO> selectByExampleWithBLOBs(WxmenuVOExample example);

    List<WxmenuVO> selectByExample(WxmenuVOExample example);

    WxmenuVO selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") WxmenuVO record, @Param("example") WxmenuVOExample example);

    int updateByExampleWithBLOBs(@Param("record") WxmenuVO record, @Param("example") WxmenuVOExample example);

    int updateByExample(@Param("record") WxmenuVO record, @Param("example") WxmenuVOExample example);

    int updateByPrimaryKeySelective(WxmenuVO record);

    int updateByPrimaryKeyWithBLOBs(WxmenuVO record);
}