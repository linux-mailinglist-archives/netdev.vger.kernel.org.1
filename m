Return-Path: <netdev+bounces-35057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA4D7A6B6F
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 21:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B4B2816D0
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 19:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AC12E64E;
	Tue, 19 Sep 2023 19:20:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09D52AB32
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 19:20:05 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA7CB3
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 12:20:03 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id af79cd13be357-773eee01525so20111485a.0
        for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 12:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1695151203; x=1695756003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCY81i+nseXrrFOhCCMbEZ9jSIB5L2BqWxrjnhtX0k0=;
        b=krSms9Rbt4TOhSjIrOpHHLtRzESDIL2wzQoBcldrnzjzX0TeSFxvrlwMkIPpOBy27R
         Lmj64y8V/Z+0k4b4a2Da9RM3fHZZbhZWWcBSrxfzKgtAPtXT5d8M6FLwo3FfCs7/lBas
         ud9ZVffJb0PiueIDvAOkKJvCF4O1LPb2X65P9dkTE2vPouRrl15AkfaBXNonUIHjjluN
         iJzPGnqyYoaNDceawytqq/FT24jfeMnDDcRlupmVtwgTaHSBxokBoRvkTmLXhy9ZYVil
         RwdQW5Yqe1t4VpwAK/rna78HmmkUnt1J7aRjEu2FFDf5tIsZJ9PnHrdgyxRrURtjyO5d
         svZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695151203; x=1695756003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCY81i+nseXrrFOhCCMbEZ9jSIB5L2BqWxrjnhtX0k0=;
        b=srceioC+obMhb6DBBn78xGvdsRKZ7iZhf9oa2fmE3TN7CckcrTYMLPjSK6HbPRvwxP
         S8+hAK9VDalfQp95ZPoxojzb9S3uue9d2fxjKbrNEVnIs6oLtvwc9KlGT9Q9sqmhqacs
         +4mLwGkzS/HIfZh0QMm4R1dimKNdI/EcEHTcDj9kDycWaSZv/iE/MBGQCDIrcG31st03
         r9A266+H/bX68uY72E5ur5rgrVS4v7gT71klAdqzYYtnkOZvV07X/R8IlYApsoaZv8Y3
         eOy+yJ+FEOOEyF/gxus2QOwW9eBtmz9Z7QoIfEt26jpp9GRywmH4pdYb1ElaEYqHquSI
         4cxg==
X-Gm-Message-State: AOJu0Yw+ZXGEA+oqjey0rut0fxjfTgmChwevKsc3g84B74DgXQ+n9wsQ
	s3U9lvdabDMWLZxreKnOwOeWTA==
X-Google-Smtp-Source: AGHT+IEiK0fjP9NmWWu/r8rCHgd3P7ehoSIOSkTPV4Wj0AIazIHRILRyy1BeOefIMr+wNBb2I6i4ow==
X-Received: by 2002:a05:620a:2ac4:b0:772:6384:e749 with SMTP id bn4-20020a05620a2ac400b007726384e749mr619554qkb.20.1695151202974;
        Tue, 19 Sep 2023 12:20:02 -0700 (PDT)
Received: from dell-precision-5540.lan ([2601:18c:8002:3d40:df77:9915:c17e:79])
        by smtp.gmail.com with ESMTPSA id x12-20020ae9f80c000000b0076c60b95b87sm4179704qkh.96.2023.09.19.12.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 12:20:02 -0700 (PDT)
From: Ben Wolsieffer <ben.wolsieffer@hefring.com>
To: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Christophe Roullier <christophe.roullier@st.com>,
	Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: [PATCH 2/2] net: stmmac: dwmac-stm32: refactor clock config
Date: Tue, 19 Sep 2023 12:45:36 -0400
Message-ID: <20230919164535.128125-4-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919164535.128125-2-ben.wolsieffer@hefring.com>
References: <20230919164535.128125-2-ben.wolsieffer@hefring.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, clock configuration is spread throughout the driver and
partially duplicated for the STM32MP1 and STM32 MCU variants. This makes
it difficult to keep track of which clocks need to be enabled or disabled
in various scenarios.

This patch adds symmetric stm32_dwmac_clk_enable/disable() functions
that handle all clock configuration, including quirks required while
suspending or resuming. syscfg_clk and clk_eth_ck are not present on
STM32 MCUs, but it is fine to try to configure them anyway since NULL
clocks are ignored.

Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 113 +++++++-----------
 1 file changed, 45 insertions(+), 68 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index a0e276783e65..e53ca4111cbe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -98,7 +98,6 @@ struct stm32_dwmac {
 
 struct stm32_ops {
 	int (*set_mode)(struct plat_stmmacenet_data *plat_dat);
-	int (*clk_prepare)(struct stm32_dwmac *dwmac, bool prepare);
 	int (*suspend)(struct stm32_dwmac *dwmac);
 	void (*resume)(struct stm32_dwmac *dwmac);
 	int (*parse_data)(struct stm32_dwmac *dwmac,
@@ -107,62 +106,55 @@ struct stm32_ops {
 	bool clk_rx_enable_in_suspend;
 };
 
-static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
+static int stm32_dwmac_clk_enable(struct stm32_dwmac *dwmac, bool resume)
 {
-	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
 	int ret;
 
-	if (dwmac->ops->set_mode) {
-		ret = dwmac->ops->set_mode(plat_dat);
-		if (ret)
-			return ret;
-	}
-
 	ret = clk_prepare_enable(dwmac->clk_tx);
 	if (ret)
-		return ret;
+		goto err_clk_tx;
 
-	if (!dwmac->ops->clk_rx_enable_in_suspend ||
-	    !dwmac->dev->power.is_suspended) {
+	if (!dwmac->ops->clk_rx_enable_in_suspend || !resume) {
 		ret = clk_prepare_enable(dwmac->clk_rx);
-		if (ret) {
-			clk_disable_unprepare(dwmac->clk_tx);
-			return ret;
-		}
+		if (ret)
+			goto err_clk_rx;
 	}
 
-	if (dwmac->ops->clk_prepare) {
-		ret = dwmac->ops->clk_prepare(dwmac, true);
-		if (ret) {
-			clk_disable_unprepare(dwmac->clk_rx);
-			clk_disable_unprepare(dwmac->clk_tx);
-		}
+	ret = clk_prepare_enable(dwmac->syscfg_clk);
+	if (ret)
+		goto err_syscfg_clk;
+
+	if (dwmac->enable_eth_ck) {
+		ret = clk_prepare_enable(dwmac->clk_eth_ck);
+		if (ret)
+			goto err_clk_eth_ck;
 	}
 
 	return ret;
+
+err_clk_eth_ck:
+	clk_disable_unprepare(dwmac->syscfg_clk);
+err_syscfg_clk:
+	if (!dwmac->ops->clk_rx_enable_in_suspend || !resume)
+		clk_disable_unprepare(dwmac->clk_rx);
+err_clk_rx:
+	clk_disable_unprepare(dwmac->clk_tx);
+err_clk_tx:
+	return ret;
 }
 
-static int stm32mp1_clk_prepare(struct stm32_dwmac *dwmac, bool prepare)
+static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat, bool resume)
 {
-	int ret = 0;
+	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
+	int ret;
 
-	if (prepare) {
-		ret = clk_prepare_enable(dwmac->syscfg_clk);
+	if (dwmac->ops->set_mode) {
+		ret = dwmac->ops->set_mode(plat_dat);
 		if (ret)
 			return ret;
-		if (dwmac->enable_eth_ck) {
-			ret = clk_prepare_enable(dwmac->clk_eth_ck);
-			if (ret) {
-				clk_disable_unprepare(dwmac->syscfg_clk);
-				return ret;
-			}
-		}
-	} else {
-		clk_disable_unprepare(dwmac->syscfg_clk);
-		if (dwmac->enable_eth_ck)
-			clk_disable_unprepare(dwmac->clk_eth_ck);
 	}
-	return ret;
+
+	return stm32_dwmac_clk_enable(dwmac, resume);
 }
 
 static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
@@ -252,13 +244,15 @@ static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
 				 dwmac->ops->syscfg_eth_mask, val << 23);
 }
 
-static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac)
+static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac, bool suspend)
 {
 	clk_disable_unprepare(dwmac->clk_tx);
-	clk_disable_unprepare(dwmac->clk_rx);
+	if (!dwmac->ops->clk_rx_enable_in_suspend || !suspend)
+		clk_disable_unprepare(dwmac->clk_rx);
 
-	if (dwmac->ops->clk_prepare)
-		dwmac->ops->clk_prepare(dwmac, false);
+	clk_disable_unprepare(dwmac->syscfg_clk);
+	if (dwmac->enable_eth_ck)
+		clk_disable_unprepare(dwmac->clk_eth_ck);
 }
 
 static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
@@ -400,7 +394,7 @@ static int stm32_dwmac_probe(struct platform_device *pdev)
 
 	plat_dat->bsp_priv = dwmac;
 
-	ret = stm32_dwmac_init(plat_dat);
+	ret = stm32_dwmac_init(plat_dat, false);
 	if (ret)
 		goto err_remove_config_dt;
 
@@ -411,7 +405,7 @@ static int stm32_dwmac_probe(struct platform_device *pdev)
 	return 0;
 
 err_clk_disable:
-	stm32_dwmac_clk_disable(dwmac);
+	stm32_dwmac_clk_disable(dwmac, false);
 err_remove_config_dt:
 	stmmac_remove_config_dt(pdev, plat_dat);
 
@@ -426,7 +420,7 @@ static void stm32_dwmac_remove(struct platform_device *pdev)
 
 	stmmac_dvr_remove(&pdev->dev);
 
-	stm32_dwmac_clk_disable(priv->plat->bsp_priv);
+	stm32_dwmac_clk_disable(dwmac, false);
 
 	if (dwmac->irq_pwr_wakeup >= 0) {
 		dev_pm_clear_wake_irq(&pdev->dev);
@@ -436,18 +430,7 @@ static void stm32_dwmac_remove(struct platform_device *pdev)
 
 static int stm32mp1_suspend(struct stm32_dwmac *dwmac)
 {
-	int ret = 0;
-
-	ret = clk_prepare_enable(dwmac->clk_ethstp);
-	if (ret)
-		return ret;
-
-	clk_disable_unprepare(dwmac->clk_tx);
-	clk_disable_unprepare(dwmac->syscfg_clk);
-	if (dwmac->enable_eth_ck)
-		clk_disable_unprepare(dwmac->clk_eth_ck);
-
-	return ret;
+	return clk_prepare_enable(dwmac->clk_ethstp);
 }
 
 static void stm32mp1_resume(struct stm32_dwmac *dwmac)
@@ -455,14 +438,6 @@ static void stm32mp1_resume(struct stm32_dwmac *dwmac)
 	clk_disable_unprepare(dwmac->clk_ethstp);
 }
 
-static int stm32mcu_suspend(struct stm32_dwmac *dwmac)
-{
-	clk_disable_unprepare(dwmac->clk_tx);
-	clk_disable_unprepare(dwmac->clk_rx);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int stm32_dwmac_suspend(struct device *dev)
 {
@@ -473,6 +448,10 @@ static int stm32_dwmac_suspend(struct device *dev)
 	int ret;
 
 	ret = stmmac_suspend(dev);
+	if (ret)
+		return ret;
+
+	stm32_dwmac_clk_disable(dwmac, true);
 
 	if (dwmac->ops->suspend)
 		ret = dwmac->ops->suspend(dwmac);
@@ -490,7 +469,7 @@ static int stm32_dwmac_resume(struct device *dev)
 	if (dwmac->ops->resume)
 		dwmac->ops->resume(dwmac);
 
-	ret = stm32_dwmac_init(priv->plat);
+	ret = stm32_dwmac_init(priv->plat, true);
 	if (ret)
 		return ret;
 
@@ -505,13 +484,11 @@ static SIMPLE_DEV_PM_OPS(stm32_dwmac_pm_ops,
 
 static struct stm32_ops stm32mcu_dwmac_data = {
 	.set_mode = stm32mcu_set_mode,
-	.suspend = stm32mcu_suspend,
 	.syscfg_eth_mask = SYSCFG_MCU_ETH_MASK
 };
 
 static struct stm32_ops stm32mp1_dwmac_data = {
 	.set_mode = stm32mp1_set_mode,
-	.clk_prepare = stm32mp1_clk_prepare,
 	.suspend = stm32mp1_suspend,
 	.resume = stm32mp1_resume,
 	.parse_data = stm32mp1_parse_data,
-- 
2.42.0


