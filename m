Return-Path: <netdev+bounces-307747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Fm5WLth+V2pcTQAAu9opvQ
	(envelope-from <netdev+bounces-307747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 14:36:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 633B175E382
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 14:36:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=j0mzjQl0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307747-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307747-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=samsung.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35545301B81F
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 12:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311AE47798B;
	Wed, 15 Jul 2026 12:36:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61239477E3F
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 12:36:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118980; cv=none; b=bqJ2q5SkC0p8WiNnBjp8wFT98NQsYaJbCniRa6zSG3oUgrlYK+pjbVROXPCXblvh84PHugnoOF51yz5h8lk4XJb8G+hsYbLmkQomC8uCn3H3YUUT4Je2LEJhIcAmlfFmF37rubXqP7AvvnTMTh5MySNtL+Qn0UzObrjug6ZLjQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118980; c=relaxed/simple;
	bh=vEsiKMGdx5Ffi6xHHnP8FyY/HHOQPO+iDK0oie/ay+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=amKn/pJEu22mMhbm0OCW9CUAUhgzJbaA3xvOl/fL9SUin9ZWODZMFtnFPqIGiTpyBUkEG7jCzaL4mC3Fv6go9MCu9aR6AmthqyxxtA6iSvG+pxmgVyCUh2L89AjuAeFX30HKnGIjphJKyfXBbTWHW48C99dCweUjYPEOMLmnU+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=j0mzjQl0; arc=none smtp.client-ip=210.118.77.12
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260715123611euoutp0251f02cfc825369d91c7376405c75211a~CdsB1lN1j2113121131euoutp02Y
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 12:36:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260715123611euoutp0251f02cfc825369d91c7376405c75211a~CdsB1lN1j2113121131euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1784118971;
	bh=A6XmGwoyQK4IATTx7Sicb5Md/GOMK8vp+z2XevcvSds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j0mzjQl0/5yjujQR70Pvx+WWmS6qaZixVmpjPwtxf/vZGoJg6HodJZ05ghl9WYH0F
	 zoGpXDV7KFyAsIltKelmMsnQRIkvdGPTQ/JgvFVfHsebEK+47ehj37Lu2w4Fs0snkI
	 cDi6DuhQo/ZGaFg2wXCLSCHwaGjaAvSNzg10gv9k=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260715123610eucas1p1487b60d74fe9741507fe744fe8e3132c~CdsBfDezb0259902599eucas1p1Y;
	Wed, 15 Jul 2026 12:36:10 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260715123610eusmtip2250609b51eddc41b7670006498b06290~CdsA2NKFQ0123201232eusmtip2v;
	Wed, 15 Jul 2026 12:36:10 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jakub
	Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net v3 2/2] net/stmmac: Prevent dma queue NULL free on
 allocation failure
Date: Wed, 15 Jul 2026 14:36:02 +0200
Message-Id: <20260715123602.51950-3-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715123602.51950-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260715123610eucas1p1487b60d74fe9741507fe744fe8e3132c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260715123610eucas1p1487b60d74fe9741507fe744fe8e3132c
X-EPHeader: CA
X-CMS-RootMailID: 20260715123610eucas1p1487b60d74fe9741507fe744fe8e3132c
References: <20260715123602.51950-1-j.raczynski@samsung.com>
	<CGME20260715123610eucas1p1487b60d74fe9741507fe744fe8e3132c@eucas1p1.samsung.com>
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[samsung.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,lists.infradead.org,samsung.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307747-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:j.raczynski@samsung.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[samsung.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 633B175E382
X-Rspamd-Action: no action

During allocation of RX/TX descriptor resources and its DMA,
there is verification of failed dma_alloc_coherent() due to lack of memory.
In case of that failure, all allocated resources are freed instantly after,
but there are no checks for dma_free_coherent() whether previous step has
failed.
This will generally result in panic due to freeing NULL address.

Fix it by adding NULL verification of memory that is to be freed.
Also assign NULL to page pointers to avoid double free scenario.

Fixes: e73b19baa3b1c ("net: stmmac: simplify DMA descriptor allocation/init/freeing")
Reported-by: Sashiko AI <sashiko-bot@kernel.org>
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 28 +++++++++++++------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3098971e0b66..77604d6ab466 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2146,7 +2146,6 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 					 u32 queue)
 {
 	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
-	size_t size;
 	void *addr;
 
 	/* Release the DMA RX socket buffers */
@@ -2158,15 +2157,21 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 	rx_q->buf_alloc_num = 0;
 	rx_q->xsk_pool = NULL;
 
-	/* Free DMA regions of consistent memory previously allocated */
-	if (priv->extend_desc)
+	if (priv->extend_desc) {
 		addr = rx_q->dma_erx;
-	else
+		rx_q->dma_erx = NULL;
+	} else {
 		addr = rx_q->dma_rx;
+		rx_q->dma_rx = NULL;
+	}
 
-	size = stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size;
+	/* Free DMA regions of consistent memory if previously allocated */
+	if (addr) {
+		size_t size;
+		size = stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size;
 
-	dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
+		dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
+	}
 
 	if (xdp_rxq_info_is_reg(&rx_q->xdp_rxq))
 		xdp_rxq_info_unreg(&rx_q->xdp_rxq);
@@ -2198,7 +2203,6 @@ static void __free_dma_tx_desc_resources(struct stmmac_priv *priv,
 					 u32 queue)
 {
 	struct stmmac_tx_queue *tx_q = &dma_conf->tx_queue[queue];
-	size_t size;
 	void *addr;
 
 	/* Release the DMA TX socket buffers */
@@ -2206,15 +2210,21 @@ static void __free_dma_tx_desc_resources(struct stmmac_priv *priv,
 
 	if (priv->extend_desc) {
 		addr = tx_q->dma_etx;
+		tx_q->dma_etx = NULL;
 	} else if (tx_q->tbs & STMMAC_TBS_AVAIL) {
 		addr = tx_q->dma_entx;
+		tx_q->dma_entx = NULL;
 	} else {
 		addr = tx_q->dma_tx;
+		tx_q->dma_tx = NULL;
 	}
 
-	size = stmmac_get_tx_desc_size(priv, tx_q) * dma_conf->dma_tx_size;
+	if (addr) {
+		size_t size;
+		size = stmmac_get_tx_desc_size(priv, tx_q) * dma_conf->dma_tx_size;
 
-	dma_free_coherent(priv->device, size, addr, tx_q->dma_tx_phy);
+		dma_free_coherent(priv->device, size, addr, tx_q->dma_tx_phy);
+	}
 
 	kfree(tx_q->tx_skbuff_dma);
 	kfree(tx_q->tx_skbuff);
-- 
2.34.1


