Return-Path: <netdev+bounces-46385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD427E384A
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 10:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A726281040
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 09:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D945814F93;
	Tue,  7 Nov 2023 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jaqEPfOj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECBA1426C
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 09:54:40 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF015124
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 01:54:38 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50797cf5b69so7151204e87.2
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 01:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699350877; x=1699955677; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rfck5FY3dF9200YZ4tXULFpESCIi8VAAOTwzFmje8Pw=;
        b=jaqEPfOjjS8CV42CwprK1l68GnR4JdiOoJohAiH02+nt0IJs/CYUAwD0g/nF8ewjSR
         WzVDEbobx9Ftxyzqr4x0ruhqu54YWgU9pRfdAtKgDwoRGOp5krhn4dvWok0LdrQKU4uT
         +A9G+zGOGi1vq0DXOF8njAJyWvEmvBomINwbmRMXkkIcyBg4ZXQJG+BVnrwryuvMFez0
         x7kkohxNP7HZ+hMGwa41bs9+Kz4DoJ8Uw7ZTVZyCeIX5TQWfLQ+DiD3ZaDFIwHj2w5Fc
         udelUm0nWexT3QhiFg+2rbh1CDkSFyVLw0T4ea11v+GSl+3pQVN27DHS4dCYf40AuWNS
         d65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699350877; x=1699955677;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rfck5FY3dF9200YZ4tXULFpESCIi8VAAOTwzFmje8Pw=;
        b=ZovEMFFdokHW7ZJoqu1CLVloTnRpFkTx5LNWqbZ+TE/XjEovjRHWTRXo8lq3piU18Y
         Rs9HAeqjCxx5wj5F1b+DAlFwnH5DPNYUffoI4/j/7bd8YKv/6V6Mg9PzOoAsXw+/kf2S
         4F5W9w5hhxU4yoDXYjL/7cqnS6kBiPe4vuYKY/eVA/dg9ELl95G9geQQ6j8lI7G2wu1e
         SczGG8PwAmJu9RjlpAmwWA4EfJ1HiZb5239szZcYx7KJnMvkdeQhnun+Xd0P5fl63+L5
         cysuH7SYc2RRYEgEVgvTR1Pni+8gukCneaKph5MpXT6BB86fKDPhwfDTosOUcziFbSgz
         SDRw==
X-Gm-Message-State: AOJu0Yy5tOPgoSFhk45FU3P8QMMJddd6H59SjzK4sKsKDSPV68sEmzJ0
	ZDeXgHwDTgk3e21evu3GmEruzp+gD26xBgwlhtE=
X-Google-Smtp-Source: AGHT+IEBVvk5s+3+jjuHHDZToklheab9cKewXJF+TOy2czkLFGo94g0k21Br2Tt8rSSzF8K3JABtuQ==
X-Received: by 2002:a05:6512:ad5:b0:501:bd43:3b9c with SMTP id n21-20020a0565120ad500b00501bd433b9cmr29893465lfu.23.1699350877142;
        Tue, 07 Nov 2023 01:54:37 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id m25-20020ac24ad9000000b005091314185asm296356lfp.285.2023.11.07.01.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 01:54:36 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 07 Nov 2023 10:54:29 +0100
Subject: [PATCH net v3 4/4] net: ethernet: cortina: Checksum only TCP and
 UDP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231107-gemini-largeframe-fix-v3-4-e3803c080b75@linaro.org>
References: <20231107-gemini-largeframe-fix-v3-0-e3803c080b75@linaro.org>
In-Reply-To: <20231107-gemini-largeframe-fix-v3-0-e3803c080b75@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

It is a bit odd that frames that are neither TCP or UDP
(such as ICMP or ARP) are still sent to the checksumming
engine, where they are clearly just ignored.

Rewrite the logic slightly so that we first check if the
frame is TCP or UDP, in that case bypass the checksum
engine.

Reported-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 78287cfcbf63..1bf07505653b 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1144,6 +1144,7 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	skb_frag_t *skb_frag;
 	dma_addr_t mapping;
 	unsigned short mtu;
+	bool tcp, udp;
 	void *buffer;
 	int ret;
 
@@ -1160,7 +1161,18 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 		word3 |= mtu;
 	}
 
-	if (skb->len >= ETH_FRAME_LEN) {
+	/* Check if the protocol is TCP or UDP */
+	tcp = false;
+	udp = false;
+	if (skb->protocol == htons(ETH_P_IP)) {
+		tcp = ip_hdr(skb)->protocol == IPPROTO_TCP;
+		udp = ip_hdr(skb)->protocol == IPPROTO_UDP;
+	} else { /* IPv6 */
+		tcp = ipv6_hdr(skb)->nexthdr == IPPROTO_TCP;
+		udp = ipv6_hdr(skb)->nexthdr == IPPROTO_UDP;
+	}
+
+	if (skb->len >= ETH_FRAME_LEN || (!tcp && !udp)) {
 		/* Hardware offloaded checksumming isn't working on frames
 		 * bigger than 1514 bytes. A hypothesis about this is that the
 		 * checksum buffer is only 1518 bytes, so when the frames get
@@ -1168,6 +1180,9 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 		 * overwritten by the FCS.
 		 *
 		 * Just use software checksumming and bypass on bigger frames.
+		 *
+		 * Bypass the checksumming engine for any protocols that are
+		 * not TCP or UDP.
 		 */
 		if (skb->ip_summed == CHECKSUM_PARTIAL) {
 			ret = skb_checksum_help(skb);
@@ -1176,22 +1191,14 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 		}
 		word1 |= TSS_BYPASS_BIT;
 	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		int tcp = 0;
-
-		/* We do not switch off the checksumming on non TCP/UDP
-		 * frames: as is shown from tests, the checksumming engine
-		 * is smart enough to see that a frame is not actually TCP
-		 * or UDP and then just pass it through without any changes
-		 * to the frame.
+		/* If we get here we are dealing with a TCP or UDP frame
+		 * which is small enough to be processed by the checkumming
+		 * engine.
 		 */
-		if (skb->protocol == htons(ETH_P_IP)) {
+		if (skb->protocol == htons(ETH_P_IP))
 			word1 |= TSS_IP_CHKSUM_BIT;
-			tcp = ip_hdr(skb)->protocol == IPPROTO_TCP;
-		} else { /* IPv6 */
+		else
 			word1 |= TSS_IPV6_ENABLE_BIT;
-			tcp = ipv6_hdr(skb)->nexthdr == IPPROTO_TCP;
-		}
-
 		word1 |= tcp ? TSS_TCP_CHKSUM_BIT : TSS_UDP_CHKSUM_BIT;
 	}
 

-- 
2.34.1


