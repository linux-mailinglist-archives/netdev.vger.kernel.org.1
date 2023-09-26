Return-Path: <netdev+bounces-36310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F227AEE51
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 16:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 611DEB2096B
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 14:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DC02AB27;
	Tue, 26 Sep 2023 14:06:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661E328E2C
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 14:06:06 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFEF101
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 07:06:04 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4053c6f1087so80123425e9.0
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 07:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695737162; x=1696341962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UcRzKohvhYG9fh6I54Q5rNI9BXZ5yEgznCb3EQhNi6o=;
        b=LDwVgDjpAlqnwFHMlciV4K+o7wf8t3Atq7goezwpkv+OC21DLjcEyMyHPjPuUJH6GN
         xJDXjTXdzlHPOONn32hlR/VN2uRon1QaEREdqD9ke2VPf6aYF5mi0C/b1zQf7ZgQb2FV
         BzBLkCzTwCWj0ua0tuEZuM+qocAXaM+wFMfTOQCOxlCgCODBXQcegA+6G18Yk03CNFdw
         ytD4fAiokyuZoQAkSVCjnJwHkf12AMHBPhqwj3aihGGZocY1UFMJPKKaSgIjuG000FD5
         eDcLSzJERW86S5bzuABNoGaLxJwfgGEXonrfUZqaRxMt5+LQ16VNGBFBTh5QlyXBM6m4
         DRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695737162; x=1696341962;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UcRzKohvhYG9fh6I54Q5rNI9BXZ5yEgznCb3EQhNi6o=;
        b=DECcP076wgYn54XJsDf3htKjVfJEjEfUTq+LNM1e1Oiu0Rf3MU32vo4DN/AALFqrg4
         GDoz+H7cfwUkNgeOqLGG52m9fdEOdzqTqlq8PH+cZDGATnWYkGmsOCYbIa7vkWtWGoII
         cL5hUmI6bWIwAVCX42otUwJ7MePaPii5QTFDDzcptsvHSOmb9gRBOkgNcFIE5+L3N2fC
         SiPyUxYed5Bm3sSUBZzw0D2+CNtcfzN3zyBqa6udx26GWmG5pIfZQjH3ds+OZYEVU/Ff
         8cMVBaF1avjsVII0wTEfy3SyOvxxdRRefURddsamGJVynBOK5TtHwohTrMsvXWpx9tI1
         nx/g==
X-Gm-Message-State: AOJu0Yw3XFbXUizzmPuAn2kbENR8xMxHhAXKhst60LkLvISgGhBbAmtg
	YoeCYntHSsxxKgvE6e+uPb3Lmw==
X-Google-Smtp-Source: AGHT+IHmw82WFnssIIqIEmLrYn1BHyVpk4TK8UqZ0ZbBr+7udHZkOSzO+Gz2dBbsn42VZE3nesQ+Bw==
X-Received: by 2002:a7b:c7d5:0:b0:3fe:5501:d284 with SMTP id z21-20020a7bc7d5000000b003fe5501d284mr8407088wmk.11.1695737162629;
        Tue, 26 Sep 2023 07:06:02 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id g14-20020a7bc4ce000000b003fc01189b0dsm15126914wmk.42.2023.09.26.07.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 07:06:02 -0700 (PDT)
Date: Tue, 26 Sep 2023 17:05:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Roger Quadros <rogerq@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 2/3 net] net: ti: icssg-prueth: Fix signedness bug in
 prueth_init_tx_chns()
Message-ID: <34770474-0345-4223-9c11-9039b74d03b4@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c2073cc-e7ef-4f16-9655-1a46cfed9fe9@moroto.mountain>
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The "tx_chn->irq" variable is unsigned so the error checking does not
work correctly.

Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 92b13057d4de..89c0c3449d98 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -316,12 +316,14 @@ static int prueth_init_tx_chns(struct prueth_emac *emac)
 			goto fail;
 		}
 
-		tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
-		if (tx_chn->irq <= 0) {
-			ret = -EINVAL;
+		ret = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
+		if (ret <= 0) {
+			if (!ret)
+				ret = -EINVAL;
 			netdev_err(ndev, "failed to get tx irq\n");
 			goto fail;
 		}
+		tx_chn->irq = ret;
 
 		snprintf(tx_chn->name, sizeof(tx_chn->name), "%s-tx%d",
 			 dev_name(dev), tx_chn->id);
-- 
2.39.2


