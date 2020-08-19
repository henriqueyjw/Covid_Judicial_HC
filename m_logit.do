*---------------------------*
  *OLS by Logit Multinomial (Y=1, Negado; Y=2, Parcialmente aprovado; Y=3, Aprovado) sobre o universo de dados*
*---------------------------*
clear all
import excel "E:\natalia\hc\base_pop_stata.xlsx", sheet("Sheet3") firstrow

*Regressão dos resultados dos HCs sobre a menção da rec 62; gênero do paciente; gênero do relator;*
*tempo de atuação do juiz (antes e no TJSP); origem do juiz (magistrado, MP ou OAB); TAC/TACCRIM;*
*juiz (presidente); juiz (titular) e HC enviado pela defensoria.*
mlogit resultado i.rec62 i.c_genero_paciente i.genero_relator tempo_atuaçãojurídica_antesTJSP tempo_TJSP i.origem_juiz i.TACTACCRIM i.titular i.presidente i.defensoria
margins, dydx(i.rec62 i.c_genero_paciente i.genero_relator tempo_atuaçãojurídica_antesTJSP tempo_TJSP i.origem_juiz i.TACTACCRIM i.titular i.presidente i.defensoria) post
outreg2 using "E:\natalia\hc\resultados_pop.xls", replace ctitle(m_logit_juiz) keep(i.rec62 i.c_genero_paciente i.genero_relator tempo_atuaçãojurídica_antesTJSP tempo_TJSP i.origem_juiz i.TACTACCRIM i.titular i.presidente i.defensoria)

*Regressão dos resultados dos HCs sobre a menção da rec 62 e a menção de cada grupo de risco*
mlogit resultado i.rec62 i.grupo_risco_idosos i.gravidas_matern_lactante i.grupo_hiv i.grupo_tuberculose i.grupo_hepatite i.grupo_diabetes i.grupo_hipert i.indigenas
margins, dydx(i.rec62 i.grupo_risco_idosos i.gravidas_matern_lactante i.grupo_hiv i.grupo_tuberculose i.grupo_hepatite i.grupo_diabetes i.grupo_hipert i.indigenas) post
outreg2 using "E:\natalia\hc\resultados_pop.xls", append ctitle(m_logit_risco_1) keep(i.rec62 i.grupo_risco_idosos i.gravidas_matern_lactante i.grupo_hiv i.grupo_tuberculose i.grupo_hepatite i.grupo_diabetes i.grupo_hipert i.indigenas)

*Regressão dos resultados dos HCs sobre a menção da rec 62, a menção de cada grupo de risco (menos maternidade, gestante e lactante) e o gênero do paciente*
mlogit resultado i.rec62 i.c_genero_paciente i.grupo_risco_idosos i.grupo_hiv i.grupo_tuberculose i.grupo_hepatite i.grupo_diabetes i.grupo_hipert i.indigenas
margins, dydx(i.rec62 i.c_genero_paciente i.grupo_risco_idosos i.grupo_hiv i.grupo_tuberculose i.grupo_hepatite i.grupo_diabetes i.grupo_hipert i.indigenas) post
outreg2 using "E:\natalia\hc\resultados_pop.xls", append ctitle(m_logit_risco_2) keep(i.rec62 i.c_genero_paciente i.grupo_risco_idosos i.grupo_hiv i.grupo_tuberculose i.grupo_hepatite i.grupo_diabetes i.grupo_hipert i.indigenas)

*---------------------------*
  *OLS by Logit (Y=1; aprovado) sobre a amostra*
*---------------------------*
clear all
import excel "E:\natalia\hc\base_amostra_stata.xlsx", sheet("Sheet1") firstrow

*Regressão dos resultados dos HCs sobre a menção da rec 62; gênero do paciente; gênero do relator;*
*tempo de atuação do juiz (antes e no TJSP); origem do juiz (magistrado, MP ou OAB); TAC/TACCRIM;*
*juiz (presidente); juiz (titular) e HC enviado pela defensoria.*
logit c_resultado i.genero_magistrado i.origem_MP i.origem_OAB i.presidente i.defensoria i.liticonsorcio i.resolucao_62_geral
margins, dydx(i.genero_magistrado i.origem_MP i.origem_OAB i.presidente i.defensoria i.liticonsorcio i.resolucao_62_geral) post
outreg2 using "E:\natalia\hc\resultados_amostral.xls", replace ctitle(m_logit_juiz) keep(i.genero_magistrado i.origem_MP i.origem_OAB i.presidente i.defensoria i.liticonsorcio i.resolucao_62_geral)

*Regressão dos resultados dos HCs sobre a menção da rec 62 e a menção de tipos de crimes mais frequentes*
logit c_resultado i.liticonsorcio i.c_genero_paciente conduta_violenta trafico furto roubo homicidio vga i.resolucao_62_geral
margins, dydx(i.liticonsorcio i.c_genero_paciente conduta_violenta trafico furto roubo homicidio vga i.resolucao_62_geral) post
outreg2 using "E:\natalia\hc\resultados_amostral.xls", append ctitle(m_logit_crime) keep(i.liticonsorcio i.c_genero_paciente conduta_violenta trafico furto roubo homicidio vga i.resolucao_62_geral)
