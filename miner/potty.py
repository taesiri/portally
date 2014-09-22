# -*- coding: utf-8 -*-
import requests
from BeautifulSoup import BeautifulSoup
import sys
import json

reload(sys)
sys.setdefaultencoding("utf-8")

TAG_SHOMARE = u'شماره'
TAG_MAGHTAE = u'مقطع'
TAG_DANESHKADE = u'دانشکده'
TAG_VAZEEAT= u'وضعيت'
WORKING_DIR = 'D://dump//'

class student(object):
	def __init__(self):
		super(student, self).__init__()
		self.name = None
		self.id = 0
		self.picUrl = None
		self.degree = None
		self.department = None
		self.status = None
		self.konkurRank = 0
		self.gpe = 0
		self.ccp = 0
		self.cct = 0


cookie = {'JSESSIONID' : 'JSID GOES HERE!'}
dumpList = range(0,1000)

for stNo in dumpList:
	url_basicInfo = 'https://portal2.aut.ac.ir/aportal/regadm/students/students.jsp?action=edit&st_no=' + str(stNo)+ '&st_info=personal&st_sub_info=0'
	url_educatinInfo = 'https://portal2.aut.ac.ir/aportal/regadm/students/students.jsp?action=edit&st_no=' +  str(stNo) + '&st_info=educational&st_sub_info=0'
	
	reqBasic = requests.get(url_basicInfo, cookies=cookie, verify=False)
	reqEdu = requests.get(url_educatinInfo, cookies=cookie, verify=False)
	
	print reqBasic.status_code
	print reqEdu.status_code
	
	parsedBasicInfo = BeautifulSoup(reqBasic.text.encode('utf-8'))
	parsedEducationalInfo = BeautifulSoup(reqEdu.text.encode('utf-8'))
	
	pic =  [x['src'] for x in parsedBasicInfo.findAll('img', attrs={'id':'st_picture'})]
	edu_data = [x for x in parsedEducationalInfo.findAll('input', attrs={'class' : 'stdeditbox'})]
	data = [x.text.encode('utf-8') for x in parsedBasicInfo.findAll('td')]
	
	data[1] = data[1].replace(TAG_SHOMARE, '')
	data[1] = data[1].replace(TAG_MAGHTAE, '')
	data[1] = data[1].replace(TAG_DANESHKADE, '')
	data[1] = data[1].replace(TAG_VAZEEAT, '')
	data[1] = data[1].replace(')', '')
	data[1] = data[1].replace('(', '')
	
	studentData = data[1].split(':')
	
	st = student()
	st.name = studentData[1].strip()
	st.id = studentData[2].strip()
	st.degree = studentData[4].strip()
	st.department = studentData[5].strip()
	st.status = studentData[6].strip()
	st.picUrl = pic[0].strip()
	st.konkurRank = edu_data[0]['value']
	st.gpe = edu_data[2]['value']
	st.ccp = edu_data[4]['value']
	st.cct = edu_data[3]['value']
	
	fo = open(WORKING_DIR +  str(stNo) +  ".json", "wb")
	fo.write(json.dumps(st.__dict__ , indent=4, sort_keys=True, ensure_ascii=False))
	fo.close()


