Return-Path: <netdev+bounces-13327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5C573B47C
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024B42819AD
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 10:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DC16AB0;
	Fri, 23 Jun 2023 10:04:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEE66AA3
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 10:04:29 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C4D1993
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:04:28 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fa798cf204so7472935e9.0
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514666; x=1690106666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JiCzEeqmjiEw3zDpGmObBnm4eT4Z865O2xg4BsYR1E=;
        b=dLurroqnBfuZlrXTJOSO1ec8tkOeNMC7/5FOt5gGsGnx23ekrR748s6VoPpqzDKbl3
         vWDMKD0wmLDtvfzCrlozDHyfcJeiN5yr+038ii6HY3l6YuEJqjShtFub/I0GFcC4U4Rr
         6CXXMUTEGhm5w0hGK/fuJUOwY8YbXrOC+taP5VC3tIqIKij5+05rpXvb9eTReVJw0FN7
         X5RfuLo8m7WYea1CwT8CcQCrZwdD0/O7CJK0yTqZsz8AGv7j/3DVE2f8OmP5261eyp3g
         qmxa+PUTNAd68WMx25arfe7WHqgX23/QkOhrMBYsMnNWRm/KUMynJUcWHz9jmRSH8taH
         xUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514666; x=1690106666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JiCzEeqmjiEw3zDpGmObBnm4eT4Z865O2xg4BsYR1E=;
        b=a57o/bLYYl6e2KvPRt7DZTyrRXFNGTwG3FxobcyzTF5PGMMYgJjcoVB7YtLDAobKhE
         9HiziMkd6/G36zLXZ1E3GpgtRX2NnI06g7WOu8CZ0vbZoOVX5xIp6imyOMv22kt8Fl9i
         BT5VU4G5HkFvnjvdVNNjISW7pevfvzxnhvGbADlRSFAizyR3lBUybKBVBiVMqV2qQdEM
         jh3hu5IIOxlTkNb+IZRU8lvnPUoqqHUtFMLfFi7JR/74lon1rzYOK/8shrnLRsvRj8yS
         evGNi2FWfOFqNQbD2kiS3fzlcE+6p/c8ySxifS18EYgKI4eB4rC5f1cLo2jv+GFJtY5T
         FmLg==
X-Gm-Message-State: AC+VfDxEixEZiDirFbABoYFvxjngDsMjIgIdvd20M2hX5niWjTUsDL5U
	DikRzN2vpzK0uA5diLM9xuEzYw==
X-Google-Smtp-Source: ACHHUZ4qSPzss8jYv0izBVyPiiYbfcs2GaupcDqzwF7GJoL6obvzFc7cSfwPYlFhIi3eERWkxmjvhA==
X-Received: by 2002:a5d:568a:0:b0:30a:eac8:e5c1 with SMTP id f10-20020a5d568a000000b0030aeac8e5c1mr20824466wrv.6.1687514665831;
        Fri, 23 Jun 2023 03:04:25 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d54c8000000b0030fae360f14sm9079360wrv.68.2023.06.23.03.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:04:25 -0700 (PDT)
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
Subject: [PATCH net-next v2 04/11] net: stmmac: dwmac-generic: use stmmac_pltfr_exit()
Date: Fri, 23 Jun 2023 12:04:10 +0200
Message-Id: <20230623100417.93592-5-brgl@bgdev.pl>
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


