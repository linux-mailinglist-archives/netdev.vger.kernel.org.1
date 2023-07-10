Return-Path: <netdev+bounces-16392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 660CE74D0DE
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 11:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96EBF1C209F2
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 09:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E449CC8C1;
	Mon, 10 Jul 2023 09:00:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D949BD52B
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 09:00:16 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A500F3
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 02:00:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbd33a57ddso43061375e9.1
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 02:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1688979613; x=1691571613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyyBvpSV8LxDog0ek0zaEgbX3az6xRdpMaG/0FwAEzQ=;
        b=3x1HBwDRhKRpNZtS59+egzHon09AC6viqlxvkgig2u73jYmx2KoeiJv1WiGL7psptP
         oMeODFZTw3hjHXmYBX3QeVeNKw79pLtGo6r+NUK4N7fgNxD5BWuk2ZA8IRrXTOF3GNvY
         fy3dAOOguHIKIbIra8lHLXaDJ2jRzs4s3csIvTScXvBfxT2bCY0/yXUoHOeVYZyUI9AC
         Mr7vbwGBMJuGhmekxfISybKSynGEb/+sV5B81QyA/7tCGowtlyzQPum6C8WZmps/VrLm
         wx5ymFtihSkmQ9FjnCaVtJMJzrwb7VXinhrIMOtWXm5HiUsVkNJedZyIZk2jOb33wNds
         tO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688979613; x=1691571613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyyBvpSV8LxDog0ek0zaEgbX3az6xRdpMaG/0FwAEzQ=;
        b=FFEGnwwr95p5wrNhz3rCkyQeFaWlktkL3hV+GSK2+kbYAKlaB4b8L1OtohympbktxD
         Fa/pvdIkU4nBoc4ZjK+rvFLLZ3qFbwsRrxUkjfTcC9tBj+utOurWSJEJ6DXhJv27h3NM
         KGu5x21BftaC/O/UsRZV8q3oHtSgwvHRc25baRZ0sdV8m6958qlaBvtsQj7E7mLh1cQI
         VP91EJ4TaRdLmRK0rxFuYrgYLuS8yN7xwkY473quU8aAsKaSXDpHIprKyBlFnwJ6RoKq
         wMDffU87pQsxAO97GqSrv8edTuXSmw++jFBOt3FSf4WleUzrsif5WOdq4mjT2Tj8PkVn
         hSzg==
X-Gm-Message-State: ABy/qLYDj/x8vP67/8T7JaNBPV5awvvbHoJ0JXrZ1bQj5eJUO/Pea68P
	W7v/vAhYQh6Akbnr1Cp4OhS5uQ==
X-Google-Smtp-Source: APBJJlE0CWZzeJZ8TiwIWmaXT0WdMJVW73xR7UitbR/EEdZvdmMI1C9Osy594l6Z5i7AebtR9dEpZA==
X-Received: by 2002:a05:600c:378b:b0:3fb:ffa8:6d78 with SMTP id o11-20020a05600c378b00b003fbffa86d78mr7014533wmr.36.1688979613585;
        Mon, 10 Jul 2023 02:00:13 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6002:540:6954:abdd])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c0b4600b003fc00702f65sm8581045wmr.46.2023.07.10.02.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 02:00:13 -0700 (PDT)
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
Subject: [PATCH net-next v3 02/12] net: stmmac: replace the sph_disable field with a flag
Date: Mon, 10 Jul 2023 10:59:51 +0200
Message-Id: <20230710090001.303225-3-brgl@bgdev.pl>
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c       | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c       | 3 ++-
 include/linux/stmmac.h                                  | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 9f88530c5e8c..0c12ab67c27b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -359,7 +359,7 @@ static int tegra_eqos_probe(struct platform_device *pdev,
 	data->fix_mac_speed = tegra_eqos_fix_speed;
 	data->init = tegra_eqos_init;
 	data->bsp_priv = eqos;
-	data->sph_disable = 1;
+	data->flags |= STMMAC_FLAG_SPH_DISABLE;
 
 	err = tegra_eqos_init(pdev, eqos);
 	if (err < 0)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index ab9f876b6df7..ae5db39a3f1b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -459,7 +459,7 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	plat->has_gmac4 = 1;
 	plat->force_sf_dma_mode = 0;
 	plat->tso_en = 1;
-	plat->sph_disable = 1;
+	plat->flags |= STMMAC_FLAG_SPH_DISABLE;
 
 	/* Multiplying factor to the clk_eee_i clock time
 	 * period to make it closer to 100 ns. This value
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 38b6cbd8a133..18e56299363d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7258,7 +7258,8 @@ int stmmac_dvr_probe(struct device *device,
 		dev_info(priv->device, "TSO feature enabled\n");
 	}
 
-	if (priv->dma_cap.sphen && !priv->plat->sph_disable) {
+	if (priv->dma_cap.sphen &&
+	    !(priv->plat->flags & STMMAC_FLAG_SPH_DISABLE)) {
 		ndev->hw_features |= NETIF_F_GRO;
 		priv->sph_cap = true;
 		priv->sph = priv->sph_cap;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 8e7511071ef1..1b02f866316c 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -205,6 +205,7 @@ struct dwmac4_addrs {
 };
 
 #define STMMAC_FLAG_HAS_INTEGRATED_PCS		BIT(0)
+#define STMMAC_FLAG_SPH_DISABLE			BIT(1)
 
 struct plat_stmmacenet_data {
 	int bus_id;
@@ -292,7 +293,6 @@ struct plat_stmmacenet_data {
 	int msi_rx_base_vec;
 	int msi_tx_base_vec;
 	bool use_phy_wol;
-	bool sph_disable;
 	bool serdes_up_after_phy_linkup;
 	const struct dwmac4_addrs *dwmac4_addrs;
 	unsigned int flags;
-- 
2.39.2


