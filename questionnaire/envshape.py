# 2021.02.19
# Demographic questionnaire for envshape

import tkinter as tk
from tkinter import ttk
import csv

LARGE_FONT = ("Verdana", 24)
HEADER_FONT = ("Verdana", 24, 'bold')
SSH_FONT = ("Verdana", 20)

class envshape(tk.Tk): # Tk is a class inside of tkinter
	
	def __init__(self, *args, **kwargs): # args is short for arguments, could pass as many of these as you want, kwargs are keyword arguments, basically dictionaries that are passed through
		tk.Tk.__init__(self, *args, **kwargs) # Initialize tkinter as well
		
		tk.Tk.wm_title(self, "envshape") # title for the window

		tk.Tk.wm_geometry(self, "480x320") # Set window size at startup?

		container = tk.Frame(self) # Make the container that everything will go into
		container.pack(side = "top", fill = "both", expand = True)
		# fill acts on the limits you set (side, in this case)	
		# expand goes beyond your set limits to fill all available space
		container.grid_rowconfigure(0, weight=1)
		container.grid_columnconfigure(0, weight=1)

		self.input = [] # Add to this for final save out to csv

		self.frames = {} # Start a dictionary

		for F in (page_1, page_welcome, page_2, page_3, page_4, page_5, 
			page_6, page_7, page_8, page_9, page_10,
			page_11, page_12, page_13, page_14, page_15, 
			page_16, page_17, page_18, page_19, page_20,
			page_21, page_22, page_23, page_24, page_25,
			page_26, page_27, page_28, page_29, page_close):
			frame = F(container, self)
			self.frames[F] = frame
			frame.grid(row=0, column=0, sticky="nsew")

		self.show_frame(page_1)

	def show_frame(self, cont): 
		
		frame = self.frames[cont] # This is the key to the dictionary self.frames
		frame.tkraise() # Brings to the foreground


# page_1 Enter ID and date
class page_1(tk.Frame):

	def __init__(self, parent, controller): # parent is envshape (the top class)
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text = "Researcher \n\nEnter anonymized ID:", font = LARGE_FONT)
		label.place(relx=0.5, rely=0.45, anchor=tk.CENTER)

		entry1 = tk.Entry(self)
		entry1.place(relx=0.5, rely=0.6, anchor=tk.CENTER)

		label2 = tk.Label(self, text="Date:", font=LARGE_FONT)
		label2.place(relx=0.5, rely=0.7, anchor=tk.CENTER)

		entry2 = tk.Entry(self)
		entry2.place(relx=0.5, rely=0.75, anchor=tk.CENTER)

		button = ttk.Button(self, text="Next",
			command = lambda: [controller.input.append(entry1.get()), controller.input.append(entry2.get()), controller.show_frame(page_welcome)]) # Multiple functions in one command for one button #[self.writeToFile(), ]
		button.place(relx=0.5, rely=0.85, anchor=tk.CENTER)

# page_welcome Welcome for participant
class page_welcome(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Welcome", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text="Thank you for participating in this study. \n\nWe will ask you questions in these four categories \n    Demographic information \n    Hearing, social, & health \n    Speech and spatial hearing \n    Musical abilities \n\n Once you click NEXT you cannot return to the screen. \n\n Please note that you are free to leave any question blank.", 
			font=LARGE_FONT)
		label.place(relx=0.5, rely=0.5, anchor=tk.CENTER)

		button = ttk.Button(self, text="Next",
			command = lambda: controller.show_frame(page_2)) # Multiple functions in one command for one button #[self.writeToFile(), ]
		button.place(relx=0.5, rely=0.9, anchor=tk.CENTER)		



### Demographics ###
# page_2 Age
class page_2(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Demographic information", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "How old are you (in years)?", font=LARGE_FONT)
		label.place(relx=0.5, rely=0.5, anchor=tk.CENTER)

		entry = tk.Entry(self)
		entry.place(relx=0.5, rely=0.55, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(entry.get()), controller.show_frame(page_3)])
		button.place(relx=0.5, rely=0.7, anchor=tk.CENTER)		

# page_3 gender
class page_3(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Demographic information", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "In terms of gender, I identify as:", font=LARGE_FONT)
		label.place(relx=0.5, rely=0.5, anchor=tk.CENTER)

		entry = tk.Entry(self)
		entry.place(relx=0.5, rely=0.55, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(entry.get()), controller.show_frame(page_4)])
		button.place(relx=0.5, rely=0.7, anchor=tk.CENTER)	

# page_4 ethnicity
class page_4(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Demographic information", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "In terms of ethnicity, I identify as:", font=LARGE_FONT)
		label.place(relx=0.5, rely=0.5, anchor=tk.CENTER)

		entry = tk.Entry(self)
		entry.place(relx=0.5, rely=0.55, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(entry.get()), controller.show_frame(page_5)])
		button.place(relx=0.5, rely=0.7, anchor=tk.CENTER)	

# page_5 handedness 
class page_5(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Demographic information", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "Which hand do you write with?", font = LARGE_FONT)
		label.place(relx=0.5, rely=0.3, anchor=tk.CENTER)

		handedness = tk.StringVar()
		right = tk.Radiobutton(self, text="Right", variable=handedness, value="right")
		left = tk.Radiobutton(self, text="Left", variable=handedness, value="left")
		ambi = tk.Radiobutton(self, text="Either hand (ambidextrous)", variable=handedness, value="ambi")
		right.place(relx=0.5, rely=0.35, anchor=tk.CENTER)
		left.place(relx=0.5, rely=0.4, anchor=tk.CENTER)
		ambi.place(relx=0.5, rely=0.45, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(handedness.get()), controller.show_frame(page_6)])
		button.place(relx=0.5, rely=0.8, anchor=tk.CENTER)	


# page_6 education 
class page_6(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Demographic information", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "My highest level of education is:", font = LARGE_FONT)
		label.place(relx=0.5, rely=0.3, anchor=tk.CENTER)

		education = tk.StringVar()

		elementary = tk.Radiobutton(self, text="Elementary school", variable=education, value="elementary school")
		high_school_minus = tk.Radiobutton(self, text="Less than Grade 12", variable=education, value="less than grade 12")
		high_school = tk.Radiobutton(self, text="High school diploma", variable=education, value="high school diploma")
		some_uni = tk.Radiobutton(self, text="Some university undegraduate schooling", variable=education, value="some undergrad")
		college_2 = tk.Radiobutton(self, text="College degree (2 years)", variable=education, value="undergrad 2 years")
		bachelors = tk.Radiobutton(self, text="Bachelor's degree", variable=education, value="bachelors")
		postgrad = tk.Radiobutton(self, text="Postgraduate degree", variable=education, value="postgrad degree")
		other = tk.Radiobutton(self, text="Other (please specify):", variable=education, value="other")

		entry = tk.Entry(self)

		elementary.place(relx=0.5, rely=0.35, anchor=tk.CENTER)
		high_school_minus.place(relx=0.5, rely=0.4, anchor=tk.CENTER)
		high_school.place(relx=0.5, rely=0.45, anchor=tk.CENTER)
		some_uni.place(relx=0.5, rely=0.5, anchor=tk.CENTER)
		college_2.place(relx=0.5, rely=0.55, anchor=tk.CENTER)
		bachelors.place(relx=0.5, rely=0.6, anchor=tk.CENTER)
		postgrad.place(relx=0.5, rely=0.65, anchor=tk.CENTER)
		other.place(relx=0.5, rely=0.7, anchor=tk.CENTER)
		entry.place(relx=0.5, rely=0.75, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(education.get()), controller.input.append(entry.get()), controller.show_frame(page_7)])
		button.place(relx=0.5, rely=0.8, anchor=tk.CENTER)	




### Hearing, social & health ###
# page_7 hearing aid 
class page_7(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Hearing, social, & health", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "Do you wear a hearing aid?", font = LARGE_FONT)
		label.place(relx=0.5, rely=0.3, anchor=tk.CENTER)

		hearing_aid = tk.StringVar()

		no = tk.Radiobutton(self, text="No", variable=hearing_aid, value="no")
		right = tk.Radiobutton(self, text="Right ear", variable=hearing_aid, value="right")
		left = tk.Radiobutton(self, text="Left ear", variable=hearing_aid, value="left")
		both = tk.Radiobutton(self, text="Both ears", variable=hearing_aid, value="both")

		no.place(relx=0.5, rely=0.35, anchor=tk.CENTER)
		right.place(relx=0.5, rely=0.4, anchor=tk.CENTER)
		left.place(relx=0.5, rely=0.45, anchor=tk.CENTER)
		both.place(relx=0.5, rely=0.5, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(hearing_aid.get()), controller.show_frame(page_8)])
		button.place(relx=0.5, rely=0.8, anchor=tk.CENTER)	


# page_8 general hearing 
class page_8(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Hearing, social, & health", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "How would you rate your general hearing abilities?", font = LARGE_FONT)
		label.place(relx=0.5, rely=0.3, anchor=tk.CENTER)

		hearing = tk.StringVar()

		e_bad = tk.Radiobutton(self, text="Extremely bad", variable=hearing, value="extremely bad")
		m_bad = tk.Radiobutton(self, text="Moderately bad", variable=hearing, value="moderately bad")
		s_bad = tk.Radiobutton(self, text="Slightly bad", variable=hearing, value="slightly bad")
		n = tk.Radiobutton(self, text="Neither bad nor good", variable=hearing, value="neither bad nor good")
		s_good = tk.Radiobutton(self, text="Slightly good", variable=hearing, value="slightly good")
		m_good = tk.Radiobutton(self, text="Moderately good", variable=hearing, value="moderately good")
		e_good = tk.Radiobutton(self, text="Extremely good", variable=hearing, value="extremely good")

		e_bad.place(relx=0.5, rely=0.35, anchor=tk.CENTER)
		m_bad.place(relx=0.5, rely=0.4, anchor=tk.CENTER)
		s_bad.place(relx=0.5, rely=0.45, anchor=tk.CENTER)
		n.place(relx=0.5, rely=0.5, anchor=tk.CENTER)
		s_good.place(relx=0.5, rely=0.55, anchor=tk.CENTER)
		m_good.place(relx=0.5, rely=0.6, anchor=tk.CENTER)
		e_good.place(relx=0.5, rely=0.65, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(hearing.get()), controller.show_frame(page_9)])
		button.place(relx=0.5, rely=0.8, anchor=tk.CENTER)


# page_9 frequency of hearing problems
class page_9(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Hearing, social, & health", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "How often do you experience hearing problems?", font = LARGE_FONT)
		label.place(relx=0.5, rely=0.3, anchor=tk.CENTER)

		hearing = tk.StringVar()

		n = tk.Radiobutton(self, text="Never", variable=hearing, value="never")
		s = tk.Radiobutton(self, text="Sometimes", variable=hearing, value="sometimes")
		h = tk.Radiobutton(self, text="About half of the time", variable=hearing, value="half")
		m = tk.Radiobutton(self, text="Most of the time", variable=hearing, value="most of the time")
		a = tk.Radiobutton(self, text="Always", variable=hearing, value="always")

		n.place(relx=0.5, rely=0.35, anchor=tk.CENTER)
		s.place(relx=0.5, rely=0.4, anchor=tk.CENTER)
		h.place(relx=0.5, rely=0.45, anchor=tk.CENTER)
		m.place(relx=0.5, rely=0.5, anchor=tk.CENTER)
		a.place(relx=0.5, rely=0.55, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(hearing.get()), controller.show_frame(page_10)])
		button.place(relx=0.5, rely=0.8, anchor=tk.CENTER)

# page_10 miss what's being said
class page_10(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Hearing, social, & health", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "How often do you miss so much of what is being said that you feel left out?", font = LARGE_FONT)
		label.place(relx=0.5, rely=0.3, anchor=tk.CENTER)

		hearing = tk.StringVar()

		n = tk.Radiobutton(self, text="Never", variable=hearing, value="never")
		s = tk.Radiobutton(self, text="Sometimes", variable=hearing, value="sometimes")
		h = tk.Radiobutton(self, text="About half of the time", variable=hearing, value="half")
		m = tk.Radiobutton(self, text="Most of the time", variable=hearing, value="most of the time")
		a = tk.Radiobutton(self, text="Always", variable=hearing, value="always")

		n.place(relx=0.5, rely=0.35, anchor=tk.CENTER)
		s.place(relx=0.5, rely=0.4, anchor=tk.CENTER)
		h.place(relx=0.5, rely=0.45, anchor=tk.CENTER)
		m.place(relx=0.5, rely=0.5, anchor=tk.CENTER)
		a.place(relx=0.5, rely=0.55, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(hearing.get()), controller.show_frame(page_11)])
		button.place(relx=0.5, rely=0.8, anchor=tk.CENTER)

# page_11 nod and smile
class page_11(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Hearing, social, & health", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "In loud or noisy environments, how often do you just nod and smile, \nbut do not follow a conversation?", font = LARGE_FONT)
		label.place(relx=0.5, rely=0.3, anchor=tk.CENTER)

		hearing = tk.StringVar()

		n = tk.Radiobutton(self, text="Never", variable=hearing, value="never")
		s = tk.Radiobutton(self, text="Sometimes", variable=hearing, value="sometimes")
		h = tk.Radiobutton(self, text="About half of the time", variable=hearing, value="half")
		m = tk.Radiobutton(self, text="Most of the time", variable=hearing, value="most of the time")
		a = tk.Radiobutton(self, text="Always", variable=hearing, value="always")

		n.place(relx=0.5, rely=0.4, anchor=tk.CENTER)
		s.place(relx=0.5, rely=0.45, anchor=tk.CENTER)
		h.place(relx=0.5, rely=0.5, anchor=tk.CENTER)
		m.place(relx=0.5, rely=0.55, anchor=tk.CENTER)
		a.place(relx=0.5, rely=0.60, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(hearing.get()), controller.show_frame(page_12)])
		button.place(relx=0.5, rely=0.8, anchor=tk.CENTER)

# page_12 switch off
class page_12(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Hearing, social, & health", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "How often do you miss so much of a conversation that you 'switch off'?", font = LARGE_FONT)
		label.place(relx=0.5, rely=0.3, anchor=tk.CENTER)

		hearing = tk.StringVar()

		n = tk.Radiobutton(self, text="Never", variable=hearing, value="never")
		s = tk.Radiobutton(self, text="Sometimes", variable=hearing, value="sometimes")
		h = tk.Radiobutton(self, text="About half of the time", variable=hearing, value="half")
		m = tk.Radiobutton(self, text="Most of the time", variable=hearing, value="most of the time")
		a = tk.Radiobutton(self, text="Always", variable=hearing, value="always")

		n.place(relx=0.5, rely=0.35, anchor=tk.CENTER)
		s.place(relx=0.5, rely=0.4, anchor=tk.CENTER)
		h.place(relx=0.5, rely=0.45, anchor=tk.CENTER)
		m.place(relx=0.5, rely=0.5, anchor=tk.CENTER)
		a.place(relx=0.5, rely=0.55, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(hearing.get()), controller.show_frame(page_13)])
		button.place(relx=0.5, rely=0.8, anchor=tk.CENTER)


# page_13 avoid
class page_13(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Hearing, social, & health", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "How often do you avoid public places, such as restaurants, cafes, or bars \nbecause you find them too loud or noisy?", font = LARGE_FONT)
		label.place(relx=0.5, rely=0.3, anchor=tk.CENTER)

		hearing = tk.StringVar()

		n = tk.Radiobutton(self, text="Never", variable=hearing, value="never")
		s = tk.Radiobutton(self, text="Sometimes", variable=hearing, value="sometimes")
		h = tk.Radiobutton(self, text="About half of the time", variable=hearing, value="half")
		m = tk.Radiobutton(self, text="Most of the time", variable=hearing, value="most of the time")
		a = tk.Radiobutton(self, text="Always", variable=hearing, value="always")

		n.place(relx=0.5, rely=0.4, anchor=tk.CENTER)
		s.place(relx=0.5, rely=0.45, anchor=tk.CENTER)
		h.place(relx=0.5, rely=0.5, anchor=tk.CENTER)
		m.place(relx=0.5, rely=0.55, anchor=tk.CENTER)
		a.place(relx=0.5, rely=0.6, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(hearing.get()), controller.show_frame(page_14)])
		button.place(relx=0.5, rely=0.8, anchor=tk.CENTER)

# page_14 avoid
class page_14(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Hearing, social, & health", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "How likely are you to go to such public spaces if you expect \nthe sound environment to be loud or noisy?", font = LARGE_FONT)
		label.place(relx=0.5, rely=0.3, anchor=tk.CENTER)

		hearing = tk.StringVar()

		d_yes = tk.Radiobutton(self, text="Definitely will go", variable=hearing, value="definitely will go")
		p_yes = tk.Radiobutton(self, text="Probably will go", variable=hearing, value="probably will go")
		m = tk.Radiobutton(self, text="Might or might not go", variable=hearing, value="might")
		p_no = tk.Radiobutton(self, text="Probably won't go", variable=hearing, value="probably won't go")
		d_no = tk.Radiobutton(self, text="Definitely won't go", variable=hearing, value="definitely won't go")

		d_yes.place(relx=0.5, rely=0.4, anchor=tk.CENTER)
		p_yes.place(relx=0.5, rely=0.45, anchor=tk.CENTER)
		m.place(relx=0.5, rely=0.5, anchor=tk.CENTER)
		p_no.place(relx=0.5, rely=0.55, anchor=tk.CENTER)
		d_no.place(relx=0.5, rely=0.6, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(hearing.get()), controller.show_frame(page_15)])
		button.place(relx=0.5, rely=0.8, anchor=tk.CENTER)


# page_15 noisy social settings
class page_15(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Hearing, social, & health", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "How likely are you to avoid being in loud or noisy social settings?", font = LARGE_FONT)
		label.place(relx=0.5, rely=0.3, anchor=tk.CENTER)

		hearing = tk.StringVar()

		d_yes = tk.Radiobutton(self, text="Definitely will avoid", variable=hearing, value="definitely will avoid")
		p_yes = tk.Radiobutton(self, text="Probably will avoid", variable=hearing, value="probably will avoid")
		m = tk.Radiobutton(self, text="Might or might not avoid", variable=hearing, value="might")
		p_no = tk.Radiobutton(self, text="Probably won't avoid", variable=hearing, value="probably won't avoid")
		d_no = tk.Radiobutton(self, text="Definitely won't avoid", variable=hearing, value="definitely won't avoid")

		d_yes.place(relx=0.5, rely=0.35, anchor=tk.CENTER)
		p_yes.place(relx=0.5, rely=0.4, anchor=tk.CENTER)
		m.place(relx=0.5, rely=0.45, anchor=tk.CENTER)
		p_no.place(relx=0.5, rely=0.5, anchor=tk.CENTER)
		d_no.place(relx=0.5, rely=0.55, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(hearing.get()), controller.show_frame(page_16)])
		button.place(relx=0.5, rely=0.8, anchor=tk.CENTER)

# page_16 conversation
class page_16(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Hearing, social, & health", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "How much do you enjoy conversations with friends/family?", font = LARGE_FONT)
		label.place(relx=0.5, rely=0.3, anchor=tk.CENTER)

		hearing = tk.StringVar()

		g = tk.Radiobutton(self, text="A great deal", variable=hearing, value="a great deal")
		l = tk.Radiobutton(self, text="A lot", variable=hearing, value="a lot")
		m = tk.Radiobutton(self, text="A moderate amount", variable=hearing, value="moderate amount")
		little = tk.Radiobutton(self, text="A little", variable=hearing, value="a little")
		n = tk.Radiobutton(self, text="Not at all", variable=hearing, value="not at all")

		g.place(relx=0.5, rely=0.35, anchor=tk.CENTER)
		l.place(relx=0.5, rely=0.4, anchor=tk.CENTER)
		m.place(relx=0.5, rely=0.45, anchor=tk.CENTER)
		little.place(relx=0.5, rely=0.5, anchor=tk.CENTER)
		n.place(relx=0.5, rely=0.55, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(hearing.get()), controller.show_frame(page_17)])
		button.place(relx=0.5, rely=0.8, anchor=tk.CENTER)

# page_17 social
class page_17(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Hearing, social, & health", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "How social are you?", font = LARGE_FONT)
		label.place(relx=0.5, rely=0.3, anchor=tk.CENTER)

		hearing = tk.StringVar()

		e = tk.Radiobutton(self, text="Extremely social", variable=hearing, value="extremely")
		v = tk.Radiobutton(self, text="Very social", variable=hearing, value="very")
		m = tk.Radiobutton(self, text="Moderately social", variable=hearing, value="moderately")
		s = tk.Radiobutton(self, text="Slightly social", variable=hearing, value="slightly")
		n = tk.Radiobutton(self, text="Not at all social", variable=hearing, value="not at all")

		e.place(relx=0.5, rely=0.35, anchor=tk.CENTER)
		v.place(relx=0.5, rely=0.4, anchor=tk.CENTER)
		m.place(relx=0.5, rely=0.45, anchor=tk.CENTER)
		s.place(relx=0.5, rely=0.5, anchor=tk.CENTER)
		n.place(relx=0.5, rely=0.55, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(hearing.get()), controller.show_frame(page_18)])
		button.place(relx=0.5, rely=0.8, anchor=tk.CENTER)

# page_18 hang out
class page_18(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Hearing, social, & health", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "How important is it for you to hang out with people?", font = LARGE_FONT)
		label.place(relx=0.5, rely=0.3, anchor=tk.CENTER)

		hearing = tk.StringVar()

		e = tk.Radiobutton(self, text="Extremely important", variable=hearing, value="extremely")
		v = tk.Radiobutton(self, text="Very important", variable=hearing, value="very")
		m = tk.Radiobutton(self, text="Moderately important", variable=hearing, value="moderately")
		s = tk.Radiobutton(self, text="Slightly important", variable=hearing, value="slightly")
		n = tk.Radiobutton(self, text="Not at all important", variable=hearing, value="not at all")

		e.place(relx=0.5, rely=0.35, anchor=tk.CENTER)
		v.place(relx=0.5, rely=0.4, anchor=tk.CENTER)
		m.place(relx=0.5, rely=0.45, anchor=tk.CENTER)
		s.place(relx=0.5, rely=0.5, anchor=tk.CENTER)
		n.place(relx=0.5, rely=0.55, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(hearing.get()), controller.show_frame(page_19)])
		button.place(relx=0.5, rely=0.8, anchor=tk.CENTER)


# page_19 avoid
class page_19(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Hearing, social, & health", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "How often do you experience ringing in your ears?", font = LARGE_FONT)
		label.place(relx=0.5, rely=0.3, anchor=tk.CENTER)

		hearing = tk.StringVar()

		n = tk.Radiobutton(self, text="Never", variable=hearing, value="never")
		s = tk.Radiobutton(self, text="Sometimes", variable=hearing, value="sometimes")
		h = tk.Radiobutton(self, text="About half of the time", variable=hearing, value="half")
		m = tk.Radiobutton(self, text="Most of the time", variable=hearing, value="most of the time")
		a = tk.Radiobutton(self, text="Always", variable=hearing, value="always")

		n.place(relx=0.5, rely=0.35, anchor=tk.CENTER)
		s.place(relx=0.5, rely=0.4, anchor=tk.CENTER)
		h.place(relx=0.5, rely=0.45, anchor=tk.CENTER)
		m.place(relx=0.5, rely=0.5, anchor=tk.CENTER)
		a.place(relx=0.5, rely=0.55, anchor=tk.CENTER)

		label = tk.Label(self, text="If you have experienced ringing, in which ear(s)?", font=LARGE_FONT)
		label.place(relx=0.5, rely=0.65, anchor=tk.CENTER)

		entry = tk.Entry(self)
		entry.place(relx=0.5, rely=0.7, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(hearing.get()), controller.input.append(entry.get()), controller.show_frame(page_20)])
		button.place(relx=0.5, rely=0.8, anchor=tk.CENTER)


# page_20 ear infections
class page_20(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Hearing, social, & health", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "Do you often get ear infections?", font = LARGE_FONT)
		label.place(relx=0.5, rely=0.3, anchor=tk.CENTER)

		hearing = tk.StringVar()

		y = tk.Radiobutton(self, text="Yes", variable=hearing, value="yes")
		n = tk.Radiobutton(self, text="No", variable=hearing, value="no")
		
		y.place(relx=0.5, rely=0.35, anchor=tk.CENTER)
		n.place(relx=0.5, rely=0.4, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(hearing.get()), controller.show_frame(page_21)])
		button.place(relx=0.5, rely=0.8, anchor=tk.CENTER)


# page_21 neurological diseases
class page_21(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Hearing, social, & health", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "Have you ever had any neurological diseases?", font = LARGE_FONT)
		label.place(relx=0.5, rely=0.3, anchor=tk.CENTER)

		hearing = tk.StringVar()

		y = tk.Radiobutton(self, text="Yes", variable=hearing, value="yes")
		n = tk.Radiobutton(self, text="No", variable=hearing, value="no")
		
		y.place(relx=0.5, rely=0.35, anchor=tk.CENTER)
		n.place(relx=0.5, rely=0.4, anchor=tk.CENTER)

		label = tk.Label(self, text="If yes, please specify what kind(s) of neurological disease:", font=LARGE_FONT)
		label.place(relx=0.5, rely=0.65, anchor=tk.CENTER)

		entry = tk.Entry(self)
		entry.place(relx=0.5, rely=0.7, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(hearing.get()), controller.input.append(entry.get()), controller.show_frame(page_22)])
		button.place(relx=0.5, rely=0.8, anchor=tk.CENTER)


# page_22 medication
class page_22(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Hearing, social, & health", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "Do you presently take any medication on a regular basis? \n(For example: prescriptions for hypertension, anxiety, depression, diabetes, etc.)", font = LARGE_FONT)
		label.place(relx=0.5, rely=0.3, anchor=tk.CENTER)

		hearing = tk.StringVar()

		y = tk.Radiobutton(self, text="Yes", variable=hearing, value="yes")
		n = tk.Radiobutton(self, text="No", variable=hearing, value="no")
		
		y.place(relx=0.5, rely=0.4, anchor=tk.CENTER)
		n.place(relx=0.5, rely=0.45, anchor=tk.CENTER)

		label = tk.Label(self, text="If yes, please describe the medication(s) you are taking:", font=LARGE_FONT)
		label.place(relx=0.5, rely=0.65, anchor=tk.CENTER)

		entry = tk.Entry(self)
		entry.place(relx=0.5, rely=0.7, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(hearing.get()), controller.input.append(entry.get()), controller.show_frame(page_23)])
		button.place(relx=0.5, rely=0.8, anchor=tk.CENTER)









### Speech & spatial hearing ###
# page_23 reverberation 
class page_23(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Speech & spatial hearing", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "When you talk to someone at a place that strongly reverberates/echoes \n(e.g., in a church or train station), can you understand what the person says? \n\nRESPONSE CHOICES: 0 ... 10 (referring to 'not at all' ... 'perfectly').", font = SSH_FONT)
		label.place(relx=0.5, rely=0.25, anchor=tk.CENTER)

		ssh = tk.StringVar()

		r_0 = tk.Radiobutton(self, text="0", variable=ssh, value="0")
		r_1 = tk.Radiobutton(self, text="1", variable=ssh, value="1")
		r_2 = tk.Radiobutton(self, text="2", variable=ssh, value="2")
		r_3 = tk.Radiobutton(self, text="3", variable=ssh, value="3")
		r_4 = tk.Radiobutton(self, text="4", variable=ssh, value="4")
		r_5 = tk.Radiobutton(self, text="5", variable=ssh, value="5")
		r_6 = tk.Radiobutton(self, text="6", variable=ssh, value="6")
		r_7 = tk.Radiobutton(self, text="7", variable=ssh, value="7")
		r_8 = tk.Radiobutton(self, text="8", variable=ssh, value="8")
		r_9 = tk.Radiobutton(self, text="9", variable=ssh, value="9")
		r_10 = tk.Radiobutton(self, text="10", variable=ssh, value="10")

		r_0.place(relx=0.5, rely=0.4, anchor=tk.CENTER)
		r_1.place(relx=0.5, rely=0.45, anchor=tk.CENTER)
		r_2.place(relx=0.5, rely=0.5, anchor=tk.CENTER)
		r_3.place(relx=0.5, rely=0.55, anchor=tk.CENTER)
		r_4.place(relx=0.5, rely=0.6, anchor=tk.CENTER)
		r_5.place(relx=0.5, rely=0.65, anchor=tk.CENTER)
		r_6.place(relx=0.5, rely=0.7, anchor=tk.CENTER)
		r_7.place(relx=0.5, rely=0.75, anchor=tk.CENTER)
		r_8.place(relx=0.5, rely=0.8, anchor=tk.CENTER)
		r_9.place(relx=0.5, rely=0.85, anchor=tk.CENTER)
		r_10.place(relx=0.5, rely=0.9, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(ssh.get()), controller.show_frame(page_24)])
		button.place(relx=0.5, rely=0.95, anchor=tk.CENTER)	

# page_24 group 
class page_24(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Speech & spatial hearing", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "When you are with a group (~5 people) in a lively restaurant, \ncan you follow the group's conversation? \n\nRESPONSE CHOICES: 0 ... 10 (referring to 'not at all' ... 'perfectly').", font = SSH_FONT)
		label.place(relx=0.5, rely=0.25, anchor=tk.CENTER)

		ssh = tk.StringVar()

		r_0 = tk.Radiobutton(self, text="0", variable=ssh, value="0")
		r_1 = tk.Radiobutton(self, text="1", variable=ssh, value="1")
		r_2 = tk.Radiobutton(self, text="2", variable=ssh, value="2")
		r_3 = tk.Radiobutton(self, text="3", variable=ssh, value="3")
		r_4 = tk.Radiobutton(self, text="4", variable=ssh, value="4")
		r_5 = tk.Radiobutton(self, text="5", variable=ssh, value="5")
		r_6 = tk.Radiobutton(self, text="6", variable=ssh, value="6")
		r_7 = tk.Radiobutton(self, text="7", variable=ssh, value="7")
		r_8 = tk.Radiobutton(self, text="8", variable=ssh, value="8")
		r_9 = tk.Radiobutton(self, text="9", variable=ssh, value="9")
		r_10 = tk.Radiobutton(self, text="10", variable=ssh, value="10")

		r_0.place(relx=0.5, rely=0.4, anchor=tk.CENTER)
		r_1.place(relx=0.5, rely=0.45, anchor=tk.CENTER)
		r_2.place(relx=0.5, rely=0.5, anchor=tk.CENTER)
		r_3.place(relx=0.5, rely=0.55, anchor=tk.CENTER)
		r_4.place(relx=0.5, rely=0.6, anchor=tk.CENTER)
		r_5.place(relx=0.5, rely=0.65, anchor=tk.CENTER)
		r_6.place(relx=0.5, rely=0.7, anchor=tk.CENTER)
		r_7.place(relx=0.5, rely=0.75, anchor=tk.CENTER)
		r_8.place(relx=0.5, rely=0.8, anchor=tk.CENTER)
		r_9.place(relx=0.5, rely=0.85, anchor=tk.CENTER)
		r_10.place(relx=0.5, rely=0.9, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(ssh.get()), controller.show_frame(page_25)])
		button.place(relx=0.5, rely=0.95, anchor=tk.CENTER)	


# page_25 group 
class page_25(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Speech & spatial hearing", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "Based on the sound of a bus or truck, \ncan you tell whether it is moving towards or away from you? \n\nRESPONSE CHOICES: 0 ... 10 (referring to 'not at all' ... 'perfectly').", font = SSH_FONT)
		label.place(relx=0.5, rely=0.25, anchor=tk.CENTER)

		ssh = tk.StringVar()

		r_0 = tk.Radiobutton(self, text="0", variable=ssh, value="0")
		r_1 = tk.Radiobutton(self, text="1", variable=ssh, value="1")
		r_2 = tk.Radiobutton(self, text="2", variable=ssh, value="2")
		r_3 = tk.Radiobutton(self, text="3", variable=ssh, value="3")
		r_4 = tk.Radiobutton(self, text="4", variable=ssh, value="4")
		r_5 = tk.Radiobutton(self, text="5", variable=ssh, value="5")
		r_6 = tk.Radiobutton(self, text="6", variable=ssh, value="6")
		r_7 = tk.Radiobutton(self, text="7", variable=ssh, value="7")
		r_8 = tk.Radiobutton(self, text="8", variable=ssh, value="8")
		r_9 = tk.Radiobutton(self, text="9", variable=ssh, value="9")
		r_10 = tk.Radiobutton(self, text="10", variable=ssh, value="10")

		r_0.place(relx=0.5, rely=0.4, anchor=tk.CENTER)
		r_1.place(relx=0.5, rely=0.45, anchor=tk.CENTER)
		r_2.place(relx=0.5, rely=0.5, anchor=tk.CENTER)
		r_3.place(relx=0.5, rely=0.55, anchor=tk.CENTER)
		r_4.place(relx=0.5, rely=0.6, anchor=tk.CENTER)
		r_5.place(relx=0.5, rely=0.65, anchor=tk.CENTER)
		r_6.place(relx=0.5, rely=0.7, anchor=tk.CENTER)
		r_7.place(relx=0.5, rely=0.75, anchor=tk.CENTER)
		r_8.place(relx=0.5, rely=0.8, anchor=tk.CENTER)
		r_9.place(relx=0.5, rely=0.85, anchor=tk.CENTER)
		r_10.place(relx=0.5, rely=0.9, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(ssh.get()), controller.show_frame(page_26)])
		button.place(relx=0.5, rely=0.95, anchor=tk.CENTER)	


# page_26 direction 
class page_26(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Speech & spatial hearing", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "When you are in an unknown environment, \ncan you tell from which direction a brief sound originates? \n\nRESPONSE CHOICES: 0 ... 10 (referring to 'not at all' ... 'perfectly').", font = SSH_FONT)
		label.place(relx=0.5, rely=0.25, anchor=tk.CENTER)

		ssh = tk.StringVar()

		r_0 = tk.Radiobutton(self, text="0", variable=ssh, value="0")
		r_1 = tk.Radiobutton(self, text="1", variable=ssh, value="1")
		r_2 = tk.Radiobutton(self, text="2", variable=ssh, value="2")
		r_3 = tk.Radiobutton(self, text="3", variable=ssh, value="3")
		r_4 = tk.Radiobutton(self, text="4", variable=ssh, value="4")
		r_5 = tk.Radiobutton(self, text="5", variable=ssh, value="5")
		r_6 = tk.Radiobutton(self, text="6", variable=ssh, value="6")
		r_7 = tk.Radiobutton(self, text="7", variable=ssh, value="7")
		r_8 = tk.Radiobutton(self, text="8", variable=ssh, value="8")
		r_9 = tk.Radiobutton(self, text="9", variable=ssh, value="9")
		r_10 = tk.Radiobutton(self, text="10", variable=ssh, value="10")

		r_0.place(relx=0.5, rely=0.4, anchor=tk.CENTER)
		r_1.place(relx=0.5, rely=0.45, anchor=tk.CENTER)
		r_2.place(relx=0.5, rely=0.5, anchor=tk.CENTER)
		r_3.place(relx=0.5, rely=0.55, anchor=tk.CENTER)
		r_4.place(relx=0.5, rely=0.6, anchor=tk.CENTER)
		r_5.place(relx=0.5, rely=0.65, anchor=tk.CENTER)
		r_6.place(relx=0.5, rely=0.7, anchor=tk.CENTER)
		r_7.place(relx=0.5, rely=0.75, anchor=tk.CENTER)
		r_8.place(relx=0.5, rely=0.8, anchor=tk.CENTER)
		r_9.place(relx=0.5, rely=0.85, anchor=tk.CENTER)
		r_10.place(relx=0.5, rely=0.9, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(ssh.get()), controller.show_frame(page_27)])
		button.place(relx=0.5, rely=0.95, anchor=tk.CENTER)

# page_27 ignore 
class page_27(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Speech & spatial hearing", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "Are you able to ignore distracting sounds, \nwhen you concentrate on a specific aspect of your acoustic surrounding? \n\nRESPONSE CHOICES: 0 ... 10 (referring to 'not at all' ... 'perfectly').", font = SSH_FONT)
		label.place(relx=0.5, rely=0.25, anchor=tk.CENTER)

		ssh = tk.StringVar()

		r_0 = tk.Radiobutton(self, text="0", variable=ssh, value="0")
		r_1 = tk.Radiobutton(self, text="1", variable=ssh, value="1")
		r_2 = tk.Radiobutton(self, text="2", variable=ssh, value="2")
		r_3 = tk.Radiobutton(self, text="3", variable=ssh, value="3")
		r_4 = tk.Radiobutton(self, text="4", variable=ssh, value="4")
		r_5 = tk.Radiobutton(self, text="5", variable=ssh, value="5")
		r_6 = tk.Radiobutton(self, text="6", variable=ssh, value="6")
		r_7 = tk.Radiobutton(self, text="7", variable=ssh, value="7")
		r_8 = tk.Radiobutton(self, text="8", variable=ssh, value="8")
		r_9 = tk.Radiobutton(self, text="9", variable=ssh, value="9")
		r_10 = tk.Radiobutton(self, text="10", variable=ssh, value="10")

		r_0.place(relx=0.5, rely=0.4, anchor=tk.CENTER)
		r_1.place(relx=0.5, rely=0.45, anchor=tk.CENTER)
		r_2.place(relx=0.5, rely=0.5, anchor=tk.CENTER)
		r_3.place(relx=0.5, rely=0.55, anchor=tk.CENTER)
		r_4.place(relx=0.5, rely=0.6, anchor=tk.CENTER)
		r_5.place(relx=0.5, rely=0.65, anchor=tk.CENTER)
		r_6.place(relx=0.5, rely=0.7, anchor=tk.CENTER)
		r_7.place(relx=0.5, rely=0.75, anchor=tk.CENTER)
		r_8.place(relx=0.5, rely=0.8, anchor=tk.CENTER)
		r_9.place(relx=0.5, rely=0.85, anchor=tk.CENTER)
		r_10.place(relx=0.5, rely=0.9, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(ssh.get()), controller.show_frame(page_28)])
		button.place(relx=0.5, rely=0.95, anchor=tk.CENTER)



### Music abilities ###
# page_28 skill
class page_28(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Music abilities", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "How would you describe your musical skill?", font = LARGE_FONT)
		label.place(relx=0.5, rely=0.3, anchor=tk.CENTER)

		music = tk.StringVar()

		e = tk.Radiobutton(self, text="Extremely skilled", variable=music, value="extremely")
		v = tk.Radiobutton(self, text="Very skilled", variable=music, value="very")
		m = tk.Radiobutton(self, text="Moderately skilled", variable=music, value="moderately")
		s = tk.Radiobutton(self, text="Slightly skilled", variable=music, value="slightly")
		n = tk.Radiobutton(self, text="Not at all skilled", variable=music, value="not at all")

		e.place(relx=0.5, rely=0.35, anchor=tk.CENTER)
		v.place(relx=0.5, rely=0.4, anchor=tk.CENTER)
		m.place(relx=0.5, rely=0.45, anchor=tk.CENTER)
		s.place(relx=0.5, rely=0.5, anchor=tk.CENTER)
		n.place(relx=0.5, rely=0.55, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(music.get()), controller.show_frame(page_29)])
		button.place(relx=0.5, rely=0.8, anchor=tk.CENTER)


def writeToFile(param1):
	with open('envshape_questionnaire_pilot.csv', 'a') as f:
		w = csv.writer(f, quoting=csv.QUOTE_ALL)
		w.writerow(param1)

# page_29 trained
class page_29(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text="Music abilities", font=HEADER_FONT)
		label.place(relx=0.5, rely=0.1, anchor=tk.CENTER)

		label = tk.Label(self, text = "Have you ever been trained on (or taught yourself) a musical instrument?", font = LARGE_FONT)
		label.place(relx=0.5, rely=0.3, anchor=tk.CENTER)

		music = tk.StringVar()

		y = tk.Radiobutton(self, text="Yes", variable=music, value="yes")
		n = tk.Radiobutton(self, text="No", variable=music, value="no")
		
		y.place(relx=0.5, rely=0.35, anchor=tk.CENTER)
		n.place(relx=0.5, rely=0.4, anchor=tk.CENTER)

		label = tk.Label(self, text="If yes, how many years did you play the instrument?", font=LARGE_FONT)
		label.place(relx=0.5, rely=0.65, anchor=tk.CENTER)

		entry = tk.Entry(self)
		entry.place(relx=0.5, rely=0.7, anchor=tk.CENTER)

		button = tk.Button(self, text="Next",
			command = lambda: [controller.input.append(music.get()), controller.input.append(entry.get()), writeToFile(controller.input), controller.show_frame(page_close)])
		button.place(relx=0.5, rely=0.8, anchor=tk.CENTER)

 



class page_close(tk.Frame):

	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		label = tk.Label(self, text = "Thank you for completing this portion of the experiment. \nPlease let the researcher know you are finished. \nDo not close this window.",
			font=LARGE_FONT)
		label.place(relx=0.5, rely=0.5, anchor=tk.CENTER)


app = envshape()
app.mainloop()		



