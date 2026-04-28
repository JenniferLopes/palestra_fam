# ============================================================
#  Galeria Completa - 6 Categorias de Gráficos + Linguagens
#  19 gráficos | dados simulados
#  Paleta: Jennifer Lopes | Café com R
#
#  CORREÇÕES APLICADAS NESTA VERSÃO:
#    1. PIB reordenado: Brasil > México (valores corrigidos)
#    2. Distribuição: eixo Y inicia em 0, limites explícitos
#    3. Histograma: eixo X com limite explícito, sem corte
#    4. Boxplot/Violin: eixo Y com expand = c(0,0) removido
#       para não cortar bigodes
#    5. Adicionado gráfico 19: uso de linguagens (R, Python, etc.)
# ============================================================

# install.packages("pacman")

pacman::p_load(
  ggplot2,
  dplyr,
  tidyr,
  forcats,
  patchwork,
  scales,
  maps,
  here
)

# ------------------------------------------------------------
# PALETA E TEMA
# ------------------------------------------------------------

cafe   <- "#6F4E37"
escuro <- "#4B2E2B"
medio  <- "#A67B5B"
claro  <- "#D9B38C"
creme  <- "#F5E6D3"
azul1  <- "#2C7FB8"
azul2  <- "#276DC3"
azul3  <- "#1F4E8C"

caption_padrao <- "Dados simulados | Café com R"

tema_cafe <- theme_minimal(base_size = 13) +
  theme(
    plot.background   = element_rect(fill = creme,  color = NA),
    panel.background  = element_rect(fill = creme,  color = NA),
    panel.grid.major  = element_line(color = claro, linewidth = 0.4,
                                     linetype = "dashed"),
    panel.grid.minor  = element_blank(),
    plot.title        = element_text(color = escuro, face = "bold", size = 15),
    plot.subtitle     = element_text(color = medio,  size = 11),
    plot.caption      = element_text(color = medio,  size = 9, hjust = 1),
    axis.text         = element_text(color = cafe),
    axis.title        = element_text(color = escuro),
    legend.background = element_rect(fill = creme,  color = NA),
    legend.text       = element_text(color = cafe),
    legend.title      = element_text(color = escuro, face = "bold"),
    plot.margin       = margin(16, 20, 12, 16)
  )

# ============================================================
# CATEGORIA 1 - COMPARAÇÃO
# ============================================================

# CORREÇÃO: Brasil > México (valores mais próximos da realidade)
# Ordem correta: Brasil lidera, depois México, Argentina, etc.
paises <- c("Brasil","México","Argentina","Colômbia","Chile",
            "Peru","Equador","Venezuela","Bolívia","Paraguai")

comp_dados <- data.frame(
  pais         = factor(paises, levels = paises),
  pib          = c(2130, 1810, 622, 363, 344, 268, 118, 92, 45, 43),
  pib_anterior = c(1920, 1320, 630, 320, 310, 240, 115, 95, 44, 42)
)

g_comp_01 <- comp_dados |>
  mutate(pais = fct_reorder(pais, pib)) |>
  ggplot(aes(x = pib, y = pais)) +
  geom_col(fill = cafe, width = 0.7) +
  geom_text(
    aes(label = paste0("US$ ", format(pib, big.mark = ".", decimal.mark = ","), "bi")),
    hjust = -0.1, size = 3.2, color = escuro, fontface = "bold") +
  scale_x_continuous(
    labels = function(x) paste0("$", x, "bi"),
    limits = c(0, 2600),
    expand = expansion(mult = c(0, 0.05))) +
  labs(
    title    = "Barras - Comparação",
    subtitle = "PIB dos países da América Latina - 2024 (USD bilhões)",
    x        = "PIB (USD bilhões)", y = NULL,
    caption  = caption_padrao) +
  tema_cafe +
  theme(panel.grid.major.y = element_blank())

g_comp_02 <- comp_dados |>
  mutate(pais = fct_reorder(pais, pib)) |>
  ggplot(aes(x = pib, y = pais)) +
  geom_segment(aes(x = 0, xend = pib, yend = pais),
               color = medio, linewidth = 0.9) +
  geom_point(size = 4.5, color = cafe) +
  geom_text(aes(label = paste0("$", pib, "bi")),
            hjust = -0.4, size = 3.2, color = escuro, fontface = "bold") +
  scale_x_continuous(
    limits = c(0, 2800),
    labels = function(x) paste0("$", x)) +
  labs(
    title    = "Lollipop - Comparação",
    subtitle = "PIB dos países da América Latina - 2024 (USD bilhões)",
    x        = "PIB (USD bilhões)", y = NULL,
    caption  = caption_padrao) +
  tema_cafe +
  theme(panel.grid.major.y = element_blank())

g_comp_03 <- comp_dados |>
  mutate(pais = fct_reorder(pais, pib)) |>
  ggplot(aes(y = pais)) +
  geom_segment(aes(x = pib_anterior, xend = pib, yend = pais),
               color = claro, linewidth = 1.4) +
  geom_point(aes(x = pib_anterior), color = medio,  size = 4.5) +
  geom_point(aes(x = pib),          color = escuro, size = 4.5) +
  scale_x_continuous(
    labels = function(x) paste0("$", x, "bi"),
    limits = c(0, 2800),
    expand = expansion(mult = c(0, 0.08))) +
  annotate("text", x = 2400, y = 2.5, label = "Anterior",
           color = medio,  size = 3.5, fontface = "bold") +
  annotate("text", x = 2400, y = 1.4, label = "2024",
           color = escuro, size = 3.5, fontface = "bold") +
  labs(
    title    = "Dot Plot Cleveland - Comparação",
    subtitle = "Variação do PIB - ano anterior vs 2024",
    x        = "PIB (USD bilhões)", y = NULL,
    caption  = caption_padrao) +
  tema_cafe +
  theme(panel.grid.major.y = element_blank())

# ============================================================
# CATEGORIA 2 - DISTRIBUIÇÃO
# CORREÇÃO: eixos Y explícitos para não cortar distribuições
# ============================================================

set.seed(123)
n <- 600

dist_dados <- data.frame(
  regiao = rep(c("Norte","Nordeste","Centro-Oeste","Sudeste","Sul"), each = n / 5),
  renda  = c(
    rnorm(n/5, 1200, 350),
    rnorm(n/5, 1500, 420),
    rnorm(n/5, 2200, 600),
    rnorm(n/5, 3100, 900),
    rnorm(n/5, 2800, 750))
) |>
  mutate(
    # CORREÇÃO: pmax garante que não há rendas negativas ou < 500
    renda  = pmax(renda, 500),
    regiao = factor(regiao,
                    levels = c("Norte","Nordeste","Centro-Oeste","Sul","Sudeste"))
  )

cores_regiao <- c(
  "Norte"       = escuro,
  "Nordeste"    = cafe,
  "Centro-Oeste"= medio,
  "Sul"         = azul1,
  "Sudeste"     = azul3
)

media_se <- mean(dist_dados$renda[dist_dados$regiao == "Sudeste"])

# CORREÇÃO: eixo X com limite explícito (0 a 6000), sem corte à esquerda
g_dist_04 <- dist_dados |>
  filter(regiao == "Sudeste") |>
  ggplot(aes(x = renda)) +
  geom_histogram(bins = 30, fill = cafe, color = creme, linewidth = 0.3) +
  geom_vline(xintercept = media_se,
             color = escuro, linewidth = 1.1, linetype = "dashed") +
  annotate("text", x = media_se + 250, y = Inf,
           label = paste0("Média\nR$", round(media_se, 0)),
           vjust = 1.5, color = escuro, size = 3.2, fontface = "bold") +
  scale_x_continuous(
    labels = dollar_format(prefix = "R$", big.mark = "."),
    limits = c(0, 7000),          # CORREÇÃO: começa em 0
    expand = expansion(mult = c(0, 0.02))) +
  scale_y_continuous(
    expand = expansion(mult = c(0, 0.08))) +  # CORREÇÃO: Y começa em 0
  labs(
    title    = "Histograma - Distribuição",
    subtitle = "Renda mensal - região Sudeste (média tracejada)",
    x        = "Renda mensal (R$)", y = "Frequência",
    caption  = caption_padrao) +
  tema_cafe

# CORREÇÃO: eixo Y com margem para não cortar bigodes
g_dist_05 <- dist_dados |>
  ggplot(aes(x = regiao, y = renda, fill = regiao)) +
  geom_boxplot(alpha = 0.8, width = 0.55,
               outlier.color = medio, outlier.size = 1.5) +
  scale_fill_manual(values = cores_regiao) +
  scale_y_continuous(
    labels = dollar_format(prefix = "R$", big.mark = "."),
    limits = c(0, NA),              # CORREÇÃO: Y mínimo em 0
    expand = expansion(mult = c(0.01, 0.08))) +
  labs(
    title    = "Boxplot - Distribuição",
    subtitle = "Distribuição da renda mensal por região",
    x        = NULL, y = "Renda mensal (R$)",
    caption  = caption_padrao) +
  tema_cafe +
  theme(legend.position = "none", panel.grid.major.x = element_blank())

# CORREÇÃO: mesma lógica de eixo Y para violin
g_dist_06 <- dist_dados |>
  ggplot(aes(x = regiao, y = renda, fill = regiao)) +
  geom_violin(alpha = 0.75, trim = TRUE) +
  geom_boxplot(width = 0.08, fill = creme,
               color = escuro, outlier.shape = NA) +
  scale_fill_manual(values = cores_regiao) +
  scale_y_continuous(
    labels = dollar_format(prefix = "R$", big.mark = "."),
    limits = c(0, NA),              # CORREÇÃO: Y mínimo em 0
    expand = expansion(mult = c(0.01, 0.08))) +
  labs(
    title    = "Violin - Distribuição",
    subtitle = "Forma da distribuição de renda com boxplot interno",
    x        = NULL, y = "Renda mensal (R$)",
    caption  = caption_padrao) +
  tema_cafe +
  theme(legend.position = "none", panel.grid.major.x = element_blank())

# ============================================================
# CATEGORIA 3 - EVOLUÇÃO
# ============================================================

meses <- seq(as.Date("2020-01-01"), as.Date("2024-12-01"), by = "month")
set.seed(42)

evo_dados <- data.frame(
  data     = rep(meses, 3),
  app      = rep(c("Nubank","Inter","C6 Bank"), each = length(meses)),
  usuarios = c(
    cumsum(c(8,  runif(length(meses)-1, 0.4, 1.8))) * 1e6,
    cumsum(c(5,  runif(length(meses)-1, 0.3, 1.2))) * 1e6,
    cumsum(c(2,  runif(length(meses)-1, 0.2, 0.9))) * 1e6)
) |>
  mutate(app = factor(app, levels = c("Nubank","Inter","C6 Bank")))

cores_app <- c("Nubank" = escuro, "Inter" = cafe, "C6 Bank" = azul1)

g_evo_07 <- evo_dados |>
  ggplot(aes(x = data, y = usuarios, color = app, group = app)) +
  geom_line(linewidth = 1.1) +
  scale_color_manual(values = cores_app, name = "App") +
  scale_y_continuous(
    labels = label_number(scale = 1e-6, suffix = "M"),
    limits = c(0, NA),
    expand = expansion(mult = c(0, 0.08))) +
  scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
  labs(
    title    = "Linha - Evolução",
    subtitle = "Crescimento de usuários de fintechs - 2020 a 2024",
    x        = NULL, y = "Usuários (milhões)",
    caption  = caption_padrao) +
  tema_cafe

g_evo_08 <- evo_dados |>
  ggplot(aes(x = data, y = usuarios, fill = app, group = app)) +
  geom_area(alpha = 0.70, position = "stack") +
  scale_fill_manual(values = cores_app, name = "App") +
  scale_y_continuous(
    labels = label_number(scale = 1e-6, suffix = "M"),
    limits = c(0, NA),
    expand = expansion(mult = c(0, 0.08))) +
  scale_x_date(date_breaks = "1 year", date_labels = "%Y") +
  labs(
    title    = "Área - Evolução",
    subtitle = "Total acumulado de usuários - fintechs empilhadas",
    x        = NULL, y = "Usuários (milhões)",
    caption  = caption_padrao) +
  tema_cafe

slope_dados <- evo_dados |>
  filter(format(data, "%Y-%m") %in% c("2020-01","2024-12")) |>
  mutate(
    ano = ifelse(format(data, "%Y") == "2020", "Jan/2020", "Dez/2024"),
    ano = factor(ano, levels = c("Jan/2020","Dez/2024")))

g_evo_09 <- slope_dados |>
  ggplot(aes(x = ano, y = usuarios / 1e6, group = app, color = app)) +
  geom_line(linewidth = 1.5) +
  geom_point(size = 4.5) +
  geom_text(
    data  = ~ filter(.x, ano == "Dez/2024"),
    aes(label = paste0(app, "\n", round(usuarios/1e6, 0), "M")),
    hjust = -0.12, size = 3.2, fontface = "bold") +
  scale_color_manual(values = cores_app) +
  scale_x_discrete(expand = expansion(add = c(0.2, 1.5))) +
  scale_y_continuous(
    labels = function(x) paste0(round(x, 0), "M"),
    limits = c(0, NA),
    expand = expansion(mult = c(0, 0.1))) +
  labs(
    title    = "Slope Chart - Evolução",
    subtitle = "Crescimento total de usuários - jan/2020 vs dez/2024",
    x        = NULL, y = "Usuários (milhões)",
    caption  = caption_padrao) +
  tema_cafe +
  theme(legend.position = "none")

# ============================================================
# CATEGORIA 4 - PARTE-TODO
# ============================================================

parte_dados <- data.frame(
  categoria = c("Alimentacao","Moradia","Transporte",
                "Saude","Educacao","Lazer","Vestuario","Outros"),
  valor     = c(28, 24, 14, 10, 8, 7, 5, 4)
) |>
  mutate(
    categoria = factor(categoria,
                       levels = categoria[order(valor, decreasing = TRUE)]),
    pct = valor / sum(valor))

cores_parte <- c(escuro, cafe, medio, azul1, azul3, azul2, claro, "#C8A882")

treemap_layout <- function(df, value_col, label_col,
                           x0=0, y0=0, w=1, h=1) {
  df2  <- df[order(df[[value_col]], decreasing = TRUE), ]
  vals <- df2[[value_col]]
  labs <- as.character(df2[[label_col]])
  rects <- vector("list", nrow(df2))
  cx <- x0; cy <- y0; cw <- w; ch <- h
  for (i in seq_len(nrow(df2))) {
    frac <- vals[i] / sum(vals[i:nrow(df2)])
    if (cw >= ch) {
      rw <- cw * frac
      rects[[i]] <- data.frame(
        xmin=cx, xmax=cx+rw, ymin=cy, ymax=cy+ch, label=labs[i], val=vals[i])
      cx <- cx + rw; cw <- cw - rw
    } else {
      rh <- ch * frac
      rects[[i]] <- data.frame(
        xmin=cx, xmax=cx+cw, ymin=cy, ymax=cy+rh, label=labs[i], val=vals[i])
      cy <- cy + rh; ch <- ch - rh
    }
  }
  bind_rows(rects) |>
    mutate(mx = (xmin+xmax)/2, my = (ymin+ymax)/2)
}

tm_df <- treemap_layout(parte_dados, "valor", "categoria") |>
  mutate(categoria = factor(label, levels = levels(parte_dados$categoria)))

g_parte_10 <- tm_df |>
  ggplot() +
  geom_rect(aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax, fill=categoria),
            color=creme, linewidth=1.0) +
  geom_text(aes(x=mx, y=my, label=paste0(label, "\n", val, "%")),
            size=3.5, color=creme, fontface="bold") +
  scale_fill_manual(values=cores_parte) +
  coord_equal() +
  labs(
    title    = "Treemap - Parte-todo",
    subtitle = "Composição do orçamento familiar médio",
    caption  = caption_padrao) +
  tema_cafe +
  theme(legend.position="none", axis.text=element_blank(),
        axis.title=element_blank(), panel.grid=element_blank())

pizza_df <- parte_dados |>
  arrange(desc(valor)) |>
  mutate(ymax=cumsum(pct), ymin=lag(ymax, default=0), mid=(ymin+ymax)/2)

g_parte_11 <- ggplot(pizza_df,
                     aes(ymax=ymax, ymin=ymin, xmax=4, xmin=2.4, fill=categoria)) +
  geom_rect(color=creme, linewidth=0.7) +
  geom_text(aes(x=3.75, y=mid, label=paste0(valor, "%")),
            size=3.0, color=creme, fontface="bold") +
  coord_polar(theta="y") +
  scale_fill_manual(values=cores_parte, name="Categoria") +
  xlim(c(0, 4)) +
  labs(
    title    = "Pizza / Donut - Parte-todo",
    subtitle = "Composição do orçamento - use com no máx. 5 fatias",
    caption  = caption_padrao) +
  tema_cafe +
  theme(axis.text=element_blank(), axis.title=element_blank(),
        panel.grid=element_blank())

sub_dados <- data.frame(
  perfil    = rep(c("Classe A","Classe B","Classe C"), each=8),
  categoria = rep(parte_dados$categoria, 3),
  valor     = c(15,32,10,14,6,12,7,4,
                26,26,14,10,8,7,5,4,
                35,18,17,8,10,5,4,3)
) |>
  group_by(perfil) |>
  mutate(pct = valor / sum(valor)) |>
  ungroup()

g_parte_12 <- sub_dados |>
  ggplot(aes(x=perfil, y=pct, fill=categoria)) +
  geom_col(width=0.6) +
  scale_y_continuous(
    labels = percent_format(),
    expand = expansion(mult = c(0, 0.02))) +
  scale_fill_manual(values=cores_parte, name="Categoria") +
  labs(
    title    = "Barras empilhadas 100% - Parte-todo",
    subtitle = "Composição do orçamento por classe social",
    x=NULL, y="Proporção",
    caption  = caption_padrao) +
  tema_cafe +
  theme(panel.grid.major.x=element_blank())

# ============================================================
# CATEGORIA 5 - RELAÇÃO
# ============================================================

set.seed(99)
n_rel <- 200

rel_dados <- data.frame(
  pais       = sample(c("Brasil","México","Argentina","Colômbia","Chile"),
                      n_rel, replace=TRUE),
  pib_capita = runif(n_rel, 3000, 22000),
  populacao  = runif(n_rel, 0.5, 215)
)
rel_dados$expectativa <- pmin(pmax(
  55 + 0.0009 * rel_dados$pib_capita + rnorm(n_rel, 0, 2.5), 58), 80)

cores_rel <- c("Brasil"=escuro, "México"=cafe, "Argentina"=medio,
               "Colômbia"=azul1, "Chile"=azul3)

g_rel_13 <- rel_dados |>
  ggplot(aes(x=pib_capita, y=expectativa, color=pais)) +
  geom_point(alpha=0.7, size=2.5) +
  geom_smooth(method="lm", formula = y ~ x, se=FALSE,
              color=escuro, linewidth=0.8, linetype="dashed") +
  scale_color_manual(values=cores_rel, name="País") +
  scale_x_continuous(
    labels=dollar_format(prefix="US$", big.mark="."),
    limits=c(0, 25000),
    expand=expansion(mult=c(0, 0.05))) +
  scale_y_continuous(
    limits=c(55, 82),
    expand=expansion(mult=c(0.02, 0.05))) +
  labs(
    title    = "Scatter - Relação",
    subtitle = "PIB per capita vs expectativa de vida - América Latina",
    x        = "PIB per capita (USD)", y = "Expectativa de vida (anos)",
    caption  = caption_padrao) +
  tema_cafe

bub_dados <- rel_dados |>
  group_by(pais) |>
  summarise(pib_media=mean(pib_capita), expectativa=mean(expectativa),
            populacao=sum(populacao), .groups="drop")

g_rel_14 <- bub_dados |>
  ggplot(aes(x=pib_media, y=expectativa, size=populacao, color=pais)) +
  geom_point(alpha=0.75) +
  geom_text(aes(label=pais), vjust=-1.5, size=3.5, fontface="bold") +
  scale_size_continuous(range=c(8, 24), name="Pop. (M)") +
  scale_color_manual(values=cores_rel, guide="none") +
  scale_x_continuous(
    labels=dollar_format(prefix="US$", big.mark="."),
    limits=c(8000, 16000),
    expand=expansion(mult=c(0.05, 0.05))) +
  scale_y_continuous(
    limits=c(63, 68),
    expand=expansion(mult=c(0.05, 0.1))) +
  labs(
    title    = "Bubble - Relação",
    subtitle = "PIB per capita vs expectativa - tamanho = população (M hab)",
    x        = "PIB per capita médio (USD)", y = "Expectativa de vida (anos)",
    caption  = caption_padrao) +
  tema_cafe

variaveis <- c("PIB","Educacao","Saude","Gini","Urbanizacao","Desemprego")
n_var <- length(variaveis)
set.seed(7)
mat <- matrix(runif(n_var^2, -0.9, 0.9), n_var, n_var)
mat[lower.tri(mat)] <- t(mat)[lower.tri(mat)]
diag(mat) <- 1
mat <- round(mat, 2)

heat_corr <- as.data.frame(mat) |>
  setNames(variaveis) |>
  mutate(var1 = variaveis) |>
  pivot_longer(-var1, names_to="var2", values_to="corr") |>
  mutate(
    var1    = factor(var1, levels=variaveis),
    var2    = factor(var2, levels=rev(variaveis)),
    txt_cor = ifelse(abs(corr) > 0.5, creme, escuro))

g_rel_15 <- heat_corr |>
  ggplot(aes(x=var1, y=var2, fill=corr)) +
  geom_tile(color=creme, linewidth=0.6) +
  geom_text(aes(label=corr, color=txt_cor), size=3.2, fontface="bold") +
  scale_color_identity() +
  scale_fill_gradient2(low=azul1, mid=creme, high=escuro,
                       midpoint=0, limits=c(-1,1), name="Correlação") +
  labs(
    title    = "Heatmap - Relação",
    subtitle = "Matriz de correlação entre indicadores socioeconômicos",
    x=NULL, y=NULL,
    caption  = caption_padrao) +
  tema_cafe +
  theme(axis.text.x=element_text(angle=30, hjust=1))

# ============================================================
# CATEGORIA 6 - GEOESPACIAL
# ============================================================

bra_mapa <- map_data("world", region="Brazil")

capitais <- data.frame(
  estado = c(
    "Acre","Alagoas","Amapá","Amazonas","Bahia",
    "Ceará","Distrito Federal","Espírito Santo","Goiás","Maranhão",
    "Mato Grosso","Mato Grosso do Sul","Minas Gerais","Pará","Paraíba",
    "Paraná","Pernambuco","Piauí","Rio de Janeiro","Rio Grande do Norte",
    "Rio Grande do Sul","Rondônia","Roraima","Santa Catarina",
    "São Paulo","Sergipe","Tocantins"),
  sigla = c(
    "AC","AL","AP","AM","BA","CE","DF","ES","GO","MA",
    "MT","MS","MG","PA","PB","PR","PE","PI","RJ","RN",
    "RS","RO","RR","SC","SP","SE","TO"),
  lat = c(-9.97,-9.67,0.03,-3.10,-12.97,
          -3.72,-15.78,-20.32,-16.69,-2.53,
          -15.60,-20.44,-19.92,-1.46,-7.12,
          -25.43,-8.05,-5.09,-22.91,-5.79,
          -30.03,-8.76,2.82,-27.60,
          -23.55,-10.91,-10.18),
  lon = c(-67.81,-35.74,-51.07,-60.02,-38.51,
          -38.54,-47.93,-40.34,-49.26,-44.30,
          -56.10,-54.65,-43.94,-48.50,-34.88,
          -49.27,-34.88,-42.80,-43.18,-35.21,
          -51.23,-63.90,-60.67,-48.55,
          -46.63,-37.05,-48.33),
  regiao = c(
    "Norte","Nordeste","Norte","Norte","Nordeste",
    "Nordeste","Centro-Oeste","Sudeste","Centro-Oeste","Nordeste",
    "Centro-Oeste","Centro-Oeste","Sudeste","Norte","Nordeste",
    "Sul","Nordeste","Nordeste","Sudeste","Nordeste",
    "Sul","Norte","Norte","Sul",
    "Sudeste","Nordeste","Norte")
) |>
  mutate(
    idh       = round(runif(n(), 0.62, 0.86), 3),
    pib_cap   = round(runif(n(), 12000, 72000), 0),
    populacao = c(0.9,3.3,0.8,4.2,15.3,
                  9.2,3.1,4.1,7.2,7.1,
                  3.5,2.8,21.4,8.7,4.0,
                  11.5,9.6,3.3,17.3,3.5,
                  11.4,1.8,0.6,7.3,
                  46.6,2.3,1.6))

cores_geo <- c("Norte"=escuro, "Nordeste"=cafe, "Centro-Oeste"=medio,
               "Sul"=azul1, "Sudeste"=azul3)

g_geo_16 <- ggplot() +
  geom_polygon(data=bra_mapa, aes(x=long, y=lat, group=group),
               fill=claro, color=creme, linewidth=0.3) +
  geom_point(data=capitais,
             aes(x=lon, y=lat, size=populacao, color=regiao),
             alpha=0.82) +
  geom_text(data=filter(capitais, populacao > 10),
            aes(x=lon, y=lat, label=sigla),
            size=2.5, color=creme, fontface="bold") +
  scale_size_continuous(range=c(2, 18), name="População\n(milhões)") +
  scale_color_manual(values=cores_geo, name="Região") +
  coord_fixed(ratio=1.2) +
  labs(
    title    = "Bubble Map - Geoespacial",
    subtitle = "População por estado - tamanho proporcional ao número de habitantes",
    caption  = caption_padrao) +
  tema_cafe +
  theme(axis.text=element_blank(), axis.title=element_blank(),
        panel.grid=element_blank())

idh_reg <- capitais |>
  group_by(regiao) |>
  summarise(idh_medio=round(mean(idh), 3), .groups="drop")

bra_reg <- bra_mapa |>
  mutate(regiao = case_when(
    lat > -5  & long < -50                    ~ "Norte",
    lat > -5  & long >= -50 & long < -35      ~ "Nordeste",
    lat >= -15 & lat <= -5  & long < -44      ~ "Norte",
    lat >= -15 & lat <= -5  & long >= -44     ~ "Nordeste",
    lat >= -20 & lat < -15  & long < -52      ~ "Centro-Oeste",
    lat >= -20 & lat < -15  & long >= -52     ~ "Sudeste",
    lat >= -24 & lat < -20  & long < -50      ~ "Centro-Oeste",
    lat >= -24 & lat < -20  & long >= -50     ~ "Sudeste",
    lat < -24  & long > -54                   ~ "Sul",
    lat < -24  & long <= -54                  ~ "Centro-Oeste",
    TRUE                                       ~ "Centro-Oeste"
  )) |>
  left_join(idh_reg, by="regiao")

g_geo_17 <- ggplot() +
  geom_polygon(data=bra_reg,
               aes(x=long, y=lat, group=group, fill=idh_medio),
               color=creme, linewidth=0.25) +
  scale_fill_gradient(low=claro, high=escuro,
                      name="IDH\nmédio", limits=c(0.60, 0.86),
                      na.value=claro) +
  coord_fixed(ratio=1.2) +
  labs(
    title    = "Choropleth - Geoespacial",
    subtitle = "IDH médio simulado por região - Brasil",
    caption  = caption_padrao) +
  tema_cafe +
  theme(axis.text=element_blank(), axis.title=element_blank(),
        panel.grid=element_blank())

g_geo_18 <- ggplot() +
  geom_polygon(data=bra_mapa, aes(x=long, y=lat, group=group),
               fill="#E8D5BB", color=creme, linewidth=0.3) +
  geom_point(data=capitais, aes(x=lon, y=lat, color=pib_cap),
             size=4.5, alpha=0.9) +
  geom_text(data=capitais, aes(x=lon, y=lat, label=sigla),
            size=1.9, color=escuro, vjust=-1.1) +
  scale_color_gradient(low=claro, high=azul3,
                       name="PIB per\ncapita (R$)",
                       labels=dollar_format(prefix="R$", big.mark=".")) +
  coord_fixed(ratio=1.2) +
  labs(
    title    = "Dot Map - Geoespacial",
    subtitle = "PIB per capita simulado por capital de estado",
    caption  = caption_padrao) +
  tema_cafe +
  theme(axis.text=element_blank(), axis.title=element_blank(),
        panel.grid=element_blank())

# ============================================================
# GRÁFICO 19 — USO DE LINGUAGENS DE PROGRAMAÇÃO
# Dados simulados para ilustrar R, Python, SQL, JS, outras
# Contexto: pesquisadores e analistas de dados - Brasil
# ============================================================

# Dados simulados representando % de uso em análise de dados
# Fonte: Dados simulados | Café com R
linguagens <- data.frame(
  linguagem = c("Python", "SQL", "R", "JavaScript",
                "Julia", "Scala", "MATLAB", "Outras"),
  pct       = c(38, 27, 16, 8, 4, 3, 2, 2)
) |>
  mutate(
    linguagem = fct_reorder(linguagem, pct),
    destaque  = linguagem %in% c("R", "Python")
  )

cores_ling <- c("TRUE" = cafe, "FALSE" = claro)

g_ling_19 <- linguagens |>
  ggplot(aes(x = pct, y = linguagem, fill = destaque)) +
  geom_col(width = 0.65, show.legend = FALSE) +
  geom_text(
    aes(label = paste0(pct, "%")),
    hjust   = -0.2,
    size    = 3.8,
    color   = escuro,
    fontface = "bold") +
  scale_fill_manual(values = cores_ling) +
  scale_x_continuous(
    limits = c(0, 46),              # limite generoso para caber os rótulos
    expand = expansion(mult = c(0, 0)),
    labels = function(x) paste0(x, "%")) +
  labs(
    title    = "Barras - Comparação",
    subtitle = "Qual linguagem de programação você usa para análise de dados?",
    x        = "Percentual de uso (%)",
    y        = NULL,
    caption  = "Dados simulados | Café com R\nDestaque: R e Python"
  ) +
  annotate("text", x = 38, y = 8,
           label = "Python e R lideram\nem análise de dados",
           color = escuro, size = 3.2, fontface = "italic", hjust = 1) +
  tema_cafe +
  theme(panel.grid.major.y = element_blank())

# ============================================================
# EXPORTAR - individuais
# ============================================================

pasta <- here::here("output3")
dir.create(pasta, showWarnings = FALSE, recursive = TRUE)

graficos <- list(
  g_comp_01, g_comp_02, g_comp_03,
  g_dist_04, g_dist_05, g_dist_06,
  g_evo_07,  g_evo_08,  g_evo_09,
  g_parte_10, g_parte_11, g_parte_12,
  g_rel_13,  g_rel_14,  g_rel_15,
  g_geo_16,  g_geo_17,  g_geo_18,
  g_ling_19
)

nomes <- c(
  "01_comp_barras",            "02_comp_lollipop",
  "03_comp_dotplot_cleveland", "04_dist_histograma",
  "05_dist_boxplot",           "06_dist_violin",
  "07_evo_linha",              "08_evo_area",
  "09_evo_slope",              "10_parte_treemap",
  "11_parte_pizza_donut",      "12_parte_barras_empilhadas",
  "13_rel_scatter",            "14_rel_bubble",
  "15_rel_heatmap_corr",       "16_geo_bubble_map",
  "17_geo_choropleth",         "18_geo_dot_map_pib",
  "19_comp_linguagens"
)

for (i in seq_along(graficos)) {
  ggsave(
    file.path(pasta, paste0(nomes[i], ".png")),
    plot   = graficos[[i]],
    width  = 10,
    height = 7,
    dpi    = 300,
    bg     = creme
  )
  cat("Exportado:", nomes[i], "\n")
}