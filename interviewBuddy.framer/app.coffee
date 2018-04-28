# {InputModule} = require "input"

# # CANDIDATE DATA
# candidateData = JSON.parse Utils.domLoadDataSync "candidates.json"
# for candidate, i in candidateData
# 	candidateData[i].name = candidate.name
# 	print candidate.name

bd = new BackgroundLayer backgroundColor: "#F6F7F9"

# #––––––––––––––––––––––––––––––––––––––––––––––––––––#
# #                     CSS STYLES                     #
# #––––––––––––––––––––––––––––––––––––––––––––––––––––#
Utils.insertCSS ("
	.light20Sm {color: #9B9B9B; font-size: 24px; line-height: 30px;}
	.smallLink {color: #4080FF; font-size: 24px;}
	.mediumLink {color: #4080FF; font-size: 28px;}
	.largeLink {color: #4080FF; font-size: 32px;}
	.mediumGrey {color: #4B4F56; font-size: 26px;}
	.mediumGreyLight {color: #E9EbEE; font-size: 26px;}
	.largeGrey {color: #4B4F56; font-size: 30px;}
	.largeLightGrey {color: #BEC2C9; font-size: 30px;}
	.light50Sm {color: #4B4F56; font-size: 26px; line-height: 30px;}
	.light50Md {color: #4B4F56; font-size: 28px; line-height: 32px;}
	.light50Lg {color: #4B4F56; font-size: 32px; line-height: 36px;}
	.light50XLg {color: #4B4F56; font-size: 40px; line-height: 44px;}
	.lightBlue {color: #4080FF; font-size: 26px;}
	.links {color: #3B5998;}
	.headerTitleWhite {color: white; font-size: 40px;}
	.headerTitleBlack {color: #4A4A4A; font-size: 40px;}
	.headerTitleBlue {color: #4080FF; font-size: 40px;}
	.headerTitleGrey {color: #4B4F56; font-size: 40px;}
	.lineAdjust05 {height: 5px;}
	.lineAdjust10 {height: 10px;}
	.lineAdjust20 {height: 20px;}
	ul {padding-left:25px;}
	ol {padding-left:35px;}
	ol li {line-height: 40px;}
	.clicked {background-color: red;}
")

# #––––––––––––––––––––––––––––––––––––––––––––––––––#
# #                     COLORS                       #
# #––––––––––––––––––––––––––––––––––––––––––––––––––#
light02 = "#F6F7F9"
light05 = "#E9EbEE"
light20 = "#BEC2C9"
light30 = "#90949C"
light50 = "#4B4F56"
highlightBlue = "#4080FF"
fbBlue = "#4267B2"
links = "#3D6AD6"
 
# #––––––––––––––––––––––––––––––––––––––––––––––––––––#
# #                ANIMATION CURVES                    #
# #––––––––––––––––––––––––––––––––––––––––––––––––––––#
animateIn = "spring(450,40,0)"
animateOut = "spring(550,45,0)"
 
# #––––––––––––––––––––––––––––––––––––––––––––––––––––#
# #            CANDIDATE SCROLL CONTAINERS             #
# #––––––––––––––––––––––––––––––––––––––––––––––––––––#
# # scroll that holds the list of candidates for the interview tab
scrollList = new ScrollComponent 
	width: Screen.width, height: Screen.height, y: 1334
	backgroundColor: light02
	visible: false
scrollList.scrollHorizontal = false
scrollList.contentInset = bottom: 40, top: 130

scrollListLoad = ->
	scrollList.visible = true
	scrollList.animate
		properties: y: 0
		curve: animateIn
		
scrollListLoad()

# scroll that holds the list of candidate names for code pic save
candidateListScroll = new ScrollComponent
	width: Screen.width, height: Screen.height, y: 1334
	backgroundColor: "white"
	visible: false
candidateListScroll.scrollHorizontal = false

# scroll that holds the list of alert status
alertStatusScroll = new ScrollComponent
	width: Screen.width, height: Screen.height, y: 1334
	backgroundColor: "white"
	visible: false
alertStatusScroll.scrollHorizontal = false
	
#–––––––––––––––––––––––––––––––––––––––––––––––#
#                  SORT MENU                    #
#–––––––––––––––––––––––––––––––––––––––––––––––#
sortMask = new Layer
	width: Screen.width, height: 483, y: -483
	backgroundColor: "#ccc"
	visible: false

sortPopover = new Layer
	width: 750, height: 483
	image: "images/sortPopover.png"
	parent: sortMask
	
overlay = new Layer
	width: Screen.width, height: Screen.height, z: 1
	backgroundColor: "black"
	visible: false
	opacity: 0
	
#–––––––––––––––––––––––––––––––––––––––––––––#
#                  NAV BAR UI                 #
#–––––––––––––––––––––––––––––––––––––––––––––#
navBar = new Layer
	width: Screen.width, height: 130
	backgroundColor: fbBlue
	
statusBarWhite = new Layer
	width: 725, height: 18, x: 15, y: 8
	image: "images/statusBarWhite.svg"
	parent: navBar
	
statusBarBlack = new Layer
	width: 725, height: 18, x: 15, y: 8
	image: "images/statusBarBlack.svg"
	parent: navBar
	visible: false
	
initialHeader = new Layer
	width: Screen.width, height: 40, y: 65
	backgroundColor: "transparent"
	parent: navBar
	html: '<span class="headerTitleWhite">My Interviews</span>'
initialHeader.style = textAlign: "center"
	
backArrow = new Layer
	width: 14, height: 30, x: 30, y: 65
	visible: false
	image: "images/backArrow.svg"
	parent: navBar
	
backBlueArrow = new Layer
	width: 14, height: 30, x: 20, y: 65
	visible: false
	image: "images/backBlueArrow.svg"
	parent: navBar
	
backBtn = new Layer
	width: 100, height: 40, x: 60, y: 67
	backgroundColor: "transparent"
	visible: false
	parent: navBar
	html: "Back"
backBtn.style = fontSize: "36px", color: "white"

alertBtn = new Layer
	width: 100, height: 40, x: 640, y: 67
	backgroundColor: "transparent"
	visible: false
	parent: navBar
	html: "Alert"
alertBtn.style = fontSize: "36px"

cameraRollCancelBtn = new Layer
	width: 120, height: 40, x: 30, y: 67
	backgroundColor: "transparent"
	visible: false
	parent: navBar
	html: "Cancel"
cameraRollCancelBtn.style = fontSize: "36px", color: highlightBlue

# ON CODE PIC SCREEN
codePicCancelBtn = new Layer
	width: 120, height: 40, x: 30, y: 67
	backgroundColor: "transparent"
	visible: false
	parent: navBar
	html: "Cancel"
codePicCancelBtn.style = fontSize: "36px", color: highlightBlue

# ON CANDIDATE LIST SELECTOR FROM CODE PIC
codePicSelectCandidateCancelBtn = new Layer
	width: 120, height: 40, x: 30, y: 67
	backgroundColor: "transparent"
	visible: false
	parent: navBar
	html: "Cancel"
codePicSelectCandidateCancelBtn.style = fontSize: "36px", color: highlightBlue

# ON CANDIDATE LIST SELECTOR FROM TAKE NOTES
takeNotesSelectCandidateCancelBtn = new Layer
	width: 120, height: 40, x: 30, y: 67
	backgroundColor: "transparent"
	visible: false
	parent: navBar
	html: "Cancel"
takeNotesSelectCandidateCancelBtn.style = fontSize: "36px", color: highlightBlue

alertStatusCancelBtn = new Layer
	width: 120, height: 40, x: 30, y: 67
	backgroundColor: "transparent"
	visible: false
	parent: navBar
	html: "Cancel"
alertStatusCancelBtn.style = fontSize: "36px", color: highlightBlue

alertStatusBackBtn = new Layer
	width: 200, height: 40, x: 50, y: 67
	backgroundColor: "transparent"
	visible: false
	parent: navBar
	html: "Alert Status"
alertStatusBackBtn.style = fontSize: "36px", color: highlightBlue

# NOTES BUTTONS
notesCancelBtn = new Layer
	width: 120, height: 40, x: 30, y: 67
	backgroundColor: "transparent"
	visible: false
	parent: navBar
	html: "Cancel"
notesCancelBtn.style = fontSize: "36px", color: highlightBlue

notesDoneBtn = new Layer
	width: 110, height: 40, x: 640, y: 67
	backgroundColor: "transparent"
	visible: false
	parent: navBar
	html: "Done"
notesDoneBtn.style = fontSize: "36px", color: highlightBlue

cameraRollDoneBtn = new Layer
	width: 110, height: 40, x: 640, y: 67
	backgroundColor: "transparent"
	visible: false
	parent: navBar
	html: "Done"
cameraRollDoneBtn.style = fontSize: "36px", color: highlightBlue

codePicSelectCandidateDoneBtn = new Layer
	width: 110, height: 40, x: 640, y: 67
	backgroundColor: "transparent"
	visible: false
	parent: navBar
	html: "Done"
codePicSelectCandidateDoneBtn.style = fontSize: "36px", color: highlightBlue

takeNotesSelectCandidateDoneBtn = new Layer
	width: 110, height: 40, x: 640, y: 67
	backgroundColor: "transparent"
	visible: false
	parent: navBar
	html: "Done"
takeNotesSelectCandidateDoneBtn.style = fontSize: "36px", color: highlightBlue

alertStatusDoneBtn = new Layer
	width: 110, height: 40, x: 640, y: 67
	backgroundColor: "transparent"
	visible: false
	parent: navBar
	html: "Done"
alertStatusDoneBtn.style = fontSize: "36px", color: highlightBlue

alertStatusSaveBtn = new Layer
	width: 110, height: 40, x: 640, y: 67
	backgroundColor: "transparent"
	visible: false
	parent: navBar
	html: "Save"
alertStatusSaveBtn.style = fontSize: "36px", color: highlightBlue

codePicSaveBtn = new Layer
	width: 110, height: 40, x: 640, y: 67
	backgroundColor: "transparent"
	visible: false
	parent: navBar
	html: "Save"
codePicSaveBtn.style = fontSize: "36px", color: highlightBlue
	
sortIcon = new Layer
	width: 35, height: 32, x: 680, y: 65
	image: "images/sortIcon.png"
	parent: navBar
	highlight: true
	
sortClose = new Layer
	width: 70, height: 70, y: 50, x: 660
	backgroundColor: "transparent"
	parent: navBar
	visible: false
	highlight: true
	
popoverArrow = new Layer
	width: 35, height: 18, y: 131, x: 680
	image: "images/popoverArrow.png"
	parent: navBar
	visible: false
	
#–––––––––––––––––––––––––––––––––––––––––––––#
#             TAB BAR MENU UI                 #
#–––––––––––––––––––––––––––––––––––––––––––––#
tabBar = new Layer
	width: Screen.width, height: 100, y: 1233
	backgroundColor: "white"
	shadowY: -1
	shadowBlur: 1
	shadowColor: "rgba(0,0,0,0.2)"
	
codePicBtn = new Layer
	width: 150, height: 100, x: 0
	backgroundColor: "transparent"
	parent: tabBar
	
cameraIcon = new Layer
	width: 50, height: 38, y: 15, x: 50
	image: "images/cameraIcon.svg"
	parent: tabBar
	visible: true
	
cameraIconBlue = new Layer
	width: 50, height: 38, y: 15, x: 50
	image: "images/cameraIconBlue.svg"
	parent: tabBar
	visible: false
	
codePicTab = new Layer
	y: 62, x: 20
	backgroundColor: "transparent"
	html: "Code Pics"
	parent: tabBar
codePicTab.style = color: light30, fontSize: "24px"

notesBtn = new Layer
	width: 150, height: 100, x: 150
	backgroundColor: "transparent"
	parent: tabBar

notesIcon = new Layer
	width: 33, height: 42, y: 12, x: 210
	image: "images/notesIcon.svg"
	parent: tabBar
	visible: true
	
notesIconBlue = new Layer
	width: 33, height: 42, y: 12, x: 210
	image: "images/notesIconBlue.svg"
	parent: tabBar
	visible: false
	
notesTab = new Layer
	y: 62, x: 195
	backgroundColor: "transparent"
	html: "Notes"
	parent: tabBar
notesTab.style = color: light30, fontSize: "24px"

interviewsBtn = new Layer
	width: 150, height: 100, x: 300
	backgroundColor: "transparent"
	parent: tabBar

personIcon = new Layer
	width: 40, height: 44, y: 12, x: 355
	image: "images/personIcon.svg"
	parent: tabBar
	visible: false
	
personIconBlue = new Layer
	width: 40, height: 44, y: 12, x: 355
	image: "images/personIconBlue.svg"
	parent: tabBar
	visible: true
	
interviewsTab = new Layer
	y: 62, x: 320
	backgroundColor: "transparent"
	html: "Interviews"
	parent: tabBar
interviewsTab.style = color: highlightBlue, fontSize: "24px"

alertsBtn = new Layer
	width: 150, height: 100, x: 450
	backgroundColor: "transparent"
	parent: tabBar
# 
alertsIcon = new Layer
	width: 47, height: 40, y: 12, x: 505
	image: "images/alertIcon.svg"
	parent: tabBar
	visible: true
	
alertsIconBlue = new Layer
	width: 47, height: 40, y: 12, x: 505
	image: "images/alertIconBlue.svg"
	parent: tabBar
	visible: false
	
alertsTab = new Layer
	y: 62, x: 500
	backgroundColor: "transparent"
	html: "Alerts"
	parent: tabBar
alertsTab.style = color: light30, fontSize: "24px"

moreBtn = new Layer
	width: 150, height: 100, x: 600
	backgroundColor: "transparent"
	parent: tabBar

moreIcon = new Layer
	width: 40, height: 26, y: 22, x: 650
	image: "images/moreIcon.svg"
	parent: tabBar
	visible: true
	
moreTab = new Layer
	y: 62, x: 645
	backgroundColor: "transparent"
	html: "More"
	parent: tabBar
moreTab.style = color: light30, fontSize: "24px"
	
#–––––––––––––––––––––––––––––––––––––––––––––––––#
#                  TIME WIDGET                    #
#–––––––––––––––––––––––––––––––––––––––––––––––––#
today = new Date
weekday = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
todaysTime = today.getTime()
day = today.getDate()
dayFuture = today.getDate() + 2
year = today.getFullYear()
hours = today.getHours()
minutes = today.getMinutes()
dayOfWeek = weekday[today.getDay()]
dayOfWeekFuture = weekday[today.getDay() + 2]
month = months[today.getMonth()]
ender =
if day == 1 or day == 21 or day == 31 then ender = 'st'
else if day == 2 or day == 22 then ender = 'nd'
else if day == 3 or day == 23 then ender = 'rd'
else ender = 'th'

ampm = if hours >= 12 then 'pm' else 'am'
hours = hours % 12
hours = if hours then hours else 12
# the hour '0' should be '12'
minutes = if minutes < 10 then '0' + minutes else minutes
strTime = hours + ':' + minutes + ' ' + ampm
strDateFull = dayOfWeek + ', ' + month + ' ' + day + ender + ' '
strDay = dayOfWeek
strDate = ', ' + month + ' ' + day + ender
strDateFuture = ', ' + month + ' ' + dayFuture + ender
# strFullDate = dayOfWeek + ', ' + month + ' ' + day + ender + ', ' + year + ' ' + strTime + ' PST'

realClock = new Layer
	width: Screen.width, height: 30, y: 7
	backgroundColor: "transparent"
	html: strTime
	parent: navBar
realClock.style = fontSize: "24px", color: "white", textAlign: "center", lineHeight: "24px"

#–––––––––––––––––––––––––––––––––––––––––––––#
#               SETTINGS MENU                 #
#–––––––––––––––––––––––––––––––––––––––––––––#
settingsContainer = new Layer
	width: Screen.width, height: Screen.height, y: 1334
	backgroundColor: light02
	visible: false

searchField = new Layer
	width: 598, height: 56, y: 55, x: 20
	image: "images/searchField.svg"
	parent: navBar
	visible: false

searchDoneBtn = new Layer
	width: 110, height: 40, x: 640, y: 67
	backgroundColor: "transparent"
	visible: false
	parent: navBar
	html: "Done"
searchDoneBtn.style = fontSize: "36px", color: "white"

settingsMenu = new Layer
	width: Screen.width, height: 853
	image: "images/settingsMenu.png"
	parent: settingsContainer
	
#–––––––––––––––––––––––––––––––––––––––––––––––––#
#                  SORT MENU OPEN                 #
#–––––––––––––––––––––––––––––––––––––––––––––––––#
sortIcon.on Events.TouchEnd, ->
	popoverArrow.visible = true
	popoverArrow.animate
		properties: y: 115
		curve: animateIn
	sortMask.visible = true
	sortMask.animate
		properties: y: navBar.height
		curve: animateIn
	sortClose.visible = true
	
#––––––––––––––––––––––––––––––––––––––––––––––––#
#                SORT MENU CLOSED                #
#––––––––––––––––––––––––––––––––––––––––––––––––#
sortClose.on Events.TouchEnd, ->
	popoverArrow.animate
		properties: y: 131
		curve: animateOut
	sortMask.animate
		properties: y: -483
		curve: animateOut
	@.visible = false
	Utils.delay 0.08, ->
		sortMask.visible = false
		popoverArrow.visible = false

#––––––––––––––––––––––––––––––––––––––––––––#
#                  DATE BARS                 #
#––––––––––––––––––––––––––––––––––––––––––––#
dayOneDateBar = new Layer
	width: Screen.width, height: 60, y: -5
	backgroundColor: "transparent"
	parent: scrollList.content
	html: '<p class="light50Lg">' + '<b>' + strDay + '</b>' + strDate + '</p>'
dayOneDateBar.style = 
	paddingTop: "24px", paddingLeft: "28px"
	
dayTwoDateBar = new Layer
	width: Screen.width, height: 60, y: 390
	backgroundColor: "transparent"
	parent: scrollList.content
	html: '<p class="light50Lg">' + '<b>' + dayOfWeekFuture + '</b>' + strDateFuture + '</p>'
dayTwoDateBar.style = 
	paddingTop: "24px", paddingLeft: "28px"	
	
# ––––––––––––––––––––––––––––––––––––––––––––––––#
#           DYNAMIC CANDIDATE LIST VIEW           #
# ––––––––––––––––––––––––––––––––––––––––––––––––#
# CANDIDATE DATA
candidateData = JSON.parse Utils.domLoadDataSync "candidates.json"
# for candidate, i in candidateData
# 	candidateData[i] = new Layer
# 		width: Screen.width, height: 90, y: 91 * i + 90
# 		backgroundColor:"white"
# 		parent: candidateListScroll.content
# 		shadowY: 1
# 		shadowBlur: 1
# 		shadowColor: "rgba(0,0,0,0.2)"
			
for candidate, i in candidateData
	candidateData[i] = new Layer
		width: Screen.width, height: 160, y: 161 * i + 74
		backgroundColor:"white"
		parent: scrollList.content
		shadowY: 1
		shadowBlur: 1
		shadowColor: "rgba(0,0,0,0.2)"
		
	candidateData[i].name = candidate.name
	candidateData[i].firstName = candidate.firstName
	candidateData[i].lastName = candidate.lastName
	candidateData[i].title1 = candidate.title1
	candidateData[i].title2 = candidate.title2
	candidateData[i].title3 = candidate.title3
	candidateData[i].location = candidate.location
	candidateData[i].role = candidate.role
	candidateData[i].room = candidate.room
	candidateData[i].date = candidate.date
	candidateData[i].time = candidate.time
	candidateData[i].address = candidate.address
	candidateData[i].phone = candidate.phone
	candidateData[i].email = candidate.email
	candidateData[i].university1 = candidate.university1
	candidateData[i].university2 = candidate.university2
	candidateData[i].university3 = candidate.university3
	candidateData[i].degree1 = candidate.degree1
	candidateData[i].degree2 = candidate.degree2
	candidateData[i].degree3 = candidate.degree3
	candidateData[i].years1 = candidate.years1
	candidateData[i].years2 = candidate.years2
	candidateData[i].years3 = candidate.years3
	candidateData[i].pic = candidate.pic
	candidateData[i].linkedin = candidate.linkedin
	candidateData[i].position = candidate.position
	candidateData[i].recruiter = candidate.recruiter
	candidateData[i].coordinator = candidate.coordinator
	candidateData[i].interviewer = candidate.interviewer
	candidateData[i].company1 = candidate.company1
	candidateData[i].company2 = candidate.company2
	candidateData[i].company3 = candidate.company3
	candidateData[i].c1years = candidate.c1years
	candidateData[i].c2years = candidate.c2years
	candidateData[i].c3years = candidate.c3years
	
	# creates the list view break between the two interviwing dates
	if candidateData.push > candidateData[1]
		candidateData[2].y = 470
		candidateData[3].y = 632
		candidateData[4].y = 794
		candidateData[5].y = 956
		candidateData[6].y = 1118
		
	# create the candidate photos
	candidatePic = new Layer
		width: 110, height: 110, x: 30, y: 25
		backgroundColor: "transparent"
		parent: candidateData[i]
		image: candidate.pic

	# create the candidate titles
	candidateLabel = new Layer
		width: 110, height: 30, x: 160, y: 25
		backgroundColor: "transparent"
		html: '<p class="light20Sm">Candidate</p>'
		parent: candidateData[i]
	candidateLabel.style = fontSize: "24px", color: light20
	 
	# create the candidate name that goes in the interview tab
	candidateName = new Layer
		width: name.width * 2, height: 40, x: 160, y: 60
		backgroundColor: "transparent"
		parent: candidateData[i]
		html:'<p class="light50Lg">' + candidate.name + '</p>'
	candidateName.style = fontSize: "32px", color: light50
	
# 	create the select candidate name list for the code pic save
# 	candidateNameList = new Layer
# 		width: name.width * 2, height: 40, x: 30, y: 27
# 		backgroundColor: "transparent"
# 		parent: candidateData[i]
# 		html:'<p class="light50Lg"><b>' + candidate.firstName + '</b> ' + candidate.lastName + '</p>'
# 	candidateNameList.style = fontSize: "32px", color: light50
	
	# create details line
	detailsLine = new Layer
		width: 600, height: 40, x: 160, y: 100
		backgroundColor: "transparent"
		parent: candidateData[i]
		html: '<span class="smallLink">' + candidate.room + '</span><span class="light20Sm">, Role: </span>' + '<span class="smallLink">' + candidate.role + '</span>'
	
	#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	#      GET TIME IN MS FROM CANDIDATE DATA AND FORMAT IT      #
	#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	secs = candidate.time / 1000 % 60
	mins = candidate.time / (1000 * 60) % 60
	hrs = candidate.time / (1000 * 60 * 60) % 12
	hrs = if hrs then hrs else 12
	mins = if mins < 10 then '0' + mins else mins
	msTime = hrs + ":" + mins + " " + ampm
	#print msTime

	# interview time indicator
	interviewTime = new Layer
		width: 150, height: 40, x: 570, y: 50
		backgroundColor: "transparent"
		parent: candidateData[i]
		html: msTime
	interviewTime.style = color: highlightBlue, fontSize: "32px", textAlign: "right"
	
	#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	#      GET TIME IN MS, CALCULATE DIFFERENCE AND FORMAT IT      #
	#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	date = new Date
	todaysDate = date.getHours()
	horas = todaysDate - candidate.time / (1000 * 60 * 60) % 12
	horas = if horas then horas else 12
	minutos = todaysDate - candidate.time / (1000 * 60) % 60
	minutos = if minutos < 10 then '0' + minutos else minutos
	interviewInTime = horas + ":" + minutos
	#print interviewInTime

	# "interview in" time indicator
	interviewIn = new Layer
		width: 200, height: 30, x: 520, y: 82
		backgroundColor: "transparent"
		parent: candidateData[i]
	interviewIn.html = '<span class="light20Sm">in </span><span class="light20Sm">' + horas + '</span><span class="light20Sm"> hrs</span>'
	interviewIn.style = textAlign: "right"
			
	#––––––––––––––––––––––––––––––––––––––––––––––––––#
	#      CANDIDATE PROFILE SEGMENTED NAVIGATION      #
	#––––––––––––––––––––––––––––––––––––––––––––––––––#
	segmentedNav = new Layer
		width: Screen.width, height: 90, y: navBar.height - 1
		backgroundColor: "transparent"
		visible: false
		
	secNavBd = new Layer
		width: Screen.width, height: 70, y: 10
		backgroundColor: light20
		parent: segmentedNav
	
	candidateBtn = new Layer
		width: 230, height: 90
		backgroundColor: light05
		parent: segmentedNav
	candidateBtn.html = "Candidate"
	candidateBtn.style = 
		fontSize: "30px", textAlign: "center", paddingTop: "30px", color: light30
		
	interviewDetailsBtn = new Layer
		width: 290, height: 90, x: 231
		backgroundColor: light05
		parent: segmentedNav
	interviewDetailsBtn.html = "Interview Details"
	interviewDetailsBtn.style =
		fontSize: "30px", textAlign: "center", paddingTop: "30px", color: light30
		
	myinterviewDetailsBtn = new Layer
		width: 230, height: 90, x: 522
		backgroundColor: light05
		parent: segmentedNav
	myinterviewDetailsBtn.html = "My Interview"
	myinterviewDetailsBtn.style =
		fontSize: "30px", textAlign: "center", paddingTop: "30px", color: light30
		
	#––––––––––––––––––––––––––––––––––––––––––––––––––#
	#       SEGMENTED NAVIGATION CANDIDATE BUTTON      #
	#––––––––––––––––––––––––––––––––––––––––––––––––––#
	candidateBtn.on Events.TouchEnd, ->
		candidateBtn.color = fbBlue
		interviewDetailsBtn.color = light30
		myinterviewDetailsBtn.color = light30
		scrollCandidateDetails.animate
			properties: x: 0
			curve: animateIn
		scrollInterviewDetails.animate
			properties: x: 750
			curve: animateOut
		scrollMyInterview.animate
			properties: x: 1500
			curve: animateOut
		
	#–––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	#      SEGMENTED NAVIGATION INTERVIEW DETAILS BUTTON      #
	#–––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	interviewDetailsBtn.on Events.TouchEnd, ->
		candidateBtn.color = light30
		interviewDetailsBtn.color = fbBlue
		myinterviewDetailsBtn.color = light30
		scrollCandidateDetails.animate
			properties: x: -750
			curve: animateOut
		scrollInterviewDetails.animate
			properties: x: 0
			curve: animateIn
		scrollMyInterview.animate
			properties: x: 750
			curve: animateOut
		
	#––––––––––––––––––––––––––––––––––––––––––––––––––––#
	#      SEGMENTED NAVIGATION MY INTERVIEW BUTTON      #
	#––––––––––––––––––––––––––––––––––––––––––––––––––––#
	myinterviewDetailsBtn.on Events.TouchEnd, ->
		candidateBtn.color = light30
		interviewDetailsBtn.color = light30
		myinterviewDetailsBtn.color = fbBlue
		scrollCandidateDetails.animate
			properties: x: -1500
			curve: animateOut
		scrollInterviewDetails.animate
			properties: x: -750
			curve: animateOut
		scrollMyInterview.animate
			properties: x: 0
			curve: animateIn
	
	#–––––––––––––––––––––––––––––––––––––––––#
	#            SCROLL CONTAINERS            #
	#–––––––––––––––––––––––––––––––––––––––––#
	# candidate details scroll
	scrollCandidateDetails = new ScrollComponent
		width: Screen.width, height: Screen.height, x: 750
		backgroundColor: light02
	scrollCandidateDetails.scrollHorizontal = false
	scrollCandidateDetails.y = navBar.height + segmentedNav.height
	scrollCandidateDetails.contentInset = bottom: 300
	
	# interview details scroll
	scrollInterviewDetails = new ScrollComponent
		width: Screen.width, height: Screen.height, x: 750
		backgroundColor: light02
	scrollInterviewDetails.scrollHorizontal = false
	scrollInterviewDetails.y = navBar.height + segmentedNav.height
	scrollInterviewDetails.contentInset = bottom: 320
	
	# my interview details scroll
	scrollMyInterview = new ScrollComponent
		width: Screen.width, height: Screen.height, x: 1500
		backgroundColor: light02
	scrollMyInterview.scrollHorizontal = false
	scrollMyInterview.y = navBar.height + segmentedNav.height
	scrollMyInterview.contentInset = bottom: 230
	
	# camera roll scroll
	scrollCameraRoll = new ScrollComponent
		width: Screen.width, height: Screen.height
		backgroundColor: "white"
		visible: false
	scrollCameraRoll.scrollHorizontal = false
	scrollCameraRoll.y = navBar.y
	scrollCameraRoll.contentInset = bottom: -550

	#–––––––––––––––––––––––––––––––––––––––#
	#        DYNAMIC NAV BAR HEADER         #
	#–––––––––––––––––––––––––––––––––––––––#	
	candidateHeader = new Layer
		width: Screen.width, height: 40, y: 65
		backgroundColor: "transparent"
		visible: false
	candidateHeader.style = textAlign: "center"
	
	cameraRollHeader = new Layer
		width: Screen.width, height: 40, y: 65
		backgroundColor: "transparent"
		visible: false
	cameraRollHeader.style = textAlign: "center"
	
	takeNotesHeader = new Layer
		width: Screen.width, height: 40, y: 65
		backgroundColor: "transparent"
		visible: false
	takeNotesHeader.style = textAlign: "center"
	
	codePicHeader = new Layer
		width: Screen.width, height: 40, y: 65
		backgroundColor: "transparent"
		visible: false
	codePicHeader.style = textAlign: "center"
	
	selectCandidateHeader = new Layer
		width: Screen.width, height: 40, y: 65
		backgroundColor: "transparent"
		visible: false
	selectCandidateHeader.style = textAlign: "center"
	
	alertStatusHeader = new Layer
		width: Screen.width, height: 40, y: 65
		backgroundColor: "transparent"
		visible: false
	alertStatusHeader.style = textAlign: "center"
	
	#–––––––––––––––––––––––––––––––––––––––––#
	#      CANDIDATE PROFILE BACK BUTTON      #
	#–––––––––––––––––––––––––––––––––––––––––#
	backBtn.on Events.TouchEnd, ->
		tabBar.visible = true
		tabBar.animate
			properties: y: 1233
			curve: animateIn
		dayOneDateBar.visible = true
		segmentedNav.visible = false
		@.visible = false
		backArrow.visible = false
		alertBtn.visible = false
		sortIcon.visible = true
		candidateHeader.visible = false
		initialHeader.visible = true
		scrollList.animate
			properties: x: 0
			curve: animateIn
		scrollCandidateDetails.animate
			properties: x: 750
			curve: animateOut
		scrollInterviewDetails.animate
			properties: x: 1500
			curve: animateOut
		scrollMyInterview.animate
			properties: x: 2250
			curve: animateOut
	
	#–––––––––––––––––––––––––––––––––––––––#
	#      CANDIDATE BUTTON FROM LIST       #
	#–––––––––––––––––––––––––––––––––––––––#
	scrolling = false
	candidateData[i].on Events.TouchStart, (event, layer) ->
		scrolling = false
	candidateData[i].on Events.TouchMove, (event, layer) ->
		scrolling = true
	candidateData[i].on Events.TouchEnd, (event, layer) ->
		if scrolling
			return false
		backArrow.visible = true
		backBtn.visible = true
		alertBtn.visible = true
		sortIcon.visible = false
		segmentedNav.visible = true
		initialHeader.visible = false
		candidateHeader.visible = true
		candidateBtn.color = fbBlue
		interviewDetailsBtn.color = light30
		myinterviewDetailsBtn.color = light30
		candidateHeader.html = layer.name
		scrollCandidateDetails.animate
			properties: x: 0
			curve: animateIn
		interviewsTab.color = highlightBlue
		scrollList.animate
			properties: x: -350
			curve: animateOut
		
		#–––––––––––––––––––––––––––––––––––––––––#
		#            CANDIDATE SCREEN             #
		#–––––––––––––––––––––––––––––––––––––––––#
		headerCard = new Layer
			width: Screen.width, height: 205, y: navBar.y
			backgroundColor: "white"
			parent: scrollCandidateDetails.content
			shadowY: 1
			shadowBlur: 1
			shadowColor: "rgba(0,0,0,0.2)"
			
		candidatePhoto = new Layer
			width: 100, height: 100, scale: 1.6, x: 70, y: 55
			backgroundColor: "transparent"
			parent: headerCard
			image: layer.pic
		
		candidateInfo = new Layer
			width: 600, height: 400, x: 220, y: 40
			backgroundColor: "transparent"
			parent: headerCard
		candidateInfo.html =
			'<div class="candidateHeader">
				<span class="light20Sm">Candidate</p>
				<p class ="lineAdjust05"></p>
					<div class="header">
						<p class="light50XLg">' + layer.name + '</p>
						<p class ="lineAdjust05"></p>
						<p class="light50Md">' + layer.title1 + '</p>
					</div>
			</div>'
			
		#––––––––––––––––––––––––––––––––––––––––––––#
		#         CANDIDATE ACTION BLUE BAR          #
		#––––––––––––––––––––––––––––––––––––––––––––#
		candidateActionBar = new Layer
			width: Screen.height, height: 130, y: segmentedNav.maxY - 13
			backgroundColor: fbBlue
			parent: scrollCandidateDetails.content
			
		resumeIconWhite = new Layer
			width: 34, height: 46, y: 20, x: 100
			image: "images/resumeIconWhite.svg"
			parent: candidateActionBar
			
		resumeIconLabel = new Layer
			y: 80, x: 60
			backgroundColor: "transparent"
			html: "Resume"
			parent: candidateActionBar
		resumeIconLabel.style = color: "white", fontSize: "30px"
			
		facebookIconWhite = new Layer
			width: 40, height: 40, y: 22, x: 350
			image: "images/facebookIconWhite.svg"
			parent: candidateActionBar
			
		facebookIconLabel = new Layer
			y: 80, x: 305
			backgroundColor: "transparent"
			html: "Facebook"
			parent: candidateActionBar
		facebookIconLabel.style = color: "white", fontSize: "30px"
			
		linkedinIconWhite = new Layer
			width: 40, height: 40, y: 22, x: 615
			image: "images/linkedinIconWhite.svg"
			parent: candidateActionBar
			
		linkedinIconLabel = new Layer
			y: 80, x: 575
			backgroundColor: "transparent"
			html: "LinkedIn"
			parent: candidateActionBar
		linkedinIconLabel.style = color: "white", fontSize: "30px"
			
		#–––––––––––––––––––––––––––––––––––––––––#
		#       CANDIDATE EDUCATION CARD          #
		#–––––––––––––––––––––––––––––––––––––––––#
		educationCard = new Layer
			width: Screen.height, height: 480
			backgroundColor: "white"
			parent: scrollCandidateDetails.content
			shadowY: 1
			shadowBlur: 1
			shadowColor: "rgba(0,0,0,0.2)"
		educationCard.y = headerCard.height + candidateActionBar.height
		
		educationIcon = new Layer
			width: 50, height: 33, x: 35, y: 35
			image: "images/educationIcon.svg"
			parent: educationCard
			
		universities1 = new Layer
			width: 640, height: 400, x: 100, y: 30
			backgroundColor: "transparent"
			parent: educationCard
		universities1.html =
			'<div class="candidateEducation">
				<span class="light20Sm">Education</p>
					<p class ="lineAdjust10"></p>
					<div class="universities">
						<p class="light50Md"><b>' + layer.university1 + '</b></p>
						<p class ="lineAdjust05"></p>
						<p class="light50Md">' + layer.degree1 + '</p>
						<p class ="lineAdjust05"></p>
						<p class="mediumGrey">' + layer.years1 + '</p>
					</div>
			</div>'
			
		divLine = new Layer
			width: 650, height: 2, x: 100, y: 190
			backgroundColor: light05
			parent: educationCard
			
		universities2 = new Layer
			width: 640, height: 400, x: 100, y: 210
			backgroundColor: "transparent"
			parent: educationCard
		universities2.html =
			'<div class="universities">
				<p class="light50Md"><b>' + layer.university2 + '</b></p>
				<p class ="lineAdjust05"></p>
				<p class="light50Md">' + layer.degree2 + '</p>
				<p class ="lineAdjust05"></p>
				<p class="mediumGrey">' + layer.years2 + '</p>
			</div>'
			
		divLine = new Layer
			width: 650, height: 2, x: 100, y: 330
			backgroundColor: light05
			parent: educationCard
	
		universities3 = new Layer
			width: 640, height: 400, x: 100, y: 350
			backgroundColor: "transparent"
			parent: educationCard
		universities3.html =
			'<div class="universities">
				<p class="light50Md"><b>' + layer.university3 + '</b></p>
				<p class ="lineAdjust05"></p>
				<p class="light50Md">' + layer.degree3 + '</p>
				<p class ="lineAdjust05"></p>
				<p class="mediumGrey">' + layer.years3 + '</p>
			</div>'
		
		#–––––––––––––––––––––––––––––––––––––––––#
		#       CANDIDATE EXPERIENCE CARD         #
		#–––––––––––––––––––––––––––––––––––––––––#
		experienceCard = new Layer
			width: Screen.height, height: 520
			backgroundColor: "white"
			parent: scrollCandidateDetails.content
			shadowY: 1
			shadowBlur: 1
			shadowColor: "rgba(0,0,0,0.2)"
			y: headerCard.height + candidateActionBar.height + educationCard.height + 10
		
		portfolioIcon = new Layer
			width: 42, height: 34, x: 40, y: 35
			image: "images/portfolioIcon.svg"
			parent: experienceCard
		
		companies1 = new Layer
			width: 640, height: 400, x: 100, y: 30
			backgroundColor: "transparent"
			parent: experienceCard
		companies1.html =
			'<div class="candidateExperience">
				<span class="light20Sm">Experience</p>
					<p class ="lineAdjust10"></p>
					<div class="companies">
						<p class="light50Md"><b>' + layer.company1 + '</b></p>
						<p class ="lineAdjust05"></p>
						<p class="light50Md">' + layer.title1 + '</p>
						<p class ="lineAdjust05"></p>
						<p class="mediumGrey">' + layer.c1years + '</p>
					</div>
			</div>'
			
		divLine = new Layer
			width: 650, height: 2, x: 100, y: 190
			backgroundColor: light05
			parent: experienceCard
			
		companies2 = new Layer
			width: 640, height: 400, x: 100, y: 210
			backgroundColor: "transparent"
			parent: experienceCard
		companies2.html =			
			'<div class="companies">
				<p class="light50Md"><b>' + layer.company2 + '</b></p>
				<p class ="lineAdjust05"></p>
				<p class="light50Md">' + layer.title2 + '</p>
				<p class ="lineAdjust05"></p>
				<p class="mediumGrey">' + layer.c2years + '</p>
			</div>'
			
		divLine = new Layer
			width: 650, height: 2, x: 100, y: 330
			backgroundColor: light05
			parent: experienceCard
			
		companies3 = new Layer
			width: 640, height: 400, x: 100, y: 350
			backgroundColor: "transparent"
			parent: experienceCard
		companies3.html =		
			'<div class="companies">
				<p class="light50Md"><b>' + layer.company3 + '</b></p>
				<p class ="lineAdjust05"></p>
				<p class="light50Md">' + layer.title3 + '</p>
				<p class ="lineAdjust05"></p>
				<p class="mediumGrey">' + layer.c3years + '</p>
			</div>'
		
		#––––––––––––––––––––––––––––––––––––––––#
		#       INTERVIEW DETAILS SCREEN         #
		#––––––––––––––––––––––––––––––––––––––––#
		interviewDetailsCard = new Layer
			width: Screen.width, height: 630, y: navBar.y + 70
			backgroundColor: "white"
			parent: scrollInterviewDetails.content
			shadowY: 1
			shadowBlur: 1
			shadowColor: "rgba(0,0,0,0.2)"
			
		interviewDetailsLabel = new Layer
			width: Screen.width, height: 60, y: 20
			backgroundColor: "transparent"
			parent: scrollInterviewDetails.content
		interviewDetailsLabel.html = "Interview Details"
		interviewDetailsLabel.style = 
			fontSize: "30px", paddingLeft: "28px", color:light50
			
		loopIcon = new Layer
			width: 44, height: 35, y: 40, x: 30
			image: "images/loopIcon.svg"
			parent: interviewDetailsCard
			
		interviewDetails1 = new Layer
				width: 640, height: 70, x: 100, y: 20
				backgroundColor: "transparent"
				parent: interviewDetailsCard
		interviewDetails1.html =
			'<div class="candidateExperience">
				<span class="light20Sm">Interview Type</p>
					<div class="interviewDetails">
						<p class="light50Md"><b>Full Interview Loop</b></p>
					</div>
			</div>'
			
		divLine = new Layer
			width: 650, height: 2, x: 100, y: 105
			backgroundColor: light05
			parent: interviewDetailsCard
			
		roleIcon = new Layer
			width: 44, height: 42, y: 138, x: 30
			image: "images/roleIcon.svg"
			parent: interviewDetailsCard
			
		interviewDetails2 = new Layer
			width: 640, height: 70, x: 100, y: 125
			backgroundColor: "transparent"
			parent: interviewDetailsCard
		interviewDetails2.html =
			'<div class="candidateExperience">
				<span class="light20Sm">Interview Role</p>
					<div class="interviewDetails">
						<p class="light50Md"><b>' + layer.role + '</b></p>
					</div>
			</div>'
			
		divLine = new Layer
			width: 650, height: 2, x: 100, y: 210
			backgroundColor: light05
			parent: interviewDetailsCard
			
		candidateIcon = new Layer
			width: 40, height: 42, y: 243, x: 30
			image: "images/candidateIcon.svg"
			parent: interviewDetailsCard
			
		interviewDetails3 = new Layer
			width: 640, height: 70, x: 100, y: 230
			backgroundColor: "transparent"
			parent: interviewDetailsCard
		interviewDetails3.html =
			'<div class="candidateExperience">
				<span class="light20Sm">Candidate Name</p>
					<div class="interviewDetails">
						<p class="mediumLink">' + layer.name + '</p>
					</div>
			</div>'
			
		divLine = new Layer
			width: 650, height: 2, x: 100, y: 315
			backgroundColor: light05
			parent: interviewDetailsCard
			
		positionIcon = new Layer
			width: 40, height: 37, y: 350, x: 30
			image: "images/positionIcon.svg"
			parent: interviewDetailsCard
			
		interviewDetails4 = new Layer
			width: 640, height: 70, x: 100, y: 335
			backgroundColor: "transparent"
			parent: interviewDetailsCard
		interviewDetails4.html =
			'<div class="candidateExperience">
				<span class="light20Sm">Position</p>
					<div class="interviewDetails">
						<p class="light50Md"><b>' + layer.position + '</b></p>
					</div>
			</div>'
			
		divLine = new Layer
			width: 650, height: 2, x: 100, y: 420
			backgroundColor: light05
			parent: interviewDetailsCard
			
		calendarIcon = new Layer
			width: 36, height: 42, y: 450, x: 30
			image: "images/calendarIcon.svg"
			parent: interviewDetailsCard
			
		interviewDetails5 = new Layer
			width: 640, height: 70, x: 100, y: 440
			backgroundColor: "transparent"
			parent: interviewDetailsCard
		interviewDetails5.html =
			'<div class="candidateExperience">	
				<span class="light20Sm">When</p>
					<div class="interviewDetails">
						<p class="light50Md"><b>' + strDateFull + '</b>' + strTime + '</p>
					</div>
			</div>'
			
		divLine = new Layer
			width: 650, height: 2, x: 100, y: 525
			backgroundColor: light05
			parent: interviewDetailsCard
			
		locationIcon = new Layer
			width: 28, height: 37, y: 550, x: 30
			image: "images/locationIcon.svg"
			parent: interviewDetailsCard
			
		interviewDetails6 = new Layer
			width: 640, height: 70, x: 100, y: 540
			backgroundColor: "transparent"
			parent: interviewDetailsCard
		interviewDetails6.html =
			'<div class="candidateExperience">
				<span class="light20Sm">Where</p>
					<div class="interviewDetails">
						<p class="mediumLink">' + layer.room + '</p>
					</div>
			</div>'
			
		#––––––––––––––––––––––––––––––––––––––––#
		#         POINT OF CONTACT CARD          #
		#––––––––––––––––––––––––––––––––––––––––#
		pointofContactCard = new Layer
			width: Screen.width, height: 200, y: 770
			backgroundColor: "white"
			parent: scrollInterviewDetails.content
			shadowY: 1
			shadowBlur: 1
			shadowColor: "rgba(0,0,0,0.2)"
			
		pointofContactLabel = new Layer
			width: Screen.width, height: 60, y: 723
			backgroundColor: "transparent"
			parent: scrollInterviewDetails.content
		pointofContactLabel.html = "Point of Contact"
		pointofContactLabel.style = 
			fontSize: "30px", paddingLeft: "28px", color:light50
			
		candidateIcon = new Layer
			width: 40, height: 42, y: 35, x: 30
			image: "images/candidateIcon.svg"
			parent: pointofContactCard
			
		pointofContact1 = new Layer
			width: 640, height: 70, x: 100, y: 20
			backgroundColor: "transparent"
			parent: pointofContactCard
		pointofContact1.html =
			'<div class="candidateExperience">
				<span class="light20Sm">Primary Recruiter</p>
					<div class="interviewDetails">
						<p class="mediumLink">' + layer.recruiter + '</p>
					</div>
			</div>'
			
		divLine = new Layer
			width: 650, height: 2, x: 100, y: 100
			backgroundColor: light05
			parent: pointofContactCard
			
		candidateIcon = new Layer
			width: 40, height: 42, y: 130, x: 30
			image: "images/candidateIcon.svg"
			parent: pointofContactCard
					
		pointofContact2 = new Layer
			width: 640, height: 70, x: 100, y: 115
			backgroundColor: "transparent"
			parent: pointofContactCard
		pointofContact2.html =
			'<div class="candidateExperience">
				<span class="light20Sm">Coordinator</p>
					<div class="interviewDetails">
						<p class="mediumLink">' + layer.coordinator + '</p>
					</div>
			</div>'
		
		#––––––––––––––––––––––––––––––––––––––––#
		#         COORDINATOR NOTES CARD         #
		#––––––––––––––––––––––––––––––––––––––––#
		coordinatorNotesCard = new Layer
			width: Screen.width, height: 300, y: 1040
			backgroundColor: "white"
			parent: scrollInterviewDetails.content
			shadowY: 1
			shadowBlur: 1
			shadowColor: "rgba(0,0,0,0.2)"
		
		coordinatorNotesLabel = new Layer
			width: Screen.width, height: 60, y: 993
			backgroundColor: "transparent"
			parent: scrollInterviewDetails.content
		coordinatorNotesLabel.html = "Coordinator Notes"
		coordinatorNotesLabel.style = fontSize: "30px", paddingLeft: "28px", color: light50
			
		coordinatorNotes = new Layer
				width: 640, height: 250, x: 40, y: 30
				backgroundColor: "transparent"
				parent: coordinatorNotesCard
		coordinatorNotes.html = 
			'<span class="light50Md">
				Hi </span><span class="light50Md">' + layer.interviewer + '</span><span class="light50Md">!
			</span>
			<div class="coordinatorNotes">
				<p class ="lineAdjust20"></p>
				<div class="interviewDetails">
					<p class="light50Md">Please let me know if you know if you can take this interview. This is half FEE/ENT loop. I know you are offline but Sara has asked that you take this. Thanks so much in advance!</p>
				</div>
			</div>
			<p class ="lineAdjust20"></p>
			<span class="light50Md">
				- </span><span class="light50Md">' + layer.recruiter + '</span><span class="light50Md">
			</span>'
			
		#–––––––––––––––––––––––––––––––––––––––#
		#       PREVIOUS QUESTIONS CARD         #
		#–––––––––––––––––––––––––––––––––––––––#
		previousQuestionsCard = new Layer
			width: Screen.width, height: 225, y: 1410
			backgroundColor: "white"
			parent: scrollInterviewDetails.content
			shadowY: 1
			shadowBlur: 1
			shadowColor: "rgba(0,0,0,0.2)"
			
		previousQuestionsLabel = new Layer
			width: Screen.width, height: 60, y: 1360
			backgroundColor: "transparent"
			parent: scrollInterviewDetails.content
		previousQuestionsLabel.html = "Previous Questions Asked"
		previousQuestionsLabel.style = fontSize: "30px", paddingLeft: "28px", color: light50
		
		previousQuestions = new Layer
				width: 640, height: 250, x: 40, y: 30
				backgroundColor: "transparent"
				parent: previousQuestionsCard
		previousQuestions.html = 
			'<div class="previousQuestionsAsked">
				<ol class="light50Md">
					<li>Given an array of non negative integers and a  number N, find a length of shortest subarray sum of whose all elements is N</li>
					<li>Longest increasing sub sequence</li>
				</ol>
			</div>'
		
		#––––––––––––––––––––––––––––––––––––––#
		#         MY INTERVIEW SCREEN          #
		#––––––––––––––––––––––––––––––––––––––#
		notesCard = new Layer
			width: Screen.width, height: 490, y: navBar.y + 70
			backgroundColor: "white"
			parent: scrollMyInterview.content
			shadowY: 1
			shadowBlur: 1
			shadowColor: "rgba(0,0,0,0.2)"
		
		notesLabel = new Layer
			width: Screen.width, height: 60, y: 20
			backgroundColor: "transparent"
			parent: scrollMyInterview.content
		notesLabel.html = "My Notes"
		notesLabel.style = 
			fontSize: "30px", paddingLeft: "28px", color: light50
			
		notes = new Layer
				width: 680, height: 250, x: 40, y: 40
				backgroundColor: "transparent"
				parent: notesCard
		notes.html =
			'<div class="coordinatorNotes">
				<ul class="light50Md"><li>Was pretty good in the interview.</li></ul>
				<p class ="lineAdjust20"></p>
				<ul class="light50Md"><li>Currently a 3rd year student looking for an internship and also told about the courses he is taking up.</li></ul>
				<p class ="lineAdjust20"></p>
				<ul class="light50Md"><li>Confident throughout and seems to have good coding skills.</li></ul>
				<p class ="lineAdjust20"></p>
				<p class="light50Md">Alexander seems able to work independently without his manager constantly driving him. He was able to resolve conflict with coworker using caution and data (in favor of coworker). Overall, leaning hire for Harshal due to the reasons listed above, although EE might not be the best fit.</p>
			</div>'
			
		#––––––––––––––––––––––––––––––––––––––#
		#         QUESTIONS ASKED CARD         #
		#––––––––––––––––––––––––––––––––––––––#
		questionsAskedCard = new Layer
			width: Screen.width, height: 220, y: 635
			backgroundColor: "white"
			parent: scrollMyInterview.content
			shadowY: 1
			shadowBlur: 1
			shadowColor: "rgba(0,0,0,0.2)"
			
		questionsAskedLabel = new Layer
			width: Screen.width, height: 60, y: 585
			backgroundColor: "transparent"
			parent: scrollMyInterview.content
		questionsAskedLabel.html = "Questions I Asked"
		questionsAskedLabel.style = 
			fontSize: "30px", paddingLeft: "28px", color: light50
				
		questions = new Layer
				width: 680, height: 250, x: 40, y: 30
				backgroundColor: "transparent"
				parent: questionsAskedCard
		questions.html =
			'<div class="coordinatorNotes">
				<ol class="light50Md">
					<li>What projects do you want to work on</li>
					<li>How do you resolve differences of opinion</li>
					<li>Matrix diagonals</li>
					<li>Longest palindrome</li>
				</ol>
			</div>'
			
		#––––––––––––––––––––––––––––––––––––#
		#           CODE PICS CARD           #
		#––––––––––––––––––––––––––––––––––––#
		codePicCard = new Layer
			width: Screen.width, height: 320, y: 930
			backgroundColor: "white"
			parent: scrollMyInterview.content
			shadowY: 1
			shadowBlur: 1
			shadowColor: "rgba(0,0,0,0.2)"
			
		codePicLabel = new Layer
			width: Screen.width, height: 60, y: 880
			backgroundColor: "transparent"
			parent: scrollMyInterview.content
			html: "Code Pics"
		codePicLabel.style = fontSize: "30px", paddingLeft: "28px", color: light50
			
		codeSnipet1 = new Layer
			width: 685, height: 60, x: 120, y: 30
			backgroundColor: "transparent"
			parent: codePicCard
		codeSnipet1.html =
			'<div class="candidateExperience">
				<span class="light50Md">Code Snipet q1</p>
					<div class="interviewDetails">
						<p class="light20Sm">711 KB</p>
					</div>
			</div>'
			
		codeSnipet1Thumb = new Layer
			width: 80, height: 80, y: 20, x: 20
			backgroundColor: "transparent"
			image: "images/snipet-q1.png"
			parent: codePicCard
			
		greyArrow = new Layer
			width: 18, height: 30, y: 40, x: 700
			image: "images/greyArrow.svg"
			parent: codePicCard
			
		divLine1 = new Layer
			width: 650, height: 2, x: 100, y: 110
			backgroundColor: light05
			parent: codePicCard
			
		codeSnipet2 = new Layer
			width: 685, height: 60, x: 120, y: 135
			backgroundColor: "transparent"
			parent: codePicCard
		codeSnipet2.html =
			'<div class="candidateExperience">
				<span class="light50Md">Code Snipet q2</p>
					<div class="interviewDetails">
						<p class="light20Sm">643 KB</p>
					</div>
			</div>'
			
		codeSnipet2Thumb = new Layer
			width: 80, height: 80, y: 125, x: 20
			backgroundColor: "transparent"
			image: "images/snipet-q2.png"
			parent: codePicCard
			
		greyArrow = new Layer
			width: 18, height: 30, y: 155, x: 700
			image: "images/greyArrow.svg"
			parent: codePicCard
			
		divLine2 = new Layer
			width: 650, height: 2, x: 100, y: 215
			backgroundColor: light05
			parent: codePicCard
			
		plusIconCodePics = new Layer
			width: 30, height: 30, x: 30, y: 250
			image: "images/plusIcon.svg"
			parent: codePicCard
			
		addAPicBtn = new Layer
			width: Screen.width, height: 100, y: 210
			backgroundColor: "transparent"
			parent: codePicCard
			
		addAPicBtn.on Events.TouchEnd, ->
			closeInterviewsScreen()
			openCameraRollScreen()
			
		addAPicLabel = new Layer
			width: 200, height: 40, x: 80, y: 250
			backgroundColor: "transparent"
			html: "Add a pic"
			parent: codePicCard
		addAPicLabel.style = fontSize: "30px", color: highlightBlue
			
	#–––––––––––––––––––––––––––––––––––––––#
	#           TAKE NOTES SCREEN           #
	#–––––––––––––––––––––––––––––––––––––––#
	takeNotesContainer = new Layer
		width: Screen.width, height: Screen.height, y: 1334
		backgroundColor: "white"
		visible: false
		
	takeNotesCandidateSelectorBar = new Layer
		width: Screen.width, height: 80, y: navBar.maxY
		backgroundColor: light02
		#parent: takeNotesContainer
		visible: false
		shadowY: -1
		shadowBlur: 1
		shadowColor: "rgba(0,0,0,0.1)"
	takeNotesCandidateSelectorBar.html = '<span class="largeGrey">Candidate: </span><span class="largeLink">' + candidate.name + '</span></span>'
	takeNotesCandidateSelectorBar.style = paddingTop: "26px", paddingLeft: "30px"
	
	takeNotesBlueArrow = new Layer
		width: 14, height: 23, y: 30, x: 700
		image: "images/blueArrow.svg"
		parent: takeNotesCandidateSelectorBar
		
# 	notesInput = new InputModule.Input
# 		setup: true
# 		virtualKeyboard: true
# 		placeholder: "Write your notes here"
# 		placeholderColor: light20
# 		type: "text"
# 		y: 30, x: 30
# 		width: 600, height: 40
# 		backgroundColor: "transparent"
# 		parent: takeNotesContainer
# 	notesInput.style = fontSize: "32px"
		
	emojiPanel = new Layer
		width: 750, height: 83, y: 610
		image: "images/emojiPanel.png"
		parent: takeNotesContainer
		
	keyboardNotes = new Layer
		width: Screen.width, height: 432, y: 690
		image: "images/keyboard.png"
		parent: takeNotesContainer
		
#–––––––––––––––––––––––––––––––––––––––––––––––#
#           CAMERA ROLL SQUARE GRID             #
#–––––––––––––––––––––––––––––––––––––––––––––––#
	squareContainer = new Layer
		width: Screen.width, height: Screen.height, y: 1334
		backgroundColor: "transparent"
		visible: false
		parent: scrollCameraRoll.content
		
	cameraIconLg = new Layer
		width: 85, height: 64, x: 80, y: 100, z: 10
		image: "images/cameraIconLg.svg"
		parent: squareContainer
	
	# Variables
	rows = 8
	cols = 3
	size = 243
	margin = 5
	
	# Mapping
	[1..rows].map (a) ->
		[1..cols].map (b) ->
			square = new Layer
				x: b * (size + margin) - 243
				y: a * (size + margin) - 243
				backgroundColor: light05
				width:  size 
				height: size
				borderRadius: 3
				parent: squareContainer
				
	codePic1 = new Layer
		width: 243, height: 243, y: 5, x: 253
		image: "images/codePic1.png"
		parent: squareContainer
		
	codePic2 = new Layer
		width: 243, height: 243, y: 5, x: 502
		image: "images/codePic2.png"
		parent: squareContainer
		
	codePic3 = new Layer
		width: 243, height: 243, y: 252, x: 4
		image: "images/codePic3.png"
		parent: squareContainer
		
	codePic4 = new Layer
		width: 243, height: 243, y: 252, x: 253
		image: "images/codePic4.png"
		parent: squareContainer
		
	codePic5 = new Layer
		width: 243, height: 243, y: 252, x: 502
		image: "images/codePic5.png"
		parent: squareContainer
		visible: false
		
	codePic5Selection = new Layer
		width: 243, height: 243, y: 252, x: 502
		image: "images/codePic5-selection.png"
		parent: squareContainer
		visible: false
		
#––––––––––––––––––––––––––––––––––––#
#           CAMERA SCREEN            #
#––––––––––––––––––––––––––––––––––––#
	cameraUIContainer = new Layer
		width: Screen.width, height: Screen.height, y: 1334
		backgroundColor: "black"
		visible: false
		
	codePicFull = new Layer
		width: 750, height: 1334
		image: "images/codePicFull.png"
		opacity: 0
		parent: cameraUIContainer
		
	cameraNavBar = new Layer
		width: Screen.width, height: 130
		backgroundColor: "#4A4A4A"
		opacity: 0.6
		visible: false
		parent: cameraUIContainer
		
	cameraUI = new Layer
		width: 681, height: 1233, y: 50
		image: "images/cameraUI.png"
		visible: false
		parent: cameraUIContainer
	cameraUI.centerX()
	
	shutterBtn = new Layer
		width: 150, height: 150, y: 1080
		backgroundColor: "transparent"
		parent: cameraUI
		borderRadius: 100
	shutterBtn.centerX()
	
	cameraClose = new Layer
		width: 70, height: 70, x: 20, y: 40
		backgroundColor: "transparent"
		parent: cameraNavBar
		
#–––––––––––––––––––––––––––––––––––––––––––#
#           CODE PIC SAVE SCREEN            #
#–––––––––––––––––––––––––––––––––––––––––––#
	codePicSaveContainer = new Layer
		width: Screen.width, height: Screen.height, y: 1334
		backgroundColor: "white"
		visible: false

	codePicCandidateSelectorBar = new Layer
		width: Screen.width, height: 80, y: navBar.maxY
		backgroundColor: light02
		#parent: codePicSaveContainer
		visible: false
		shadowY: -1
		shadowBlur: 1
		shadowColor: "rgba(0,0,0,0.1)"
	codePicCandidateSelectorBar.html = '<span class="largeGrey">Candidate: </span><span class="largeLink">' + candidate.name + '</span></span>'
	codePicCandidateSelectorBar.style = paddingTop: "26px", paddingLeft: "30px"
	
	checkIcon = new Layer
		width: 26, height: 19, y: 33, x: 680
		image: "images/checkIcon.svg"
		visible: false
		parent: candidateData[i]
		
	codePicBlueArrow = new Layer
		width: 14, height: 23, y: 30, x: 700
		image: "images/blueArrow.svg"
		parent: codePicCandidateSelectorBar
		
# 	codePicTitleInput = new InputModule.Input
# 		setup: true
# 		virtualKeyboard: true
# 		placeholder: "Add a title to this pic here"
# 		placeholderColor: light20
# 		type: "text"
# 		y: navBar.y + codePicCandidateSelectorBar.y - 30, x: 30
# 		width: 600, height: 40
# 		backgroundColor: "transparent"
# 		parent: codePicSaveContainer
# 	codePicTitleInput.style = fontSize: "32px"
	
	codePicImage = new Layer
		width: Screen.width, height: 1030, y: codePicCandidateSelectorBar.y + 50
		image: "images/codePicImage.png"
		parent: codePicSaveContainer
		
	keyboardCodePicSave = new Layer
		width: Screen.width, height: 432, y: 1770
		image: "images/keyboard.png"
		parent: codePicSaveContainer
		
#––––––––––––––––––––––––––––––––––––––––––#
#           ALERT STATUS SCREEN            #
#––––––––––––––––––––––––––––––––––––––––––#
	customAlertMessageBar = new Layer
		width: Screen.width, height: 90, y: 130
		backgroundColor: "white"
		visible: false
		shadowY: 1
		shadowBlur: 1
		shadowColor: "rgba(0,0,0,0.07)"  
		html: '<span class="largeLightGrey">Custom alert message</span>'
	customAlertMessageBar.style = paddingTop: "30px", paddingLeft: "75px"
	
	plusIconAlert = new Layer
		width: 30, height: 30, x: 30, y: 30
		image: "images/plusIcon.svg"
		parent: customAlertMessageBar
	
	# Data
	asDataOne = status: "Candidate running late"
	asDataTwo = status: "Candidate ready for next interviewer"
	asDataThree = status: "Candidate needs a bathroom break"
	asDataFour = status: "Candidate missing"
	asDataFive = status: "Interview running late"
	
	# Array	
	statusList = []
	
	# Push data into array
	statusList.push(asDataOne, asDataTwo, asDataThree, asDataFour, asDataFive)
	
	# Loop through array and populate list
	for result, i in statusList
		statusList[i] = new Layer
			width: Screen.width, height: 90, y: 91 * i
			backgroundColor:"white"
			parent: alertStatusScroll.content
			shadowY: 1
			shadowBlur: 1
			shadowColor: "rgba(0,0,0,0.1)"
			
		statusList[i].listIndex = i

		alertListItem = new Layer
			width: result.status.width * 2, height: 40, x: 30, y: 27
			backgroundColor: "transparent"
			parent: statusList[i]
			html:'<p class="light50Lg">' + result.status + '</p>'
		alertListItem.style = fontSize: "32px", color: light50
		
		statusList[i].status = result.status
		
		#––––––––––––––––––––––––––––––––––––––––––#
		#          CHECK ICON ON AND OFF           #
		#––––––––––––––––––––––––––––––––––––––––––#
		checkIconAlert = "images/checkIcon.svg"

		checkboxes = []

		checkboxesContainer = new Layer
			width: Screen.width, height: 450
			backgroundColor: "transparent"
			parent: alertStatusScroll
			
		for n in [0..4]
			checkbox = checkboxes[n] = new Layer
				parent: checkboxesContainer
				width: 28, height: 21, x: 680, y: 33 + (91 * n)
				name: "checkbox#{n}"
				#visible: false
				backgroundColor: "transparent"
				
			checkbox.on Events.TouchEnd, (event) ->
				if @.image is checkIconAlert
					@.image = ""
				else 
					@.image = checkIconAlert

#––––––––––––––––––––––––––––––––––––––––––#
#       CUSTOM ALERT STATUS SCREEN         #
#––––––––––––––––––––––––––––––––––––––––––#
	customAlertScreenContainer = new Layer
		width: Screen.width, height: Screen.height, y: 1334
		backgroundColor: "white"
		visible: false
		
# 	customAlertInput = new InputModule.Input
# 		setup: true
# 		virtualKeyboard: true
# 		placeholder: "Type your custom alert here"
# 		placeholderColor: light20
# 		type: "text"
# 		y: navBar.y + 30, x: 30
# 		width: 600, height: 40
# 		backgroundColor: "transparent"
# 		parent: customAlertScreenContainer
# 	customAlertInput.style = fontSize: "32px"
	
	keyboardCustomAlert = new Layer
		width: Screen.width, height: 432, y: 1334
		image: "images/keyboard.png"
		parent: customAlertScreenContainer

#–––––––––––––––––––––––––––––––––––––––––––––––#
#           TAB BAR ON/OFF FUNCTIONS            #
#–––––––––––––––––––––––––––––––––––––––––––––––#
	# /////// CODE PICS TAB ///////
	codePicBlueTabON = ->
		cameraIcon.visible = false
		cameraIconBlue.visible = true
		codePicTab.color = highlightBlue
		
	codePicGreyTabON = ->
		cameraIcon.visible = true
		cameraIconBlue.visible = false
		codePicTab.color = light30
	
	# /////// NOTES TAB ///////
	notesBlueTabON = ->
		notesIcon.visible = false
		notesIconBlue.visible = true
		notesTab.color = highlightBlue
		
	notesGreyTabON = ->
		notesIcon.visible = true
		notesIconBlue.visible = false
		notesTab.color = light30
		
	# /////// INTERVIEWS TAB ///////
	interviewsBlueTabON = ->
		personIcon.visible = false
		personIconBlue.visible = true
		interviewsTab.color = highlightBlue
		
	interviewsGreyTabON = ->
		personIcon.visible = true
		personIconBlue.visible = false
		interviewsTab.color = light30
		
	# /////// ALERTS TAB ///////
	alertsBlueTabON = ->
		alertsIcon.visible = false
		alertsIconBlue.visible = true
		alertsTab.color = highlightBlue
		
	alertsGreyTabON = ->
		alertsIcon.visible = true
		alertsIconBlue.video = false
		alertsTab.color = light30
		
#––––––––––––––––––––––––––––––––––––––––––––––#
#           OPEN INTERVIEWS SCREEN            #
#––––––––––––––––––––––––––––––––––––––––––––––#
	openInterviewsScreen = ->
		sortIcon.visible = true
		statusBarWhite.visible = true
		statusBarBlack.visible = false
		initialHeader.visible = true
		realClock.color = "white"
		navBar.backgroundColor = fbBlue
		scrollListLoad()
		tabBar.animate
			properties: y: 1233
			curve: animateIn
		interviewsBlueTabON()
		
	#––––––––––––––––––––––––––––––––––––––––––––––#
	#           CLOSE INTERVIEWS SCREEN            #
	#––––––––––––––––––––––––––––––––––––––––––––––#
	closeInterviewsScreen = ->
		sortIcon.visible = false
		statusBarWhite.visible = false
		statusBarBlack.visible = true
		initialHeader.visible = false
		realClock.color = "black"
		navBar.backgroundColor = light02
		Utils.delay .2, ->
			scrollList.visible = false
		scrollList.animate
			properties: y: 1334
			curve: animateOut
		tabBar.animate
			properties: y: 1334
			curve: animateOut
		interviewsGreyTabON()
			
	#––––––––––––––––––––––––––––––––––––––––––––––#
	#           OPEN CAMERA ROLL SCREEN            #
	#––––––––––––––––––––––––––––––––––––––––––––––#
	openCameraRollScreen = ->
# 		codePicCandidateSelectorBar.visible = false
		candidateHeader.visible = false
		backArrow.visible = false
		backBtn.visible = false
		cameraRollDoneBtn.visible = true
		cameraRollCancelBtn.visible = true
		scrollCameraRoll.visible = true
		scrollCameraRoll.animate
			properties: y: 130
			curve: animateIn
		cameraRollHeader.visible = true
		cameraRollHeader.html = '<span class="headerTitleGrey">Camera Roll</span>'
		squareContainer.visible = true
		squareContainer.animate
			properties: y: navBar.y
			curve: animateIn
			
	#––––––––––––––––––––––––––––––––––––––––––––––#
	#           CLOSE CAMERA ROLL SCREEN           #
	#––––––––––––––––––––––––––––––––––––––––––––––#
	closeCameraRollScreen = ->
		cameraRollCancelBtn.visible = false
		cameraRollDoneBtn.visible = false
		cameraRollHeader.visible = false
		scrollCameraRoll.animate
			properties: y: 1334
			curve: animateOut
		Utils.delay 0.2, ->
			scrollCameraRoll.visible = false
			squareContainer.visible = false
			
	#––––––––––––––––––––––––––––––––––––––––#
	#           OPEN NOTES SCREEN            #
	#––––––––––––––––––––––––––––––––––––––––#
	openNotesScreen = ->
		takeNotesCandidateSelectorBar.visible = true
		navBar.backgroundColor = light02
		cameraRollHeader.visible = false
		candidateHeader.visible = false
		backArrow.visible = false
		backBtn.visible = false
		takeNotesContainer.visible = true
		takeNotesContainer.animate
			properties: y: navBar.maxY + 85
			curve: animateIn
		takeNotesHeader.visible = true
		takeNotesHeader.html = '<span class="headerTitleBlack">Notes</span>'
		notesCancelBtn.visible = true
		notesDoneBtn.visible = true
		
#––––––––––––––––––––––––––––––––––––––––#
#           CLOSE NOTES SCREEN           #
#––––––––––––––––––––––––––––––––––––––––#
	closeNotesScreen = ->
		takeNotesCandidateSelectorBar.visible = false
		candidateHeader.visible = true
		takeNotesHeader.visible = false
		takeNotesContainer.animate
			properties: y: 1334
			curve: animateOut
		Utils.delay .2, ->
			takeNotesContainer.visible = false
		notesCancelBtn.visible = false
		notesDoneBtn.visible = false
		
#–––––––––––––––––––––––––––––––––––––––––––––––#
#           OPEN CODE PIC SAVE SCREEN           #
#–––––––––––––––––––––––––––––––––––––––––––––––#
	openCodePicSaveScreen = ->
		navBar.backgroundColor = light02
		codePicCandidateSelectorBar.visible = true
		codePicSaveBtn.visible = true
		codePicCancelBtn.visible = true
		tabBar.animate
			properties: y: 1334
			curve: animateOut
		Utils.delay .2, ->
			keyboardCodePicSave.animate
				properties: y: 770
				curve: animateIn
		codePicSaveContainer.visible = true
		codePicSaveContainer.animate
			properties: y: navBar.maxY
			curve: animateIn
		codePicHeader.visible = true
		codePicHeader.html = '<span class="headerTitleBlack">Code Pic</span>'
		
#––––––––––––––––––––––––––––––––––––––––––––––––#
#           CLOSE CODE PIC SAVE SCREEN           #
#––––––––––––––––––––––––––––––––––––––––––––––––#
	closeCodePicSaveScreen = ->
		codePicCandidateSelectorBar.visible = false
		codePicSaveBtn.visible = false
		codePicCancelBtn.visible = false
		keyboardCodePicSave.animate
			properties: y: 1334
			curve: animateIn
		Utils.delay .2, ->
			codePicSaveContainer.visible = true
		codePicSaveContainer.animate
			properties: y: 1334
			curve: animateIn
		codePicHeader.visible = false
		
	#––––––––––––––––––––––––––––––––––––––––––––––#
	#           OPEN ALERT STATUS SCREEN           #
	#––––––––––––––––––––––––––––––––––––––––––––––#
	openAlertStatusScreen = ->
		customAlertMessageBar.visible = true
		alertStatusCancelBtn.visible = true
		alertStatusDoneBtn.visible = true
		alertStatusHeader.visible = true
		alertStatusHeader.html = '<span class="headerTitleBlack">Alert Status</span>'
		alertStatusScroll.visible = true
		alertStatusScroll.animate
			properties: y: 220
			curve: animateIn
			
	#––––––––––––––––––––––––––––––––––––––––––––––#
	#           CLOSE ALERT STATUS SCREEN          #
	#––––––––––––––––––––––––––––––––––––––––––––––#
	closeAlertStatusScreen = ->
		customAlertMessageBar.visible = false
		alertStatusCancelBtn.visible = false
		alertStatusDoneBtn.visible = false
		alertStatusHeader.visible = false
		Utils.delay .2, ->
			alertStatusScroll.visible = true
		alertStatusScroll.animate
			properties: y: 1334
			curve: animateIn
		
	#–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	#      OPEN CANDIDATE LIST SELECTOR SCREEN FROM CODE PIC SCREEN       #
	#–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	openCodePicCandidateListSelector = ->
		codePicCandidateSelectorBar.visible = true
		codePicSelectCandidateDoneBtn.visible = true
		codePicSelectCandidateCancelBtn.visible = true
		selectCandidateHeader.visible = true
		selectCandidateHeader.html = '<span class="headerTitleBlack">Select Candidate</span>'
		candidateListScroll.visible = true
		candidateListScroll.animate
			properties: y: navBar.maxY
			curve: animateIn
			
	#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	#      CLOSE CANDIDATE LIST SELECTOR SCREEN FROM CODE PIC SREEN      #
	#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	closeCodePicCandidateListSelector = ->
		codePicCandidateSelectorBar.visible = false
		codePicSelectCandidateDoneBtn.visible = false
		codePicSelectCandidateCancelBtn.visible = false
		Utils.delay .2, ->
			candidateListScroll.visible = false
		candidateListScroll.animate
			properties: y: 1334
			curve: animateOut
		selectCandidateHeader.visible = false
			
	#–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	#      OPEN CANDIDATE LIST SELECTOR SCREEN FROM CODE PIC SCREEN       #
	#–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	openTakeNotesCandidateListSelector = ->
		takeNotesCandidateSelectorBar.visible = true
		takeNotesSelectCandidateDoneBtn.visible = true
		takeNotesSelectCandidateCancelBtn.visible = true
		selectCandidateHeader.visible = true
		selectCandidateHeader.html = '<span class="headerTitleBlack">Select Candidate</span>'
		candidateListScroll.visible = true
		candidateListScroll.animate
			properties: y: navBar.maxY
			curve: animateIn
		
	#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	#      CLOSE CANDIDATE LIST SELECTOR SCREEN FROM TAKE NOTES SREEN      #
	#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	closeTakeNotesCandidateListSelector = ->
		takeNotesCandidateSelectorBar.visible = false
		takeNotesSelectCandidateDoneBtn.visible = false
		takeNotesSelectCandidateCancelBtn.visible = false
		Utils.delay .2, ->
			candidateListScroll.visible = false
		candidateListScroll.animate
			properties: y: 1334
			curve: animateOut
		selectCandidateHeader.visible = false
			
	#––––––––––––––––––––––––––––––––––––––––––––––#
	#      OPEN CUSTOM ALERT MESSSAGE SCREEN       #
	#––––––––––––––––––––––––––––––––––––––––––––––#
	openCustomAlertMessageScreen = ->
		alertStatusBackBtn.visible = true
		backBlueArrow.visible = true
		alertStatusSaveBtn.visible = true
		alertStatusHeader.visible = true
		alertStatusHeader.html = '<span class="headerTitleBlack">Message</span>'
		customAlertScreenContainer.visible = true
		customAlertScreenContainer.animate
			properties: y: navBar.maxY
			curve: animateIn
		keyboardCustomAlert.animate
			properties: y: 770
			curve: animateIn
		
	#––––––––––––––––––––––––––––––––––––––––––––––#
	#      CLOSE CUSTOM ALERT MESSSAGE SCREEN      #
	#––––––––––––––––––––––––––––––––––––––––––––––#
	closeCustomAlertMessageScreen = ->
		alertStatusBackBtn.visible = false
		backBlueArrow.visible = false
		alertStatusSaveBtn.visible = false
		alertStatusHeader.visible = false
		Utils.delay .2, ->
			customAlertScreenContainer.visible = false
		customAlertScreenContainer.animate
			properties: y: 1334
			curve: animateOut
		keyboardCustomAlert.animate
			properties: y: 1334
			curve: animateOut
	
	#–––––––––––––––––––––––––––––––––––––#
	#      OPEN SETTINGS MENU SCREEN      #
	#–––––––––––––––––––––––––––––––––––––#
	openSettingsMenu = ->
		statusBarWhite.visible = true
		realClock.color = "white"
		navBar.visible = true
		navBar.backgroundColor = fbBlue
		sortIcon.visible = false
		searchDoneBtn.visible = true
		searchField.visible = true
		settingsContainer.visible = true
		settingsContainer.animate
			properties: y: navBar.maxY
			curve: animateIn
			
	#––––––––––––––––––––––––––––––––––––––#
	#      CLOSE SETTINGS MENU SCREEN      #
	#––––––––––––––––––––––––––––––––––––––#
	closeSettingsMenu = ->
		searchDoneBtn.visible = false
		searchField.visible = false
		settingsContainer.animate
			properties: y: 1334
			curve: animateOut
		Utils.delay .2, ->
			settingsContainer.visible = false

	#–––––––––––––––––––––––––––––––––––––––#
	#      SET ALERT BUBBLE ON TAB BAR      #
	#–––––––––––––––––––––––––––––––––––––––#
	setAlert = ->
		redCircle = new Layer
			width: 35, height: 35, y: 10, x: 535
			backgroundColor: "red"
			html: "1"
			scale: 0
			borderRadius: "50%"
			parent: tabBar
		redCircle.style = color: "white", fontSize: "26px", paddingTop: "3px", textAlign: "center"
		
		redCircle.animate
			properties: scale: 1
			curve: "spring(500, 20, 10)"
	
	#–––––––––––––––––––––––––––––––––––––––#
	#           OPEN CAMERA VIEWER          #
	#–––––––––––––––––––––––––––––––––––––––#		
	cameraIconLg.on Events.TouchEnd, ->
		cameraNavBar.visible = true
		cameraUI.visible = true
		cameraUIContainer.visible = true
		cameraUIContainer.animate
			properties: y: 0
			curve: animateIn
		Utils.delay .5, ->
			codePicFull.animate
				properties: opacity: 1
				curve: animateIn
				
	#–––––––––––––––––––––––––––––––––––#
	#       CLOSE CAMERA VIEWER         #
	#–––––––––––––––––––––––––––––––––––#
	cameraClose.on Events.TouchEnd, ->
		cameraUIContainer.animate
			properties: y: 1334
			curve: animateOut
		Utils.delay .5, ->
			cameraUIContainer.visible = false
			cameraNavBar.visible = false
			cameraUI.visible = false
			codePicFull.opacity = 0
				
	#–––––––––––––––––––––––––––––––––––––––––#
	#         OPEN CAMERA ROLL SCREEN         #
	#–––––––––––––––––––––––––––––––––––––––––#
	codePicBtn.on Events.TouchEnd, ->
		closeInterviewsScreen()
		closeNotesScreen()
		closeCodePicSaveScreen()
		closeAlertStatusScreen()
		openCameraRollScreen()
		
	#––––––––––––––––––––––––––––––––––––––––––––––#
	#           CLOSE CAMERA ROLL SCREEN           #
	#––––––––––––––––––––––––––––––––––––––––––––––#
	cameraRollCancelBtn.on Events.TouchEnd, ->
		closeCameraRollScreen()
		openInterviewsScreen()
		scrollListLoad()
		sortIcon.visible = false
		backArrow.visible = true
		backBtn.visible = true
		
	#––––––––––––––––––––––––––––––––––––––––#
	#           OPEN NOTES SCREEN            #
	#––––––––––––––––––––––––––––––––––––––––#
	notesBtn.on Events.TouchEnd, ->
		closeInterviewsScreen()
		closeCameraRollScreen()
		closeCodePicSaveScreen()
		closeAlertStatusScreen()
		openNotesScreen()
		
	#––––––––––––––––––––––––––––––––––––––#
	#        OPEN INTERVIEWS SCREEN        #
	#––––––––––––––––––––––––––––––––––––––#
	interviewsBtn.on Events.TouchEnd, ->
		closeCameraRollScreen()
		closeNotesScreen()
		closeCodePicSaveScreen()
		closeAlertStatusScreen()
		openInterviewsScreen()
		
	#–––––––––––––––––––––––––––––––––––––––#
	#        OPEN ALERT STATUS SCREEN       #
	#–––––––––––––––––––––––––––––––––––––––#
	alertsBtn.on Events.TouchEnd, ->
		closeInterviewsScreen()
		closeNotesScreen()
		closeCameraRollScreen()
		closeCodePicSaveScreen()
		openAlertStatusScreen()

	#––––––––––––––––––––––––––––––––––––––––––––––––#
	#       CLOSE CODE PIC CANDIDATE LIST SCREEN     #
	#––––––––––––––––––––––––––––––––––––––––––––––––#
	codePicCancelBtn.on Events.TouchEnd, ->
		closeCodePicSaveScreen()
		openCameraRollScreen()
		
	#––––––––––––––––––––––––––––––––––––––––––#
	#        CLOSE NOTES SCREEN BUTTON         #
	#––––––––––––––––––––––––––––––––––––––––––#
	notesCancelBtn.on Events.TouchEnd, ->
		closeCameraRollScreen()
		closeNotesScreen()
		openInterviewsScreen()
	
	#––––––––––––––––––––––––––––––––––––––––#
	#        CLOSE ALERT STATUS SCREEN       #
	#––––––––––––––––––––––––––––––––––––––––#
	alertStatusCancelBtn.on Events.TouchEnd, ->
		closeAlertStatusScreen()
		openInterviewsScreen()
		
	#–––––––––––––––––––––––––––––––––––––––––––––#
	#            OPEN SETTINGS MENU               #
	#–––––––––––––––––––––––––––––––––––––––––––––#
	moreBtn.on Events.TouchEnd, ->
		#closeInterviewsScreen()
		closeNotesScreen()
		closeCameraRollScreen()
		closeCodePicSaveScreen()
		openSettingsMenu()
		
	#–––––––––––––––––––––––––––––––––––––––––––––#
	#            CLOSE SETTINGS MENU              #
	#–––––––––––––––––––––––––––––––––––––––––––––#
	searchDoneBtn.on Events.TouchEnd, ->
		closeSettingsMenu()
		sortIcon.visible = true

	#–––––––––––––––––––––––––––––––#
	#        SET ALERT STATUS       #
	#–––––––––––––––––––––––––––––––#
	alertStatusDoneBtn.on Events.TouchEnd, ->
		closeAlertStatusScreen()
		openInterviewsScreen()
		Utils.delay .5, ->
			setAlert()
		
	#––––––––––––––––––––––––––––––––––––––––#
	#        BACK TO ALERT STATUS SCREEN     #
	#––––––––––––––––––––––––––––––––––––––––#
	alertStatusBackBtn.on Events.TouchEnd, ->
		closeCustomAlertMessageScreen()
		openAlertStatusScreen()

	#–––––––––––––––––––––––––––––––––––––––––––#
	#      SAVE PIC TO A CANDIDATE PROFILE      #
	#–––––––––––––––––––––––––––––––––––––––––––#
	cameraRollDoneBtn.on Events.TouchEnd, ->
		closeCameraRollScreen()
		openCodePicSaveScreen()

	#–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	#      OPEN CANDIDATE LIST SELECTION SCREEN FROM THE CODE PICS SAVE SCREEN      #
	#–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	codePicCandidateSelectorBar.on Events.TouchEnd, ->
		checkIcon.visible = true
		closeCodePicSaveScreen()
		closeCameraRollScreen()
		closeNotesScreen()
		closeAlertStatusScreen()
		closeInterviewsScreen()
		openCodePicCandidateListSelector()
		
	#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	#      OPEN CANDIDATE LIST SELECTION SCREEN FROM THE NOTES SCREEN      #
	#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	takeNotesCandidateSelectorBar.on Events.TouchEnd, ->
		checkIcon.visible = true
		closeCodePicSaveScreen()
		closeCameraRollScreen()
		closeNotesScreen()
		closeAlertStatusScreen()
		closeInterviewsScreen()
		openTakeNotesCandidateListSelector()

	#–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	#      CLOSE CANDIDATE LIST SELECTION SCREEN FROM CODE PIC SCREEN       #
	#–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	codePicSelectCandidateCancelBtn.on Events.TouchEnd, ->
		closeCodePicCandidateListSelector()
		openCodePicSaveScreen()
		
	#–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	#      CLOSE CANDIDATE LIST SELECTION SCREEN FROM TAKE NOTES SCREEN     #
	#–––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	takeNotesSelectCandidateCancelBtn.on Events.TouchEnd, ->
		closeTakeNotesCandidateListSelector()
		openNotesScreen()
		
	#––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	#      OPEN MESSAGE SCREEN FROM ALERT STATUS SCREEN      #
	#––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
	customAlertMessageBar.on Events.TouchEnd, ->
		closeAlertStatusScreen()
		openCustomAlertMessageScreen()

	#––––––––––––––––––––––––––––––#
	#      CODE PIC SAVE BTN       #
	#––––––––––––––––––––––––––––––#
	codePicSaveBtn.on Events.TouchEnd, ->
				
	#–––––––––––––––––––––––––––––––––––––#
	#           SHUTTER ACTION            #
	#–––––––––––––––––––––––––––––––––––––#
	shutterBtn.on Events.TouchEnd, ->
		cameraSnapEffect = new Layer
			width: Screen.width, height: Screen.height
			backgroundColor: "white"
			opacity: 0
		snap = cameraSnapEffect.animate
			properties: opacity: 1
			time: .1
				
		snap.on "end", ->
			cameraSnapEffect.animate
				properties: opacity: 0
				time: .2
				
		codePic5.visible = true
	
#––––––––––––––––––––––––––––––––––––––––––#
#     SELECT CODE PIC FROM CAMERA ROLL     #
#––––––––––––––––––––––––––––––––––––––––––#
	codePic5.on Events.TouchEnd, ->
		codePic5Selection.visible = true