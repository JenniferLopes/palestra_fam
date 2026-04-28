# Analise e Visualizacao de Dados
### Palestra - FAM Online - Jennifer Luz Lopes

> *"O analista que sabe comunicar vale mais que o que so sabe calcular. Aprendam os dois."*

---

## Sobre este repositorio

Este repositorio contém todos os materiais da palestra **Analise e Visualizacao de Dados**, apresentada para alunos de graduacao em TI na **FAM - Centro Universitario das Americas (FAM Online)**.

O objetivo da palestra e demonstrar, com dados reais e codigo reproduzivel, como cada etapa de uma analise - da coleta a visualizacao - gera valor concreto para a tomada de decisao.

---

## Estrutura

```
palestra_fam/
|
|-- case/                  # Case pratico em Quarto (.qmd)
|   |-- case_stackoverflow_2024.qmd
|
|-- scripts/               # Scripts R com os graficos da palestra
|   |-- scripts.R
|
|-- .gitignore
|-- palestra_fam.Rproj
```

---

## Case pratico

**Pergunta de negocio:**
> O que mais impacta o salario de um desenvolvedor brasileiro?

**Dataset:** Stack Overflow Developer Survey 2024
- 65.437 respondentes - 185 paises - dados publicos e gratuitos
- Fonte: [survey.stackoverflow.co/2024](https://survey.stackoverflow.co/2024)
- Disponivel via pacote R `tidytuesdayR` - semana `2024-09-03`

**Principais insights encontrados:**

| Insight | Dado |
|---|---|
| Outro pos-grad lidera em salario | USD 38.649 vs Mestrado USD 36.086 |
| Doutorado nao garante maior salario em TI | Doutorado: USD 17.623 vs Bacharelado: USD 24.933 |
| Maior salto: entre 0-2 e 3-5 anos de exp. | De USD 6.826 para USD 16.577 (+143%) |
| Plato apos 15 anos de experiencia | 11-15 anos: USD 41.960 \| 15+ anos: USD 41.027 (~0%) |
| Data Scientist e o 2o cargo mais bem pago globalmente | Mediana global: USD 99.043 |
| Gap Data Scientist vs Back-end dev | +74% a mais (USD 57.024) |

---

## Galeria de graficos

O arquivo `scripts/scripts.R` contem **19 graficos** organizados em 6 categorias:

| Categoria | Tipos |
|---|---|
| Comparacao | Barras - Lollipop - Dot plot Cleveland |
| Distribuicao | Histograma - Boxplot - Violin |
| Evolucao | Linha - Area - Slope chart |
| Parte-todo | Treemap - Pizza/Donut - Barras empilhadas |
| Relacao | Scatter - Bubble - Heatmap de correlacao |
| Geoespacial | Bubble map - Choropleth - Dot map |

Todos os graficos usam dados simulados com a paleta visual **Cafe com R** e sao exportados em alta resolucao (300 DPI).

---

## Como reproduzir

### Pre-requisitos

```r
# Instalar pacotes necessarios
install.packages("pacman")

pacman::p_load(
  tidyverse,
  scales,
  tidytuesdayR,
  maps,
  patchwork,
  here,
  knitr
)
```

### Rodar os graficos

```r
# Abrir o projeto
# palestra_fam.Rproj

# Executar o script completo
source("scripts/scripts.R")
# Os graficos serao exportados para a pasta output/
```

### Renderizar o case

```r
# No RStudio, com o arquivo .qmd aberto:
quarto::quarto_render("case/case_stackoverflow_2024.qmd")

# Ou no terminal:
# quarto render case/case_stackoverflow_2024.qmd
```

---

## Tema CSS

O documento Quarto usa o arquivo `fam_theme.css` com a paleta visual da **FAM Online**:

| Cor | Hex | Uso |
|---|---|---|
| Laranja FAM | `#EE8127` | Titulos de secao - destaque |
| Ciano FAM Online | `#02A7CF` | Links - callout note |
| Navy | `#0A1928` | Cabecalho - fundo |
| Cinza FAM | `#818084` | Texto secundario |

---

## Links da Palestra

Esses recursos foram mencionados ao longo da palestra:

| Recurso | Link |
|---|---|
| Stack Overflow Survey 2024 | [survey.stackoverflow.co/2024](https://survey.stackoverflow.co/2024) |
| DataViz Project | [datavizproject.com](https://datavizproject.com) |
| 1 dataset 100 visualizacoes | [100.datavizproject.com](https://100.datavizproject.com) |
| Data to Viz | [data-to-viz.com](https://www.data-to-viz.com) |
| R Graph Gallery | [r-graph-gallery.com](https://r-graph-gallery.com) |
| Python Graph Gallery | [python-graph-gallery.com](https://python-graph-gallery.com) |
| D3 Graph Gallery | [d3-graph-gallery.com](https://d3-graph-gallery.com) |
| TimeViz Browser | [browser.timeviz.net](https://browser.timeviz.net) |
| Datawrapper | [app.datawrapper.de](https://app.datawrapper.de/river) |
| Flourish | [flourish.studio/examples](https://flourish.studio/examples) |
| Checklist de etapas | [hackmd.io](https://hackmd.io/@RY-bd3qORkmelWjJal4fIA/rJC9dNupyg) |
| Material Design - DataViz | [m2.material.io/design/communication](https://m2.material.io/design/communication/data-visualization.html) |
| Material Design - Acessibilidade | [m2.material.io/design/usability](https://m2.material.io/design/usability/accessibility.html) |

---

## Mais Links

1. **The R Graph Gallery** - A maior colecao de graficos feitos em R. Mais de 400 exemplos organizados por tipo.
   [https://r-graph-gallery.com](https://r-graph-gallery.com)

2. **The Python Graph Gallery** - O equivalente para Python. Mesma estrutura, mesma qualidade de referencia.
   [https://python-graph-gallery.com](https://python-graph-gallery.com)

3. **Data to Viz - Caveats** - Colecao de ressalvas e erros comuns em visualizacao de dados.
   [https://www.data-to-viz.com/caveats.html](https://www.data-to-viz.com/caveats.html)

4. **Dataviz Inspiration** - O Pinterest da visualizacao de dados. Para quando voce precisa de referencia antes de comecar.
   [https://dataviz-inspiration.com](https://dataviz-inspiration.com)

5. **Dataviz Project** - Catalogo de tipos de visualizacao com definicoes e quando usar cada um.
   [https://datavizproject.com](https://datavizproject.com)

6. **Data Viz Catalogue** - Mais um catalogo completo de tipos de graficos com exemplos visuais.
   [https://datavizcatalogue.com](https://datavizcatalogue.com)

7. **The TimeViz Browser 2.0** - Referencia especifica para visualizacao de dados temporais.
   [https://browser.timeviz.net](https://browser.timeviz.net)

8. **Datawrapper** - Ferramenta para criar graficos e mapas sem codigo. Direto no navegador.
   [https://app.datawrapper.de](https://app.datawrapper.de)

9. **Flourish** - Duplique um modelo e faca o seu grafico. Impressionante para quem quer resultado rapido e bonito.
   [https://flourish.studio](https://flourish.studio)

10. **Cedric Scherer - Data Visualization & Information Design** - Um dos maiores referencias mundiais em dataviz.
    [https://www.cedricscherer.com](https://www.cedricscherer.com)

11. **1 Dataset, 100 Visualizations** - O mesmo conjunto de dados representado de 100 formas diferentes. Abre a cabeca.
    [https://100.datavizproject.com](https://100.datavizproject.com)

12. **datasauRus** - O Datasaurus Dozen mostra por que visualizar e indispensavel. Estatisticas resumidas podem ser identicas e as distribuicoes completamente diferentes.
    [https://github.com/jumpingrivers/datasauRus](https://github.com/jumpingrivers/datasauRus)

13. **Anscombe's Quartet** - Quatro conjuntos de dados com estatisticas descritivas quase identicas e distribuicoes completamente distintas quando visualizadas. Um classico que todo analista precisa conhecer.
    [https://en.wikipedia.org/wiki/Anscombe%27s_quartet](https://en.wikipedia.org/wiki/Anscombe%27s_quartet)

14. **Nicola Rennie - Expert em dataviz em R**
    [https://nrennie.rbind.io](https://nrennie.rbind.io)

---

## Desafios de Visualizacao

Quer praticar? Participe do **#TidyTuesday** - um desafio semanal de visualizacao de dados da comunidade R.

A cada semana um dataset publico e disponibilizado e a comunidade compartilha suas visualizacoes no Twitter/X com a hashtag `#TidyTuesday`.

[https://github.com/rfordatascience/tidytuesday](https://github.com/rfordatascience/tidytuesday)

---

## Referencias

### Livros
- **Storytelling com Dados** - Cole Nussbaumer Knaflic (Alta Books, 2019)
- **The Visual Display of Quantitative Information** - Edward Tufte (Graphics Press, 1983)
- **How Charts Lie** - Alberto Cairo (W. W. Norton, 2019)
- **Data Visualisation** - Andy Kirk (SAGE, 2019)

---

## Sobre a autora

**Jennifer Luz Lopes**
Engenheira Agronoma - Dra. em Melhoramento Genetico - Analista de Dados SR

- Consultora e Instrutora em Estatistica e Ciencia de Dados em R
- Cofundadora do [R-Ladies Goiania](https://www.rladiesgyn.com/)
- Criadora do **Cafe com R**
- [linkedin.com/in/jennifer-luz-lopes](https://www.linkedin.com/in/jennifer-luz-lopes)

---

## Licenca

Este material e de uso educacional livre.
Os dados do Stack Overflow estao disponiveis sob licenca
[Open Database License (ODbL)](https://opendatacommons.org/licenses/odbl/).

---

<div align="center">
  <sub>FAM Online - Graduacao em TI - 2025</sub>
</div>
