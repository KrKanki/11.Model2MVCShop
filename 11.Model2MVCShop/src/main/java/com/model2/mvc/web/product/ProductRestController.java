package com.model2.mvc.web.product;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductRestController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET )
	public Product getProduct( @PathVariable int prodNo ) throws Exception{
		
		System.out.println("/user/json/getProduct : GET");
		System.out.println(prodNo);
		//Business Logic
		return productService.getProduct(prodNo);
	}

	@RequestMapping( value="json/getProductList/{value}", method=RequestMethod.GET )
	public Map<String, Object> getProductList( @PathVariable String value, 
			@RequestParam("currentPage") int currentPage,
			@RequestParam("searchCondition") String searchCondition,
			@RequestParam("searchKeyword") String searchKeyword) throws Exception{
		
		
		System.out.println("/product/json/getProductList : GET");
		System.out.println(value);
		Search search = new Search();
		search.setCurrentPage(currentPage);
		search.setSearchCondition(searchCondition);
		search.setSearchKeyword(searchKeyword);
		search.setPageSize(pageSize);
		System.out.println(search);
		//Business Logic
		return productService.getProductList(search);
	}
	
	@RequestMapping(value="json/updateProduct/{value}")
	public void updateProduct(@ModelAttribute("product") Product product ,Model model) throws Exception{
		
		System.out.println("product/json/updateProduct 실행");
		
		System.out.println("product check : "+ product);
		
		productService.updateProduct(product);
		
	}
	
	@RequestMapping(value="json/addProduct/{value}")
	public void addProduct(@ModelAttribute("product") Product product, Model model) 
									throws Exception {
		System.out.println("/addProduct.do 실행");
		
		product.setManuDate(product.getManuDate().replaceAll("-", ""));
		
		productService.addProduct(product);
		
		model.addAttribute(product);
		
		 
		
	}
}