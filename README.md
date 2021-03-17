# Cargo-A-Car-Rental-System
A	new	up	and	coming	car	rental	service	is	wishing	to	have	a	user	interface	that	will	allow	their	
customers	to	view	the	models,	descriptions	and	prices	of	different	cars available.	The	user	has	
the	ability	to	register	and	log	in	to	the	Web	App	and	track	their	rental	plan.	The	Web	App	will	
be	responsive,	allowing	for	the	customer	to	view	it	on	any	device,	from	tablets	to	mobile	
phones	and	desktop	computers.	The	administrator	will	also	be	able	to	login	through	the	same	
form	but	have	the	ability	to	add/remove	new	car	rentals,	change	prices,	and	so	on.

# Goals	for	the	Project
This	software,	called	‘Ghost	Rental	Data’, will	allow	for	the	company	to	access	their	database	
securely	and	safely	in	a	user-friendly	online	environment.	Allowing	for	them	to	change	car	
information	with	ease.	The	software	will	be	in	sync	with	the	both	the	Web	App,	allowing	for	
real-time	up-to-date services	for	their	customers.


# Process Flow	Preview
For	our	process	flow,	we	plan	on	taking	the	iterative	route,	as	we	find	communication	essential	
throughout	the	development	process.	In	order	to	plan	all	aspects	of	the	project	in	detail,	we	
feel	that	contacting	the	car	rental	service	and having	those	in	charge	be	in	the	same	room	when	

the	planning	is	taking	place.	It	is	our	way	of	discussing	requirements	and	develop	important	
notes	that	will	help	in	constructing	the	overall	feel	and	idea.	The	modeling	process	in	its	own	
right	we	feel	is	not	a	start	to	finish	process.	There	will	be	times	that	we	may	have	to	go	back	to	
certain	portions	within	the	modeling	activity	to	ensure	a	sufficient	model.	We	wish	to	make	
sure	that	if	we	miss	anything,	we	do	not	figure	that	out	in	the	construction	stage.
Project	Plan

#	Task	Descriptions
Stakeholder	Meetings:
The	stakeholders	and	the	software	engineering	team	conducts	meetings	in	order	to get	the	full	
grasp	of	the	problem	at	hand,	obtaining	any	and	all	information	needed.	Conflicts	and	
negotiations	would	be	conducted	during	this	time	and	any	time	throughout	the	project	process	
flow.
Design	Models	and	Mockups:
Designing	the	models	and	mockups	help	to	ensure	clarity	in	view	of	the	project	as	well	as	how	it	
works.	Stakeholders	are	to	sit	through	this	process	as	drawings	are	created.
Database	Creation
A	database	is	created	using	the	models	to	provide	storage	for	customer	information,	vehicle	
information,	and	payment	reports.	Testing	of	the	database	is	ensured	at	this	point.
Employee	Software	Creation:
The	software	that	is	to	be	used	by	the	employees	will	be	designed	using	Visual	Basic	using	the	
guide	of	the	mockups,	requirements,	and	models.	The	software	will	act	as	a	simple	and	easy	to	
understand	user	interface	to	‘browse’	and	among	other	functions	the	database	- the	
information	stored	including	customer	information,	vehicle	information,	and	payment	reports.
Application	Creation:
The web	site	will	be	designed	using	Xcode	on	Swift	programming	language	using	the	guide	of	the	
mockups,	requirements,	and	models.	The	website	will	be	implemented	using	high-quality	
design	techniques.	It	should	allow	for	users	to	immediately	see	the	rental	cars	that	are	
available.	They	can	also	have	the	ability	to	search	for	a	certain	vehicle	they	desire.	Once	they	
select	they	can	register	or	log	in	to	store	any	private	information	they	are	about	to	give	to	the	
company	in	order	to	obtain	their	vehicle,	although	registering	is	not	required.
Testing:
Testing	will	be	implemented	on	both	the	website	and	software.	Test	cases	may	be	used	to	
guide	and	understand	the	basic	actions	of	both	customers	and	employees.	Any	bugs	or	errors	
that	occur	will	be	identified	and	resolved.	
Finalization	and	Reports
All	testing	and	function	processes	are	finalized	at	this	stage.	Reports	will	be	created	to	ensure	
all	information	and	functionality	is	clear	in	order	to	make	the	user	manual	and	to	help	ensure	
employees	can	use	the	software	with	ease.

# flow Charts/Models
[GhostCarRental-Feedback (copied-document).pdf](https://github.com/NamrataAdhvaryu/Cargo-A-Car-Rental-System/files/6158578/GhostCarRental-Feedback.copied-document.pdf)
[GhostCarRental-Feedback2 (1).pdf](https://github.com/NamrataAdhvaryu/Cargo-A-Car-Rental-System/files/6158580/GhostCarRental-Feedback2.1.pdf)


# Functional	Requirements
Hardware	Requirements:
The	software	should	be	ran	on	any	sort	of	desktop	or	laptop	environment,	regardless	of	the	
operating	system.	The	software	also	has	the	potential	of	running	on	tablets,	but	with	a	more	
simplified	version.	Essential	input/output	devices	are	keyboards,	mouse,	and	printers;	nothing	
else	is	required	but	can	be	recommended	if	desired.
Website	Interface	- Primary	Tasks:

● View	all	available	rental	cars	
○ Connects	with	the	database	through	JavaScript to	call	all	car	objects	and	display	
them	accordingly
● Search	for	desired	car	by	model,	seating	capacity,	and	cost
○ A	search	bar	will	be	implemented	on	the	website	that	will	search	the	site	based	
on	the	input
● Select	their	desired	rental	car
○ A	button	will	be	displayed	under	the	rental	car	previews	that	will	allow	for	the	
selection	
● Allow	for	registration
○ registration	display	form	

● Allow	the	customer	to	log	in
○ log	in	display	form
● Allow	administrators	to	change	what	cars	are	available	for	rent
○ Administrators will	log	in	through	the	log	in	display	form	such	as	customers	
would,	but	would	have	a	different	looking	interface	to	allow	for	them	to	add	and	
remove	options.
Website	Interface	- Secondary	Tasks:
● Allow	for	rent	cancellation	by	customer
○ Only	for	users	who are	registered,	there	were	be	a	cancel	button	on	the	display	
page	that	shows	all	rents	present	by	customer
● Allow	the	user	select	and	provide	a	payment	type
○ Display	form	- with	options	for	typical	card	information	- type,	number,	code	on	
back,	month,	year	etc.
● Authenticate	any	user	logging	in
○ communicates	with	the	database	to	verify	the	inputted	username	and	password	
is	correct
● Authenticate	any	form	of	payment
○ communicates	with	verifiers	to	confirm	the	input	information	on	the	card	is	
correct
● Calculate	tax	rates,	customer	totals

○ algorithms	implemented	within	the	code	that	will	calculate	all	totals	‘behind	the	
scenes’
● Send	an	email	to	verify	a	registration
○ Once	a	customer	registers	and	click	the	complete	registration	button,	an	email	
will	be	sent	to	the	email the	customer	provided,	provided	a	link	in	the	email	that	
will	allow	for	a	verification	that	this	is	the	said-customer.
● Display	a	transaction	summary	/	email	a	summary
○ after	customer	submits	their	payment	and	it	is	confirmed	client-side,	a	
transaction	summary	will	display	on	the	website	and	a	copy	will	be	emailed	to	
the	customer
● Select	date	of	desired	delivery	(	&	choose	delivery	destination),	or	date	of	planned	pickup	at	nearest	store	location
○ Calendar	options	will	be	displayed	that	will	allow	the	user	to	select	directly	on	
the	calendars	- if	they	want	it	as	soon	as	possible,	there	will	be	a	checkbox	for	
that	option
● Select	length	of	rental	and	planned	drop-off	date
○ Calendar	options	as	well
● Store	customer	information	in	the	database
○ When	registering,	the	customer	will	provide	their	information	in	the	form	- this	
information	will	be	sent	securely	sent	and	stored	in	the	database
Company-side	Software	- Primary	Tasks:

● Allow	company	workers	to	open	and	view	customer	information
○ navigation	option	that	will	allow	for	search	of	customer	by	name	or	rental	car	
○ implementation	of	search	bar
● Track	customer	payments
○ displays	with	the	customer’s	information
● Keep	and	display	available	rental	car	records	(for	damages	purposes	and	such)
○ Searching	and	viewing	much	like	with	customers	
Company-side	Software	- Secondary	Tasks:
● Print	invoice
○ if	print	option	is	selected,	a	printable	version	of	the	page	being	viewed	by	the	
worker	will	display	with	a	confirm	print	button	to	selected	printer
● Calculate	total	of	all	transactions
○ algorithms	behind	the	scenes
● Allow	for	rent	cancellation	by	company	worker
○ a	button	will	cancel	a	rent	request	by	a	customer
