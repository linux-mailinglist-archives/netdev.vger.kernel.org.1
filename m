Return-Path: <netdev+bounces-58272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DC6815B59
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 20:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84FF1C2193E
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 19:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEAD328CD;
	Sat, 16 Dec 2023 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AwkAdIVr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B90F31A8E
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e30b28c1aso299782e87.0
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 11:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702755413; x=1703360213; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVRwOGlgS4OX+8vqS+0hxHNi+4vVCWuPIOJJBMqWhWs=;
        b=AwkAdIVrpZzQjk1itmEtvQHQXik0zUpSni1rLSkQsNifH6+QEUgePUKjtPfMSJGs37
         apjy0Elf6ydjs4IG0sqkDaaT6LhjE0XQtRGpZSDSxCfG5/elNhA8USwN3AXVyH5kLX7c
         EE+98jKl1e91p7DesMhOevmbBxtgJYOBuGRlwqf2BVSHn/Ljpv1pe6zOsYcB56zzHzOM
         ghCkWfzHs6/O0dUHpUFx4TKXcI7ZA0+uFEsL7KjiFNjBLav7GnKc0Uzh2kTKuNTGEjTq
         HJMnuJ2P9IwogX2fwjm2S2FzJf06XcX9CScw0G99NqCYGGt20UryT9fUkpnCWhhPCPtt
         pB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702755413; x=1703360213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVRwOGlgS4OX+8vqS+0hxHNi+4vVCWuPIOJJBMqWhWs=;
        b=nIhIc4PXgGpw41q68WEpm6S6mH4NW0L3poQk8EIzS8oe93sZIvnL2GqZVq6sN1V/AP
         UGPikrKi1KUF9KniF1g473O7+po8sJoazBOIn3G+Q+bTTjT1nwb7hMHX7SdDJ9dK7WtV
         /eoW7m2UPEOtMoAs7u2/XA6y/xvowzF7lZTNnFQwtGFSh8JcY73a4TT+0YhizBxtFe5T
         tpLmQmXgyS8fS8KP60tCtGHj95ZFfRtwPcBn7SIbRGPbT9EQePAC/+0JcYuML4X02Wvj
         alWAeM7FJsCkMhuxiAaltjwbPhuNrebXYeeX1PDDFBMw8ciLE5EhCLcIsrJQfuoHJjBK
         qc6g==
X-Gm-Message-State: AOJu0YxJHATxnLWI5rgIn/wYaja5xX6GVE9e6u4E3SQpUR754Yk1rkgD
	tRE4jUKBKMKCyVwbpWyLLh0cCs8RSh9QY0HgZ48=
X-Google-Smtp-Source: AGHT+IHY2ROHEnoFTZYPwJOrMyDhsKSiT8c8G0JCi/UQNfM0wO3Ieumfb25ZUVURB0//wh+mxHCHxQ==
X-Received: by 2002:ac2:4c4a:0:b0:50b:ef70:8d66 with SMTP id o10-20020ac24c4a000000b0050bef708d66mr8871731lfk.26.1702755413706;
        Sat, 16 Dec 2023 11:36:53 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u13-20020ac25bcd000000b0050bc96f5258sm2441553lfn.214.2023.12.16.11.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 11:36:53 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 16 Dec 2023 20:36:52 +0100
Subject: [PATCH net v2 1/2] net: ethernet: cortina: Drop software checksum
 and TSO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231216-new-gemini-ethernet-regression-v2-1-64c269413dfa@linaro.org>
References: <20231216-new-gemini-ethernet-regression-v2-0-64c269413dfa@linaro.org>
In-Reply-To: <20231216-new-gemini-ethernet-regression-v2-0-64c269413dfa@linaro.org>
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
index 78287cfcbf63..6a7ea051391a 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -79,8 +79,7 @@ MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 #define GMAC0_IRQ4_8 (GMAC0_MIB_INT_BIT | GMAC0_RX_OVERRUN_INT_BIT)
 
 #define GMAC_OFFLOAD_FEATURES (NETIF_F_SG | NETIF_F_IP_CSUM | \
-		NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM | \
-		NETIF_F_TSO | NETIF_F_TSO_ECN | NETIF_F_TSO6)
+	       NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM )
 
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


