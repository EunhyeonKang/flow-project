package com.spring.web.model.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.web.model.vo.Extension;

@Repository
public class ExtensionDao {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<Extension> selectExtension() {
		List<Extension> list = sqlSession.selectList("extension.selectExtension");
		return (ArrayList<Extension>) list;
	}

	public int CustomCheck(String customExtension) {
		return sqlSession.selectOne("extension.CustomCheck", customExtension);
	}

	public String InsertExtension(Extension e) {
		sqlSession.insert("extension.InsertExtension", e);
		return e.getEx_name();
	}

	public int UpdateExtension(Map<String, Object> param) {
		return sqlSession.update("extension.UpdateExtension", param);
	}

	public Extension selectByName(String string) {
		return sqlSession.selectOne("extension.selectByName", string);
	}

	public int DeleteExtension(String deleteVal) {
		return sqlSession.delete("extension.DeleteExtension", deleteVal);
	}

	public Extension ExtensionNameCheck(String fileExtension) {
		return sqlSession.selectOne("extension.ExtensionNameCheck", fileExtension);
	}
}
