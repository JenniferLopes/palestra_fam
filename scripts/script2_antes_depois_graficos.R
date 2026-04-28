# ============================================================
#  ANTES E DEPOIS - 3 Pares de Gráficos
#  Cada par mostra o erro e a correção lado a lado
#  Exportação individual: _ruim e _bom para cada exemplo
# ============================================================

pacman::p_load(ggplot2, dplyr, forcats, scales, here)

pasta <- here::here("output_depois")
dir.create(pasta, showWarnings = FALSE, recursive = TRUE)

# ------------------------------------------------------------
# PALETA E TEMAS
# ------------------------------------------------------------

cor_ruim   <- "#C0392B"   # vermelho - gráfico errado
cor_boa    <- "#2C7FB8"   # azul - gráfico correto
cor_neutra <- "#7F8C8D"   # cinza
cor_dest   <- "#E67E22"   # laranja - destaque no gráfico bom
fundo      <- "#FAFAFA"

tema_base <- theme_minimal(base_size = 13) +
  theme(
    plot.background  = element_rect(fill = fundo, color = NA),
    panel.background = element_rect(fill = fundo, color = NA),
    panel.grid.minor = element_blank(),
    plot.margin      = margin(16, 20, 12, 16),
    plot.caption     = element_text(color = cor_neutra, size = 9, hjust = 0)
  )

tema_ruim <- tema_base +
  theme(
    plot.title    = element_text(face = "bold", color = cor_ruim,  size = 14),
    plot.subtitle = element_text(color = cor_ruim,  size = 10)
  )

tema_bom <- tema_base +
  theme(
    plot.title    = element_text(face = "bold", color = cor_boa, size = 14),
    plot.subtitle = element_text(color = cor_boa, size = 10)
  )

# ============================================================
# PAR 1 - EIXO Y TRUNCADO  vs  EIXO DO ZERO
#
# PROBLEMA (ruim):
#   O eixo Y começa em 96,5%, não em 0. Uma variação real de
#   apenas 1,7 pp (de 97,2% a 98,9%) parece uma oscilação
#   enorme - quase triplicando visualmente. Em gráficos de
#   barras, a altura da barra codifica o valor inteiro;
#   cortá-la distorce essa codificação de forma enganosa.
#
# SOLUÇÃO (bom):
#   Eixo começando em 0. A variação real (~2 pp) fica visível
#   e proporcional. Se quiser destacar a tendência leve de
#   alta, use um gráfico de linha - que tolera eixo truncado
#   por mostrar variação, não magnitude absoluta.
# ============================================================

dados_01 <- data.frame(
  mes   = factor(c("Jan","Fev","Mar","Abr","Mai","Jun"),
                 levels = c("Jan","Fev","Mar","Abr","Mai","Jun")),
  valor = c(97.2, 97.8, 98.1, 97.5, 98.4, 98.9)
)

# --- RUIM ---
g_01_ruim <- ggplot(dados_01, aes(x = mes, y = valor)) +
  geom_col(fill = cor_ruim, width = 0.65, alpha = 0.85) +
  geom_text(aes(label = paste0(valor, "%")),
            vjust = -0.5, size = 3.5, fontface = "bold", color = cor_ruim) +
  # ↓ ERRO: eixo começa em 96,5 - variação de 2 pp parece enorme
  coord_cartesian(ylim = c(96.5, 99.5)) +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  labs(
    title    = "✗  ANTES: Eixo Y truncado",
    subtitle = "Variação de apenas 1,7 pp parece uma montanha-russa",
    x        = NULL,
    y        = "Taxa de satisfação (%)",
    caption  = "Erro: eixo Y começa em 96,5% - a altura visual das barras não representa o valor real"
  ) +
  tema_ruim +
  theme(panel.grid.major.x = element_blank())

# --- BOM ---
g_01_bom <- ggplot(dados_01, aes(x = mes, y = valor)) +
  geom_col(fill = cor_boa, width = 0.65, alpha = 0.85) +
  geom_text(aes(label = paste0(valor, "%")),
            vjust = -0.5, size = 3.5, fontface = "bold", color = cor_boa) +
  # ↓ CORRETO: eixo começa em 0 - a variação real (~2 pp) é proporcional
  scale_y_continuous(limits = c(0, 105),
                     labels = function(x) paste0(x, "%"),
                     breaks = seq(0, 100, 25)) +
  labs(
    title    = "✓  DEPOIS: Eixo Y a partir do zero",
    subtitle = "A mesma variação de 1,7 pp - agora em proporção real",
    x        = NULL,
    y        = "Taxa de satisfação (%)",
    caption  = "Correção: eixo iniciando em 0 preserva a codificação correta da altura das barras"
  ) +
  tema_bom +
  theme(panel.grid.major.x = element_blank())

ggsave(file.path(pasta, "par1_ruim_eixo_truncado.png"),
       plot = g_01_ruim, width = 10, height = 7, dpi = 300, bg = fundo)
cat("Exportado: par1_ruim_eixo_truncado.png\n")

ggsave(file.path(pasta, "par1_bom_eixo_zero.png"),
       plot = g_01_bom, width = 10, height = 7, dpi = 300, bg = fundo)
cat("Exportado: par1_bom_eixo_zero.png\n")


# ============================================================
# PAR 2 - PIZZA COM 12 FATIAS  vs  BARRAS HORIZONTAIS ORDENADAS
#
# PROBLEMA (ruim):
#   O olho humano é péssimo em comparar ângulos e áreas de
#   setores. Com 12 categorias de tamanhos similares (5%–12%),
#   é impossível dizer qual fatia é maior sem ler os rótulos.
#   A legenda separada obriga o leitor a ir e voltar entre
#   gráfico e legenda para cada fatia. Se os números resolvem
#   tudo, o gráfico não acrescenta nada.
#
# SOLUÇÃO (bom):
#   Barras horizontais ordenadas do maior para o menor.
#   A comparação de comprimentos é a tarefa mais precisa que
#   o olho humano executa. O ranking fica imediato, sem legenda,
#   sem ir e voltar - e a leitura acontece em segundos.
# ============================================================

dados_02 <- data.frame(
  categoria = paste("Categoria", LETTERS[1:12]),
  valor     = c(12, 11, 10, 10, 9, 9, 8, 8, 7, 6, 5, 5)
) |>
  mutate(pct = valor / sum(valor) * 100)

# --- RUIM ---
g_02_ruim <- ggplot(dados_02, aes(x = "", y = valor, fill = categoria)) +
  geom_bar(stat = "identity", width = 1, color = "white", linewidth = 0.5) +
  coord_polar("y", start = 0) +
  # 12 cores para 12 categorias - outro erro embutido
  scale_fill_manual(values = c(
    "#E74C3C","#E67E22","#F1C40F","#2ECC71","#1ABC9C","#3498DB",
    "#9B59B6","#34495E","#E91E63","#00BCD4","#8BC34A","#FF5722"
  )) +
  labs(
    title    = "✗  ANTES: Pizza com 12 fatias",
    subtitle = "Consegue dizer qual é a 3ª maior? Nem o autor sabe sem olhar os números",
    fill     = NULL,
    caption  = "Erro: ângulos similares são indistinguíveis - a legenda separada torna a leitura exaustiva"
  ) +
  theme_void(base_size = 13) +
  theme(
    plot.background = element_rect(fill = fundo, color = NA),
    plot.title      = element_text(face = "bold", color = cor_ruim,
                                   size = 14, hjust = 0.5, margin = margin(b = 4)),
    plot.subtitle   = element_text(color = cor_ruim, size = 10,
                                   hjust = 0.5, margin = margin(b = 8)),
    plot.caption    = element_text(color = cor_neutra, size = 9,
                                   hjust = 0.5, margin = margin(t = 8)),
    plot.margin     = margin(16, 20, 12, 16),
    legend.position = "right",
    legend.text     = element_text(size = 9)
  )

# --- BOM ---
g_02_bom <- dados_02 |>
  mutate(categoria = fct_reorder(categoria, pct)) |>
  ggplot(aes(x = pct, y = categoria)) +
  geom_col(fill = cor_boa, width = 0.7, alpha = 0.85) +
  geom_text(aes(label = paste0(round(pct, 0), "%")),
            hjust = -0.2, size = 3.5, fontface = "bold", color = cor_boa) +
  scale_x_continuous(limits = c(0, 16),
                     labels = function(x) paste0(x, "%")) +
  labs(
    title    = "✓  DEPOIS: Barras horizontais ordenadas",
    subtitle = "O ranking fica imediato - sem legenda, sem ir e voltar, leitura em segundos",
    x        = "Participação (%)",
    y        = NULL,
    caption  = "Correção: comprimentos são a comparação mais precisa que o olho humano executa"
  ) +
  tema_bom +
  theme(panel.grid.major.y = element_blank())

ggsave(file.path(pasta, "par2_ruim_pizza_fatias.png"),
       plot = g_02_ruim, width = 10, height = 7, dpi = 300, bg = fundo)
cat("Exportado: par2_ruim_pizza_fatias.png\n")

ggsave(file.path(pasta, "par2_bom_barras_ordenadas.png"),
       plot = g_02_bom, width = 10, height = 7, dpi = 300, bg = fundo)
cat("Exportado: par2_bom_barras_ordenadas.png\n")


# ============================================================
# PAR 3 - BARRAS DESORDENADAS + ARCO-ÍRIS DE CORES
#          vs  BARRAS ORDENADAS + COR COM PROPÓSITO
#
# PROBLEMA (ruim):
#   Dois erros combinados: (a) categorias em ordem alfabética,
#   sem nenhuma lógica de ranking - o olho precisa varrer tudo
#   para encontrar o maior e o menor; (b) cada barra com uma
#   cor diferente, sem nenhum critério - cor vira ruído, não
#   informação. A legenda duplica os rótulos do eixo e ocupa
#   espaço que poderia ser dado ao dado.
#
# SOLUÇÃO (bom):
#   Barras ordenadas do maior para o menor, todas na mesma cor
#   neutra - exceto a maior, destacada em laranja para guiar o
#   olho imediatamente. Cor com propósito: diz "preste atenção
#   aqui". Nenhuma legenda necessária.
# ============================================================

dados_03 <- data.frame(
  pais  = c("Brasil","México","Argentina","Colômbia","Chile",
            "Peru","Equador","Bolívia"),
  valor = c(42, 78, 55, 63, 88, 31, 47, 25)
)

# --- RUIM ---
g_03_ruim <- dados_03 |>
  # ↓ ERRO 1: ordem alfabética - ranking invisível
  mutate(pais = factor(pais, levels = sort(pais))) |>
  ggplot(aes(x = pais, y = valor, fill = pais)) +
  geom_col(width = 0.7) +
  # ↓ ERRO 2: uma cor por país - arco-íris sem sentido
  scale_fill_manual(values = c(
    "#E74C3C","#F39C12","#27AE60","#2980B9",
    "#8E44AD","#16A085","#D35400","#C0392B"
  )) +
  geom_text(aes(label = valor),
            vjust = -0.5, size = 3.5, fontface = "bold") +
  labs(
    title    = "✗  ANTES: Ordem aleatória + arco-íris de cores",
    subtitle = "Qual é o maior? Qual o menor? Você precisa ler todos os números",
    x        = NULL,
    y        = "Índice de adoção digital (%)",
    caption  = "Erros: (1) ordem alfabética esconde o ranking; (2) cores sem critério viram ruído visual"
  ) +
  tema_ruim +
  theme(
    panel.grid.major.x = element_blank(),
    legend.position    = "right",
    legend.title       = element_blank(),
    legend.text        = element_text(size = 9)
  )

# --- BOM ---
dados_03_ord <- dados_03 |>
  mutate(
    pais      = fct_reorder(pais, valor),
    destaque  = ifelse(valor == max(valor), "Destaque", "Normal"),
    cor_barra = ifelse(valor == max(valor), cor_dest, cor_neutra)
  )

g_03_bom <- ggplot(dados_03_ord,
                   aes(x = valor, y = pais, fill = destaque)) +
  geom_col(width = 0.7, alpha = 0.9) +
  geom_text(aes(label = paste0(valor, "%")),
            hjust = -0.2, size = 3.5, fontface = "bold",
            color = ifelse(dados_03_ord$destaque == "Destaque",
                           cor_dest, cor_neutra)) +
  scale_fill_manual(values = c("Destaque" = cor_dest, "Normal" = cor_neutra),
                    guide = "none") +    # sem legenda - a cor fala por si
  scale_x_continuous(limits = c(0, 105),
                     labels = function(x) paste0(x, "%")) +
  annotate("text",
           x = 92, y = "Chile",
           label = "← Maior índice\n   da região",
           color = cor_dest, size = 3.2, fontface = "bold", hjust = 0) +
  labs(
    title    = "✓  DEPOIS: Ordenado por valor + cor com propósito",
    subtitle = "O ranking é imediato - a cor guia o olho para o dado mais relevante",
    x        = "Índice de adoção digital (%)",
    y        = NULL,
    caption  = "Correção: fct_reorder() ordena as barras; cor única com destaque pontual elimina o ruído"
  ) +
  tema_bom +
  theme(panel.grid.major.y = element_blank())

ggsave(file.path(pasta, "par3_ruim_cores_desordem.png"),
       plot = g_03_ruim, width = 10, height = 7, dpi = 300, bg = fundo)
cat("Exportado: par3_ruim_cores_desordem.png\n")

ggsave(file.path(pasta, "par3_bom_ordenado_destaque.png"),
       plot = g_03_bom, width = 10, height = 7, dpi = 300, bg = fundo)
cat("Exportado: par3_bom_ordenado_destaque.png\n")

cat("\nConcluído: 6 gráficos exportados em", pasta, "\n")





# gif ---------------------------------------------------------------------

install.packages("gapminder")
install.packages("gganimate")

# Charge libraries:
library(ggplot2)
library(gganimate)
library(gapminder)

# Make a ggplot, but add frame=year: one image per year
ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, color = continent)) +
  geom_point() +
  scale_x_log10() +
  theme_bw() +
  # gganimate specific bits:
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  ease_aes('linear')

# Save at gif:
anim_save("271-ggplot2-animated-gif-chart-with-gganimate1.gif")