Return-Path: <netdev+bounces-303740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GlIYH9s6RWq/8woAu9opvQ
	(envelope-from <netdev+bounces-303740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:05:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1CF6EF7D3
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 18:05:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=YZLJ5olh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303740-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303740-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B994E30BD3A7
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 16:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FA849690D;
	Wed,  1 Jul 2026 15:59:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB2049253B;
	Wed,  1 Jul 2026 15:59:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921576; cv=none; b=SYMBaF0lWinSYqNWRdZkmj+QRIPnPP5bKpQ2x9UeB/z+aROZpoPplfeW7B+Yhl8RPgje9M1NqshunUYpvOuedlO9bONQaq5iQMwsdhVmzNZUR8PSJcxcw9ebKEtrhMsGyHc8w3lP1/1i66BAPgroRquEUcFlmY8C471jPzC/o2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921576; c=relaxed/simple;
	bh=1WEC0v3fhxlqw7mp8SfJc8g3LoRdfrHJS0wY0RVhOGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eFNGt8kGUi/wsUEkl8pIosRoEcsaHHueOEDQTUz931yv099pMnybwru0SfdIhK8s1Ksx6bpLS10jvtHMrNdKItH8gpsvX3BRJ+pHXWYNtV/H1j11ePpRuZvQG1C5us3u09tzRfU5gGHMEDfQvoXtC6rL4KIb9ujCrHjzs3iLCTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YZLJ5olh; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 74E73C4FECB;
	Wed,  1 Jul 2026 15:59:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7689860288;
	Wed,  1 Jul 2026 15:59:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EFCAC104C968B;
	Wed,  1 Jul 2026 17:59:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782921572; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pm4seeTo6xQ3kGjppMMUq3/BSxQXP52DaEQsPZ8GebY=;
	b=YZLJ5olhSmP6HY0WV2+mg0YmfIXf1HxEdeSKkv49WbMPeW8BHzzmfu35GCMlojLLBGysS4
	0g4CLgu+8HWm8Eet0RODl7sjfI9eJR3vUlYT8bAE1KugvomlxNqUXJ1Wm++8d366vx2lQ1
	Cs1YtVrpE2ZQWZEaL01z99r9D02BqZ9+mtrOLJvXf/jjs4saSZqtXH+AK7D4PnNDh7G4jt
	zmdQYsZMop0pkqDM1Gb5Xa7BoWobgnSdkhUwSfEo4O+bmBBKB/+MVuyZo3L6mOZTzXnH7y
	8BR+ibiLJDp+jOReu9UDDVlbMz77aVKEih3tDTlFYaFilSPgBB7DYYVcFiGLrQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 01 Jul 2026 17:59:11 +0200
Subject: [PATCH net-next v3 08/15] net: macb: avoid
 macb_init_rx_buffer_size() modifying state
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260701-macb-context-v3-8-00268d5b1502@bootlin.com>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
In-Reply-To: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303740-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:theo.lebrun@bootlin.com,m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:pvalerio@redhat.com,m:nb@tipi-net.de,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE1CF6EF7D3

macb_init_rx_buffer_size() takes the macb private data struct and
overrides its bp->ctx->rx_buffer_size. To make it usable with multiple
contexts, make it return its value.

Also, move the `bufsz` computation into it. The value is only used if
GEM, and for historical reason it currently lives in macb_open().

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index dfb1d49d841c..13a1813fae6b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2615,25 +2615,26 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	return ret;
 }
 
-static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
+static unsigned int macb_rx_buffer_size(struct macb *bp, unsigned int mtu)
 {
-	if (!macb_is_gem(bp)) {
-		bp->ctx->rx_buffer_size = MACB_RX_BUFFER_SIZE;
-	} else {
-		bp->ctx->rx_buffer_size = MIN(size, RX_BUFFER_MAX);
+	unsigned int size;
 
-		if (bp->ctx->rx_buffer_size % RX_BUFFER_MULTIPLE) {
+	if (!macb_is_gem(bp)) {
+		size = MACB_RX_BUFFER_SIZE;
+	} else {
+		size = mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
+		size = MIN(size, RX_BUFFER_MAX);
+
+		if (size % RX_BUFFER_MULTIPLE) {
 			netdev_dbg(bp->netdev,
 				   "RX buffer must be multiple of %d bytes, expanding\n",
 				   RX_BUFFER_MULTIPLE);
-			bp->ctx->rx_buffer_size =
-				roundup(bp->ctx->rx_buffer_size,
-					RX_BUFFER_MULTIPLE);
+			size = roundup(size, RX_BUFFER_MULTIPLE);
 		}
 	}
 
-	netdev_dbg(bp->netdev, "mtu [%u] rx_buffer_size [%u]\n",
-		   bp->netdev->mtu, bp->ctx->rx_buffer_size);
+	netdev_dbg(bp->netdev, "mtu [%u] rx_buffer_size [%u]\n", mtu, size);
+	return size;
 }
 
 static void gem_free_rx_buffers(struct macb *bp)
@@ -3177,7 +3178,6 @@ static void macb_set_rx_mode(struct net_device *netdev)
 
 static int macb_open(struct net_device *netdev)
 {
-	size_t bufsz = netdev->mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
 	struct macb *bp = netdev_priv(netdev);
 	struct macb_queue *queue;
 	unsigned int q;
@@ -3196,7 +3196,7 @@ static int macb_open(struct net_device *netdev)
 	}
 
 	/* RX buffers initialization */
-	macb_init_rx_buffer_size(bp, bufsz);
+	bp->ctx->rx_buffer_size = macb_rx_buffer_size(bp, netdev->mtu);
 	bp->ctx->rx_ring_size = bp->configured_rx_ring_size;
 	bp->ctx->tx_ring_size = bp->configured_tx_ring_size;
 

-- 
2.55.0


