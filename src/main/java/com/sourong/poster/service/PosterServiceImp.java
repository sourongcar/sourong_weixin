package com.sourong.poster.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sourong.poster.dao.PosterVOMapper;
import com.sourong.poster.domain.PosterVO;
import com.sourong.poster.domain.PosterVOExample;

@Service
public class PosterServiceImp implements PosterService {
	@Autowired
	private PosterVOMapper mapper;

	@Override
	public PosterVO getRandom() {
		PosterVOExample example = new PosterVOExample();
		example.createCriteria();
		example.setOrderByClause("rand()");
		example.setLimit(1);
		List<PosterVO> list = mapper.selectByExample(example);
		if (list != null && list.size() == 1) {
			return list.get(0);
		} else
			return null;
	}

}
