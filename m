Return-Path: <netdev+bounces-46031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7EF7E0F72
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 13:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1BC1C210A4
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 12:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BB9171DF;
	Sat,  4 Nov 2023 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d2xvWO4S"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC3A1A5A2
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 12:43:58 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415C7D4E
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 05:43:56 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c509d5ab43so42064061fa.0
        for <netdev@vger.kernel.org>; Sat, 04 Nov 2023 05:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699101834; x=1699706634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGuoNoybmpAHVbeBRQ0Y/xZn4w65B05owlyMy7HgTuo=;
        b=d2xvWO4ScSw5iDGGrf5T4DdSaie2rYXL4P08TnmhPuTytCXNw16vb9TzYTpT0snlbg
         HJZUnMNOKFLVcUh0YZ4Qex3UDoIE5jpiUVrowLCwkJTzzJRUWhmVPq/ujbmhAAbQxogg
         Ppu08ekkM5OrENbvJX+0Ir5z4yeoU3evZN+YibULApcl4gAICZFaRtEr/sTBljFM2cXi
         BWpfe+kNA9MPS/abpXvdHQLNtkCML2QQe2gQxeHmTAzo241bRMcu8KbBwyrB/Wx4zQgO
         fLQWp0J96w779pogg1S8ZBPaGMY6CiY52ES1x9tThamt7ygywOrvuUUfTSJcx0JOqTJu
         qtfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699101834; x=1699706634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGuoNoybmpAHVbeBRQ0Y/xZn4w65B05owlyMy7HgTuo=;
        b=fxAxPsdHVIzTWDkg1x9GbuawUj54W08BC7TCl9snuYCmLSyl4Zq4f5xkYOG84uxCY9
         c1Zn0HX/MoQ2Wv7kHZMpATilw1QpJ+KGuEVsFUPi4Ia+lGBocUPJJKndAN7Rh55DDKBE
         Ame3I0jyGgcJ8L2DtSs67aKanQ6KY6oIkyCAqt1Cc04Uj3Rtj45TKSRabZvmmOMFAk2p
         YNibNS7ePdJO4XMZqC1ymdFhQrs3PRL5ePnmQAZFb/Q4Dnz/gJjsZDIHQ+15L67xQWOR
         WgJ1yB9KoQP0iIZEM1km9nNv/JZzRj12B58dTzrohxzBJ5gk4Xx2TMPIJH2rLA8ggE7V
         5Y6Q==
X-Gm-Message-State: AOJu0Yw06yYaDRplvLKDfoOi4DqJuxiKd1VUh/GUey/XamartujOYrW/
	mW4XFZThFiLqeOUKM4a4g84RhA==
X-Google-Smtp-Source: AGHT+IFM8LyKtYP3lb6rmldO2Y/K2K0eNH2873kfaHunY7CPSwdiCXkmjcn14UjlqR8YVVm6mXvm5w==
X-Received: by 2002:a05:6512:3f29:b0:509:62de:71c7 with SMTP id y41-20020a0565123f2900b0050962de71c7mr825163lfa.2.1699101834505;
        Sat, 04 Nov 2023 05:43:54 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u22-20020ac24c36000000b005093312f66fsm496100lfq.124.2023.11.04.05.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 05:43:53 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 04 Nov 2023 13:43:51 +0100
Subject: [PATCH net 4/4] net: ethernet: cortina: Handle large frames
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231104-gemini-largeframe-fix-v1-4-9c5513f22f33@linaro.org>
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

The Gemini ethernet controller provides hardware checksumming
for frames up to 1514 bytes including ethernet headers but not
FCS.

If we start sending bigger frames (after first bumping up the MTU
on both interfaces sending and receiveing the frames), truncated
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

On the D-Link DIR-685 router this fixes a bug on the conduit
interface to the RTL8366RB DSA switch: as the switch needs to add
space for its tag it increases the MTU on the conduit interface
to 1504 and that means that when the router sends packages
of 1500 bytes these get an extra 4 bytes of DSA tag and the
transfer fails because of the erroneous hardware checksumming,
affecting such basic functionality as the LuCI web inteface.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 23723c9c0f93..063e58639379 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1145,6 +1145,7 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	dma_addr_t mapping;
 	unsigned short mtu;
 	void *buffer;
+	int ret;
 
 	mtu  = ETH_HLEN;
 	mtu += netdev->mtu;
@@ -1170,7 +1171,14 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 		word3 |= mtu;
 	}
 
-	if (skb->ip_summed != CHECKSUM_NONE) {
+	if (skb->len >= ETH_FRAME_LEN) {
+		/* Hardware offloaded checksumming isn't working on frames
+		 * bigger than 1514 bytes. Perhaps the buffer is only 1518
+		 * bytes fitting mach a normal frame and a checksum?
+		 * Just bypass on bigger frames.
+		 */
+		word1 |= TSS_BYPASS_BIT;
+	} else if (skb->ip_summed != CHECKSUM_NONE) {
 		int tcp = 0;
 
 		if (skb->protocol == htons(ETH_P_IP)) {

-- 
2.34.1


