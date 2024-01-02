Return-Path: <netdev+bounces-61012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB038222A3
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 21:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13C48B2290B
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 20:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7802F16421;
	Tue,  2 Jan 2024 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dBWoNgo5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9071168AA
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e759ece35so7540752e87.3
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 12:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704227674; x=1704832474; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1M9nYN3vG6J30yAr/55QkQJHhhME7G4QwBy/DGljMWQ=;
        b=dBWoNgo5PygEcC9HMkb5J8G3zVrW34Vd60E8oSa69CsPq3v7ZNeInou1ajtqfeynNL
         LOhUP0GryNId1+I/b5EvwRhjCfuNjRhzn2Awr0SUnzbA+Bex3+wvO9Zn309aNZ9dZTHy
         FkXlxKDVitRnFynCQoyfm0JPUNe4XVnLVSR/pjtNs69EX1zKT71QV4yzIhmzmFVlEShq
         NvGMq7cupxhAXToeiw/qQm5bpTNuERUoGrtSNeOS3ieI5V51sbo1mhgNN03FA61/4gQP
         S9NT2nJiouyQJ+MPG/BPLWgzbF7CMZ/cAfI+MG+SJ+KKnRo0knmq5r8M6k+aJvACBSph
         EqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704227674; x=1704832474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1M9nYN3vG6J30yAr/55QkQJHhhME7G4QwBy/DGljMWQ=;
        b=LPoOnJDUvHZvXI4lg0dde8v3s0cG3X94RaA/VCM0FV2ZqUS6UXc4jv49DRuW0W3wt2
         A1nhEWtgGqttG1qaa042B5q2rn5EZa5N6ibh8URseooWbE5qSBRsbBhtKV+qqiEAg/Lf
         MvbbtxIBeAdym2CssUhXaaYrnIsGOb4szg6sUSHRKmq2hn5vlR6EtOkHO/awma7vmkfY
         s8t4U32QVvAZWjMst3QlxXwCbnS2J/N4zFoxrn+eAv5asheqZ4qvYqUD6+/0DlVCReX9
         PDrRXdejZVVbXZqIph/K9mOQyGF/mKFh6NWiqthrSyro0KATamOzh5ooJ2soOBvEsG/k
         3tJQ==
X-Gm-Message-State: AOJu0YyzLU7sh7JoGQFgt90mpMyOOmq1+utzcWvLeGiLj4RzI+jRzGZN
	KscXu9LM927HkZo1Cv0cHeJEBtH2xE34Bg==
X-Google-Smtp-Source: AGHT+IELY2RrI4v5BL6TZkjmiBBdx1iS+Ih9bElowArkthdxzgBDg9lZEcLiiHvbEL8Q/G4RFbWmKg==
X-Received: by 2002:a05:6512:2346:b0:50e:7dd2:4104 with SMTP id p6-20020a056512234600b0050e7dd24104mr6792899lfu.56.1704227674119;
        Tue, 02 Jan 2024 12:34:34 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a19-20020ac25213000000b0050e7b52c735sm2668392lfl.145.2024.01.02.12.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 12:34:33 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 02 Jan 2024 21:34:25 +0100
Subject: [PATCH net v5 1/2] net: ethernet: cortina: Drop software checksum
 and TSO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240102-new-gemini-ethernet-regression-v5-1-cf61ab3aa8cd@linaro.org>
References: <20240102-new-gemini-ethernet-regression-v5-0-cf61ab3aa8cd@linaro.org>
In-Reply-To: <20240102-new-gemini-ethernet-regression-v5-0-cf61ab3aa8cd@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Household Cang <canghousehold@aol.com>, 
 Romain Gantois <romain.gantois@bootlin.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The recent change to allow large frames without hardware checksumming
slotted in software checksumming in the driver if hardware could not
do it.

This will however upset TSO (TCP Segment Offloading). Typical
error dumps includes this:

skb len=2961 headroom=222 headlen=66 tailroom=0
(...)
WARNING: CPU: 0 PID: 956 at net/core/dev.c:3259 skb_warn_bad_offload+0x7c/0x108
gemini-ethernet-port: caps=(0x0000010000154813, 0x00002007ffdd7889)

And the packets do not go through.

After investigating I drilled it down to the introduction of the
software checksumming in the driver.

Since the segmenting of packets will be done by the hardware this
makes a bit of sense since in that case the hardware also needs to
be keeping track of the checksumming.

That begs the question why large TCP or UDP packets also have to
bypass the checksumming (like e.g. ICMP does). If the hardware is
splitting it into smaller packets per-MTU setting, and checksumming
them, why is this happening then? I don't know. I know it is needed,
from tests: the OpenWrt webserver uhttpd starts sending big skb:s (up
to 2047 bytes, the max MTU) and above 1514 bytes it starts to fail
and hang unless the bypass bit is set: the frames are not getting
through.

Drop the size check and the offloading features for now: this
needs to be fixed up properly.

Suggested-by: Eric Dumazet <edumazet@google.com>
Fixes: d4d0c5b4d279 ("net: ethernet: cortina: Handle large frames")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 35 ++++-------------------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 78287cfcbf63..5e399c6e095b 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -79,8 +79,7 @@ MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 #define GMAC0_IRQ4_8 (GMAC0_MIB_INT_BIT | GMAC0_RX_OVERRUN_INT_BIT)
 
 #define GMAC_OFFLOAD_FEATURES (NETIF_F_SG | NETIF_F_IP_CSUM | \
-		NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | \
-		NETIF_F_TSO | NETIF_F_TSO_ECN | NETIF_F_TSO6)
+			       NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM)
 
 /**
  * struct gmac_queue_page - page buffer per-page info
@@ -1143,39 +1142,13 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	struct gmac_txdesc *txd;
 	skb_frag_t *skb_frag;
 	dma_addr_t mapping;
-	unsigned short mtu;
 	void *buffer;
-	int ret;
-
-	mtu  = ETH_HLEN;
-	mtu += netdev->mtu;
-	if (skb->protocol == htons(ETH_P_8021Q))
-		mtu += VLAN_HLEN;
 
+	/* TODO: implement proper TSO using MTU in word3 */
 	word1 = skb->len;
-	word3 = SOF_BIT;
-
-	if (word1 > mtu) {
-		word1 |= TSS_MTU_ENABLE_BIT;
-		word3 |= mtu;
-	}
+	word3 = SOF_BIT | skb->len;
 
-	if (skb->len >= ETH_FRAME_LEN) {
-		/* Hardware offloaded checksumming isn't working on frames
-		 * bigger than 1514 bytes. A hypothesis about this is that the
-		 * checksum buffer is only 1518 bytes, so when the frames get
-		 * bigger they get truncated, or the last few bytes get
-		 * overwritten by the FCS.
-		 *
-		 * Just use software checksumming and bypass on bigger frames.
-		 */
-		if (skb->ip_summed == CHECKSUM_PARTIAL) {
-			ret = skb_checksum_help(skb);
-			if (ret)
-				return ret;
-		}
-		word1 |= TSS_BYPASS_BIT;
-	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		int tcp = 0;
 
 		/* We do not switch off the checksumming on non TCP/UDP

-- 
2.34.1


