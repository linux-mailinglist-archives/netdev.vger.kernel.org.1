Return-Path: <netdev+bounces-14659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86030742CFF
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 21:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26535280A25
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 19:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2ED1429E;
	Thu, 29 Jun 2023 19:18:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2069714A83
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 19:18:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEE14698
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 12:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688066280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IdunTKBXq26vcyYb/EdIVE7YvQRq/YPpQ2jK2C3l7sY=;
	b=WNGs4pJo1jxyZRhG3BUw9EpZ+AJVi45QgGXlmOP8T49CxpIWQ0Nh/FNOSl77rQ6HVXj+WP
	xrzX22pLmcAenahMNK6VxgKfp28P19/5t0KRQhMvjq7hY4SB2pUSbgO7pWffOLw/V39zve
	ahGNSlWdGZZvegnjkkzd8J5b8Eyj+N8=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-ukSdxPstNIqPoAdQp8ycow-1; Thu, 29 Jun 2023 15:17:58 -0400
X-MC-Unique: ukSdxPstNIqPoAdQp8ycow-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5704e551e8bso8704267b3.3
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 12:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688066278; x=1690658278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdunTKBXq26vcyYb/EdIVE7YvQRq/YPpQ2jK2C3l7sY=;
        b=FW8q4VYXbh9XW07aFLq8Yp8kV25HAdPH89CLAYXGoRq41VMWmqnjHZaDH31JpU3GFU
         y6+jRXE9teOkCsPiwG45vmRAZwOsyT5uyqyXOJim/d3r+bAiXu0PrjZ3lzw/71wCSu8c
         nvqIgD86qvlcNqIvfszIIN97yXizfJzTMagU3+rWmamSywOwQzD9jvcmaDYYxy2Zu84G
         0ggQ6vyxSxT4+BuODdaQrtPMgFV8qf0gcvXSGOyRuSZXpYDZWM+9ePcmnfOkDU82X/7n
         fsx43PaBUqshKJtJmSmorScqGexC5RttK1IwM6ItIvWyL3H6SRDLJ95/iY0t1rvBpBOP
         pe9Q==
X-Gm-Message-State: ABy/qLbER80NNQeCAeg7qEZawJgSVpF2RUxt7C9EILEnvblVPAhxGDS+
	ff/sUMlVbox1x1MJr6vfiDX9HQIgNEOfrqqRjZnD/DYTBry9ELzAFWeKgsfwJbSluv7/cIQ4FL9
	5dq4woZLk5xPtTLr6
X-Received: by 2002:a0d:f2c4:0:b0:570:6fbd:2daf with SMTP id b187-20020a0df2c4000000b005706fbd2dafmr303066ywf.37.1688066278443;
        Thu, 29 Jun 2023 12:17:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGWPYjej9cDTBj9PaobIHZOXCIJHkmLixBjf5KfzXTvWmIZX19PFv5oYzbDnjlXG204DfghIQ==
X-Received: by 2002:a0d:f2c4:0:b0:570:6fbd:2daf with SMTP id b187-20020a0df2c4000000b005706fbd2dafmr303048ywf.37.1688066278207;
        Thu, 29 Jun 2023 12:17:58 -0700 (PDT)
Received: from halaney-x13s.redhat.com ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id w127-20020a0ded85000000b0057085b18cddsm3052478ywe.54.2023.06.29.12.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 12:17:57 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	mcoquelin.stm32@gmail.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	joabreu@synopsys.com,
	alexandre.torgue@foss.st.com,
	peppe.cavallaro@st.com,
	bhupesh.sharma@linaro.org,
	vkoul@kernel.org,
	bartosz.golaszewski@linaro.org,
	Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH 2/3] net: stmmac: dwmac-qcom-ethqos: Use dev_err_probe()
Date: Thu, 29 Jun 2023 14:14:17 -0500
Message-ID: <20230629191725.1434142-2-ahalaney@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629191725.1434142-1-ahalaney@redhat.com>
References: <20230629191725.1434142-1-ahalaney@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Using dev_err_probe() logs to devices_deferred which is helpful
when debugging.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 3bf025e8e2bd..a40869b2dd64 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -710,8 +710,8 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 
 	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
 	if (IS_ERR(plat_dat)) {
-		dev_err(dev, "dt configuration failed\n");
-		return PTR_ERR(plat_dat);
+		return dev_err_probe(dev, PTR_ERR(plat_dat),
+				     "dt configuration failed\n");
 	}
 
 	plat_dat->clks_config = ethqos_clks_config;
-- 
2.41.0


