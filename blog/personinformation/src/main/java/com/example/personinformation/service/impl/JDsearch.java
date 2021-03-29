package com.example.personinformation.service.impl;

import com.example.personinformation.bean.book;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.common.text.Text;
import org.elasticsearch.common.unit.TimeValue;
import org.elasticsearch.common.xcontent.XContentType;
import org.elasticsearch.index.query.MatchQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.index.query.TermQueryBuilder;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightBuilder;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightField;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.alibaba.fastjson.JSON;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@Service
public class JDsearch {

    @Autowired
    private RestHighLevelClient restHighLevelClient;

    public List<Map<String,Object>> searchPage(String keyword,int pageNo,int pageSize) throws Exception{
        if(pageNo<=0){
            pageNo=1;
        }
        SearchRequest searchRequest=new SearchRequest("jd_goods");
        //		创建  搜索内容参数设置对象:SearchSourceBuilder
        SearchSourceBuilder sourceBuilder=new SearchSourceBuilder();
        //分页
        sourceBuilder.from(pageNo);
        sourceBuilder.size(pageSize);

        //精准匹配
        MatchQueryBuilder termQueryBuilder = QueryBuilders.matchQuery("title", keyword);
        sourceBuilder.query(termQueryBuilder);

        sourceBuilder.timeout(new TimeValue(60, TimeUnit.SECONDS));

        //高亮
        HighlightBuilder highlightBuilder = new HighlightBuilder();
        highlightBuilder.field("title");
        highlightBuilder.preTags("<span style='color:red;font-size:17px'>");
        highlightBuilder.postTags("</span>");
        sourceBuilder.highlighter(highlightBuilder);

        //执行搜索
        searchRequest.source(sourceBuilder);
        SearchResponse searchResponse = restHighLevelClient.search(searchRequest, RequestOptions.DEFAULT);
        ArrayList<Map<String,Object>> list=new ArrayList<>();
        for(SearchHit hit:searchResponse.getHits().getHits()){
            Map<String, HighlightField> highlightFields = hit.getHighlightFields();
            //获取高亮字段
            HighlightField title = highlightFields.get("title");
            Map<String, Object> sourceAsMap = hit.getSourceAsMap();
            if(title!=null){
                Text[] fragments = title.fragments();
                String n_title="";
                for(Text text:fragments){
                    n_title+=text;
                }
                sourceAsMap.put("title",n_title);//高亮替换原来的
            }
            list.add(sourceAsMap);
        }
        return list;
    }
    public void addbook(String price,String title,String img) throws Exception{
        book b=new book();
        b.setImg(img);
        b.setPrice(price);
        b.setTitle(title);
        IndexRequest request = new IndexRequest("jd_goods");
        request.timeout("1s");
        request.source(JSON.toJSONString(b), XContentType.JSON);
        IndexResponse index = restHighLevelClient.index(request, RequestOptions.DEFAULT);
        System.out.println(index.toString());
        System.out.println(index.status());
    }
}
