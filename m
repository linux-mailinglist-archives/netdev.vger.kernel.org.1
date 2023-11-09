Return-Path: <netdev+bounces-46782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C937E6623
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 10:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC4A1C20BE4
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 09:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C5211192;
	Thu,  9 Nov 2023 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KfIJEmWs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7D210A35
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 09:03:19 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA28A2D59
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 01:03:17 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c6ef6c1ec2so6694651fa.2
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 01:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699520596; x=1700125396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aC8LSFbrPW68Hp+zttgMH6wC0575N6ndnCuu0kvQp3U=;
        b=KfIJEmWsBKMIMPyg/8glfSplb7JaxQvUVljaU3sZZgAVJ526I66ZJ7jMcm9E0kcFPV
         aAUIwFNGyaUj8/ztpVsb57Rc72XGkhAhByewcD4X54XIz+COpvpw5oL37YMpRTJxaMLt
         7K/gJdcf73G9j5+1I48E/6d+qMl9rG/697Y+zKUNkmEVgLNQZf1CbzcquOGLkSboFxFQ
         CLCGG4MSRyH3HSRTpHvjU+Z1NNzCjJHmRqqLVB8/fj1scyWQSbf77+1bQMNQppEztrsf
         9ffkyATa8zM/3YyOrz4+vcipFmv2R58HFNSr1Ynx7TD3E6gl0QeN3cv+boo6BKFc9f96
         L/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699520596; x=1700125396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aC8LSFbrPW68Hp+zttgMH6wC0575N6ndnCuu0kvQp3U=;
        b=vOMYpUoTFa1FVAJcaoJYF5bNLCpmKeImWqsuohdBwqpuNoPeD7iGe8FhDxqquSEJ4r
         OdTX2s5U5obEJgGFXck153nd7ToUuPW3zPIaCGtpCyTos0mZlcQJowHa17W6oKyGSChv
         nYTC0cybVcg70dz+COODFpCzhgC+Y8I2+O7u731pftAdBGCO0WfQbZYk5jAmPAtAcWXt
         EZov1FwoIcQtKsHxT6bDH0BYFrKjXz+yeTA/WBiAtP3KC8zmMDCUfUWRWgWw06jdQAkT
         lIC0xZwxfDOE42NhVMVP3H7j5WQGJYgZ4N+MnzPWZB9oudj9mqRUga1RqjVT/lMfZl5N
         O9Ig==
X-Gm-Message-State: AOJu0Yxy8UP62Nq0n8uUxLOmRLAlm7Jb+GTKW+mPk4wELICIpQa/xptl
	ZeWQ1+E5xAXYvYGZknJ9F+dY2g==
X-Google-Smtp-Source: AGHT+IHoDrqOJeHD3P8tw48u5vyH0Sw1wB8cwi01eZho9VrbWwPklDV2CqEV2k0vWTpPDakTgfwwRg==
X-Received: by 2002:a05:651c:104c:b0:2b9:f13b:6139 with SMTP id x12-20020a05651c104c00b002b9f13b6139mr4288294ljm.20.1699520595911;
        Thu, 09 Nov 2023 01:03:15 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h19-20020a05651c159300b002bbacc6c523sm2212383ljq.49.2023.11.09.01.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 01:03:15 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 09 Nov 2023 10:03:13 +0100
Subject: [PATCH net v4 2/3] net: ethernet: cortina: Handle large frames
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231109-gemini-largeframe-fix-v4-2-6e611528db08@linaro.org>
References: <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org>
In-Reply-To: <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The Gemini ethernet controller provides hardware checksumming
for frames up to 1514 bytes including ethernet headers but not
FCS.

If we start sending bigger frames (after first bumping up the MTU
on both interfaces sending and receiving the frames), truncated
packets start to appear on the target such as in this tcpdump
resulting from ping -s 1474:

23:34:17.241983 14:d6:4d:a8:3c:4f (oui Unknown) > bc:ae:c5:6b:a8:3d (oui Unknown),
ethertype IPv4 (0x0800), length 1514: truncated-ip - 2 bytes missing!
(tos 0x0, ttl 64, id 32653, offset 0, flags [DF], proto ICMP (1), length 1502)
OpenWrt.lan > Fecusia: ICMP echo request, id 1672, seq 50, length 1482

If we bypass the hardware checksumming and provide a software
fallback, everything starts working fine up to the max TX MTU
of 2047 bytes, for example ping -s2000 192.168.1.2:

00:44:29.587598 bc:ae:c5:6b:a8:3d (oui Unknown) > 14:d6:4d:a8:3c:4f (oui Unknown),
ethertype IPv4 (0x0800), length 2042:
(tos 0x0, ttl 64, id 51828, offset 0, flags [none], proto ICMP (1), length 2028)
Fecusia > OpenWrt.lan: ICMP echo reply, id 1683, seq 4, length 2008

The bit enabling to bypass hardware checksum (or any of the
"TSS" bits) are undocumented in the hardware reference manual.
The entire hardware checksum unit appears undocumented. The
conclusion that we need to use the "bypass" bit was found by
trial-and-error.

Since no hardware checksum will happen, we slot in a software
checksum fallback.

Check for the condition where we need to compute checksum on the
skb with either hardware or software using == CHECKSUM_PARTIAL instead
of != CHECKSUM_NONE which is an incomplete check according to
<linux/skbuff.h>.

On the D-Link DIR-685 router this fixes a bug on the conduit
interface to the RTL8366RB DSA switch: as the switch needs to add
space for its tag it increases the MTU on the conduit interface
to 1504 and that means that when the router sends packages
of 1500 bytes these get an extra 4 bytes of DSA tag and the
transfer fails because of the erroneous hardware checksumming,
affecting such basic functionality as the LuCI web interface.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 5bdd1b252840..dbbccef86516 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1145,6 +1145,7 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	dma_addr_t mapping;
 	unsigned short mtu;
 	void *buffer;
+	int ret;
 
 	mtu  = ETH_HLEN;
 	mtu += netdev->mtu;
@@ -1159,9 +1160,30 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 		word3 |= mtu;
 	}
 
-	if (skb->ip_summed != CHECKSUM_NONE) {
+	if (skb->len >= ETH_FRAME_LEN) {
+		/* Hardware offloaded checksumming isn't working on frames
+		 * bigger than 1514 bytes. A hypothesis about this is that the
+		 * checksum buffer is only 1518 bytes, so when the frames get
+		 * bigger they get truncated, or the last few bytes get
+		 * overwritten by the FCS.
+		 *
+		 * Just use software checksumming and bypass on bigger frames.
+		 */
+		if (skb->ip_summed == CHECKSUM_PARTIAL) {
+			ret = skb_checksum_help(skb);
+			if (ret)
+				return ret;
+		}
+		word1 |= TSS_BYPASS_BIT;
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		int tcp = 0;
 
+		/* We do not switch off the checksumming on non TCP/UDP
+		 * frames: as is shown from tests, the checksumming engine
+		 * is smart enough to see that a frame is not actually TCP
+		 * or UDP and then just pass it through without any changes
+		 * to the frame.
+		 */
 		if (skb->protocol == htons(ETH_P_IP)) {
 			word1 |= TSS_IP_CHKSUM_BIT;
 			tcp = ip_hdr(skb)->protocol == IPPROTO_TCP;

-- 
2.34.1


