Return-Path: <netdev+bounces-12707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A7C7389CA
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A2E281680
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D8E19BA4;
	Wed, 21 Jun 2023 15:37:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BC319BA3
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 15:37:41 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782FFE69
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:37:22 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f76a0a19d4so8366463e87.2
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687361828; x=1689953828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yItovFwloe3duebYnq7A6B4V/jKgQ44zzRGa/G+pPW8=;
        b=CSv88/ZWPsCkujCLeQvR5zV6QJ197upQiupFOf7hhQJLU4holZQmyEM8afOeiopPJI
         rxkkXknIdFBsXaGs9e5eQl8cmqwLLSitBBUYN4EkfgWs1N3I08bYlFaMCcxWlpL00o5R
         m+Z0PytTuM0BQ2VA1FUXHz93HaoWpBMXD7Xg1oI0Iex7kwBXSFxukS+BVYvPEM1Z+x/J
         1MMnplXM//mLc8MN0qTVv7Q3KJFsN8GnzobJyIhzjWXEbG/2zt6VldBu8G2I7bJGs2ei
         Te8uSE3lkY289Edv22F486sKBj0Hx/GJT7tkzQsTOMVS4qqtocy0eoZE2IXrcvMDnFyM
         oU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361828; x=1689953828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yItovFwloe3duebYnq7A6B4V/jKgQ44zzRGa/G+pPW8=;
        b=fJzJ1Mzn5qvf9qqVmZmHxaM4KiaJ3wIH86vbJQd4fc25tgHKqM4noFQ1NEO+Zd5Ko0
         G4qplMD5TUlGpY6SSZa1Hh2aWbSVaEvSLr/soFtzdvOZVmxFjsL3nJk20jm3HfBc1T8O
         7yFFySmNzC/drJo4q2AQo1TZzCWjBeo/uMy5rp9KFLzG7fsQDb0DoGDzIn9gbb16w3sH
         byj6Ay6Uzvk9vlSfLl1kv8+BnHWQhBhlghtaEhNQYIrfivUwcDU2Mw2N0GFfHjuRxBRb
         SPyI9RPhK80mDbGyqLak8GY+Tvl2Cm2/lCRoQheOspqJBlkhTyL63EGHJyHJaPOki5Y6
         jiyg==
X-Gm-Message-State: AC+VfDwDKmO03do+/1D4lvivS7YJpgzVuNLRLNa91BHmPC1HCdH/6dVT
	+iJsE3iP8TjuCekBrbWeq1XKQQ==
X-Google-Smtp-Source: ACHHUZ6zjgqtk9I7hnzpINsxw7Jk5ONzx9X2XtIX2vI7/3ICM1PCWSNZh/mAZPlvVnMabN82Dm8Q4g==
X-Received: by 2002:a05:6512:3b0a:b0:4f8:6fe9:3c9c with SMTP id f10-20020a0565123b0a00b004f86fe93c9cmr992970lfv.49.1687361828170;
        Wed, 21 Jun 2023 08:37:08 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003f7ed463954sm5322491wme.25.2023.06.21.08.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:37:07 -0700 (PDT)
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
Subject: [PATCH net-next 06/11] net: stmmac: dwmac-generic: use stmmac_pltfr_probe()
Date: Wed, 21 Jun 2023 17:36:45 +0200
Message-Id: <20230621153650.440350-7-brgl@bgdev.pl>
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

Shrink the code and remove labels by using the new stmmac_pltfr_probe()
function.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
index dabf05601221..20fc455b3337 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
@@ -46,19 +46,12 @@ static int dwmac_generic_probe(struct platform_device *pdev)
 		plat_dat->unicast_filter_entries = 1;
 	}
 
-	/* Custom initialisation (if needed) */
-	ret = stmmac_pltfr_init(pdev, plat_dat);
+	ret = stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 	if (ret)
 		goto err_remove_config_dt;
 
-	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
-	if (ret)
-		goto err_exit;
-
 	return 0;
 
-err_exit:
-	stmmac_pltfr_exit(pdev, plat_dat);
 err_remove_config_dt:
 	if (pdev->dev.of_node)
 		stmmac_remove_config_dt(pdev, plat_dat);
-- 
2.39.2


