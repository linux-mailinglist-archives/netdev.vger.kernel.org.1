Return-Path: <netdev+bounces-36531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B264E7B04BD
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 14:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 64F52282DC4
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 12:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E056428DBC;
	Wed, 27 Sep 2023 12:55:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7C1B269
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 12:55:17 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0469BC0
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 05:55:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so10428238f8f.2
        for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 05:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695819314; x=1696424114; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q+1t1P5I5WKboLrqwp2yf5WoUoPKv1FgbHipL+4z2I8=;
        b=YsK6MiVTivqK4Je8frhGBVlnTQTB/wbXvGz7mWFg6xAl8FdNzNyOBu0/M2Y0WppkOB
         iH+piKYx947Aetzky3KQzQHPPY2UhXb5reD5iG0pyW8fUvG6QuGXnR62otNc7b7HbOpk
         rUIcK01i7fM6wGJ/FKDcVF7PP4zzrrX8xp5mniZhkO+5oy1N1IozYvycbq4GcArH79sK
         lIeiiwJq4ZFlsqGQtbkWjYrGaTYDHY8uExm/oydW80toF0dm7skRgd31vGagu82aNAbj
         e0Qnt10ckl1jEcrofJxmhWJAH48u2UaCvdrBbk+9Qm9aJsO4mv58qdd1vLHnN+MF813o
         wtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695819314; x=1696424114;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+1t1P5I5WKboLrqwp2yf5WoUoPKv1FgbHipL+4z2I8=;
        b=Azkk4eHdsaP8G4ebNzwE4pbZdqQi0mM2KHwcp+b1Et9thUXE+q1hI8YkHBUrdDx/ZI
         YuQK4rZUCT1sxpn62Rq1p8BfNs4MBDKOD5CG/RZTpShJESpSgVXrTpJ+9b6utfckn8qQ
         13rEVkwnHgLXaLefgEQ8gcxy/JlY5BG3tCdx8eXtPGyciF+xdba1ybr3zOZ7lTbUNDBj
         DmWS8h4Rtf3E0D96I5vpGezozzrgO/Ofvy0eGNQwJVHNCcjQjB+x52N3Oc9BraPkm4Yy
         RX3zmqCZ5lv6eOsTAv0hBnDB/FRzLy8rInjWRMxWi6uTXjdIHy0AXu4fwmB+5Ad6ACPW
         k5vw==
X-Gm-Message-State: AOJu0YxA/HLG2m5B6XJIo0ttzEB/SA3kPwmb3EbjLY1y3WWdMjtSE7g2
	DfPftroyUe+Zt75yC8veuWtYDg==
X-Google-Smtp-Source: AGHT+IEWh365sjezz7UFOsIzAffZmD/KojQX6xd0VdrtKc3n8/qBapI+G3fEBTQNXR5CBME+Ozhx8A==
X-Received: by 2002:a5d:4cc7:0:b0:314:a3f:9c08 with SMTP id c7-20020a5d4cc7000000b003140a3f9c08mr1526754wrt.39.1695819314384;
        Wed, 27 Sep 2023 05:55:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d4d81000000b003140f47224csm16937060wru.15.2023.09.27.05.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 05:55:14 -0700 (PDT)
Date: Wed, 27 Sep 2023 15:55:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Vadim Fedorenko <vadfed@fb.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jiri Pirko <jiri@resnulli.us>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] ptp: ocp: fix error code in probe()
Message-ID: <5c581336-0641-48bd-88f7-51984c3b1f79@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There is a copy and paste error so this uses a valid pointer instead of
an error pointer.

Fixes: 09eeb3aecc6c ("ptp_ocp: implement DPLL ops")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/ptp/ptp_ocp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 88d60a9b5731..d39afe091a7b 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4453,7 +4453,7 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	for (i = 0; i < OCP_SMA_NUM; i++) {
 		bp->sma[i].dpll_pin = dpll_pin_get(clkid, i, THIS_MODULE, &bp->sma[i].dpll_prop);
 		if (IS_ERR(bp->sma[i].dpll_pin)) {
-			err = PTR_ERR(bp->dpll);
+			err = PTR_ERR(bp->sma[i].dpll_pin);
 			goto out_dpll;
 		}
 
-- 
2.39.2


