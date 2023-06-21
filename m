Return-Path: <netdev+bounces-12710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF8F7389D4
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB41128165E
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE65F19BD4;
	Wed, 21 Jun 2023 15:37:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF4119BA3
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 15:37:48 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B2E198B
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:37:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f9c0abc876so6782065e9.3
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687361831; x=1689953831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzkZoWqIdrFL84uinSijWf7BmQOJpWDfpkjROxZd1c8=;
        b=PcGca/hWjJcVv+Y/tbmdA71BgJ7Lr6OMUaqZiMiOw/DP9D2tyjb2ebFZwqVne5WD/Z
         JQWUu6+eZ+cphu8t9HiFXX4Oe0PApDoD8mDbNRalw0FyE7F29WNYN61faxh1Wh+JUY2T
         SCtMK2sfzM6L5oWuLO06DYM+7eITR+bMkb0qsRAjucXpmWBHc756CN2nbbp2Evg5ifd5
         J4USwnkUh2Ml7zPchKernlpz+3oGy56v10NHcOt7x0+WKK0GbHYvIlYSwD2k3lpbTaFg
         F79ZuOgORX3hOD6C9VxWLe06gI/y9L3VIhoAh012UQeyay+mV+a+vRRIuuMEFENPYXzz
         KMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361831; x=1689953831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzkZoWqIdrFL84uinSijWf7BmQOJpWDfpkjROxZd1c8=;
        b=Lkgkqf3G4syVaoTx0JpKKQs+HHW3PHd/S5l7UQ7zYnKEd1DdDBYKew8gcRKzaAXXHq
         agk1l/ChtedxfS1ZFDdO1xBM2ra8t3+9p9sT0W9JWMdICkNLGuNdrP/fQ9hxyLpPF/XD
         UMUE9aYvdToh/PcU1FHLxhmlmdPCQbVHLSDvew0KI2oEh6TMmPvDFA0hRWrN7l+Lpthg
         1a/8RecFuP2WjBKKNk6wn1nkBO2wwquchbCZz+9aW0mcjTL1O2xGcxzIV1XfjP6y7aLZ
         vE0Ptywl1mLt/bcBGyqgLzDcNlMODNyy03VhjpDFFHQ0vYIoTmYjjftkug/yhibpb9bC
         Rblg==
X-Gm-Message-State: AC+VfDx/IPDqFYNQuUryQ+YNcgk3ECnOA/yiwCPMifDWvFm6xaQguAk/
	qDbW9XmiFD2Y0hooz9BckSB0sA==
X-Google-Smtp-Source: ACHHUZ6+m4x+02dzD0msTZyYePiggPtcVzXmvvy5Lf7/ySBqdENggcehBQ1qprkG4JzujBxj3sOUTA==
X-Received: by 2002:a05:600c:22d8:b0:3f8:f884:ebe7 with SMTP id 24-20020a05600c22d800b003f8f884ebe7mr10660338wmg.0.1687361831603;
        Wed, 21 Jun 2023 08:37:11 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003f7ed463954sm5322491wme.25.2023.06.21.08.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:37:11 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Junxiao Chang <junxiao.chang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next 09/11] net: stmmac: dwmac-qco-ethqos: use devm_stmmac_probe_config_dt()
Date: Wed, 21 Jun 2023 17:36:48 +0200
Message-Id: <20230621153650.440350-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621153650.440350-1-brgl@bgdev.pl>
References: <20230621153650.440350-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Significantly simplify the driver's probe() function by using the devres
variant of stmmac_probe_config_dt(). This allows to drop the goto jumps
entirely.

The remove_new() callback now needs to be switched to
stmmac_pltfr_remove_no_dt().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 49 ++++++-------------
 1 file changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index fa0fc53c56a3..7b9fbcb8d84d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -708,7 +708,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
 	if (IS_ERR(plat_dat)) {
 		dev_err(dev, "dt configuration failed\n");
 		return PTR_ERR(plat_dat);
@@ -717,10 +717,8 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	plat_dat->clks_config = ethqos_clks_config;
 
 	ethqos = devm_kzalloc(dev, sizeof(*ethqos), GFP_KERNEL);
-	if (!ethqos) {
-		ret = -ENOMEM;
-		goto out_config_dt;
-	}
+	if (!ethqos)
+		return -ENOMEM;
 
 	ethqos->phy_mode = device_get_phy_mode(dev);
 	switch (ethqos->phy_mode) {
@@ -734,19 +732,15 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		ethqos->configure_func = ethqos_configure_sgmii;
 		break;
 	case -ENODEV:
-		ret = -ENODEV;
-		goto out_config_dt;
+		return -ENODEV;
 	default:
-		ret = -EINVAL;
-		goto out_config_dt;
+		return -EINVAL;
 	}
 
 	ethqos->pdev = pdev;
 	ethqos->rgmii_base = devm_platform_ioremap_resource_byname(pdev, "rgmii");
-	if (IS_ERR(ethqos->rgmii_base)) {
-		ret = PTR_ERR(ethqos->rgmii_base);
-		goto out_config_dt;
-	}
+	if (IS_ERR(ethqos->rgmii_base))
+		return PTR_ERR(ethqos->rgmii_base);
 
 	ethqos->mac_base = stmmac_res.addr;
 
@@ -757,24 +751,20 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	ethqos->has_emac_ge_3 = data->has_emac_ge_3;
 
 	ethqos->link_clk = devm_clk_get(dev, data->link_clk_name ?: "rgmii");
-	if (IS_ERR(ethqos->link_clk)) {
-		ret = PTR_ERR(ethqos->link_clk);
-		goto out_config_dt;
-	}
+	if (IS_ERR(ethqos->link_clk))
+		return PTR_ERR(ethqos->link_clk);
 
 	ret = ethqos_clks_config(ethqos, true);
 	if (ret)
-		goto out_config_dt;
+		return ret;
 
 	ret = devm_add_action_or_reset(dev, ethqos_clks_disable, ethqos);
 	if (ret)
-		goto out_config_dt;
+		return ret;
 
 	ethqos->serdes_phy = devm_phy_optional_get(dev, "serdes");
-	if (IS_ERR(ethqos->serdes_phy)) {
-		ret = PTR_ERR(ethqos->serdes_phy);
-		goto out_config_dt;
-	}
+	if (IS_ERR(ethqos->serdes_phy))
+		return PTR_ERR(ethqos->serdes_phy);
 
 	ethqos->speed = SPEED_1000;
 	ethqos_update_link_clk(ethqos, SPEED_1000);
@@ -797,16 +787,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		plat_dat->serdes_powerdown  = qcom_ethqos_serdes_powerdown;
 	}
 
-	ret = stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
-	if (ret)
-		goto out_config_dt;
-
-	return ret;
-
-out_config_dt:
-	stmmac_remove_config_dt(pdev, plat_dat);
-
-	return ret;
+	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
 }
 
 static const struct of_device_id qcom_ethqos_match[] = {
@@ -820,7 +801,7 @@ MODULE_DEVICE_TABLE(of, qcom_ethqos_match);
 
 static struct platform_driver qcom_ethqos_driver = {
 	.probe  = qcom_ethqos_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove_new = stmmac_pltfr_remove_no_dt,
 	.driver = {
 		.name           = "qcom-ethqos",
 		.pm		= &stmmac_pltfr_pm_ops,
-- 
2.39.2


