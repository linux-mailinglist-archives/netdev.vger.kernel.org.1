Return-Path: <netdev+bounces-12706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB387389C9
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0C0281669
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01901992E;
	Wed, 21 Jun 2023 15:37:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54851990E
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 15:37:40 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF8B210C
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:37:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fa0253b9e7so277195e9.1
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687361827; x=1689953827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1MdpjqTiZB/Ps9LoJ+Yhj9at3Zx7ZNJ3CPY0Mq713Y=;
        b=G6zYz9cKoSNRIVlhsRux2o+ct2G37TFxEQtQQVXLGOrYecbehoGdxONWH8lp7WkNTZ
         7KMH4O2hnylqp7YUNNwIGyorY+eT/iE/kuv74lWBsVrEaOvH3eHxgd9NWS3iwiuDqn08
         pZu6f1/jsxiy8/DZTT6w8uFkt26l1A+XYmazHQgKzYJkWYB9N39o57Kmjg1fn4H+AaIK
         nIAofbGW5NZ0oVR4Fh8U4u57UZINc9copdCKprqr7ZIEk78QDbVbNOYsYPISczGi0zMw
         RAH9Fb02vq6DS22CwN4VHCOK1HHQfP0NvUHuaTTrVww5MX8yolM/P6F9eTNz6mKlqz0q
         ZzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361827; x=1689953827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1MdpjqTiZB/Ps9LoJ+Yhj9at3Zx7ZNJ3CPY0Mq713Y=;
        b=QFC8JB6VlVMPcvCOVR3bnMxcNlGLk44btkqltYkwBpZeaxQ+jg13qHWHSNrpmkpFZM
         e8l9R/qQikdSTiKug/rTCq+Iamzpgw9Mpr8ijKcZ5OSbP4VMv32+lMPXLyR8mtucHgE2
         EBoHhMqqaFvYk/28LMFg5TW66TIL2JTznsAu8/H09sJ642pqADs4bD6ldQX6tGGq9v9f
         9/hk81c2fsP43HUn+nnJQj2Lj1/lWsL77IT8kikCtnIDYCvEBtN8WQ4RFWnFLwkHvme4
         ghRuwVcb1G9EfQmCt1EZ9TATUMlph8o4bqQY0Rrbfeug+GeZOtvAg0TUSOxuhx7oIH6g
         /OPQ==
X-Gm-Message-State: AC+VfDwJhmql4RcypWz0GdENTmodQQHxCdUMW/D+eVmohqDncFGrkXNo
	gEHg/1bYFzdAMNiGkoZKUSUM0w==
X-Google-Smtp-Source: ACHHUZ7El/Ih0d2Yz/gKGvMngTDUjCNwXQ864fWEFUCB1ReXz/MhJ1k+riyAXlWajUNesQKCvoVyww==
X-Received: by 2002:a1c:f616:0:b0:3f6:d90:3db with SMTP id w22-20020a1cf616000000b003f60d9003dbmr13811551wmc.3.1687361827133;
        Wed, 21 Jun 2023 08:37:07 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003f7ed463954sm5322491wme.25.2023.06.21.08.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:37:06 -0700 (PDT)
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
Subject: [PATCH net-next 05/11] net: stmmac: platform: provide stmmac_pltfr_probe()
Date: Wed, 21 Jun 2023 17:36:44 +0200
Message-Id: <20230621153650.440350-6-brgl@bgdev.pl>
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
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Implement stmmac_pltfr_probe() which is the logical API counterpart
for stmmac_pltfr_remove(). It calls the platform's init() callback and
then probes the stmmac device.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 28 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.h |  3 ++
 2 files changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 5b2bc129cd85..df417cdab8c1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -734,6 +734,34 @@ void stmmac_pltfr_exit(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(stmmac_pltfr_exit);
 
+/**
+ * stmmac_pltfr_probe
+ * @pdev: platform device pointer
+ * @plat: driver data platform structure
+ * @res: stmmac resources structure
+ * Description: This calls the platform's init() callback and probes the
+ * stmmac driver.
+ */
+int stmmac_pltfr_probe(struct platform_device *pdev,
+		       struct plat_stmmacenet_data *plat,
+		       struct stmmac_resources *res)
+{
+	int ret;
+
+	ret = stmmac_pltfr_init(pdev, plat);
+	if (ret)
+		return ret;
+
+	ret = stmmac_dvr_probe(&pdev->dev, plat, res);
+	if (ret) {
+		stmmac_pltfr_exit(pdev, plat);
+		return ret;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(stmmac_pltfr_probe);
+
 /**
  * stmmac_pltfr_remove
  * @pdev: platform device pointer
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
index e79134cc1d3d..f968e658c9d2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
@@ -24,6 +24,9 @@ int stmmac_pltfr_init(struct platform_device *pdev,
 void stmmac_pltfr_exit(struct platform_device *pdev,
 		       struct plat_stmmacenet_data *plat);
 
+int stmmac_pltfr_probe(struct platform_device *pdev,
+		       struct plat_stmmacenet_data *plat,
+		       struct stmmac_resources *res);
 void stmmac_pltfr_remove(struct platform_device *pdev);
 extern const struct dev_pm_ops stmmac_pltfr_pm_ops;
 
-- 
2.39.2


