Return-Path: <netdev+bounces-12662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0267385CB
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD72028046B
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 13:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C453A182B6;
	Wed, 21 Jun 2023 13:55:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76EB18AEE
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:55:50 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3332619B5
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:55:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f8f3786f20so69718765e9.2
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687355744; x=1689947744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TGiINbu7foWgaD89gaNM9RV3a9vEUoSjU+97idyE2Co=;
        b=G5MLNwrMO/ygECl2UrKnTU4hYZAPfCguFUUBoqVRG3tRN7Vb04To5n0wDzGBF6f9uu
         SrAyU1MPLRIzDsEAZZzVc3u9m29IKIkNND81q1leCLtwqeXIqNaoqKGegINEEVVhbawA
         lExWWKmCn1a/dyqWCjd/GKB31g6qHiPLXntc6CxZGa0j3MtIG9oO/SDZMLwTiUdNZw9w
         mEuKhbpeXSqFRWSbmSWMxJ2wNF63e7yMjAtS8xw4UircxJRfc2yFhtDsx9nR76005mya
         rFBm0l+tgvZwCeuNJklbDwxyzx8/AjGTKlDRwZY325eNt4a324SQDVm8GJNdTefEaaAw
         eoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687355744; x=1689947744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGiINbu7foWgaD89gaNM9RV3a9vEUoSjU+97idyE2Co=;
        b=gONMSFqbWS3D1P5SGR7G0/TtYALvdQhtEqRX0qjl2yKi7iQfU6ufrHzW69SvQUTTdJ
         YxFmKMminyzBxinFGNXna1M6kYTqV8EE3dDMmRhD2dLv87aWUb9rxTktcc7QBaE18sh1
         xYQPaVsjsS1uStHh358Prm0Fliuaj+ssHAuru/y+6HP/PxuW8WwbpeLa9biP4CueM9VE
         53K5CbrVvMFC9d9ojOVj92ciRnVpe303TwfGDkrkBAPRlpxs5u067wj4Gtv7wLccuSSo
         SKVHiB3vATTT3EB6ZP04UgLo1F5Ux5j9NHkAnYLdDgbby8fy+xBWk9kAdLf0Rw22ig10
         i4gw==
X-Gm-Message-State: AC+VfDzXKSZrjl0omwflpDD0gsg5tulowKEpD10tFVqU/WneBz7akTFu
	QQDWMB4W9ESQMa5ERsln2mxAtW1XiI5czvkdcMc=
X-Google-Smtp-Source: ACHHUZ6lpAkKw4lUE1mi/nl5WQy66Jmf4UjvJOEHqcX5UnW2U7zvUnOOSSgljBc/dyx9VV5dVySgcw==
X-Received: by 2002:a05:600c:22c6:b0:3f9:b244:c294 with SMTP id 6-20020a05600c22c600b003f9b244c294mr8259781wmg.35.1687355744011;
        Wed, 21 Jun 2023 06:55:44 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id y7-20020a1c4b07000000b003f17848673fsm5069294wma.27.2023.06.21.06.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 06:55:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Junxiao Chang <junxiao.chang@intel.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net] net: stmmac: fix double serdes powerdown
Date: Wed, 21 Jun 2023 15:55:37 +0200
Message-Id: <20230621135537.376649-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
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

Commit 49725ffc15fc ("net: stmmac: power up/down serdes in
stmmac_open/release") correctly added a call to the serdes_powerdown()
callback to stmmac_release() but did not remove the one from
stmmac_remove() which leads to a doubled call to serdes_powerdown().

This can lead to all kinds of problems: in the case of the qcom ethqos
driver, it caused an unbalanced regulator disable splat.

Fixes: 49725ffc15fc ("net: stmmac: power up/down serdes in stmmac_open/release")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 10e8a5606ba6..4727f7be4f86 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7461,12 +7461,6 @@ void stmmac_dvr_remove(struct device *dev)
 	netif_carrier_off(ndev);
 	unregister_netdev(ndev);
 
-	/* Serdes power down needs to happen after VLAN filter
-	 * is deleted that is triggered by unregister_netdev().
-	 */
-	if (priv->plat->serdes_powerdown)
-		priv->plat->serdes_powerdown(ndev, priv->plat->bsp_priv);
-
 #ifdef CONFIG_DEBUG_FS
 	stmmac_exit_fs(ndev);
 #endif
-- 
2.39.2


