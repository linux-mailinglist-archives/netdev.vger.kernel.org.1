Return-Path: <netdev+bounces-13333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E976273B48A
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B91281AA9
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 10:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F0F8BED;
	Fri, 23 Jun 2023 10:04:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8948BE1
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 10:04:36 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1020E210E
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:04:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fa74d06d72so5252305e9.3
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514673; x=1690106673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6sVXJ2cleHMEi/0WcOIV4n/ZjjS+cQY293Qzlx7CXQ=;
        b=zuGv3jqXPXNst6BYdlNOz5i7R06BMmZUVLJVX6sdqiNUSMSJA2TAJOvJxpPq7poHFl
         FHr5u/kNtB7MlgZf+OWwoWxJ6Jxu8gW0lGRZwQY8yPD1iznE9mpGFEjJM3mAoU7ZRbRK
         MRYVo7oR/4TUl7HvpOZsCmJ5nu7qLJus9x9vo5gmUfvUhlC4qJsBa63p2GNLpiliJdH8
         hV88Vin4HqHWY3tNDp3gTuszcYIIA1WEyz4n9c4yXp62IKJ36mBCCsXKu1PmbJQ1p11J
         atLvDgsPjPDAdkzCsH3ErVKInQek3T5Hapaa49UXesn9QL4rWhG7caUsMcQi5XO7qFTV
         xk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514673; x=1690106673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6sVXJ2cleHMEi/0WcOIV4n/ZjjS+cQY293Qzlx7CXQ=;
        b=e/+j1NFfakSiSrljZPGrxqb+mvdk2oAmxyA3uV+viDxaCMjEYrNPXmRDGHCwUvqpkh
         Dchv5amyoFMi/d6wD57bxe9UXK9xN6AFee7vwF+waptN8SlrSqeveN8nNQvQu+wOGQkh
         W5uWfq6K2MYIvTk9gYo3+eTx1oZNbyN/Qgd4o4ftEmx6a/54z0miXqVfDn0hXWmBqXYF
         TG2fRGgkFnUIXlD0YsheZkGBYXTypHQerncG3T83mRKWyWSXt8Iwk12ulMIY6YgT3lXi
         5lWxwKQz4VVHaQXCQFCccDe4m7x0i9sXs7H8jjXYRc6/EiLdfsvbU2hllPDYqaHzZrur
         afXg==
X-Gm-Message-State: AC+VfDyf/0FGe9QitoP8XjEkd1fugzU4lMhDR1VcdZDjFTFR0nvdAZer
	vFVURuSgGkpe9hK+G5/ziy6clQ==
X-Google-Smtp-Source: ACHHUZ6QwnIxjXMCCySl+cTuiFkXSm9Z1C26KrzkHt/AtwA5hawwYsHJNk48HZyL8sHOloJRl0dkvw==
X-Received: by 2002:a7b:cd10:0:b0:3f9:b79b:e74e with SMTP id f16-20020a7bcd10000000b003f9b79be74emr7799589wmj.22.1687514673633;
        Fri, 23 Jun 2023 03:04:33 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d54c8000000b0030fae360f14sm9079360wrv.68.2023.06.23.03.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:04:33 -0700 (PDT)
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
Subject: [PATCH net-next v2 11/11] net: stmmac: dwmac-qcom-ethqos: use devm_stmmac_pltfr_probe()
Date: Fri, 23 Jun 2023 12:04:17 +0200
Message-Id: <20230623100417.93592-12-brgl@bgdev.pl>
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
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Use the devres variant of stmmac_pltfr_probe() and finally drop the
remove() callback entirely.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 7b9fbcb8d84d..e62940414e54 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -787,7 +787,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		plat_dat->serdes_powerdown  = qcom_ethqos_serdes_powerdown;
 	}
 
-	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
+	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 
 static const struct of_device_id qcom_ethqos_match[] = {
@@ -801,7 +801,6 @@ MODULE_DEVICE_TABLE(of, qcom_ethqos_match);
 
 static struct platform_driver qcom_ethqos_driver = {
 	.probe  = qcom_ethqos_probe,
-	.remove_new = stmmac_pltfr_remove_no_dt,
 	.driver = {
 		.name           = "qcom-ethqos",
 		.pm		= &stmmac_pltfr_pm_ops,
-- 
2.39.2


