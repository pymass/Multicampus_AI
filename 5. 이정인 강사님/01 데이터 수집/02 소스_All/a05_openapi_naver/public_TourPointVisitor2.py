import urllib.request
import config
import json
import math

#유료 관광지 방문객 수 조회를 위한 url 생성
def makeURL(yyyymm, sido, gungu, nPagenum, nItems):
    end_point = "http://openapi.tour.go.kr/openapi/service/TourismResourceStatsService/getPchrgTrrsrtVisitorList"  #
    parameters = "?_type=json&serviceKey=" + #TODO
    parameters += "&YM=" + yyyymm    .
    parameters += "&SIDO=" + urllib.parse.quote(sido)  # 한글은 인코딩하여 사용
    parameters += "&GUNGU=" + urllib.parse.quote(gungu)
    parameters += "&RES_NM=&pageNo=" + str(nPagenum)  # 숫자는 문자로 변경 후 사용
    parameters += "&numOfRows=" + str(nItems)
    url = end_point + parameters
    return url

def requestURL(url):
    req = #TODO
    try:
        response = #TODO
        if response.status == 200:                  # 200이면 정상 응답
            print("Url Request Success")
            data = #TODO
            return data                             # 크롤링 결과 반환
    except Exception as e:  # url로 요청 중 오류가 발생시 실행
        print(e)
        print("Error for URL : %s" %url)
        return None

def getTourPointData(item, yyyymm, jsonResult):
    addrCd = 0
    # TODO

    gungu = ''
    # TODO

    sido = ''
    if 'sido' in item:
        sido = item['sido']

    resNm = ''
    if 'resNm' in item:
        resNm = item['resNm']

    rnum = ''
    if 'rnum' in item:
        rnum = item['rnum']

    ForNum = ''
    if 'csForCnt' in item:
        ForNum = item['csForCnt']

    NatNum = ''
    if 'csNatCnt' in item:
        NatNum = item['csNatCnt']

     #TODO      ({'yyyymm': yyyymm, 'addrCd': addrCd,
                       'gungu': gungu, 'sido': sido, 'resNm': resNm,
                       'rnum': rnum, 'ForNum': ForNum, 'NatNum': NatNum})
    return

def main():
    sido = '서울특별시'
    gungu = ''
    nPagenum = 1
    nItems = 100
    nStartYear = 2011
    nEndYear = 2018
    jsonResult = []

    for year in range(nStartYear, nEndYear):    #시작년도부터 종료년도(endyear-1) 까지 반복 요청
         #TODO                              #1월~12월까지 반복

            # 201101, 201102, 201103, 201104 .... 을 하나씩 생성
            yyyymm =str(year)
            if month < 10 :
                yyyymm = yyyymm+'0' +str(month)
            else :
                yyyymm = yyyymm +  str(month)

            nPagenum = 1

            while True:
                targetURL = makeURL(yyyymm, sido, gungu, nPagenum, nItems)  # 1. URL 만들기
                result = requestURL(targetURL)                              # 2. URL로 크롤링
                print(result)                                               # 3. 크롤링 결과 출력

                if (result != None):
                    jsonData = json.loads(result)

                if (jsonData['response']['header']['resultMsg'] == 'OK'):  # 요청에 대한 응답이 정상이면
                    nTotal = jsonData['response']['body']['totalCount']  # 요청 결과 건수

                    if nTotal == 0:  # 해당 페이지에 데이터가 없는 경우 반복 나옴.
                        break

                    for item in jsonData['response']['body']['items']['item']:  # 응답 결과 건수 만큼 반복 돌면서 data 저장
                        getTourPointData(item, yyyymm, jsonResult)

                    nPage = math.ceil(nTotal / 100)  # 이 사이트는 한번에 100개의 데이터를 요청.
                    if (nPagenum == nPage):          # 전체 데이터가 100 이상인 경우 총 페이지 수를 계산하여 여러번 반복해야 함.
                        break

                    nPagenum += 1                    # nPagenum를 증가 시켜가면 계속 요청
                else:
                    break



    # TODO

main()
