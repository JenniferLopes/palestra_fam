# Análise e Visualização de Dados

### Palestra - FAM Online \| FAM Centro Universitário das Américas Jennifer Luz Lopes

![](images/clipboard-2755452795.png)

![](images/clipboard-566354187.png)

## Sobre este repositório

Este repositório contém todos os materiais da palestra **Análise e Visualização de Dados**, apresentada para alunos de graduação em TI na **FAM - Centro Universitário das Américas (FAM Online)**.

O objetivo da palestra é demonstrar, com dados reais e código reproduzível, como cada etapa de uma análise - da coleta à visualização - gera valor concreto para a tomada de decisão.

## Estrutura

```         
palestra_fam/
|
|-- case/                  # Case prático em Quarto (.qmd)
|   |-- case_stackoverflow_2024.qmd
|
|-- scripts/               # Scripts R com os gráficos da palestra
|   |-- scripts.R
|
|-- .gitignore
|-- palestra_fam.Rproj
```

------------------------------------------------------------------------

## Case prático

**Pergunta de negócio:**

> **O que mais impacta o salário de um desenvolvedor brasileiro?**

**Dataset:** **Stack Overflow Developer Survey 2024**

-   65.437 respondentes

-   185 países

-   Dados públicos e gratuitos

-   Fonte: <https://github.com/rfordatascience/tidytuesday/tree/main/data/2024/2024-09-03>

-   Disponível via pacote R `tidytuesdayR` - semana `2024-09-03`

**Principais insights encontrados:**

| Insight | Dado |
|------------------------------------|------------------------------------|
| Outro pós-grad lidera em salário | USD 38.649 vs Mestrado USD 36.086 |
| Doutorado não garante maior salário em TI | Doutorado: USD 17.623 vs Bacharelado: USD 24.933 |
| Maior salto: entre 0-2 e 3-5 anos de exp. | De USD 6.826 para USD 16.577 (+143%) |
| Platô após 15 anos de experiência | 11-15 anos: USD 41.960 \| 15+ anos: USD 41.027 (\~0%) |
| Data Scientist é o 2º cargo mais bem pago globalmente | Mediana global: USD 99.043 |
| Gap Data Scientist vs Back-end dev | +74% a mais (USD 57.024) |

------------------------------------------------------------------------

## Galeria de gráficos

O arquivo `scripts/scripts.R` contém **19 gráficos** organizados em 6 categorias:

| Categoria    | Tipos                                     |
|--------------|-------------------------------------------|
| Comparação   | Barras - Lollipop - Dot plot Cleveland    |
| Distribuição | Histograma - Boxplot - Violin             |
| Evolução     | Linha - Área - Slope chart                |
| Parte-todo   | Treemap - Pizza/Donut - Barras empilhadas |
| Relação      | Scatter - Bubble - Heatmap de correlação  |
| Geoespacial  | Bubble map - Choropleth - Dot map         |

Todos os gráficos usam dados simulados com a paleta visual **Café com R** e são exportados em alta resolução (300 DPI).

------------------------------------------------------------------------

## Como reproduzir

### Pré-requisitos

``` r
# Instalar pacotes necessários
install.packages("pacman")

pacman::p_load(
  tidyverse,
  scales,
  tidytuesdayR,
  maps,
  patchwork,
  here,
  knitr)
```

### Rodar os gráficos

``` r
# Abrir o projeto
# palestra_fam.Rproj

# Executar o script completo
source("scripts/scripts.R")
# Os gráficos serão exportados para a pasta output/
```

### Renderizar o case

``` r
# No RStudio, com o arquivo .qmd aberto:
quarto::quarto_render("case/case_stackoverflow_2024.qmd")

# Ou no terminal:
# quarto render case/case_stackoverflow_2024.qmd
```

------------------------------------------------------------------------

## Tema CSS

O documento Quarto usa o arquivo `fam_theme.css` com a paleta visual da **FAM**:

| Cor              | Hex       | Uso                         |
|------------------|-----------|-----------------------------|
| Laranja FAM      | `#EE8127` | Títulos de seção - destaque |
| Ciano FAM Online | `#02A7CF` | Links - callout note        |
| Navy             | `#0A1928` | Cabeçalho - fundo           |
| Cinza FAM        | `#818084` | Texto secundário            |

------------------------------------------------------------------------

## Links da Palestra

Esses recursos foram mencionados ao longo da palestra:

| Recurso | Link |
|------------------------------------|------------------------------------|
| Stack Overflow Survey 2024 | [survey.stackoverflow.co/2024](https://survey.stackoverflow.co/2024) |
| DataViz Project | [datavizproject.com](https://datavizproject.com) |
| 1 dataset 100 visualizações | [100.datavizproject.com](https://100.datavizproject.com) |
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

------------------------------------------------------------------------

## Mais Links

1.  **The R Graph Gallery** - A maior coleção de gráficos feitos em R.
    Mais de 400 exemplos organizados por tipo.
    <https://r-graph-gallery.com>

2.  **The Python Graph Gallery** - O equivalente para Python.
    Mesma estrutura, mesma qualidade de referência.
    <https://python-graph-gallery.com>

3.  **Data to Viz - Caveats** - Coleção de ressalvas e erros comuns em visualização de dados.
    <https://www.data-to-viz.com/caveats.html>

4.  **Dataviz Inspiration** - O Pinterest da visualização de dados.
    Para quando você precisa de referência antes de começar.
    <https://dataviz-inspiration.com>

5.  **Dataviz Project** - Catálogo de tipos de visualização com definições e quando usar cada um.
    <https://datavizproject.com>

6.  **Data Viz Catalogue** - Mais um catálogo completo de tipos de gráficos com exemplos visuais.
    <https://datavizcatalogue.com>

7.  **The TimeViz Browser 2.0** - Referência específica para visualização de dados temporais.
    <https://browser.timeviz.net>

8.  **Datawrapper** - Ferramenta para criar gráficos e mapas sem código.
    Direto no navegador.
    <https://app.datawrapper.de>

9.  **Flourish** - Duplique um modelo e faça o seu gráfico.
    Impressionante para quem quer resultado rápido e bonito.
    <https://flourish.studio>

10. **Cédric Scherer - Data Visualization & Information Design** - Um dos maiores referências mundiais em dataviz.
    <https://www.cedricscherer.com>

11. **1 Dataset, 100 Visualizations** - O mesmo conjunto de dados representado de 100 formas diferentes.
    Abre a cabeça.
    <https://100.datavizproject.com>

12. **datasauRus** - O Datasaurus Dozen mostra por que visualizar é indispensável.
    Estatísticas resumidas podem ser idênticas e as distribuições completamente diferentes.
    <https://github.com/jumpingrivers/datasauRus>

13. **Anscombe's Quartet** - Quatro conjuntos de dados com estatísticas descritivas quase idênticas e distribuições completamente distintas quando visualizadas.
    Um clássico que todo analista precisa conhecer.
    <https://en.wikipedia.org/wiki/Anscombe%27s_quartet>

14. **Nicola Rennie - Expert em dataviz em R** <https://nrennie.rbind.io>

------------------------------------------------------------------------

## Desafios de Visualização

**Quer praticar?**

-   Participe do **#TidyTuesday**

-   Um desafio semanal de visualização de dados da comunidade R.

A cada semana um dataset público é disponibilizado e a comunidade compartilha suas visualizações no Twitter/X com a hashtag `#TidyTuesday`.

<https://github.com/rfordatascience/tidytuesday>

------------------------------------------------------------------------

## Referências

### Livros

-   **Storytelling com Dados** - Cole Nussbaumer Knaflic (Alta Books, 2019)
-   **The Visual Display of Quantitative Information** - Edward Tufte (Graphics Press, 1983)
-   **How Charts Lie** - Alberto Cairo (W. W. Norton, 2019)
-   **Data Visualisation** - Andy Kirk (SAGE, 2019)

------------------------------------------------------------------------

## Sobre a autora

**Jennifer Luz Lopes** Engenheira Agrônoma - Dra.
em Melhoramento Genético - Analista de Dados SR

-   Consultora e Instrutora em Estatística e Ciência de Dados em R
-   Cofundadora do [R-Ladies Goiânia](https://www.rladiesgyn.com/)
-   Criadora do **Café com R**
-   [linkedin.com/in/jennifer-luz-lopes](https://www.linkedin.com/in/jennifer-luz-lopes)

------------------------------------------------------------------------

## Licença

Este material é de uso educacional livre.
Os dados do Stack Overflow estão disponíveis sob licença [Open Database License (ODbL)](https://opendatacommons.org/licenses/odbl/).

------------------------------------------------------------------------
