Return-Path: <netdev+bounces-13332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F52073B489
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267D2280E49
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 10:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602418494;
	Fri, 23 Jun 2023 10:04:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4C88492
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 10:04:35 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E220A211E
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:04:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f9c532f9e3so6025845e9.1
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514672; x=1690106672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ii2x6MMLssuPPDNgYZGKvPLHM+c/zKC3YPgF49rTzdU=;
        b=xSDCg+lQUTIDMHwkxHAv0qmSrhP3TF+2Q+0dynApoIaSJ5GIQM6boUZKpmYDJLDuIP
         BOEE/sQ2caNPKZ1VaFG7OZwGiPYnsN9M90ejDCYrmbZJTTCLS/jfL3VuASK7IbdgtUm8
         6PpCE0fAhax4EJ36dRSkksMuIH/rHPH7J1PBgvNevC22JeNI4uq1L9CEtfIUlw0Iaq30
         WBH3cUDzzwurXlrJIDqzk3Vfd2W9XovQSWzJ+KylTKtr79sm7p8zwZZ4jw5WHgFoQLXT
         ORDkSaDF2Xep9pqXC8oU4uxnl3oy3wSOhvV8X/TirT9j0K6ocU4LZH7IT1DirOgPUW9k
         35fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514672; x=1690106672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ii2x6MMLssuPPDNgYZGKvPLHM+c/zKC3YPgF49rTzdU=;
        b=lGsGpsnRgCZ/vZD+Q49dSIAyEA0dwDc6bO9Tu3tO8WvMHLR7PR+Q5qdxdlCY2LDG1o
         f8t+rIUT4B/KwXcJ0RMzlgtHbV4P9i1bXELpV31NFdo1ppCwd32vRrEOyy1ASl17cJN+
         ksZayBFYll78KOp8bXjn8iyI5Cvkhnt7FETBpH70J1btlyFWElTVgjUafQ6vSnoNCZXx
         lyCg/KOzxvqZ2qzePB+4h9IQlBKNgq5T/idlEKUC2DYKuVpBkTa3deckq3QKSGjeH+qK
         axRfhncixkdGlpZSvsoW3pX7g4uBWmsoVvMpP8lv1QNSLZgdf+aDQ9g8tYRKDEquJhEu
         InuA==
X-Gm-Message-State: AC+VfDy+cJ4H+sb3urh5Gmbs4nNo2Nz4QAikdXEanm5PxGI9voT9YNUT
	d1h3uVrZbf0DYiLaMo0J3rJNmw==
X-Google-Smtp-Source: ACHHUZ4zkuuP4XLvWsf7VK9/F+8V9/cJeGdLNhhFXFsK0B4wOm3wwwI0PE3dMoROI9fRkKxT0tyIbw==
X-Received: by 2002:a5d:6ad1:0:b0:2f5:d3d7:7af4 with SMTP id u17-20020a5d6ad1000000b002f5d3d77af4mr16354365wrw.63.1687514672396;
        Fri, 23 Jun 2023 03:04:32 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d54c8000000b0030fae360f14sm9079360wrv.68.2023.06.23.03.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:04:31 -0700 (PDT)
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
Subject: [PATCH net-next v2 10/11] net: stmmac: platform: provide devm_stmmac_pltfr_probe()
Date: Fri, 23 Jun 2023 12:04:16 +0200
Message-Id: <20230623100417.93592-11-brgl@bgdev.pl>
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

Provide a devres variant of stmmac_pltfr_probe() which allows users to
skip calling stmmac_pltfr_remove() at driver detach.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 30 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.h |  3 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 82d8a1c76476..231152ee5a32 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -803,6 +803,36 @@ int stmmac_pltfr_probe(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(stmmac_pltfr_probe);
 
+static void devm_stmmac_pltfr_remove(void *data)
+{
+	struct platform_device *pdev = data;
+
+	stmmac_pltfr_remove_no_dt(pdev);
+}
+
+/**
+ * devm_stmmac_pltfr_probe
+ * @pdev: pointer to the platform device
+ * @plat: driver data platform structure
+ * @res: stmmac resources
+ * Description: Devres variant of stmmac_pltfr_probe(). Allows users to skip
+ * calling stmmac_pltfr_remove() on driver detach.
+ */
+int devm_stmmac_pltfr_probe(struct platform_device *pdev,
+			    struct plat_stmmacenet_data *plat,
+			    struct stmmac_resources *res)
+{
+	int ret;
+
+	ret = stmmac_pltfr_probe(pdev, plat, res);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(&pdev->dev, devm_stmmac_pltfr_remove,
+					pdev);
+}
+EXPORT_SYMBOL_GPL(devm_stmmac_pltfr_probe);
+
 /**
  * stmmac_pltfr_remove_no_dt
  * @pdev: pointer to the platform device
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
index 8c1e5b2e9dae..c5565b2a70ac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
@@ -29,6 +29,9 @@ void stmmac_pltfr_exit(struct platform_device *pdev,
 int stmmac_pltfr_probe(struct platform_device *pdev,
 		       struct plat_stmmacenet_data *plat,
 		       struct stmmac_resources *res);
+int devm_stmmac_pltfr_probe(struct platform_device *pdev,
+			    struct plat_stmmacenet_data *plat,
+			    struct stmmac_resources *res);
 void stmmac_pltfr_remove_no_dt(struct platform_device *pdev);
 void stmmac_pltfr_remove(struct platform_device *pdev);
 extern const struct dev_pm_ops stmmac_pltfr_pm_ops;
-- 
2.39.2


