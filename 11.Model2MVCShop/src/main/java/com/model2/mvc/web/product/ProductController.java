package com.model2.mvc.web.product;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public ProductController() {
		System.out.println(this.getClass());
//		 TODO Auto-generated constructor stub
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	//@RequestMapping("addProduct.do")
	@RequestMapping(value="addProduct")
	public String addProduct(@ModelAttribute("product") Product product, Model model) 
									throws Exception {
		System.out.println("/addProduct.do 실행");
		
		product.setManuDate(product.getManuDate().replaceAll("-", ""));
		
		productService.addProduct(product);
		
		model.addAttribute(product);
		
		return "redirect:/product/addProduct.jsp";
		
	}
	
	@RequestMapping(value="getProduct")
	public String getProduct(@RequestParam("prodNo") int prodNo, HttpSession session,
											@RequestParam("menu") String menu, 
											Model model)throws Exception{
			
		System.out.println("/getProduct 실행");
		Product product =productService.getProduct(prodNo);
		System.out.println("product check : "+product);

		model.addAttribute(product);
		
		if(menu.equals("manage")) {
			
			return "forward:/product/updateProductView.jsp";
		}else {
				
			return "forward:/product/getProduct.jsp";
		}
	}
	
	
	@RequestMapping(value="listProduct")
	public String listProduct(@ModelAttribute("search") Search search, Model model,
								@RequestParam("menu") String menu,
								HttpServletRequest request) throws Exception {

		   System.out.println("/product/listProduct : GET / POST ");
		      
	      if( search.getCurrentPage() ==0 ){
	         search.setCurrentPage(1);
	      }
	      search.setPageSize(pageSize);
	      
	      // Business logic 수행
	      Map<String , Object> map = productService.getProductList(search);
	      
	      Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
	      System.out.println(resultPage);

		String title = null;
		String url = null;
		String sc = null;
		String sk = null;
		System.out.println("test2");
		if( menu.equals("manage")) {
		 title = "상품 관리";
		 url = "menu=manage";
		 sc = search.getSearchCondition();
		 sk = search.getSearchKeyword();
		}else{
		 title = "상품 목록조회";
		 url = "menu=search";
		 sc = search.getSearchCondition();
		 sk = search.getSearchKeyword();
		}
		String action = "ProductList";
		
		
		model.addAttribute("title", title);
		model.addAttribute("url", url);
		model.addAttribute("sc", sc);
		model.addAttribute("sk", sk);
		model.addAttribute("action", action);
		
		System.out.println("ListProductAction ::"+resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("search", search);			
		model.addAttribute("resultPage", resultPage);
		System.out.println(map.get("purList"));
		
		System.out.println("resultPage ::"+resultPage);
		System.out.println("jsp 보내기전 list의 값"+map.get("list"));
		System.out.println("listProductAction 끝");
		
		return "forward:/product/listProduct.jsp";
	}
	
	@RequestMapping(value="updateProduct")
	public String updateProduct(@ModelAttribute("product") Product product ,Model model, HttpSession session) throws Exception{
		
		System.out.println("UpdateProduct 실행");
		
		System.out.println("product check : "+ product);
		productService.updateProduct(product);
		
		session.setAttribute("product", product);
		 
		return "redirect:/product/getProduct?prodNo="+product.getProdNo()+"&menu=search";
		
	}
	
	
}
