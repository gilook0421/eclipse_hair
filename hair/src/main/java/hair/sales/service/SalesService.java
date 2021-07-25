package hair.sales.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import hair.sales.dao.SalesDAO;

@Service
public class SalesService{

	private static final Logger logger = LoggerFactory.getLogger(SalesService.class);
	
	@Inject
	private SalesDAO dao;
	
	// 글쓰기
	public HashMap<String, Object> write(String param, HttpServletRequest request) throws Exception{

		if(logger.isDebugEnabled()) logger.debug("XXXXXXXXXXXXXXXXXXXXXXXXXXX 1" + param.toString());
		if(logger.isDebugEnabled()) logger.debug("XXXXXXXXXXXXXXXXXXXXXXXXXXX 1" + request.getParameter("obj").toString());
		
		HashMap<String, Object> result = new HashMap<>();
		{
			//param.setSales_id(memberVO.getMem_id());
			//dao.write(param);

			JSONParser jsonParser = new JSONParser();
             
            //JSON데이터를 넣어 JSON Object 로 만들어 준다.
            //JSONObject jsonObject = (JSONObject)jsonParser.parse( request.getParameter("obj").toString() );
             
            //books의 배열을 추출
            JSONArray jsonArray = (JSONArray) jsonParser.parse(request.getParameter("obj").toString());

            ///다중 insert mybatis foreach사용을 위한 map
            ///List<SalesVO> list = new ArrayList<SalesVO>();
            ///HashMap<String, Object> map = new HashMap<String, Object>();
            
            if ( jsonArray.size() > 0 ) {
            	if(logger.isDebugEnabled()) logger.debug("건수 존재.");

                for(int i=0; i<jsonArray.size(); i++){
     
                	if(logger.isDebugEnabled()) logger.debug("=arr_"+i+" ===========================================");
                     
                    //배열 안에 있는것도 JSON형식 이기 때문에 JSON Object 로 추출
                    JSONObject obj = (JSONObject) jsonArray.get(i);
                     
                    //JSON name으로 추출
                    if(logger.isDebugEnabled()) logger.debug("obj: sales_no==>"+obj.get("sales_no"));
                    if(logger.isDebugEnabled()) logger.debug("obj: sales_prod_name==>"+obj.get("sales_prod_name"));
                    if(logger.isDebugEnabled()) logger.debug("obj: sales_prod_price==>"+obj.get("sales_prod_price"));
                    if(logger.isDebugEnabled()) logger.debug("obj: sales_prod_price_tot==>"+obj.get("sales_prod_price_tot"));
                    if(logger.isDebugEnabled()) logger.debug("obj: sales_point_plus==>"+obj.get("sales_point_plus"));
                    if(logger.isDebugEnabled()) logger.debug("obj: sales_point_minus==>"+obj.get("sales_point_minus"));
                    if(logger.isDebugEnabled()) logger.debug("obj: sales_point_tot==>"+obj.get("sales_point_tot"));
                    if(logger.isDebugEnabled()) logger.debug("obj: sales_filler1==>"+obj.get("sales_filler1"));
                    if(logger.isDebugEnabled()) logger.debug("obj: sales_staff_no==>"+obj.get("sales_staff_no"));

                    HashMap<String, Object> vo = new HashMap<>();
					/*
					 * vo.put("Sales_id",memberVO.get("Mem_id")); vo.put("Sales_cust_no",
					 * String.valueOf( ((Number) obj.get("sales_no")) ) );
					 * vo.put("Sales_prod_name",(String) obj.get("sales_prod_name"));
					 * vo.put("Sales_prod_price",(String) obj.get("sales_prod_price"));
					 * vo.put("Sales_prod_price_tot",String.valueOf( ((Number)
					 * obj.get("sales_prod_price_tot")) ) );
					 * vo.put("Sales_point_plus",String.valueOf( ((Number)
					 * obj.get("sales_point_plus")) ) ); vo.put("Sales_point_minus",String.valueOf(
					 * ((Number) obj.get("sales_point_minus")) ) );
					 * vo.put("Sales_point_tot",String.valueOf( ((Number)
					 * obj.get("sales_point_tot")) ) ); vo.put("Sales_filler1",(String)
					 * obj.get("sales_filler1")); vo.put("Sales_staff_no",(String)
					 * obj.get("sales_staff_no"));
					 */
                    dao.write(vo);
                    ///list.add(vo);
                    
                }// end for
                
                ///map.put("list", list);
                ///dao.foreachIns(map);
            }
            else {
            	if(logger.isDebugEnabled()) logger.debug("건수 미존재");
            }
	            
		}
		
		result.put("data", "");
		
		return result;
	}
	
	// 게시판 리스트
	public HashMap<String, Object> list(HashMap<String, Object> param) throws Exception{
	
		List<Object> board = new ArrayList<>();
		board = dao.list(param);
				
		HashMap<String, Object> result = new HashMap<>();
		result.put("data", board);
		
		return result; 
	}

	// 손님 조회
	public HashMap<String, Object> selectOne(HashMap<String, Object> param, HttpServletRequest request) throws Exception{

			//param.put("Cust_id", memberVO.get("Mem_id") );
		
		List<Object> list = new ArrayList<>();
		list = dao.selectOne(param);
				
		HashMap<String, Object> result = new HashMap<>();
		//result.put("msg", commonVO);
		result.put("data", list);
		
		
		return result;
	}
	
}
