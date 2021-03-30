########################################################################### general settings
import sys, os

print ('Number of arguments:', len(sys.argv), 'arguments.')
print ('Argument List:', str(sys.argv))

model_extensions = ["obj","md2","md3"]
texture_extensions = ["png","bmp","jpg","jpeg","tga"]
default_models_path = "models/"
default_textures_path = "models/"

########################################################################## defining a file class

class FileObject:
    def __init__(self,path,i):
        """Creates a file object"""
        global arguments, model_extensions, texture_extensions, model_list, texture_list
        self.name = ""
        self.nameL = []
        self.path = path
        self.extension = ""
        self.isTexture = False
        self.isModel = False
        self.pair = "" #models have texture pairs

        self.getName(i)
        self.getExt(self.name)
        self.addToList(self.isTexture,self.isModel)

    def getName(self,i):
        self.name = os.path.basename(str(arguments[i]))
    def getExt(self,name):
        self.nameL = self.name.split(sep=".")
        self.extension = self.nameL[1]

        if (self.extension in model_extensions):
            self.isModel = True
        elif (self.extension in texture_extensions):
            self.isTexture = True
        else:
            print("I can't determine if", name, "is a model or texture\n\ please rename it.")
    def addToList(self,isTexture,isModel):
        if (self.isModel):
            model_list.append(self)
        elif(self.isTexture):
            texture_list.append(self)
        else:
            print("can't decide yet again")
    def checkPair(self,nameL,othername):
        if (nameL[0] == othername[0]):
            self.pair = othername[0]+"."+othername[1] #name + extension
    

########################################################################## defining variables

arguments = sys.argv
files = []
model_list = []
texture_list = []


########################################################################## looping throught everything and setting all up

x=0

for i in arguments: #initialize all files
    files.append(FileObject(i,x))

    x += 1
x=0

for i in model_list: #find pair texture for the model
    for j in texture_list:
        i.checkPair(i.nameL,j.nameL)


########################################################################## creating the folders, moving the files

if (not os.path.exists(default_models_path)):
    os.mkdir(default_models_path)
if (not os.path.exists(default_textures_path)):
    os.mkdir(default_textures_path)

for i in model_list: #move models to that folder
    os.replace(i.path,default_models_path+i.name)

for i in texture_list: #move textures to that folder
    os.replace(i.path,default_textures_path+i.name)



f = open("textures.DummySprites.lmp","w") #create dummy sprites
f.write("sprite 0000A0, 1, 1 { patch TNT1A0, 0, 0 {} }")
f.close()


for i in model_list:


    f = open("ZScript.zs","a") #create zscript
    f.write("""\n\n\n

class %s : Actor 
{
    Default
    {
        Radius 26;
        Height 30;
        Health 100;
        ProjectilePassHeight -16;
        Mass 1000;
        +SOLID
        +SHOOTABLE
        +NOBLOOD
        +NOFRICTIONBOUNCE
        +ACTLIKEBRIDGE
        }
    States
    {
    Spawn:
        0000 A -1;
        Stop;
    Death:
        0000 A 1;
        Stop;
    }
}

    """ % (i.nameL[0]))
    f.close()

    f = open("Modeldef.txt","a") #create modeldef
    f.write("""\n\n\n

Model %s 
{
Path %s
Model 0 %s
Skin 0 %s
Scale 1 1 1
Offset 0 0 0
AngleOffset 0

FrameIndex 0000 A 0 0 

}

    """ % (i.nameL[0],default_models_path,i.name,i.pair)
    )
    f.close()


##########################################################################

#
#while True:
#    try:
#        exec(input(">>> "))
#    except Exception as e:
#        print(e)
#
#input()