Return-Path: <netdev+bounces-263997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDdqJXJ8qGmHuwAAu9opvQ
	(envelope-from <netdev+bounces-263997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:39:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01611206815
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D40FD3250E22
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 18:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E303D5678;
	Wed,  4 Mar 2026 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KSOTSxrp"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAE13DA5AB
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648688; cv=none; b=UfgI3vTSa8UujZjePMYMbVWXq26gmViWc/cgDsUIDnc80HgxZ22KnXgWkmrQYotaj9eU9PE4FLq2jo5badDFnpINSfpKl5YgV8/Vlj2zNAC9bKl7uvZJmeXBALBtVY13Zxi6C6EgGi6Rgtl04ywdBVst32DD2TdCdTy0impyU4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648688; c=relaxed/simple;
	bh=1kn1psIhiJQGixudWstdQUGbMnl65a2Ws9qkxb0h6vA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GlbGFFYAxFDj2mrjgx+sKHF3xJQJQaasrH0YZfGM2YZftxfd+YNEuT+YwJr5scLZQHmoOUBNDio5MGGYItEUeQNVqCj6q0+ZwbTGPmIm8xIpJ3EB2wUm69QhRWrPE/cD+T3d94K/19v14wyjdPZn2Qt2pasDL4/e55ASu2teD/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KSOTSxrp; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 94DC54E42543;
	Wed,  4 Mar 2026 18:24:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 63F6C5FF5C;
	Wed,  4 Mar 2026 18:24:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 10862103695FE;
	Wed,  4 Mar 2026 19:24:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772648683; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=afu30LFlXgCnEzNfi1TzEAIspkrLSXKZZ9DD7cZcOIc=;
	b=KSOTSxrpWkZQgzLiyoGhPRhMXy7ijJemYXH/1A9i1v912AqXLRj21WYaD9tFiOGBrCKjaC
	DPrNlF+fuYRgVpUeRfJGTKdDULcpjE5WWGS8rLuv8M1FtLNK10d3HfQyh3VAjAQO7GNHEX
	tsHKcUrF0nnXG62J3WnXVQETPMSYvVSnE4HXJG3jc+rahGYNtv6RMb6YdfKcnLLbt89bkR
	kfIhmWd+QrNxUb7kuK2YwM5aWlE/boa4/Q3eoV0/LCJULuX0fdaTQrq6JnVCPMhxsRbAio
	uKEWZGI7o6Y5u2FYBkocnEWkGixsWmIPk7W6Ke4J7TKrCONEj3kc53DKSvjrdw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 04 Mar 2026 19:24:24 +0100
Subject: [PATCH net-next 1/8] net: macb: make rx error messages
 rate-limited
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260304-macb-xsk-v1-1-ba2ebe2bdaa3@bootlin.com>
References: <20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com>
In-Reply-To: <20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 01611206815
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263997-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Action: no action

If Rx codepath error messages trigger, they do not interrupt reception.
Kernel log gets spammed, we lose useful history and everything crawls
to a halt. Instead, make them rate-limited to keep old useful
information in the log and keep the system responsive.

No netdev_*_ratelimited() variants exist so we switch to dev_*().

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index a79daad275ba..ab73d1a522c2 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1303,11 +1303,12 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 static inline int gem_rx_data_len(struct macb *bp, struct macb_queue *queue,
 				  u32 desc_ctrl, bool rx_sof, bool rx_eof)
 {
+	struct device *dev = &bp->pdev->dev;
 	int len;
 
 	if (unlikely(!rx_sof && !queue->skb)) {
-		netdev_err(bp->dev,
-			   "Received non-starting frame while expecting a starting one\n");
+		dev_err_ratelimited(dev,
+				    "Received non-starting frame while expecting a starting one\n");
 		return -1;
 	}
 
@@ -1322,7 +1323,7 @@ static inline int gem_rx_data_len(struct macb *bp, struct macb_queue *queue,
 
 	if (rx_eof && !rx_sof) {
 		if (unlikely(queue->skb->len > len)) {
-			netdev_err(bp->dev, "Unexpected frame len: %d\n", len);
+			dev_err_ratelimited(dev, "Unexpected frame len: %d\n", len);
 			return -1;
 		}
 
@@ -1382,8 +1383,8 @@ static int gem_rx_refill(struct macb_queue *queue, bool napi)
 						    gem_total_rx_buffer_size(bp),
 						    gfp_alloc | __GFP_NOWARN);
 			if (!page) {
-				netdev_err(bp->dev,
-					   "Unable to allocate rx buffer\n");
+				dev_err_ratelimited(&bp->pdev->dev,
+						    "Unable to allocate rx buffer\n");
 				err = -ENOMEM;
 				break;
 			}
@@ -1666,8 +1667,8 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 
 		buff_head = queue->rx_buff[entry];
 		if (unlikely(!buff_head)) {
-			netdev_err(bp->dev,
-				   "inconsistent Rx descriptor chain\n");
+			dev_err_ratelimited(&bp->pdev->dev,
+					    "inconsistent Rx descriptor chain\n");
 			bp->dev->stats.rx_dropped++;
 			queue->stats.rx_dropped++;
 			break;

-- 
2.53.0


