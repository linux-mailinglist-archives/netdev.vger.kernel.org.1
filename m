Return-Path: <netdev+bounces-12705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942C87389B4
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A60280E5A
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04131991D;
	Wed, 21 Jun 2023 15:37:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D171990E
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 15:37:38 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A781FDC
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:37:19 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f8f3786f1dso66490385e9.2
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687361826; x=1689953826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JiCzEeqmjiEw3zDpGmObBnm4eT4Z865O2xg4BsYR1E=;
        b=zAnRcyEUDD5wtE0JhsBJCTGSOI9JVuvZGa/odSLqFHGsQXN85gQbvlTZBX+am6cdI+
         wCvXHD639o04po8/nN9twgtY0tb8Ta1S3yBXDl7G0Fd9XQKAb1wC9qdjPaWIBd5mOT48
         7zeagteknLjoF5nSF0V7R/AtC20zPvspcgJBBYFLMPkitQz6gJSXwUKaWBwX5jxjEOHy
         JOpbdPE6txob69F4MW2cyB9+zk0UbktknOZ49yzYBKDghJy0OqxuCH4OAwiGOYqiNK5A
         L8qJa5APnKWbZKMZxsy51rLkI/usP+ajNckWWYum2ZWXFca8SHEIjTp4o0UIVhnnXfW3
         mt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361826; x=1689953826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JiCzEeqmjiEw3zDpGmObBnm4eT4Z865O2xg4BsYR1E=;
        b=YjEfE/vsq554e273AYn0AlUgenwuqK4/Cw8lHz1RGX3GUVynv/ZENjzAgfuT8Q3cUl
         K6Ssw6wF1pFr2L1BgYQrc3JVD8zuAjL0XWRNJjgkTrMffkhCp0ZfM0T8rcyzU+ITwXIL
         vgDuk7LP/fPVWWbJLg64CeGYqqXW325xbGD8bXCVc388hlcVHt2G2Wbh5wp9+ep2auni
         8wh5d1JAqoxs5F538SnwYdTG4R0odt6FiIrVnvHQrADU4LScjBd28rsks8fBvIBc53MR
         Kc63xwGA4aAenxVuvoywmm/5JP6XUUrNPsWFcjNjIkA2fLKlHzkIjt9dUfF/3h/XanjV
         q2qg==
X-Gm-Message-State: AC+VfDxzLl8KCMxi/qe9pTYnlNzMbuME9t3DCrJjtIrcUqaEbwpkZbT2
	mjC85if2rES8RaYrE6xycqNCDA==
X-Google-Smtp-Source: ACHHUZ7xPJZ1J9M1CQ6hghcx/4kh4qmQUTaDMOedqzbwk1iUrz91I0UBgHrzOTPLQtNdytzHq/JnJg==
X-Received: by 2002:a7b:c391:0:b0:3f9:b3f5:b8f with SMTP id s17-20020a7bc391000000b003f9b3f50b8fmr5845974wmj.34.1687361826051;
        Wed, 21 Jun 2023 08:37:06 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id l13-20020a1c790d000000b003f7ed463954sm5322491wme.25.2023.06.21.08.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:37:05 -0700 (PDT)
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
Subject: [PATCH net-next 04/11] net: stmmac: dwmac-generic: use stmmac_pltfr_exit()
Date: Wed, 21 Jun 2023 17:36:43 +0200
Message-Id: <20230621153650.440350-5-brgl@bgdev.pl>
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

Shrink the code in dwmac-generic by using the new stmmac_pltfr_exit()
helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
index b7fc79864e8c..dabf05601221 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
@@ -58,8 +58,7 @@ static int dwmac_generic_probe(struct platform_device *pdev)
 	return 0;
 
 err_exit:
-	if (plat_dat->exit)
-		plat_dat->exit(pdev, plat_dat->bsp_priv);
+	stmmac_pltfr_exit(pdev, plat_dat);
 err_remove_config_dt:
 	if (pdev->dev.of_node)
 		stmmac_remove_config_dt(pdev, plat_dat);
-- 
2.39.2


