Return-Path: <netdev+bounces-13328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B9173B484
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4921C20D42
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 10:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085E0611F;
	Fri, 23 Jun 2023 10:04:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17AB6FBB
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 10:04:30 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E419211D
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:04:29 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31109cd8d8cso470805f8f.2
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514668; x=1690106668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yItovFwloe3duebYnq7A6B4V/jKgQ44zzRGa/G+pPW8=;
        b=l0DUJdzlIHLN9/12vsEkAUNYNor4yQLqqSoGRxNk3EPmXOD2uFpAHbY4VklRmVQl3W
         +ENIrmsfRrIo4VfPjgmUQ/qlVWQ/ASV+aqcDfTJW9cv55BQDIxyjuiuCIZ4ey++WfOVZ
         e1P2A4jCjaM+XdtvCqaOpk3t2uaYGGziW1b1bYWPSrzQ7RFEhHoKViWdajx1ztsw+2oN
         bnk9AbhndEj+pJmoqRdzjQ34R9lSf+WGThG2I/dM3n8sMm339S386riM8UpqOyAs/hIl
         HePSRoIZgG9WM5dzaaaI+QNv3jNFWhnplP86qSx4p1RkU6q37ZAgOElyDOcrJT12BHma
         qu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514668; x=1690106668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yItovFwloe3duebYnq7A6B4V/jKgQ44zzRGa/G+pPW8=;
        b=lyGMSxo7bFfTA0Ek2QF+dP5ciMuSPpY0X5jN/Xz51oqc09/XvWRncAu6vh4YWBrNmj
         j5tzxrgw2qSd/UJxRQ/UTWp2S0VOXANZlZy6SWRZfoiv/PYUGQC+80HmsyvPjZ7jihKe
         /A495rb1auZ9MVgiSU+/3P/eJ0Zo/zLsLpWTD8DRGvfn2FkpFqRzqXwTCXLlyfUcg/af
         AiwpnGlyzVIaBNlk+Ig/DUQCmJ/uMP1sf4UFHzaKE/2sojWdWP0tuwHPMXde/tachwkU
         rAnnCE2Gqtz3Gz3uPRzo5Gi160VOnLcICDfQMO5yu/NuxxPNcFdxY+SSQKCqCd3GHQ9f
         qjJQ==
X-Gm-Message-State: AC+VfDwF+IneElgQOlYTwuvm+GH1tQk+W/y1eM0Hu1DJMp65FqPo3DEL
	9zFaseBUoHjU4mQ1eyBWnaYUJA==
X-Google-Smtp-Source: ACHHUZ6FLrSK9VU9Oq4F41PZ3cJGKL7Y2Pamvyhspuem2ue7YRvUpv2Kv8yhkqC7Oo450xcBGrhcpA==
X-Received: by 2002:a5d:5346:0:b0:30f:cb74:35f9 with SMTP id t6-20020a5d5346000000b0030fcb7435f9mr17053297wrv.66.1687514667863;
        Fri, 23 Jun 2023 03:04:27 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d54c8000000b0030fae360f14sm9079360wrv.68.2023.06.23.03.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:04:27 -0700 (PDT)
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
Subject: [PATCH net-next v2 06/11] net: stmmac: dwmac-generic: use stmmac_pltfr_probe()
Date: Fri, 23 Jun 2023 12:04:12 +0200
Message-Id: <20230623100417.93592-7-brgl@bgdev.pl>
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


