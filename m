Return-Path: <netdev+bounces-12708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B027389CF
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0664E1C20F0B
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18E219BB1;
	Wed, 21 Jun 2023 15:37:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBAC19BA3
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 15:37:44 +0000 (UTC)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3E11997
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:37:25 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f76a0a19d4so8366495e87.2
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687361829; x=1689953829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jabdaiTACMvGCMLJ1hwhPAwP261O3guFNIkOypEaFEs=;
        b=iG7OfDCk3JDXJMpMe5FwY7oS1o3s1Nvx9x2APRVXDEve97G6AYWW8S/2RDRZtlP4b/
         aDrsWqVsROpv7zXRW9DWRTmH1qqcyVjNN2Xhyjmz3PBMs0AlQHlyfhiACVgiVQQyKWDi
         OObFeo1/781gyvg+8LOciR+e1zqcDmI+umqnmkJLnPHvRvqn2r2LfA92wrJDvxt37lW0
         GX+uGFlJQhc0SLqQ70RUt7kJiR9PZYlesbkhkhLGmOJ5Zk0K7+hQ6IjBUcIT7seW8Jui
         0yqngOHSp0/CYOv0+ORCvbaYwqkzPV9ZuXxXlmAHOup61KLjOSUSY8CVF7APhwWZyq5D
         jfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361829; x=1689953829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jabdaiTACMvGCMLJ1hwhPAwP261O3guFNIkOypEaFEs=;
        b=VENnsOIZSoZD3SEbobPULKWvWU1q0suFRfYk71SjN3gospby3MgjJOpuCmOwsSki8n
         fwKP6zN9X9vuC+UOaVJ3naIxl+2XJAIG+JpHnlSoNyx7IP0xjI2kXknvFhdBbkjyR8//
         pmfEbzF2PZUfID5tMkyJDDtvznIZaD/QrmOwexuLtJ0mchovDLQC5CGBh6fXQEsiCwa/
         y3nViCjF8nGguMmcHR7Q3idnfFfJQUskZjPxInZXCZzalm1bOHiVSPTKQ8dVokQHZZd7
         pyONCq8Jof2i+/qahWZG8TE5Zj60p9c3sj2gXwONDuzuy6XedJgURt9qtivtZHx8oabg
         G0/Q==
X-Gm-Message-State: AC+VfDzsk8rbQ2FJIkynz20byuMJu9hDUlF2I2c3rBDlARl/2DZrpSWl
	PbC6FED0o+iK7NvzOgAb/HHRTw==
X-Google-Smtp-Source: ACHHUZ7O6m3NitPkltuHDknRSK9sSvm6K9sSsjvlHBt+9Nc1zRq0igP7Yk0EiNzUJ+83oxpIYhIKTg==
X-Received: by 2002:a19:ab12:0:b0:4f8:cd67:88e6 with SMTP id u18-20020a19ab12000000b004f8cd6788e6mr3668244lfe.44.1687361829235;
        Wed, 21 Jun 2023 08:37:09 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003f7ed463954sm5322491wme.25.2023.06.21.08.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:37:08 -0700 (PDT)
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
Subject: [PATCH net-next 07/11] net: stmmac: platform: provide stmmac_pltfr_remove_no_dt()
Date: Wed, 21 Jun 2023 17:36:46 +0200
Message-Id: <20230621153650.440350-8-brgl@bgdev.pl>
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

Add a variant of stmmac_pltfr_remove() that only frees resources
allocated by stmmac_pltfr_probe() and - unlike stmmac_pltfr_remove() -
does not call stmmac_remove_config_dt().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 20 +++++++++++++++++--
 .../ethernet/stmicro/stmmac/stmmac_platform.h |  1 +
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index df417cdab8c1..58d5c5cc2269 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -762,6 +762,23 @@ int stmmac_pltfr_probe(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(stmmac_pltfr_probe);
 
+/**
+ * stmmac_pltfr_remove_no_dt
+ * @pdev: pointer to the platform device
+ * Description: This undoes the effects of stmmac_pltfr_probe() by removing the
+ * driver and calling the platform's exit() callback.
+ */
+void stmmac_pltfr_remove_no_dt(struct platform_device *pdev)
+{
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	struct plat_stmmacenet_data *plat = priv->plat;
+
+	stmmac_dvr_remove(&pdev->dev);
+	stmmac_pltfr_exit(pdev, plat);
+}
+EXPORT_SYMBOL_GPL(stmmac_pltfr_remove_no_dt);
+
 /**
  * stmmac_pltfr_remove
  * @pdev: platform device pointer
@@ -774,8 +791,7 @@ void stmmac_pltfr_remove(struct platform_device *pdev)
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	struct plat_stmmacenet_data *plat = priv->plat;
 
-	stmmac_dvr_remove(&pdev->dev);
-	stmmac_pltfr_exit(pdev, plat);
+	stmmac_pltfr_remove_no_dt(pdev);
 	stmmac_remove_config_dt(pdev, plat);
 }
 EXPORT_SYMBOL_GPL(stmmac_pltfr_remove);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
index f968e658c9d2..af52d5aa2b9a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
@@ -27,6 +27,7 @@ void stmmac_pltfr_exit(struct platform_device *pdev,
 int stmmac_pltfr_probe(struct platform_device *pdev,
 		       struct plat_stmmacenet_data *plat,
 		       struct stmmac_resources *res);
+void stmmac_pltfr_remove_no_dt(struct platform_device *pdev);
 void stmmac_pltfr_remove(struct platform_device *pdev);
 extern const struct dev_pm_ops stmmac_pltfr_pm_ops;
 
-- 
2.39.2


