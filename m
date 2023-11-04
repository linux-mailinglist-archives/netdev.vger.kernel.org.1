Return-Path: <netdev+bounces-46028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB017E0F6F
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 13:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77B21C2108C
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 12:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA97218B08;
	Sat,  4 Nov 2023 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bckd4k8Z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEDC17737
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 12:43:54 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97210D60
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 05:43:52 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507be298d2aso3756197e87.1
        for <netdev@vger.kernel.org>; Sat, 04 Nov 2023 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699101830; x=1699706630; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Oy6YnzrrQAU74UB/BgNy8fxjGeu1ULALolZntz7GpU=;
        b=bckd4k8ZwZWtVNFCjzqnJOHxFhsIXC9HPD4IS9cTYlU2EfXQ1/xY9lVF7Sm8ETRbUE
         g0qf51je+M0H0FQOHqDKssCUjTzO7tRiPw2ZH8V/tMrx5aclgws3a9sTdxUrd01ovi4F
         21ijAT8ibZTaICo9vCVDGlAUoUwY9lpdmZSXKny6kg8oJcw9y6+Mnv3/9P9kAs4LTle1
         JSQxndFOWQm5R7LwlerhD+4+l+pZv0kW3zUehWUBnITPUWsgmO6q5iMK5igaSNKUjOv7
         315CGLHSqXGfxn3Mg0bjgP426dla0lKEFj/wKNN9YcWmmIebPyT8G8GC2IlIqtOsz98N
         28DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699101830; x=1699706630;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Oy6YnzrrQAU74UB/BgNy8fxjGeu1ULALolZntz7GpU=;
        b=t4WmVhQre9yrTmqwnNVkMCnsGTkKQPM5ek07u6sqPrlBKToHLWw9Lf75zJUW0SBO6y
         wsE8D+ygxqd82ucp3jxdevoRR4PKmqT8PdwQsy6fZVbq3EwQC2j5oZfj9kOZP9m9DxEX
         AiaglDMT8DSsiSBT2SuvvSErzDGKbUcfBr7vbuouplSX7xesXlDJbBmVo2d1r6oKN8BM
         0+bQrcleWeYpk2TeuoWZrMVFoNGj9BdYO3N9QadJdr/sptdbC7ZjYbJSF7rJ5c7ll7xh
         4kCuF3MpcCjChMl+oPLXFc4nnivKEIj1U4IZ0bbDo7o+MEByXPVIfw5lEY4xcfxkHm2D
         4jXQ==
X-Gm-Message-State: AOJu0YyrmFKd+YtUIjtDwB1q7Lzcjsf9QzWVTTc/Sowh0QUEUZYYaZBY
	8126SHP5BI/OtZUP2MlKkNGdCA==
X-Google-Smtp-Source: AGHT+IGwsd6bMa0WdkB0xdWasEvDnIiyZd8prwFEb7gsYRpi9uYQ0Z3rXATmveYQoxaGQ3DQcung8A==
X-Received: by 2002:a19:f80e:0:b0:500:7f71:e46b with SMTP id a14-20020a19f80e000000b005007f71e46bmr18641913lff.1.1699101830741;
        Sat, 04 Nov 2023 05:43:50 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u22-20020ac24c36000000b005093312f66fsm496100lfq.124.2023.11.04.05.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 05:43:50 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 04 Nov 2023 13:43:48 +0100
Subject: [PATCH net 1/4] net: ethernet: cortina: Fix MTU max setting
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231104-gemini-largeframe-fix-v1-1-9c5513f22f33@linaro.org>
References: <20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org>
In-Reply-To: <20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Vladimir Oltean <olteanv@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The RX max frame size is over 10000 for the Gemini ethernet,
but the TX max frame size is actually just 2047 (0x7ff after
checking the datasheet). Reflect this in what we offer to Linux,
cap the MTU at the TX max frame minus ethernet headers.

Use the BIT() macro for related bit flags so these TX settings
are consistent.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 12 +++++++++---
 drivers/net/ethernet/cortina/gemini.h |  8 ++++----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 5423fe26b4ef..e12d14359133 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1151,6 +1151,11 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	if (skb->protocol == htons(ETH_P_8021Q))
 		mtu += VLAN_HLEN;
 
+	if (mtu > MTU_SIZE_BIT_MASK) {
+		netdev_err(netdev, "%s: MTU too big, max size 2047 bytes, capped\n", __func__);
+		mtu = MTU_SIZE_BIT_MASK;
+	}
+
 	word1 = skb->len;
 	word3 = SOF_BIT;
 
@@ -2464,11 +2469,12 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 
 	netdev->hw_features = GMAC_OFFLOAD_FEATURES;
 	netdev->features |= GMAC_OFFLOAD_FEATURES | NETIF_F_GRO;
-	/* We can handle jumbo frames up to 10236 bytes so, let's accept
-	 * payloads of 10236 bytes minus VLAN and ethernet header
+	/* We can receive jumbo frames up to 10236 bytes but only
+	 * transmit 2047 bytes so, let's accept payloads of 2047
+	 * bytes minus VLAN and ethernet header
 	 */
 	netdev->min_mtu = ETH_MIN_MTU;
-	netdev->max_mtu = 10236 - VLAN_ETH_HLEN;
+	netdev->max_mtu = MTU_SIZE_BIT_MASK - VLAN_ETH_HLEN;
 
 	port->freeq_refill = 0;
 	netif_napi_add(netdev, &port->napi, gmac_napi_poll);
diff --git a/drivers/net/ethernet/cortina/gemini.h b/drivers/net/ethernet/cortina/gemini.h
index 9fdf77d5eb37..d7101bfcb4a0 100644
--- a/drivers/net/ethernet/cortina/gemini.h
+++ b/drivers/net/ethernet/cortina/gemini.h
@@ -499,10 +499,10 @@ union gmac_txdesc_3 {
 };
 
 #define SOF_EOF_BIT_MASK	0x3fffffff
-#define SOF_BIT			0x80000000
-#define EOF_BIT			0x40000000
-#define EOFIE_BIT		BIT(29)
-#define MTU_SIZE_BIT_MASK	0x1fff
+#define SOF_BIT			BIT(31) /* Start of Frame */
+#define EOF_BIT			BIT(30) /* End of Frame */
+#define EOFIE_BIT		BIT(29) /* End of Frame Interrupt Enable */
+#define MTU_SIZE_BIT_MASK	0x7ff /* Max MTU 2047 bytes */
 
 /* GMAC Tx Descriptor */
 struct gmac_txdesc {

-- 
2.34.1


