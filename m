Return-Path: <netdev+bounces-12703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3692C7389AB
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686951C20F16
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957271953D;
	Wed, 21 Jun 2023 15:37:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2EF1951F
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 15:37:35 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EA51FCE
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:37:15 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fa0253b9e7so276545e9.1
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687361823; x=1689953823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohR2MIoFexvaG1IRw5Am1pEJrTY7jcRqlxnO/EQTdy8=;
        b=dkyDfYiIBxOJV2hxR/4c8Uta3MSZJK6qmT57b/J+17eBqI0hCGQ4XExaV4F7mYh4be
         VgT3ePn99e8bol/sXnx1xvaO+w76lIn+/zPxUZDiMYIOPqYTFeXmZfLsWUl39mCAqHVm
         HmyVVnGIWuw9CPtJxjxzHypnrORSkLN6pecDdYnUN5jV4DzRvqFQ+pZ6CnSJD5xIYOKa
         B2ovTwgnrU+dxC4JIU+t0UGPXJiIBbiAJrMXERMaiJ65jYeyaF0Jjc2Ovwlz89sqjlUT
         c2h5du2jStF+P4xOeLkev3lON5iHC9iTT22u8lbT6RBnHQbRkWakb1/EofidM1kHhnNO
         VpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361823; x=1689953823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohR2MIoFexvaG1IRw5Am1pEJrTY7jcRqlxnO/EQTdy8=;
        b=MWjj98LXGl4hl8drxgYjlJNkrZw03ArZ1kfYjfKqApInvPl0bSyW1BhxVxJhMLkT2z
         B3ubXciHPNPsE4XnVWjQ1i8CZr4BeWyggvRqqWkgHfyCIKMbBGZcj4QphME6rPOfMYBK
         UUTzGq51G/1ive3wLdnU6JMIDG46/6aE+Q6qtSxMJ0vKTb7B1cyu8/uhK4eLseU9Z33v
         zC1FpRs36UHBmS+mmgsvs4tA/HMpMacL31tgqSu9NoXYNQmYOLcxmcb6bwTss6tPNE7a
         VWkR7bI+zLzNgq3RbnP6YAVPeFwu1UMq87LwHMGomAn43LQvZciRGxKrnyAYoieWNFWB
         1cWQ==
X-Gm-Message-State: AC+VfDycwqMi++yLJrtytEuBUMd1lXp+1AWq15Vi8nil6/EUOeF4cpQb
	daJfkjwnQ7aYHNZ/ds7GqCXsyw==
X-Google-Smtp-Source: ACHHUZ6ZDp52UApJ3piW/H11lxFyTw3oeRrK9CSYjqYjy6prgfBnCMfLOO2kaY9rWqwnOQ/4eCyV9w==
X-Received: by 2002:a05:600c:21d8:b0:3f9:bc32:ca6c with SMTP id x24-20020a05600c21d800b003f9bc32ca6cmr2740533wmj.13.1687361823489;
        Wed, 21 Jun 2023 08:37:03 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003f7ed463954sm5322491wme.25.2023.06.21.08.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:37:03 -0700 (PDT)
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
Subject: [PATCH net-next 02/11] net: stmmac: dwmac-generic: use stmmac_pltfr_init()
Date: Wed, 21 Jun 2023 17:36:41 +0200
Message-Id: <20230621153650.440350-3-brgl@bgdev.pl>
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


