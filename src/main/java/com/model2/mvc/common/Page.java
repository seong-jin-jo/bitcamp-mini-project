package com.model2.mvc.common;


public class Page {
	
	///Field
	private int currentPage;		// 현재페이지 			  (파인튜닝)
	private int totalCount;			// 총 게시물 수
	private int pageUnit;			// 하단 페이지 번호 화면에 보여지는 개수
	private int pageSize;			// 한 페이지당 보여지는 게시물수
	private int maxPage;			// 전체 페이지수 		  (논리구현)
	private int beginUnitPage;	//화면에 보여지는 페이지 번호의 최소수 (논리구현)
	private int endUnitPage;	//화면에 보여지는 페이지 번호의 최대수 (논리구현)
	
	///Constructor
	public Page() {
	}
	public Page( int currentPage, int totalCount, int pageUnit, int pageSize ) {
		this.totalCount = totalCount;
		this.pageUnit = pageUnit;
		this.pageSize = pageSize;
		
		this.maxPage = (pageSize == 0) ? totalCount :  (totalCount-1)/pageSize +1;
		// pageSize 1이면 maxPage12 = totalCount12 되어야함 (ok)
		// pageSize 2이면 maxpage6  = totalCount12 되어야함 (ok)
		// pageSize 3이면 maxPage9  = totalCount27 되어야함 (ok)
		// 한편 pageSize 0 이면 그냥 maxPage 를 12로 처리함. (마지막페이지에서 남은거 다보여주려하나?)
		
		this.currentPage = ( currentPage > maxPage) ? maxPage : currentPage;
		// currentPage 가 마지막꺼 넘어가면 그냥 maxPage 로 고정이 됨
		
		this.beginUnitPage = ( (currentPage-1) / pageUnit ) * pageUnit +1 ;
		// 현재 6페이지고 페이지 5개씩 보여준다하면 (5/5)*5+1 = 6 이 시작페이지
		// 현재 11페이지고 한 화면에 5개씩 보여준다면 (10/5)*5+1= 11 이 시작페이지
		// 곧 현재페이지에서 6~10 이 띄워져있으면 6이 시작페이지 논리완성
		
		if( maxPage <= pageUnit ){
			this.endUnitPage = maxPage;
		}else{
			this.endUnitPage = beginUnitPage + (pageUnit -1);
			if( maxPage <= endUnitPage){
				this.endUnitPage = maxPage;
			}
		}
		// 한페이지당 5개씩 보여주는데 전체페이지9가 이보다 작으면 끝페이지가 전체페이지
		// 한편                전체페이지9가 이보다 크면  시작페이지 + 4가 끝페이지
		// 또                 전체페이지9가 마지막페이지보다 작으면 끝페이지는 전체페이지
	}
	
	///Mehtod
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getPageUnit() {
		return pageUnit;
	}
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getMaxPage() {
		return maxPage;
	}
	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}
	public int getBeginUnitPage() {
		return beginUnitPage;
	}
	public void setBeginUnitPage(int beginUnitPage) {
		this.beginUnitPage = beginUnitPage;
	}
	public int getEndUnitPage() {
		return endUnitPage;
	}
	public void setEndUnitPage(int endUnitPage) {
		this.endUnitPage = endUnitPage;
	}
	@Override
	public String toString() {
		return "Page [currentPage=" + currentPage + ", totalCount="
				+ totalCount + ", pageUnit=" + pageUnit + ", pageSize="
				+ pageSize + ", maxPage=" + maxPage + ", beginUnitPage="
				+ beginUnitPage + ", endUnitPage=" + endUnitPage + "]";
	}
}