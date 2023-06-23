Return-Path: <netdev+bounces-13329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C1073B485
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DAE281A18
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 10:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFDE6FD5;
	Fri, 23 Jun 2023 10:04:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5156FBB
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 10:04:32 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923E8210E
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:04:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f9bece8d1bso6124305e9.0
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514669; x=1690106669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jabdaiTACMvGCMLJ1hwhPAwP261O3guFNIkOypEaFEs=;
        b=eqSeo+sjCAKrN1PhWFnU8m2bX62dkk//RSa+mhdep5Am2/hvnd1c/spwgUf7UT8S+J
         DMn1c4hnrsC9dhMXtA0DGjXjpUQ+EzJkHb6xwKO4k/sfxR/S91g9f34oXkXhrF167u/a
         jKCk4PQUr/+LGiVH9h9X1QwBzqmB1WBEs/zOwuJ76DOfi5n8R8lSBPuhqI4SpVs6y+lT
         W1JLncUby2C0RfAB0uN/ZzltRPnuX4MSo87iEt4e5dFWx7jeVNPoBowuo+iDuXQiqRjL
         RSYchx2ZVcrvpGzaugbS+4n2XUtIJnVCsBPHlyYLvjawalaYX37MftDL87DI6V7A9611
         XlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514669; x=1690106669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jabdaiTACMvGCMLJ1hwhPAwP261O3guFNIkOypEaFEs=;
        b=FVcQxTi4PnRzhOflMGZRNLBQXx7gTR5D2WUC4EjPfH7pb0OwWqMQTmpuOPRHTB7i/m
         sTQnCO2qkn2mIzPoSweGXlli4vQGYJbaVNny87sdvXXl4lJQZpm8JkuIhzhGnX9GtHO9
         l+mNsNKWsXDdYgVp0ZOV7udFmlGdS/XgDmTFUXY1FVfUhOgjS+62CYdfT65uY6Czgivk
         RswzY8cJf2GdIJOXoYfondH9skDB5I4PbihRqspH/GCRBsMe2NA3rImkxYfGsUQ3kkrk
         vviRIYx4tQlT9bjYfh3fzO7I9W1+MoIfyflreP87wnvGDwdzkC7sLmcbEBmLE6iGAwdK
         By8A==
X-Gm-Message-State: AC+VfDzvXJqFcSZvXEaSuqja31U4bU7gVRGc4FdlVziqPLCqQ4bRPyaH
	Mo48ujtJJJB06ql48FEqVWdvhGFbE6WzR/66j5w=
X-Google-Smtp-Source: ACHHUZ4bVCpHhUCnxYiI3JTV0LWY7FqHqFM5Tihm/PAqtSEUDYD7cm5xfHqQ00GaUxgHhpUKVF5oaw==
X-Received: by 2002:adf:f844:0:b0:311:f28:c65b with SMTP id d4-20020adff844000000b003110f28c65bmr14808026wrq.23.1687514669140;
        Fri, 23 Jun 2023 03:04:29 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d54c8000000b0030fae360f14sm9079360wrv.68.2023.06.23.03.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:04:28 -0700 (PDT)
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
Subject: [PATCH net-next v2 07/11] net: stmmac: platform: provide stmmac_pltfr_remove_no_dt()
Date: Fri, 23 Jun 2023 12:04:13 +0200
Message-Id: <20230623100417.93592-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623100417.93592-1-brgl@bgdev.pl>
References: <20230623100417.93592-1-brgl@bgdev.pl>
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


