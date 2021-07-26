package hair.support.paging;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DefaultPaginationRenderer extends AbstractPaginationRenderer{ 

	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(DefaultPaginationRenderer.class);
	
	public DefaultPaginationRenderer() {
		firstPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" >◀</a>";
		previousPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" >◁</a>";
		currentPageLabel = "<li style=\"border:1px solid #7d7a82; color:#fff; background-color:#7d7a82;\">{0}</li>";
		otherPageLabel = "<li onclick=\"{0}({1}); return false;\" style=\"cursor:pointer\">{2}</li>";
		nextPageLabel = "<a  href=\"#\" onclick=\"{0}({1}); return false;\" >▷</a>";
		lastPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\" >▶</a>";
		logger.error("@DefaultPaginationRenderer :"+firstPageLabel);	
	}
	
	public String renderPagination(PaginationInfo pageInfo, String param) {
		logger.error("@renderPagination :"+pageInfo);	
		logger.error("@renderPagination :"+param);	
		return super.renderPagination(pageInfo, param);
	}
    
}
