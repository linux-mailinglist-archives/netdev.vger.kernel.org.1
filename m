Return-Path: <netdev+bounces-13337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DA273B4A9
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D234281A9C
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 10:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768C85681;
	Fri, 23 Jun 2023 10:08:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D186121
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 10:08:56 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512582D6A
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:08:53 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f9c2913133so5916925e9.1
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514932; x=1690106932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ew/OjzgYg2nsW0kAROkz29zhVp2ggSYw8qH9w/3MfWE=;
        b=C8u+ZXCHQdPKodiM5v7/b2mSTYm4069RdqKcGt2d3qQ3M0hMOVzAtCHLEGcydsb9H5
         ezLk1y5ZIDblnE7dNeLg+BehZmNh49pBMfSPETU+4kQXzgpcU5iGT1L5ytBxl4yG3z11
         3zfOvc8zrbW74LSoOg4yEjoy7nK6pBCWG+1owflHbdBU36HiEZhbhvmFXzwR21kn7RGx
         hsJiHOWrOuxoFTE7cie99DPxLl6R3ced0Nrc9TX3PA/Oa+/fa5uiyuZf3B2apnzOrHLZ
         ucec1zb/DS7XqppiySHzdUpwHpzH3jOZvIVEi9t6dm1B/YpVhZcULrDKxp75c8pR7DNO
         85oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514932; x=1690106932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ew/OjzgYg2nsW0kAROkz29zhVp2ggSYw8qH9w/3MfWE=;
        b=en9TDOTZR13/cnF0W4E5Iy0MvKZOYo3mcFMcL1YkXrUQKcC2qcVBkD2ylgSLzphW74
         UyqiPt6BrQDs33CqAeX9/q7kVJflmFeaxWJtVYJTfv6QbryqEvFYBxfxw7NYS3VrFPI8
         F9xQmyqBgVCx+qVgXJ8YVCcPp1DgPnu3uBpQjGvlXkniXZT7IgFOtjYjVejPFS4UlckX
         0fFydcRdqPwuSs+wbtBXYGf5l4fm4kLNmu3pfiGrjIf/cWOyvd/yf2KgZW/c1lVGiVTJ
         OcwrItI/bZl9YIKSb0Z3MOCs+sUSmwt2uHG9GINaSO3b5QsgTDA4amNN8NX3ue8c8/5a
         tvEQ==
X-Gm-Message-State: AC+VfDxP+cra+87tXUVcLGa0bwQi943aVBrGGauKuJnK2cQuOua4z80b
	g0S6bKY4v5hcn1U7gOG0cg6TyZOIug0y8uQ/1Y4=
X-Google-Smtp-Source: ACHHUZ71+U53koIeVd6HcBoAAxnwXclqi3Dgq8ZgYmlNoX3pgWmdescemRu5qaQBqUT4Fm8/LU0+Gw==
X-Received: by 2002:a05:600c:248:b0:3f9:b3b4:4367 with SMTP id 8-20020a05600c024800b003f9b3b44367mr9685508wmj.15.1687514931873;
        Fri, 23 Jun 2023 03:08:51 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id k18-20020adfe8d2000000b0030ae3a6be4asm9278100wrn.72.2023.06.23.03.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:08:51 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Vinod Koul <vkoul@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Andrew Halaney <ahalaney@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next v2 02/12] net: stmmac: replace the sph_disable field with a flag
Date: Fri, 23 Jun 2023 12:08:35 +0200
Message-Id: <20230623100845.114085-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623100845.114085-1-brgl@bgdev.pl>
References: <20230623100845.114085-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Drop the boolean field of the plat_stmmacenet_data structure in favor of a
simple bitfield flag.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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
index ab9f876b6df7..70e91bbef2a6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -459,7 +459,7 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	plat->has_gmac4 = 1;
 	plat->force_sf_dma_mode = 0;
 	plat->tso_en = 1;
-	plat->sph_disable = 1;
+	data->flags |= STMMAC_FLAG_SPH_DISABLE;
 
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


