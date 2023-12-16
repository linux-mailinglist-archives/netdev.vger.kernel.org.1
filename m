Return-Path: <netdev+bounces-58273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD529815B5A
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 20:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47832284E07
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 19:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E59632C6B;
	Sat, 16 Dec 2023 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sb/Pyfeh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73026328A6
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e270639d9so853540e87.3
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 11:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702755414; x=1703360214; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9h9Ee/Vwe1BIQxBQqqcTxcTd1wrlWdnAiQYYrezMqwc=;
        b=sb/Pyfeh8z1OtZ04S5ISpAiwsUnCm7TTcqvL8zDF7U3cFLVgeUo57JXj00ycCB7YmX
         GnlFtZkYgkLf8zPffckB0xCZ38g7YgL6YoQ4NB0qZamEtZcYwOmHiFZmGxC+8PObXPz8
         JKScbTCiJTQYconhPfHZcaJ2whRRxaTe8fcVbkrA7qZjQASsrhbc++br5LyyRDYpwqEh
         +N06bYd2lsnJQ9s3RLs5HoVTsvSLsA0sJFW2waXr6UOJoUa4To2XoeTXu8hJeWOEJFwy
         cDvW74uXXOqnGVzbMIytY0BMZMIHcRUnOPsjzpYmW+zivkFSSnR6qFw6okPYafWOBMjs
         r2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702755414; x=1703360214;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9h9Ee/Vwe1BIQxBQqqcTxcTd1wrlWdnAiQYYrezMqwc=;
        b=STZl1bdm1MnUoDOrYHqe20hUusvo4/FkR7zgauL7FoZ1KB1ntzcIw5DXEC5VFNkHGn
         hAErKIWyJI5V1801+fcjgfWFs2Umm3a0lRDU82XTazh/EvmVlhuyOdgreLAXJRRtdcgD
         PFXbASBksqPtNv8r1LyL2mUvEIjLSPGs5XNbNfSkJ/xFHwNb4f9hr4QzTJXGwXtnnS6+
         t0tPOFbhcedQt1fQHMwaTQzEP58cTo5fqZ4qOluG/0tJeb0CmgF7xhX4+pkJDTFEZeA5
         svREEIq+oNTgMxETQHmIDEw9RlY+EKaebNYEAskuJ/cxauFnPfvLgrAuTRn0ycmiESFg
         a0dQ==
X-Gm-Message-State: AOJu0YzU4jRIotkmNqZ4pk+uMmD/J7oVXpd+hjo5A3fgFzS+R7gp8tdU
	ZlZDMtzBpsvtEMMCJTe9yeRNlyONLA8iIh+xHzg=
X-Google-Smtp-Source: AGHT+IFzz+T2hXXKxiCdBwJyMPL+OjikGaLBZmuS4blLXomqcUvu7YRY16pFw58HaKIwbEvjI8YB8w==
X-Received: by 2002:a05:6512:693:b0:50b:b9c7:9f3d with SMTP id t19-20020a056512069300b0050bb9c79f3dmr9084665lfe.21.1702755414542;
        Sat, 16 Dec 2023 11:36:54 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u13-20020ac25bcd000000b0050bc96f5258sm2441553lfn.214.2023.12.16.11.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 11:36:54 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 16 Dec 2023 20:36:53 +0100
Subject: [PATCH net v2 2/2] net: ethernet: cortina: Bypass checksumming
 engine of alien ethertypes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231216-new-gemini-ethernet-regression-v2-2-64c269413dfa@linaro.org>
References: <20231216-new-gemini-ethernet-regression-v2-0-64c269413dfa@linaro.org>
In-Reply-To: <20231216-new-gemini-ethernet-regression-v2-0-64c269413dfa@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

We had workarounds were the ethernet checksumming engine would be bypassed
for larger frames, this fixed devices using DSA, but regressed devices
where the ethernet was connected directly to a PHY.

The devices with a PHY connected directly can't handle large frames
either way, with or without bypass. Looking at the size of the frame
is probably just wrong.

Rework the workaround such that we just bypass the checksumming engine if
the ethertype inside the actual frame is something else than 0x0800
(IPv4) or 0x86dd (IPv6). These are the only frames the checksumming engine
can actually handle. VLAN framing (0x8100) also works fine.

We can't inspect skb->protocol because DSA frames will sometimes have a
custom ethertype despite skb->protocol is e.g. 0x0800.

After this both devices with direct ethernet attached such as D-Link
DNS-313 and devices with a DSA switch with a custom ethertype such as
D-Link DIR-685 work fine.

Fixes: d4d0c5b4d279 ("net: ethernet: cortina: Handle large frames")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 6a7ea051391a..1400f19bf05b 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1143,7 +1143,9 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	skb_frag_t *skb_frag;
 	dma_addr_t mapping;
 	unsigned short mtu;
+	u16 ethertype;
 	void *buffer;
+	__be16 *p;
 
 	mtu  = ETH_HLEN;
 	mtu += netdev->mtu;
@@ -1158,7 +1160,24 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 		word3 |= mtu;
 	}
 
-	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+	/* Dig out the the ethertype actually in the buffer and not what the
+	 * protocol claims to be. This is the raw data that the checksumming
+	 * offload engine will have to deal with.
+	 */
+	p = (__be16 *)(skb->data + 2 * ETH_ALEN);
+	ethertype = ntohs(*p);
+	if (ethertype == ETH_P_8021Q) {
+		p += 2; /* +2 sizeof(__be16) */
+		ethertype = ntohs(*p);
+	}
+
+	if (ethertype != ETH_P_IP && ethertype != ETH_P_IPV6) {
+		/* Hardware offloaded checksumming isn't working on non-IP frames.
+		 * This happens for example on some DSA switches using a custom
+		 * ethertype. Just bypass the engine for those.
+		 */
+		word1 |= TSS_BYPASS_BIT;
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		int tcp = 0;
 
 		/* We do not switch off the checksumming on non TCP/UDP

-- 
2.34.1


