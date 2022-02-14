package com.spring.web.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.web.model.service.ExtensionService;
import com.spring.web.model.vo.Extension;

@Controller
public class ExtensionController {
	@Autowired
	private ExtensionService service;

	@ResponseBody
	@RequestMapping(value = "/customCheck.do", method = RequestMethod.POST)
	public String CustomCheck(@RequestParam("custom") String customExtension) {
		int result = service.CustomCheck(customExtension);
		return String.valueOf(result);
	}

	@ResponseBody
	@RequestMapping(value = "/deleteExtension.do")
	public String DeleteExtension(@RequestParam("deleteVal") String deleteVal, Model model) {
		int result = service.DeleteExtension(deleteVal);
		return String.valueOf(result);
	}

	@ResponseBody
	@RequestMapping(value = "/insertExtension.do")
	public String InsertExtension(Extension e) {
		return service.InsertExtension(e);
	}

	@ResponseBody
	@RequestMapping(value = "/updateExtension.do", method = RequestMethod.POST)
	public String UpdateExtension(@RequestParam Map<String, Object> param, Model model) {
		int result = service.UpdateExtension(param);
		return String.valueOf(result);
	}

	@ResponseBody
	@RequestMapping(value = "/extensionNameCheck.do", method = RequestMethod.POST)
	public String ExtensionNameCheck(@RequestParam("fileExtension") String fileExtension) {
		Extension result = service.ExtensionNameCheck(fileExtension);
		if (result != null) {
			return "1";
		} else {
			return "0";
		}
	}
}
