package hair.support.paging;

public abstract interface PaginationRenderer { 
	
	public abstract String renderPagination(PaginationInfo pageInfo, String param);
    
}
