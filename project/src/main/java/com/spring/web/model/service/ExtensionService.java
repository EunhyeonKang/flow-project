package com.spring.web.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.web.model.dao.ExtensionDao;
import com.spring.web.model.vo.Extension;

@Service
public class ExtensionService {
	@Autowired
	private ExtensionDao dao;

	@Transactional
	public ArrayList<Extension> selectExtension() {
		return dao.selectExtension();
	}

	public int CustomCheck(String customExtension) {
		return dao.CustomCheck(customExtension);
	}

	public String InsertExtension(Extension e) {
		if (dao.selectByName(e.getEx_name()) != null) {
			if (dao.selectByName(e.getEx_name()).getEx_type().equals("f"))
				return "0";
			else
				return "-1";
		} else {
			return dao.InsertExtension(e);
		}

	}

	public int UpdateExtension(Map<String, Object> param) {
		return dao.UpdateExtension(param);
	}

	public int DeleteExtension(String deleteVal) {
		return dao.DeleteExtension(deleteVal);
	}

	public Extension ExtensionNameCheck(String fileExtension) {
		return dao.ExtensionNameCheck(fileExtension);
	}
}
