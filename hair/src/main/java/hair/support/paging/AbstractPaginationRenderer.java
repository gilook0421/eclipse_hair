package hair.support.paging;

import java.text.MessageFormat;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public abstract class AbstractPaginationRenderer implements PaginationRenderer{ 

	@SuppressWarnings("unused")
	private static final Logger logger = LoggerFactory.getLogger(AbstractPaginationRenderer.class);
	
	public String firstPageLabel;
	public String previousPageLabel;
	public String currentPageLabel;
	public String otherPageLabel;
	public String nextPageLabel;
	public String lastPageLabel;
	
	public String renderPagination(PaginationInfo pageInfo, String param) {
		StringBuffer strBuff = new StringBuffer();
		
		int firstPageNo = pageInfo.getFirstPageNo();
		int firstPageNoOnPageList = pageInfo.getFirstPageNoOnPageList();
		int totalPageCount = pageInfo.getTotalPageCount();
		int pageSize = pageInfo.getPageSize();
		int lastPageNoOnPageList = pageInfo.getLastPageNoOnPageList();
		int currentPageNo = pageInfo.getCurrentPageNo();
		int lastPageNo = pageInfo.getLastPageNo();


		logger.error("@renderPagination : " + pageInfo.toString());
		logger.error("@renderPagination firstPageNo : " + firstPageNo);
		logger.error("@renderPagination firstPageNoOnPageList : " + firstPageNoOnPageList);
		logger.error("@renderPagination totalPageCount : " + totalPageCount);
		logger.error("@renderPagination pageSize : " + pageSize);
		logger.error("@renderPagination lastPageNoOnPageList : " + lastPageNoOnPageList);
		logger.error("@renderPagination currentPageNo : " + currentPageNo);
		logger.error("@renderPagination lastPageNo : " + lastPageNo);
		if(totalPageCount > pageSize) {
			if(firstPageNoOnPageList > pageSize) {
				strBuff.append(MessageFormat.format(this.firstPageLabel, new Object[] {param, Integer.toString(firstPageNo) }));
				strBuff.append(MessageFormat.format(this.previousPageLabel, new Object[] {param, Integer.toString(firstPageNoOnPageList-1) }));
			}
			else {
				strBuff.append(MessageFormat.format(this.firstPageLabel, new Object[] {param, Integer.toString(firstPageNo) }));
				strBuff.append(MessageFormat.format(this.previousPageLabel, new Object[] {param, Integer.toString(firstPageNo) }));
			}
		}
		
		for(int i = firstPageNoOnPageList; i <= lastPageNoOnPageList; i++) {
			if(i == currentPageNo) {
				strBuff.append(MessageFormat.format(this.currentPageLabel, new Object[] {Integer.toString(i) }));
			}
			else {
				strBuff.append(MessageFormat.format(this.otherPageLabel, new Object[] {param, Integer.toString(i), Integer.toString(i) }));
			}
		}
		

		if(totalPageCount > pageSize) {
			if(lastPageNoOnPageList < totalPageCount) {
				strBuff.append(MessageFormat.format(this.nextPageLabel, new Object[] {param, Integer.toString(firstPageNoOnPageList + pageSize) }));
				strBuff.append(MessageFormat.format(this.lastPageLabel, new Object[] {param, Integer.toString(lastPageNo) }));
			}
			else {
				strBuff.append(MessageFormat.format(this.nextPageLabel, new Object[] {param, Integer.toString(lastPageNo) }));
				strBuff.append(MessageFormat.format(this.lastPageLabel, new Object[] {param, Integer.toString(lastPageNo) }));
			}
		}

		logger.error("@renderPagination : " + strBuff.toString());
		logger.error("@renderPagination firstPageNo : " + firstPageNo);
		logger.error("@renderPagination firstPageNoOnPageList : " + firstPageNoOnPageList);
		logger.error("@renderPagination totalPageCount : " + totalPageCount);
		logger.error("@renderPagination pageSize : " + pageSize);
		logger.error("@renderPagination lastPageNoOnPageList : " + lastPageNoOnPageList);
		logger.error("@renderPagination currentPageNo : " + currentPageNo);
		logger.error("@renderPagination lastPageNo : " + lastPageNo);
		return strBuff.toString();
	}
    
}
