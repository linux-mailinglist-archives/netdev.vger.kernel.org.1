Return-Path: <netdev+bounces-59380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD88281AB83
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 01:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6B41F21965
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 00:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFD4433A1;
	Thu, 21 Dec 2023 00:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7uJvkq3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C289A433A6
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 00:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50c0f13ea11so309643e87.3
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 16:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703116962; x=1703721762; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBDD0R1VzHn04ZqBmcTCc/UmHgjO4/zmLvPSgWyQBHQ=;
        b=Z7uJvkq3DnlxwDtWbE+epa1qmxRcRIFeAb5KXHuEYZbXiYL1B0cQ/Qz93AUq7D5lgP
         jY2CVRu/f6kcrJfCdFX8adDNKUeTwR9wmKdbhnaPe2LrdT4Io7MdbFx3DMYv5KojDY9k
         Ub3tAlHvgMxX6gNAxsBffMahCTO98M05M2qnFyMl5FYOfs+UoLDtfR4ofMcxK+ZPKGLA
         yEnIvcqyufGB6jSQBPFj2kg5rLz62MZFsrAu/pHC0pT8Gfw25G018Dm9c6Tpw0SGKUvI
         rCQVvE2JmR0OyjPkOhzkfkE0g/bFuRKW2p9zMTLluox/fIXng0QgXtbu0HsxLsJpoc3I
         zUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703116962; x=1703721762;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBDD0R1VzHn04ZqBmcTCc/UmHgjO4/zmLvPSgWyQBHQ=;
        b=Pk7+GuclJGIpAQEEdc83iMrUsyu46Gc+w1U2Stou9ZejuQctB1Aso2bevqlXfwIP3C
         Xn1gwYWsurB6locof8EPEAUoYMq2cjH0vMFtnrkRYkj8qhTXadyjVZEoOKIRKmT4XXbv
         GD2b2a5rB1O3A3/djjVq0u5081F0+9r9llV+umkO8/z/RqAJ+weTtgpuX7+xb+x0CEmP
         jaO6mNYDJ8wQc1eSnJ9HCJg/E0RLzI8Hk7gIpD3zNqaxGeiufmi09qRMatBgN4A2930T
         usweS4A7BAptyd8J+SRvjbfcej+rody7itykaZNswCy5thuzSDr/G03XqtpKTjA80PZe
         Kvhg==
X-Gm-Message-State: AOJu0Yw8cP82JkkP/8Mw93BxSBB6RVK1AlVZgHt03B/huNDOD5HUv32l
	ARe+/nal4aElsOMXenT6ww96uw==
X-Google-Smtp-Source: AGHT+IE9vovWa2oEaTXPQ/5pFhmMSE8TvFmpLGCQ2fhM/PpdpCW6+Lgc17iCMbIuZgRM2VVnZmXXjw==
X-Received: by 2002:a05:6512:78:b0:50e:55bb:a453 with SMTP id i24-20020a056512007800b0050e55bba453mr685783lfo.3.1703116961756;
        Wed, 20 Dec 2023 16:02:41 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id v26-20020a19741a000000b0050e4ac5bf5asm100321lfe.284.2023.12.20.16.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 16:02:40 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Dec 2023 01:02:20 +0100
Subject: [PATCH net v3 1/3] net: ethernet: cortina: Drop software checksum
 and TSO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231221-new-gemini-ethernet-regression-v3-1-a96b4374bfe8@linaro.org>
References: <20231221-new-gemini-ethernet-regression-v3-0-a96b4374bfe8@linaro.org>
In-Reply-To: <20231221-new-gemini-ethernet-regression-v3-0-a96b4374bfe8@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
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
 drivers/net/ethernet/cortina/gemini.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 78287cfcbf63..ecc247acac39 100644
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
@@ -1145,7 +1144,6 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	dma_addr_t mapping;
 	unsigned short mtu;
 	void *buffer;
-	int ret;
 
 	mtu  = ETH_HLEN;
 	mtu += netdev->mtu;
@@ -1160,22 +1158,7 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 		word3 |= mtu;
 	}
 
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


