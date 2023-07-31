Return-Path: <netdev+bounces-22718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B92AC768F1A
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 09:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5D91C20A8F
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 07:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E47563C1;
	Mon, 31 Jul 2023 07:42:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F0D2569
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 07:42:39 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2239F
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 00:42:37 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso6638493e87.0
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 00:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690789356; x=1691394156;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r3g9PTR1d4q+jWB72BuFEuFidr0WoeWZpmTU/FdkTwA=;
        b=KNowhtElgaLjVT8TTEugRwPkJ0OI56CCkuXHLR7mt6uZSiuOo2NiUU1oYIwDYIpygd
         ZH1XQAOiVePnDgm43OUDVsnXjwl7sjbUvzMEQ3dKwJiq6AxJxWQ9OHGrbYCA3jJvnve2
         8At4qTMVeP3O5/3FcbOE+NU9Z9RGi3rtQmmk+o67YvMpdqJh3jJkPm4jlmAiEUuW+9Ws
         J2w+ScgGuqKqiu29qhT8d37FZNicZI8DAAi5fi7ioXvCdKW6He1jjfIZYPqdof5f2dNt
         9nBSE8OxfRm06q1Ejon9BaUiESILdyX0EJUa1UtcF4oI7S3XmlUbgCeiFTfE0W84bvht
         pWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690789356; x=1691394156;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r3g9PTR1d4q+jWB72BuFEuFidr0WoeWZpmTU/FdkTwA=;
        b=O8hwz6oKtcjGiKmDNhuevmZM+FP4VRo4PKE+SuOTgTW8UPgH0T1WUq8jCh7vwG74lp
         HIjbWVIWZWuHj0/bQZivGv3ta0ek7Xp9qxPq/LKbUeXcOG9pE3Eyu2CSOzh9F4odYez4
         aEgrefiOgUDtZLaENI9PYBKCq1nc8z0+cfyZ8wjYphvdWEV2jA3FBh4StJxVM2vIj64i
         lce70g977JIjGMaAxaiC8ZVUBf/xCqGX8a51dW4uX8C6smP18F1C+T4MuU1Vc5TXlKjL
         H+DBsc6dNeIUHJRcYOyjUU7FoBTkbOpfkyCo5BwhOUzz/j+ONzegebVZPt9qCer62Kz2
         jBFA==
X-Gm-Message-State: ABy/qLbAz1pQEmCz53w0biADLSk7zQs6rBc3DlGdsNLl2o1e8G3UwRxs
	ECHAVC+Sc9mKH0i4HVjr9kCyBQ==
X-Google-Smtp-Source: APBJJlEOznDYQySZio03F1hYTLcYmvIl22I1LNPpOKYqMFCdj/rqT30KnTt01opN3wkvhOuI5z2fqw==
X-Received: by 2002:ac2:4e8b:0:b0:4fb:fe00:49c2 with SMTP id o11-20020ac24e8b000000b004fbfe0049c2mr4377205lfr.32.1690789355848;
        Mon, 31 Jul 2023 00:42:35 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f17-20020adffcd1000000b00313f61889ecsm12211498wrs.66.2023.07.31.00.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:42:35 -0700 (PDT)
Date: Mon, 31 Jul 2023 10:42:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Esben Haabendal <esben@geanix.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	Harini Katakam <harini.katakam@amd.com>,
	Haoyue Xu <xuhaoyue1@hisilicon.com>,
	huangjunxian <huangjunxian6@hisilicon.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Rob Herring <robh@kernel.org>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] net: ll_temac: fix error checking of
 irq_of_parse_and_map()
Message-ID: <3d0aef75-06e0-45a5-a2a6-2cc4738d4143@moroto.mountain>
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Most kernel functions return negative error codes but some irq functions
return zero on error.  In this code irq_of_parse_and_map(), returns zero
and platform_get_irq() returns negative error codes.  We need to handle
both cases appropriately.

Fixes: 8425c41d1ef7 ("net: ll_temac: Extend support to non-device-tree platforms")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/xilinx/ll_temac_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index e0ac1bcd9925..49f303353ecb 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1567,12 +1567,16 @@ static int temac_probe(struct platform_device *pdev)
 	}
 
 	/* Error handle returned DMA RX and TX interrupts */
-	if (lp->rx_irq < 0)
-		return dev_err_probe(&pdev->dev, lp->rx_irq,
+	if (lp->rx_irq <= 0) {
+		rc = lp->rx_irq ?: -EINVAL;
+		return dev_err_probe(&pdev->dev, rc,
 				     "could not get DMA RX irq\n");
-	if (lp->tx_irq < 0)
-		return dev_err_probe(&pdev->dev, lp->tx_irq,
+	}
+	if (lp->tx_irq <= 0) {
+		rc = lp->tx_irq ?: -EINVAL;
+		return dev_err_probe(&pdev->dev, rc,
 				     "could not get DMA TX irq\n");
+	}
 
 	if (temac_np) {
 		/* Retrieve the MAC address */
-- 
2.39.2


