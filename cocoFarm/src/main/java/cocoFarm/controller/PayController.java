package cocoFarm.controller;


import java.util.ArrayList;
import java.util.List;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;



import cocoFarm.dto.Option;
import cocoFarm.dto.SaleOption;
import cocoFarm.service.ProductService;

@Controller
public class PayController {
	@Autowired ProductService productService;

	
	@RequestMapping(value="/orderpay.do",method=RequestMethod.GET)
	public String payVieworder(SaleOption saleoption) {
		/*System.out.println(saleoption.getProAmount());*/
		
		
		return "payment/oderPay";
	}
	
	
	
	@RequestMapping(value="/orderpay.do",method=RequestMethod.POST)
	public String payorder(Option option,Model model) {

		
		/*06월 04일 추가*/
		try{
			List<SaleOption> saleList = option.getSaleOptions();
			
			//옵션 불러오는것 idx
			String query ="(";
			
			List<Integer> listA = new ArrayList();
			
			
			for(int i=0; i<saleList.size()-1; i++) {
				query += saleList.get(i).getIdx()+",";
				listA.add(saleList.get(i).getProAmount());
			}
			query +=saleList.get(saleList.size()-1).getIdx() +")";
			listA.add(saleList.get(saleList.size()-1).getProAmount());
			
			System.out.println(query);
			System.out.println(listA);
			
			
			model.addAttribute("opt",(productService.getPayOption(query)));
			System.out.println((productService.getPayOption(query)));
			model.addAttribute("amount",listA);
		
			//옵션 판매글 불러오는것 
			String salequery ="(";
			
			for(int i=0; i<productService.getPayOption(query).size()-1; i++) {
				salequery += productService.getPayOption(query).get(i).getSaleIdx()+",";
				
			}
			salequery += productService.getPayOption(query).get(productService.getPayOption(query).size()-1).getSaleIdx()+")";
			/*System.out.println(salequery);*/
			
			
			productService.getSale_Option(salequery);
			System.out.println(productService.getSale_Option(salequery));
			/*System.out.println(productService.getPayOption(query).get(0).getSaleIdx());
			*/
			
			model.addAttribute("pro",(productService.getSale_Option(salequery)));
			
		}catch(NullPointerException np) {
				System.out.println("리스트에 아무것도 없습니다.");
		}
		return "payment/oderPay";
	}
	
	/*
	@RequestMapping(value="/paycomple.do",method=RequestMethod.GET)
	public String paycomple(SaleOption saleoption) {
		System.out.println(saleoption.getProAmount());
		
		
		return "payment/oderPay";
	}
	*/
	@RequestMapping(value="/paycomple.do",method=RequestMethod.POST)
	@ResponseBody
	public String paycomplepots(String memdeliver,String buyer_name,String memname) {
//		model.addAttribute("memname", memname);
		System.out.println(buyer_name);
		
		
		
		System.out.println("===배송==================");
		System.out.println(memdeliver);
		
		return "{\"result\":\""+memname+"\"}";
				
		
//		try {
//			writer.write("{\"result\":"+ memname +"}");
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
		
		
		/*Gson gson = new Gson();
		JsonObject jsonObject = new JsonObject();*/
		
//		try {
//		
//			writer.write("{\"result\":"+ memname +"}");
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
	
//		List<SaleOption> payList = option.getSaleOptions();
		
//		System.out.println(payList.get(0).getIdx());
		
		
		
		//return "payment/oderPay";
	}
	
}

