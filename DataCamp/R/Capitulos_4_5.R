###################################################
#
#    	    Guiões de utilização do R
#
###########  Estatística Multivariada  ############
#
# Adelaide Freitas,
###################################################

########################################
########################################
#
#Capítulo 4:  ACP
#
########################################
########################################
# Secí§í£o: ACP na prática
#(exemplificação com o ficheiro FoodPriceUSA.txt
########################################
########################################


# Exercício: Encontrar um índice de preço ao consumidor.


#LEITURA DOS DADOS:
dados<-read.table("FoodPriceUSA.txt",sep="\t",dec=",",header=TRUE)
dados

# primeira coluna ser o nome das linhas
dadosx<-dados[,-1]
rownames(dadosx)<-dados[,1]
dadosx


# ACP sobre dados não normalidados 
res1=prcomp(dadosx)   # Nota: o prcomp, por defeito, centraliza os dados
res1
# ( sum.res1=summary(res1) ) - Vinha assim no script, mas tb pode ser assim:
#sum.res1=summary(res1) ->   aqui não imprime

sum.res1=summary(res1)
sum.res1

#Os indivíduos expressos nas novas CP's:
res1$x

#calculado na aula - a variância está nas diagonais
var(dadosx)
diag(var(dadosx))

#Gráfico das 23 cidades nas duas primeiras CP's (estas explicam 70,5% da variabilidade dos dados).

par(mfrow=c(1,2))
plot(res1$x[,1],res1$x[,2], type="n", xlab=paste(" CP1  (", (round(100*sum.res1$importance[2,1],digits=1)), " % )"),
ylab=paste(" CP2  (", (round(100*sum.res1$importance[2,2],digits=1)), " % )"), main="ACP (dados não normalizados) FoodPrice.xls")
text(res1$x[,1:2],lab=rownames(dadosx))

# ACP sobre dados normalizados
res2=prcomp(dadosx, scale=TRUE)
res2
( sum.res2=summary(res2) )

#Os indivíduos expressos nas novas CP's:
res2$x



#Gráfico das 23 cidades nas duas primeiras CP's (estas explicam 83% da variabilidade dos dados).

plot(res2$x[,1],res2$x[,2], type="n", xlab=paste(" CP1  (", (round(100*sum.res2$importance[2,1],digits=1)), " % )"),
ylab=paste(" CP2  (", (round(100*sum.res2$importance[2,2],digits=1)), " % )"), main="ACP (dados normalizados) FoodPrice.xls")
text(res2$x[,1:2],lab=rownames(dadosx))




## Algumas verificações
# CP's de dados não normalizados
S=var(dadosx)
VectValProprios = eigen(S)
VectValProprios  #Comparar o  res1
res1

# Cálculo das CP's sobre os individuos
res1$x
t(t(dadosx)-sapply(dadosx, mean))%*% res1$rotation

# CP's de dados não normalizados
dadosxNorm = scale(dadosx)
SNorm=var(dadosxNorm)
SNorm
cor(dadosx)#comparar  SNorm com cor(dadosx)
VectValProprios = eigen(SNorm)
VectValProprios  #Comparar o  res2
res2

# calculo das CP's sobre os individuos
res2$x
dadosxNormMatrix=dadosxNorm[1:23,1:5]
scale(dadosxNormMatrix)%*% res2$rotation

#RESPOSTA ? PERGUNTA DO EXERC:
#escolhemos um indice (bivariado) o qual explica 70,5 % da variabilidade dos dados.
#Esse indice tem duas componentes calculadas do seguinte modo:
# Indice1= O.49*breadNorm + 0.58*burgerNorm + 0.34*milkNorm + 0.22*orangesNorm + 0.51*tomatoesNorm
# Indice2= -0.31*breadNorm -0.04*burgerNorm - 0.43*milkNorm - 0.80*orangesNorm + 0.29*tomatoesNorm


#Para medir a influ?ncia das variaveis originais na constru??o deste indice bivariado, determina-se 
# a correla??o entre as Variaveis originais e as CP's
cor(dadosxNormMatrix,res2$x)


########################################
########################################
# Biplot ACP COM OS DADOS DO FICHEIRO FoodPrice.xls
########################################
########################################

# Exercício: Atraves de um biplot (clássico de Gabriel), obter uma visualiza??o dos dados do Ficheiro FoodProce.xls 
# num espa?o reduzido indicando a percentagem de variabilidade explicada nesse espa?o.


# LEITURA DOS DADOS:
dados<-read.table("FoodPriceUSA.txt",sep="\t",dec=",",header=TRUE)

dados

# primeira coluna ser o nome das linhas
dadosx<-dados[,-1]
rownames(dadosx)<-dados[,1]
dadosx


# ACP sobre dados não normalidados 
#Nota: prcomp(...) usa DVS; Este ? o m?todo geralmente preferido
a<-prcomp(dadosx,scale=FALSE)
b<-summary(a)
b

par(mfrow=c(1,2))
plot(a$x[,1:2], main="ACP",xlab=paste(" CP1  (", (round(100*b$importance[2,1],digits=1)), " % )"),ylab=paste(" CP2  (", (round(100*b$importance[2,2],digits=1)), " % )"),type="n", pch=19)
text(a$x[,1:2],lab=rownames(dadosx))
abline(h=0,lty=2); abline(v=0,lty=2)

# Constru??o de um biplot usindo a fun??o "biplot"
# biplot preservando a m?trica das linha (form biplot)
biplot(a,choices=1:2, pch=15, cex=0.8,cex.axis=0.7,arrow.len = 0.05,xlab=paste(" CP1  (", (round(100*b$importance[2,1],digits=1)), " % )"),
ylab=paste(" CP2(", (round(100*b$importance[2,2],digits=1)), " % )"),var.axes=TRUE,scale=0, main="biplot preservando a m?trica das linhas")

# biplot preservando a m?trica das colunas (covariance biplot, biplot clássico, biplot segundo Gabriel)
#biplot(a,choices=1:2, pch=15, cex=0.8,cex.axis=0.7,arrow.len = 0.05,xlab=paste(" CP1  (", (round(100*b$importance[2,1],digits=1)), " % )"),
#ylab=paste(" CP2  (", (round(100*b$importance[2,2],digits=1)), " % )"),var.axes=TRUE,scale=1,  main="biplot clássico")
#biplot(a,choices=1:2, pch=15, cex=0.8,cex.axis=0.7,arrow.len = 0.05,var.axes=TRUE,scale=1,  main="biplot clássico")


par(mfrow=c(1,2))
biplot(a,choices=1:2, pch=15, cex=0.8,cex.axis=0.7,arrow.len = 0.05,var.axes=TRUE,scale=1,  main="biplot clássico")
biplot(a,choices=1:2, pch=15, cex=0.8,cex.axis=0.7,arrow.len = 0.05,var.axes=TRUE,scale=0,  main="biplot scale=0")





########################################
########################################
#
#Capítulo 5:    Análise Fatorial (para dados em escala de razí£o (métricos))

#
########################################
########################################


########################################
########################################
#
#  #  Parte 1: interpretação de resultados
#
########################################
########################################



#######
# Ler os dados
#######
	install.packages("foreign")
	library(foreign)  # for reading data stored by SPSS

data<-read.spss("DadosGarciaMarques2004.sav", to.data.frame = TRUE)
head(data)
dim(data)
str(data)


#######
#Preparação dos dados
#######
#Para considerar apenas dados não omissos usar:
#datax <- data[complete.cases(data), ]
#head(datax)
#str(datax)

dados=data[,-1]
head(dados)


#######
#ANÁLISES Modelo fatorial para dados não normalizados
#######
	install.packages("psych")
	library(psych)
###
#para dados não normalizados
###
rMatrix<-cov(dados)
#Determinação dos pesos facoriais
(AF<-principal(rMatrix, nfactors = 1,residuals = TRUE, rotate = "none", covar=TRUE) )



###
#para dados normalizados
###
rMatrix<-cor(dados)
#Determinação dos pesos facoriais
(AF<-principal(rMatrix, nfactors = 1,residuals = TRUE, rotate = "none") )




########################################
########################################
#
#  Parte 2: adequação do modelo fatorial
#
########################################
########################################


library(nFactors) # to help determine the number of factors/components to retain
#Regras de Determinação do numero de factores a reter:
parallelAnalysis<-nScree(rMatrix)
parallelAnalysis
plotnScree(parallelAnalysis)


# Rotação PESQUISAR
rotate="varimax"
#"none", "varimax", "quatimax", "promax", "oblimin", "simplimax", and "cluster" are possible rotations/transformations of the solution
rMatrix<-cor(dados)
#Determinação dos pesos facoriais
(AF<-principal(rMatrix, nfactors = 1,residuals = TRUE, rotate = "oblimin", scores=TRUE) )

#Cálculo do KMO e MSA
		### KMO e MSA

			print(KMO(dados),digits=3)

		### Teste de Bartlett
			cortest.bartlett(cor(dados),n=nrow(dados))
