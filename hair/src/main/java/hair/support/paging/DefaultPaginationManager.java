package hair.support.paging;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import hair.product.controller.ProductController;

public class DefaultPaginationManager  implements PaginationManager{ 

	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	private Map<String, PaginationRenderer> rendererType;
	
	public void setRendererType(Map<String, PaginationRenderer> rendererType) {
		this.rendererType = rendererType;
	}
	
	public PaginationRenderer getRendererType(String type) {
		logger.error("@page : " + type);
		return (this.rendererType != null) && (this.rendererType.containsKey(type)) ? (PaginationRenderer)this.rendererType.get(type) : new DefaultPaginationRenderer();
	}
    
}
