Return-Path: <netdev+bounces-258649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aD9tImpYj2lqQQEAu9opvQ
	(envelope-from <netdev+bounces-258649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 17:59:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CC5138712
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 17:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 877243028037
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 16:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68883364E91;
	Fri, 13 Feb 2026 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="He2bjiYH"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199534FF41
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771001922; cv=none; b=P952FEYYqtF7rc4KnwR2A6sJZKCVz+Ox/OPWX/VrBQEau61/tajFhrziwAVBk9lRWOj0SOP3ZsckTI3vf60jQEF58sah85PtAIshqLpuoAQQAJ0pMSpXKCBbD0icCaml5QZ9x7+dI/U7q4paxEzokhxVuAqbqzzmiuSOxTCb5V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771001922; c=relaxed/simple;
	bh=IHv+Js7yQQT3Cb7lwaAKGDjjC8/sgnB8epbGQqfOEkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QogNiHzfFkmXJts3LmmdTf/MLKPOC+gURNyYp2pAIXtCRKGHm7OLxghqbFm9mryXlJfqZYTpt49OfGP2iczPyyBlJPaIy4o+Q4rnF/KJa0+lTDG0ny1XTXPDyIUUTzvgpTjcfrpXvBGCZL1LqaMqbd8XvjddRhL1WifVWwK4u8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=He2bjiYH; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C66BF1A0EC1;
	Fri, 13 Feb 2026 16:58:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9C711606CB;
	Fri, 13 Feb 2026 16:58:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 839F110368EF4;
	Fri, 13 Feb 2026 17:58:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771001918; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TH8bhaw+p833aL4PQQSr7Otnu00e9AzMPg2hZGvfovM=;
	b=He2bjiYHKumB7SVDRi1o54UnpEpiXQuK4aRANq6rPkbqFtQg6ps6s1ebWnUHM3lOzby+0f
	O4cRTpkUKsFJoKv6wqjfk5L6UxazIK7YRjchtWRojXRwNQr0N0K+12Ggsbh+JRMz2gtssV
	nU9844EOOcCBMlsNzQ1UEcLsFfnEOJzdjLqWNZzw1BZD1pNXuMEVSlRB4D+lGk0V819CBX
	T9aVOi/iUEFi8f00I5fpFQXOvAHpfWlW79acMi3rDMwYdzyTIdozc+CCi813aub0Ttnmfl
	pYQzVgTQ4wmwjB624llGa6qixkLieESjJ9ZUPySneinXb7ud7Y34VlNYQiTfIw==
From: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
To: theo.lebrun@bootlin.com
Cc: andrew+netdev@lunn.ch,
	claudiu.beznea@tuxon.dev,
	davem@davemloft.net,
	edumazet@google.com,
	gregory.clement@bootlin.com,
	kuba@kernel.org,
	lorenzo@kernel.org,
	netdev@vger.kernel.org,
	nicolas.ferre@microchip.com,
	pabeni@redhat.com,
	pvalerio@redhat.com,
	thomas.petazzoni@bootlin.com
Subject: [PATCH 4/6] net: macb: account for stats in Rx XDP codepaths
Date: Fri, 13 Feb 2026 17:57:57 +0100
Message-ID: <20260213165759.225449-4-theo.lebrun@bootlin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213165759.225449-1-theo.lebrun@bootlin.com>
References: <DG4MBFXG7GGG.3GFLWBUKH087T@bootlin.com>
 <20260213165759.225449-1-theo.lebrun@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258649-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2CC5138712
X-Rspamd-Action: no action

gem_xdp_run() returns an action. Wrt stats, we land in three different
cases:
 - Packet is handed to the stack (XDP_PASS), turns into an SKB and gets
   accounted for below in gem_rx(). No fix here.
 - Packet is dropped (XDP_DROP|ABORTED), we must increment the dropped
   counter. Missing; add it.
 - Packet is passed along (XDP_TX|REDIRECT), we must increment bytes &
   packets counters. Missing; add it.

Along the way, use local variables to store rx_bytes, rx_packets and
rx_dropped. Then increase stats only once at the end of gem_rx(). This
is simpler because all three stats must modified on a per interface and
per queue basis.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 37 +++++++++++++++++-------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 05bbbaf260ce..01b4299dc34b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1548,6 +1548,7 @@ static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
 static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		  int budget)
 {
+	unsigned int packets = 0, dropped = 0, bytes = 0;
 	struct skb_shared_info *shinfo;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
@@ -1595,8 +1596,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		if (unlikely(!buff_head)) {
 			netdev_err(bp->dev,
 				   "inconsistent Rx descriptor chain\n");
-			bp->dev->stats.rx_dropped++;
-			queue->stats.rx_dropped++;
+			dropped++;
 			break;
 		}
 
@@ -1613,10 +1613,21 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 
 		if (first_frame && last_frame) {
 			ret = gem_xdp_run(queue, buff_head, data_len, addr);
-			if (ret == XDP_REDIRECT)
-				xdp_flush = true;
 
-			if (ret != XDP_PASS) {
+			switch (ret) {
+			case XDP_PASS:
+				break; /* fallthrough to SKB handling */
+			case XDP_ABORTED:
+			case XDP_DROP:
+				dropped++;
+				queue->rx_buff[entry] = NULL;
+				continue;
+			case XDP_REDIRECT:
+				xdp_flush = true;
+				fallthrough;
+			case XDP_TX:
+				packets++;
+				bytes += data_len;
 				queue->rx_buff[entry] = NULL;
 				continue;
 			}
@@ -1672,10 +1683,8 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 
 		/* now everything is ready for receiving packet */
 		if (last_frame) {
-			bp->dev->stats.rx_packets++;
-			queue->stats.rx_packets++;
-			bp->dev->stats.rx_bytes += queue->skb->len;
-			queue->stats.rx_bytes += queue->skb->len;
+			packets++;
+			bytes += queue->skb->len;
 
 			gem_ptp_do_rxstamp(bp, queue->skb, desc);
 #if defined(DEBUG) && defined(VERBOSE_DEBUG)
@@ -1704,11 +1713,17 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 						false);
 		}
 
-		bp->dev->stats.rx_dropped++;
-		queue->stats.rx_dropped++;
+		dropped++;
 		queue->rx_buff[entry] = NULL;
 	}
 
+	bp->dev->stats.rx_packets += packets;
+	queue->stats.rx_packets += packets;
+	bp->dev->stats.rx_dropped += dropped;
+	queue->stats.rx_dropped += dropped;
+	bp->dev->stats.rx_bytes += bytes;
+	queue->stats.rx_bytes += bytes;
+
 	if (xdp_flush)
 		xdp_do_flush();
 
-- 
2.53.0


