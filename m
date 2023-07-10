Return-Path: <netdev+bounces-16395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D0D74D0EB
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 11:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2CE1C208DC
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 09:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A143C8D7;
	Mon, 10 Jul 2023 09:00:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459B2101CD
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 09:00:22 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F79F3
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 02:00:20 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso44054015e9.2
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 02:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1688979618; x=1691571618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rs3h3ox9QJXzxEXaQ8eFHHv1moh5d5VyZpUhlfQfPbk=;
        b=j/BZlydBM6wGl4yFCHFw1nv5xpiLEeyNu/cRugRSlHsmK+YmFnanXcerms6WxdxKDF
         fYOBivTSiQ08bWtKMJ5IqwCOtiprl4ZQZBvwzTDSWhtX3LobmjsY4vetGemgns2xKr+v
         +V8L8T5lnc/XCj9QBXJnNzIQxzF7iO0xnyPwlUEmwgERKki4Y98Df96+HOKuYDDHSoOL
         Z1VpnZkF4QKGmJCCvw2utD85WkStlwTRMu6pkOSCcmwBsxpMV5dmLf6VCrmk3q27u07e
         BKjkHYXe9w3BYt1quSm//4trXKPLE4sQsdH7QGUkL/xy63DXCuDDajS5NdeJMFIm8JjN
         Y37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688979618; x=1691571618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rs3h3ox9QJXzxEXaQ8eFHHv1moh5d5VyZpUhlfQfPbk=;
        b=HXrj7EjYM4CM2qU1I8mJQWm8umu3KLgT6cRy/wRemgv2fTpr9jCV0ZtQASlYtkxOWf
         5hVMett5QA2udBq2RzF/XD/8b/dwAx4XhphsYFFPUXlVJaB+K2Gy2G/U6sZFnmg2XZF5
         HVbZWLTK2y1dFPGqTp8AsA2mQN+REz56DTbmCHlpeaYWwhGGd5vvMIjVc5LDDY0y4BvW
         eEa7m7uOUh2O44YPQxKDKqe4S7w9Ao7suWji54LUwMoE5lGGnHqj2K83R1uTyobF4mXC
         K4rn8vA1z2s3+ekc0S+Ul9dmW/PcWgY5Wrr2LPzVYaZ9IxPQRgyJ3hhER7St5Iimxpec
         AoXw==
X-Gm-Message-State: ABy/qLY8kWZ+XBB+oIQp3f8PijhbFHOATnpX1fLC9jhByIEZQeg5G9UA
	yOS5q2S0xYcwtOIBRqJjVUVh3w==
X-Google-Smtp-Source: APBJJlHje8En2b/i7BLbuz5lOIAZsUxfaY03jH+dzCVkrzrzF0sBF+ijHOxW/3xsSCvhR+geHHMH9g==
X-Received: by 2002:a05:600c:22c6:b0:3fa:96db:7b7c with SMTP id 6-20020a05600c22c600b003fa96db7b7cmr11945769wmg.35.1688979617591;
        Mon, 10 Jul 2023 02:00:17 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6002:540:6954:abdd])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c0b4600b003fc00702f65sm8581045wmr.46.2023.07.10.02.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 02:00:17 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH net-next v3 05/12] net: stmmac: replace the tso_en field with a flag
Date: Mon, 10 Jul 2023 10:59:54 +0200
Message-Id: <20230710090001.303225-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710090001.303225-1-brgl@bgdev.pl>
References: <20230710090001.303225-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Drop the boolean field of the plat_stmmacenet_data structure in favor of a
simple bitfield flag.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c       | 3 +--
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 3 ++-
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c       | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c       | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c        | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c   | 6 ++++--
 include/linux/stmmac.h                                  | 2 +-
 8 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 0c12ab67c27b..b5efd9c2eac7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -113,7 +113,7 @@ static int dwc_eth_dwmac_config_dt(struct platform_device *pdev,
 	/* dwc-qos needs GMAC4, AAL, TSO and PMT */
 	plat_dat->has_gmac4 = 1;
 	plat_dat->dma_cfg->aal = 1;
-	plat_dat->tso_en = 1;
+	plat_dat->flags |= STMMAC_FLAG_TSO_EN;
 	plat_dat->pmt = 1;
 
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index c690ec1b9bab..faa6f4ec6838 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -458,8 +458,7 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	plat->has_gmac = 0;
 	plat->has_gmac4 = 1;
 	plat->force_sf_dma_mode = 0;
-	plat->tso_en = 1;
-	plat->flags |= STMMAC_FLAG_SPH_DISABLE;
+	plat->flags |= (STMMAC_FLAG_TSO_EN | STMMAC_FLAG_SPH_DISABLE);
 
 	/* Multiplying factor to the clk_eee_i clock time
 	 * period to make it closer to 100 ns. This value
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index a5e708534730..2692ccebea50 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -777,7 +777,8 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	if (ethqos->has_emac_ge_3)
 		plat_dat->dwmac4_addrs = &data->dwmac4_addrs;
 	plat_dat->pmt = 1;
-	plat_dat->tso_en = of_property_read_bool(np, "snps,tso");
+	if (of_property_read_bool(np, "snps,tso"))
+		plat_dat->flags |= STMMAC_FLAG_TSO_EN;
 	if (of_device_is_compatible(np, "qcom,qcs404-ethqos"))
 		plat_dat->rx_clk_runs_in_lpi = 1;
 	if (data->has_integrated_pcs)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
index f8367c5b490b..5e8aa03cffae 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
@@ -290,7 +290,7 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
 	}
 
 	plat->has_xgmac = 1;
-	plat->tso_en = 1;
+	plat->flags |= STMMAC_FLAG_TSO_EN;
 	plat->pmt = 1;
 	plat->bsp_priv = mgbe;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3df32658b5bb..73002ed923aa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5677,7 +5677,7 @@ static netdev_features_t stmmac_fix_features(struct net_device *dev,
 		features &= ~NETIF_F_CSUM_MASK;
 
 	/* Disable tso if asked by ethtool */
-	if ((priv->plat->tso_en) && (priv->dma_cap.tsoen)) {
+	if ((priv->plat->flags & STMMAC_FLAG_TSO_EN) && (priv->dma_cap.tsoen)) {
 		if (features & NETIF_F_TSO)
 			priv->tso = true;
 		else
@@ -7250,7 +7250,7 @@ int stmmac_dvr_probe(struct device *device,
 		ndev->hw_features |= NETIF_F_HW_TC;
 	}
 
-	if ((priv->plat->tso_en) && (priv->dma_cap.tsoen)) {
+	if ((priv->plat->flags & STMMAC_FLAG_TSO_EN) && (priv->dma_cap.tsoen)) {
 		ndev->hw_features |= NETIF_F_TSO | NETIF_F_TSO6;
 		if (priv->plat->has_gmac4)
 			ndev->hw_features |= NETIF_F_GSO_UDP_L4;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index 644bb54f5f02..352b01678c22 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -77,7 +77,7 @@ static int snps_gmac5_default_data(struct pci_dev *pdev,
 	plat->clk_csr = 5;
 	plat->has_gmac4 = 1;
 	plat->force_sf_dma_mode = 1;
-	plat->tso_en = 1;
+	plat->flags |= STMMAC_FLAG_TSO_EN;
 	plat->pmt = 1;
 
 	/* Set default value for multicast hash bins */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 231152ee5a32..f51522cb0061 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -525,7 +525,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 		plat->has_gmac4 = 1;
 		plat->has_gmac = 0;
 		plat->pmt = 1;
-		plat->tso_en = of_property_read_bool(np, "snps,tso");
+		if (of_property_read_bool(np, "snps,tso"))
+			plat->flags |= STMMAC_FLAG_TSO_EN;
 	}
 
 	if (of_device_is_compatible(np, "snps,dwmac-3.610") ||
@@ -538,7 +539,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	if (of_device_is_compatible(np, "snps,dwxgmac")) {
 		plat->has_xgmac = 1;
 		plat->pmt = 1;
-		plat->tso_en = of_property_read_bool(np, "snps,tso");
+		if (of_property_read_bool(np, "snps,tso"))
+			plat->flags |= STMMAC_FLAG_TSO_EN;
 	}
 
 	dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*dma_cfg),
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 66dcf84d024a..47ae29a98835 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -208,6 +208,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_SPH_DISABLE			BIT(1)
 #define STMMAC_FLAG_USE_PHY_WOL			BIT(2)
 #define STMMAC_FLAG_HAS_SUN8I			BIT(3)
+#define STMMAC_FLAG_TSO_EN			BIT(4)
 
 struct plat_stmmacenet_data {
 	int bus_id;
@@ -271,7 +272,6 @@ struct plat_stmmacenet_data {
 	struct reset_control *stmmac_ahb_rst;
 	struct stmmac_axi *axi;
 	int has_gmac4;
-	bool tso_en;
 	int rss_en;
 	int mac_port_sel_speed;
 	bool en_tx_lpi_clockgating;
-- 
2.39.2


