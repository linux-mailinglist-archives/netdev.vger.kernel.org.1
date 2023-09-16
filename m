Return-Path: <netdev+bounces-34253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4617A2ED2
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 10:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5050A282270
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 08:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA8A12B73;
	Sat, 16 Sep 2023 08:13:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3538512B6A;
	Sat, 16 Sep 2023 08:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25B1C433D9;
	Sat, 16 Sep 2023 08:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694851987;
	bh=Ook4MmbZyTHTwBCPoZcoElhvKPXaGKHEfuZZRckhrmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nvRKVGJKVHMGLMpp5YqLLYgdXsun+QlFWk4gFlg85cQYIwJ0diFJXzoJtQvgRYI+z
	 3pRwqAoLxhGAEnlm/HY8SDM55pRzT8xmX6w8U6xpUmXUqbFUiXxjjqiicaNhXWb1RS
	 5UWBpJunRapoCq9ybIJHKOg3rubzsaW5eVQNSI5sjTQC8ziQ/6+XoSTUSX7hHMUdWV
	 3T0ogMoSc5oPSVIDwofX2oYTnU5qXVRsP9cC6Wt0JygjJCybt5EZcnUMHaJNHOvQxN
	 Gb90KRTtGWCtSAdKHRTe8BlG1SBH+9WaRRXjNV849EigxmDn1gO0gcwHRRIHvg5MRM
	 GALllzSuuDR9w==
From: Jisheng Zhang <jszhang@kernel.org>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v2 22/23] net: stmmac: rename stmmac_pltfr_remove_no_dt to stmmac_pltfr_remove
Date: Sat, 16 Sep 2023 15:58:28 +0800
Message-Id: <20230916075829.1560-23-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230916075829.1560-1-jszhang@kernel.org>
References: <20230916075829.1560-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, all users of the old stmmac_pltfr_remove() are converted to the
devres helper, it's time to rename stmmac_pltfr_remove_no_dt() back to
stmmac_pltfr_remove() and remove the old stmmac_pltfr_remove().

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../ethernet/stmicro/stmmac/dwmac-anarion.c   |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-ingenic.c   |  2 +-
 .../stmicro/stmmac/dwmac-intel-plat.c         |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-ipq806x.c   |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-lpc18xx.c   |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-mediatek.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-meson.c |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-starfive.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-sunxi.c |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-tegra.c |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-visconti.c  |  3 +--
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 23 +++----------------
 .../ethernet/stmicro/stmmac/stmmac_platform.h |  1 -
 17 files changed, 18 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
index 0df3a2ad0986..643ee6d8d4dd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
@@ -135,7 +135,7 @@ MODULE_DEVICE_TABLE(of, anarion_dwmac_match);
 
 static struct platform_driver anarion_dwmac_driver = {
 	.probe  = anarion_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove_no_dt,
+	.remove_new = stmmac_pltfr_remove,
 	.driver = {
 		.name           = "anarion-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index e5989424894b..8f730ada71f9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -418,7 +418,7 @@ MODULE_DEVICE_TABLE(of, imx_dwmac_match);
 
 static struct platform_driver imx_dwmac_driver = {
 	.probe  = imx_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove_no_dt,
+	.remove_new = stmmac_pltfr_remove,
 	.driver = {
 		.name           = "imx-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
index 3f87053ffc07..19c93b998fb3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ingenic.c
@@ -370,7 +370,7 @@ MODULE_DEVICE_TABLE(of, ingenic_mac_of_matches);
 
 static struct platform_driver ingenic_mac_driver = {
 	.probe		= ingenic_mac_probe,
-	.remove_new	= stmmac_pltfr_remove_no_dt,
+	.remove_new	= stmmac_pltfr_remove,
 	.driver		= {
 		.name	= "ingenic-mac",
 		.pm		= pm_ptr(&ingenic_mac_pm_ops),
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
index d1aec2ca2b42..70edc5232379 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
@@ -164,7 +164,7 @@ static void intel_eth_plat_remove(struct platform_device *pdev)
 {
 	struct intel_dwmac *dwmac = get_stmmac_bsp_priv(&pdev->dev);
 
-	stmmac_pltfr_remove_no_dt(pdev);
+	stmmac_pltfr_remove(pdev);
 	clk_disable_unprepare(dwmac->tx_clk);
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
index a9916fd07616..281687d7083b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
@@ -487,7 +487,7 @@ MODULE_DEVICE_TABLE(of, ipq806x_gmac_dwmac_match);
 
 static struct platform_driver ipq806x_gmac_dwmac_driver = {
 	.probe = ipq806x_gmac_probe,
-	.remove_new = stmmac_pltfr_remove_no_dt,
+	.remove_new = stmmac_pltfr_remove,
 	.driver = {
 		.name		= "ipq806x-gmac-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
index dad23b47f383..4c810d8f5bea 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c
@@ -72,7 +72,7 @@ MODULE_DEVICE_TABLE(of, lpc18xx_dwmac_match);
 
 static struct platform_driver lpc18xx_dwmac_driver = {
 	.probe  = lpc18xx_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove_no_dt,
+	.remove_new = stmmac_pltfr_remove,
 	.driver = {
 		.name           = "lpc18xx-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index 11976a854240..2a9132d6d743 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -683,7 +683,7 @@ static void mediatek_dwmac_remove(struct platform_device *pdev)
 {
 	struct mediatek_dwmac_plat_data *priv_plat = get_stmmac_bsp_priv(&pdev->dev);
 
-	stmmac_pltfr_remove_no_dt(pdev);
+	stmmac_pltfr_remove(pdev);
 	mediatek_dwmac_clks_config(priv_plat, false);
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
index 3373d3ec2368..a16bfa9089ea 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
@@ -78,7 +78,7 @@ MODULE_DEVICE_TABLE(of, meson6_dwmac_match);
 
 static struct platform_driver meson6_dwmac_driver = {
 	.probe  = meson6_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove_no_dt,
+	.remove_new = stmmac_pltfr_remove,
 	.driver = {
 		.name           = "meson6-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
index 37f249980929..b23944aa344e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
@@ -520,7 +520,7 @@ MODULE_DEVICE_TABLE(of, meson8b_dwmac_match);
 
 static struct platform_driver meson8b_dwmac_driver = {
 	.probe  = meson8b_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove_no_dt,
+	.remove_new = stmmac_pltfr_remove,
 	.driver = {
 		.name           = "meson8b-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 03e7701d0186..ba2ce776bd4d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -500,7 +500,7 @@ static void socfpga_dwmac_remove(struct platform_device *pdev)
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	struct phylink_pcs *pcs = priv->hw->lynx_pcs;
 
-	stmmac_pltfr_remove_no_dt(pdev);
+	stmmac_pltfr_remove(pdev);
 
 	lynx_pcs_destroy(pcs);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
index e87b4d335c72..5d630affb4d1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
@@ -152,7 +152,7 @@ MODULE_DEVICE_TABLE(of, starfive_dwmac_match);
 
 static struct platform_driver starfive_dwmac_driver = {
 	.probe  = starfive_dwmac_probe,
-	.remove_new = stmmac_pltfr_remove_no_dt,
+	.remove_new = stmmac_pltfr_remove,
 	.driver = {
 		.name = "starfive-dwmac",
 		.pm = &stmmac_pltfr_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 63a7e5e53d7b..1c702d0b2d29 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -1312,7 +1312,7 @@ static void sun8i_dwmac_remove(struct platform_device *pdev)
 		clk_put(gmac->ephy_clk);
 	}
 
-	stmmac_pltfr_remove_no_dt(pdev);
+	stmmac_pltfr_remove(pdev);
 	sun8i_dwmac_unset_syscon(gmac);
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
index b857235f5b1f..2653a9f0958c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
@@ -172,7 +172,7 @@ MODULE_DEVICE_TABLE(of, sun7i_dwmac_match);
 
 static struct platform_driver sun7i_dwmac_driver = {
 	.probe  = sun7i_gmac_probe,
-	.remove_new = stmmac_pltfr_remove_no_dt,
+	.remove_new = stmmac_pltfr_remove,
 	.driver = {
 		.name           = "sun7i-dwmac",
 		.pm		= &stmmac_pltfr_pm_ops,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
index 7e512c0762ea..362f85136c3e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
@@ -358,7 +358,7 @@ static void tegra_mgbe_remove(struct platform_device *pdev)
 
 	clk_bulk_disable_unprepare(ARRAY_SIZE(mgbe_clks), mgbe->clks);
 
-	stmmac_pltfr_remove_no_dt(pdev);
+	stmmac_pltfr_remove(pdev);
 }
 
 static const struct of_device_id tegra_mgbe_match[] = {
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
index 45f5d66a11c2..a5a5cfa989c6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
@@ -256,8 +256,7 @@ static int visconti_eth_dwmac_probe(struct platform_device *pdev)
 
 static void visconti_eth_dwmac_remove(struct platform_device *pdev)
 {
-	stmmac_pltfr_remove_no_dt(pdev);
-
+	stmmac_pltfr_remove(pdev);
 	visconti_eth_clock_remove(pdev);
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 0f28795e581c..716434b58321 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -807,7 +807,7 @@ static void devm_stmmac_pltfr_remove(void *data)
 {
 	struct platform_device *pdev = data;
 
-	stmmac_pltfr_remove_no_dt(pdev);
+	stmmac_pltfr_remove(pdev);
 }
 
 /**
@@ -834,12 +834,12 @@ int devm_stmmac_pltfr_probe(struct platform_device *pdev,
 EXPORT_SYMBOL_GPL(devm_stmmac_pltfr_probe);
 
 /**
- * stmmac_pltfr_remove_no_dt
+ * stmmac_pltfr_remove
  * @pdev: pointer to the platform device
  * Description: This undoes the effects of stmmac_pltfr_probe() by removing the
  * driver and calling the platform's exit() callback.
  */
-void stmmac_pltfr_remove_no_dt(struct platform_device *pdev)
+void stmmac_pltfr_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
@@ -848,23 +848,6 @@ void stmmac_pltfr_remove_no_dt(struct platform_device *pdev)
 	stmmac_dvr_remove(&pdev->dev);
 	stmmac_pltfr_exit(pdev, plat);
 }
-EXPORT_SYMBOL_GPL(stmmac_pltfr_remove_no_dt);
-
-/**
- * stmmac_pltfr_remove
- * @pdev: platform device pointer
- * Description: this function calls the main to free the net resources
- * and calls the platforms hook and release the resources (e.g. mem).
- */
-void stmmac_pltfr_remove(struct platform_device *pdev)
-{
-	struct net_device *ndev = platform_get_drvdata(pdev);
-	struct stmmac_priv *priv = netdev_priv(ndev);
-	struct plat_stmmacenet_data *plat = priv->plat;
-
-	stmmac_pltfr_remove_no_dt(pdev);
-	stmmac_remove_config_dt(pdev, plat);
-}
 EXPORT_SYMBOL_GPL(stmmac_pltfr_remove);
 
 /**
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
index c5565b2a70ac..bb07a99e1248 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
@@ -32,7 +32,6 @@ int stmmac_pltfr_probe(struct platform_device *pdev,
 int devm_stmmac_pltfr_probe(struct platform_device *pdev,
 			    struct plat_stmmacenet_data *plat,
 			    struct stmmac_resources *res);
-void stmmac_pltfr_remove_no_dt(struct platform_device *pdev);
 void stmmac_pltfr_remove(struct platform_device *pdev);
 extern const struct dev_pm_ops stmmac_pltfr_pm_ops;
 
-- 
2.40.1


