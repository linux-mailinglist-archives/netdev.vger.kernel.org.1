Return-Path: <netdev+bounces-12702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D3E7389A3
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA5E1C20EDD
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF97D1952E;
	Wed, 21 Jun 2023 15:37:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EB41952C
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 15:37:34 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634511FCF
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:37:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fa0253b9e7so276155e9.1
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687361822; x=1689953822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfAhAsug9ufzHE7mkap9OTTt62MSzJGSWiVrEWzAwlU=;
        b=Hkolap0343pI2fTeDMlSL1ecIJgWvi+Cb3axXsbFUnMqYfjB0CdwOKmdaJCFujs4LI
         0Rc9dnin8sX/+/MAm7llAX+pu3vF9n0x9GAmBwyyeDeGTFTfpDJ4L9KjfqG2N91gNgYI
         55uWZk+4qz6IH6GmNakF9fu2scRuEmaclyvRs4aNEXa8gZ4/TMo0q+TtRFf8qkHzZvd0
         tZjiIO5QubenHiHbQcsBfYJcJJ3oQs8Uwa1ETmppDB0V38beg2XzIi4EBzfod8JGFr/n
         js20442BN7akSbBSzSQKV1H96WRh3TlDX1c5fOPtTYOjTLrF9BaDoUuZxGZtP1rmWoTX
         xAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361822; x=1689953822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfAhAsug9ufzHE7mkap9OTTt62MSzJGSWiVrEWzAwlU=;
        b=UmQDRJOHXXnn12UE+KOcEQUJ95121QQj53qrUs0+IC6cdI8N78B/ejNmSrIKK0Hvci
         xqxb8MF6mjlW9lV3CV6IdjY0KOTXyEvAuidqQSXgE0YjqhFySpAxrGD/NMyARj73Fx7m
         FtFdOIzn4P2qED5qofhcb4Gt5wYkjMS5HmDXLZVR5MSnDzwx89qqHf+IcDpteexJNuqe
         tIOw8J8jLsYzOFbYYDJF2d7peQjJn64PVJKiAad6a8/KL2fs3bVDs42V3jR0HZd6boE1
         NCWIP2xfIqxjOwMHljg7oC0z7virLsKfWnYCeUImKQCeS7Lnp0atCsqzicXgzkPWUqYa
         Gmyg==
X-Gm-Message-State: AC+VfDz6NKCWhlMCl9BdfC1Xn0ENka4+fEcFnvV5ouxSAd1iNtaJURHF
	Egm822qG3dhZwGi7+dh7ub+YCg==
X-Google-Smtp-Source: ACHHUZ61KtPw7PZMSqkd+p+2S3J7vRMgyN38QB8hapuEJIl2U4P060oQ1mu5xvl7D6IGcQD0QKv/mA==
X-Received: by 2002:a05:600c:3659:b0:3f7:aee8:c23a with SMTP id y25-20020a05600c365900b003f7aee8c23amr19068795wmq.19.1687361822463;
        Wed, 21 Jun 2023 08:37:02 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003f7ed463954sm5322491wme.25.2023.06.21.08.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:37:02 -0700 (PDT)
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
Subject: [PATCH net-next 01/11] net: stmmac: platform: provide stmmac_pltfr_init()
Date: Wed, 21 Jun 2023 17:36:40 +0200
Message-Id: <20230621153650.440350-2-brgl@bgdev.pl>
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

Provide a helper wrapper around calling the platform's init() callback.
This allows users to skip checking if the callback exists.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 25 +++++++++++++++++--
 .../ethernet/stmicro/stmmac/stmmac_platform.h |  3 +++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 3c6b55b60461..41ca4fc9f863 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -701,6 +701,25 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(stmmac_get_platform_resources);
 
+/**
+ * stmmac_pltfr_init
+ * @pdev: pointer to the platform device
+ * @plat: driver data platform structure
+ * Description: Call the platform's init callback (if any) and propagate
+ * the return value.
+ */
+int stmmac_pltfr_init(struct platform_device *pdev,
+		      struct plat_stmmacenet_data *plat)
+{
+	int ret = 0;
+
+	if (plat->init)
+		ret = plat->init(pdev, plat->bsp_priv);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(stmmac_pltfr_init);
+
 /**
  * stmmac_pltfr_remove
  * @pdev: platform device pointer
@@ -755,9 +774,11 @@ static int __maybe_unused stmmac_pltfr_resume(struct device *dev)
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	struct platform_device *pdev = to_platform_device(dev);
+	int ret;
 
-	if (priv->plat->init)
-		priv->plat->init(pdev, priv->plat->bsp_priv);
+	ret = stmmac_pltfr_init(pdev, priv->plat->bsp_priv);
+	if (ret)
+		return ret;
 
 	return stmmac_resume(dev);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
index f7e457946681..6a2cd47fedcd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
@@ -19,6 +19,9 @@ void stmmac_remove_config_dt(struct platform_device *pdev,
 int stmmac_get_platform_resources(struct platform_device *pdev,
 				  struct stmmac_resources *stmmac_res);
 
+int stmmac_pltfr_init(struct platform_device *pdev,
+		      struct plat_stmmacenet_data *plat);
+
 void stmmac_pltfr_remove(struct platform_device *pdev);
 extern const struct dev_pm_ops stmmac_pltfr_pm_ops;
 
-- 
2.39.2


