import urllib.request
import config

#유료 관광지 방문객 수

"""
 data.go.kr 사이트의 open API는 
 키를 
 url의 파라미터(serviceKey=... )로 추가 전달.  ( 참고 - 네이버는 header로 전달)  
"""

#유료 관광지 방문객 수 조회를 위한 url 생성
def makeURL(yyyymm, sido, gungu, nPagenum, nItems):
    end_point = "http://openapi.tour.go.kr/openapi/service/TourismResourceStatsService/getPchrgTrrsrtVisitorList"
    parameters = "?_type=json&serviceKey=" +    #TODO

    parameters += "&YM=" + yyyymm  # p121 요청 파라미터 참고 .
    parameters += "&SIDO=" + urllib.parse.quote(sido)  # 한글은 인코딩하여 사용
    parameters += "&GUNGU=" + urllib.parse.quote(gungu)
    parameters += "&RES_NM=&pageNo=" + str(nPagenum)  # 숫자는 문자로 변경 후 사용
    parameters += "&numOfRows=" + str(nItems)
    url = end_point + parameters
    return url


def requestURL(url):
    req =   #TODO
    try:
        response =    #TODO
        if response.status == 200:                  # 200이면 정상 응답
            print("Url Request Success")
            data =     #TODO
            return data                             # 크롤링 결과 반환
    except Exception as e:  # url로 요청 중 오류가 발생시 실행
        print(e)
        print("Error for URL : %s" %url)
        return None

def main():
    sido = '서울특별시'
    gungu = '' 
    nItems = 100
    yyyymm ='201710'
    nPagenum = 1

    # TODO

main()

