Return-Path: <netdev+bounces-13324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7647D73B472
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B20281A42
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 10:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A45553A2;
	Fri, 23 Jun 2023 10:04:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F97B5CBA
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 10:04:26 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A64E2695
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:04:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3113306a595so522358f8f.1
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514663; x=1690106663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohR2MIoFexvaG1IRw5Am1pEJrTY7jcRqlxnO/EQTdy8=;
        b=VJVkqpM0z1wIlKhzeq04Rr7yyGW6m3B/0zSZk0ZF4oiorHhFrGx3eAZ1O4ghz35lwf
         2Vzj0yeKHFt8iyIvWIANy0BeEEJLy58mwkOpyJ8EUD5cfbEnin8OZiW5Qrfrhba4IafS
         AhgymSi7xoCo2CAObI5Le7wjzGVwohZoop4TrW0K1NQs6HjtaoIvw8x3N0+kNrhlaH5u
         c/9DBysGIZT8a3wYKYvZtOBcF/ETPZ+WRMljR5pIW7cK9jng1I/pvaqfvfNjG+c+Jlm6
         09/vv4XjZtDB+2OBy6nNaWUZoMVcVTMTyK/bex35Sk8ATc0doQDj7H5pCe/C1yS/tvg/
         WZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514663; x=1690106663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohR2MIoFexvaG1IRw5Am1pEJrTY7jcRqlxnO/EQTdy8=;
        b=D4T5m8LOSfjKv9ivjhiVjSlC9Ut/P0/ScZzuEfmd5v+bTm/V7wjZ8dBi7bdQ6YIJ+Y
         DPJlt45B2/HRIzunVFPMqvrCDvx3RKT2agzNbxezqevhkJDEmm7V8hRnPpFCZ0aq/Sjb
         pRQW4EXkMYn1/M8PdhfoO/3BjCoQ6YHwvRW90W11OMQRDGarGCsXOcy1CLYPBX4DZs7Q
         fpYjneUL42xUs6/6WTWMfsOlkN+/vIQFWyBCNWX33adjDXVQz88JesfZph9JRJzBlwig
         xVylLWctA5EvYbobhTd/GtZ9eevg90LazUXgCtaQa7RGl//RWS5EqJL8R1s39XgtntTM
         nONg==
X-Gm-Message-State: AC+VfDy9+RTSJaUz5Ezx/RHzj5dFZKxLZU15QmeDjLcpng4n4tLvfNEB
	DQZyeI9uIDe75XlH7Sur3VSkXg==
X-Google-Smtp-Source: ACHHUZ4BlcG23HC/pK8EJxlXEJOy4hJWAWELm8KN8y0FLwbTfwQ/yreCzwvqxmKh8BtYzNpWMvINCQ==
X-Received: by 2002:adf:e6d2:0:b0:311:1d4a:33e6 with SMTP id y18-20020adfe6d2000000b003111d4a33e6mr18600252wrm.48.1687514663606;
        Fri, 23 Jun 2023 03:04:23 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d54c8000000b0030fae360f14sm9079360wrv.68.2023.06.23.03.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:04:23 -0700 (PDT)
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
Subject: [PATCH net-next v2 02/11] net: stmmac: dwmac-generic: use stmmac_pltfr_init()
Date: Fri, 23 Jun 2023 12:04:08 +0200
Message-Id: <20230623100417.93592-3-brgl@bgdev.pl>
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

Shrink the code in dwmac-generic by using the new stmmac_pltfr_init()
helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
index ef1023930fd0..b7fc79864e8c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
@@ -47,11 +47,9 @@ static int dwmac_generic_probe(struct platform_device *pdev)
 	}
 
 	/* Custom initialisation (if needed) */
-	if (plat_dat->init) {
-		ret = plat_dat->init(pdev, plat_dat->bsp_priv);
-		if (ret)
-			goto err_remove_config_dt;
-	}
+	ret = stmmac_pltfr_init(pdev, plat_dat);
+	if (ret)
+		goto err_remove_config_dt;
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret)
-- 
2.39.2


