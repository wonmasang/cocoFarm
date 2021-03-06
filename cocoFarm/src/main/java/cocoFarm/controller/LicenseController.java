package cocoFarm.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import cocoFarm.dto.LicenseDto;
import cocoFarm.service.LicenseService;

@Controller
public class LicenseController {

	private static final Logger logger = LoggerFactory.getLogger(LicenseController.class);
	
	@Autowired
	LicenseService licenseService;
	@Autowired
	ServletContext context;
	
	@RequestMapping(value="/mypage/license.do", method=RequestMethod.GET)
	public void license() { }
	
	@RequestMapping(value="/mypage/license.do", method=RequestMethod.POST)
	public String license(LicenseDto license, HttpSession session) {
		
		MultipartFile file = license.getLicense_img();
		
		String uID = UUID.randomUUID().toString().split("-")[0];
		String realpath = context.getRealPath("/resources/img/licenseimg"); 
		String stored = file.getOriginalFilename() + "_" + uID;
		
		File dest = new File(realpath, stored);
		
		try {
			file.transferTo(dest);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		license.setLicense_storedName(stored);
		license.setAcc_idx((int)session.getAttribute("idx"));
		
		System.out.println(license.toString());
		
		licenseService.license(license);
		
		
		
		return "redirect:/mypage/message.do";
	}
	
	@RequestMapping(value="/mypage/deleteLicense.do", method=RequestMethod.GET)
	public void deleteLicense() {
		
	}
	
	@RequestMapping(value="/mypage/deleteLicense.do", method=RequestMethod.POST)
	public String deleteLicense(LicenseDto license) {
		
		System.out.println("라이센스 삭제 = "+license.getAcc_idx());
		
		licenseService.deleteLicense(license);
		
		return "redirect:/mypage/message.do";
	}
	
}
