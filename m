Return-Path: <netdev+bounces-277534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFQiIYFV2WlgoggAu9opvQ
	(envelope-from <netdev+bounces-277534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:54:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9C33DC254
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 541C7306B50E
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7162383C85;
	Fri, 10 Apr 2026 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="z+Sy1YXq"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFB7382F16
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850738; cv=none; b=dyF6Vbe1VjMSnYi7Epe9ScvK1+OPrnbwEIQjvIJg6FrS1O2WvF8qvmDRQFiprZJ0oUYAeXbXZwAFYI0HNPv5Qvj5kxFD+Ee3rZ8e6MNT0gmOthcJQMM12jzsEd46worykc4nl79ldN+Ju9WRChEuk3mjdOd1dXkqfgn+8h1qRas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850738; c=relaxed/simple;
	bh=ms+LD8U5s+vRgLlncn5oYiaSEvOl1H6WWLiT7B68Hcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eSbcgAV3Y4Nf1PTCoyOoe5V+Vtp4xkQRlsSiI+iydi8cwhCeUrWlE3GetaMXfG7gk/8ptuCf/soRiMzgnaOOqLganhsyIAWmEyxh8CLtR76EHKM4BacbV1+ryqSnTWejTInqMaLyhiL1WF93yGYwaIEqLJJSXFnqMuHjqVBbxK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=z+Sy1YXq; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 12E891A3269;
	Fri, 10 Apr 2026 19:52:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DCE1B603F0;
	Fri, 10 Apr 2026 19:52:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 666BE10450087;
	Fri, 10 Apr 2026 21:52:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775850734; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5BPJL0tk60XJvTFqc7UkIf9zLe/TnKCikU2bD7MQXis=;
	b=z+Sy1YXqBqKW9RNdyHm4T42eFduncI180vz2Se0A3By/RvtfTyJUq8jgubLaxHHg/qfaY9
	KG/OcGcdWJ4Yfsv+ZD+EU6uG9vPQ6ATxfaNiHuNOvGC933GK2FZeEeTYvlPq7YinRlqE1T
	oK0yDq+Ykz277yVf0Y+B9iKYhgJxgzgHteriHt0hxCcRxMp/Sot5LwLusIRG6OqfltsyN8
	e0u8P+EsTxFtIUza4tgzhcK9Lvsgzrh/7VZAv7DS65YTQVHf5UgX1wefzBRuFNEzofajUt
	9ygMIgAivJohjlg3QGtfkkVb6Oj9QrjyjMwJPV1QKjcm3QTkYxW51t9H9vfcnA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 10 Apr 2026 21:51:52 +0200
Subject: [PATCH net-next v2 04/14] net: macb: enforce reverse christmas
 tree (RCT) convention
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-macb-context-v2-4-af39f71d40b6@bootlin.com>
References: <20260410-macb-context-v2-0-af39f71d40b6@bootlin.com>
In-Reply-To: <20260410-macb-context-v2-0-af39f71d40b6@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Paolo Valerio <pvalerio@redhat.com>, Conor Dooley <conor@kernel.org>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15.1
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277534-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1A9C33DC254
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enforce the reverse christmas tree convention in those functions:

   macb_tx_error_task()
   gem_rx_refill()
   gem_rx()
   macb_rx_frame()
   macb_init_rx_ring()
   macb_rx()
   macb_rx_pending()
   macb_start_xmit()

The goal is to minimise unrelated diff in future patches.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 61 ++++++++++++++++----------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b0e70f6ce305..c5d8e8f835ba 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1254,20 +1254,19 @@ static dma_addr_t macb_get_addr(struct macb *bp, struct macb_dma_desc *desc)
 
 static void macb_tx_error_task(struct work_struct *work)
 {
-	struct macb_queue	*queue = container_of(work, struct macb_queue,
-						      tx_error_task);
-	bool			halt_timeout = false;
-	struct macb		*bp = queue->bp;
-	unsigned int		q;
-	u32			packets = 0;
-	u32			bytes = 0;
-	struct macb_tx_skb	*tx_skb;
-	struct macb_dma_desc	*desc;
-	struct sk_buff		*skb;
-	unsigned int		tail;
-	unsigned long		flags;
+	struct macb_queue *queue = container_of(work, struct macb_queue,
+						tx_error_task);
+	unsigned int q = queue - queue->bp->queues;
+	struct macb *bp = queue->bp;
+	struct macb_tx_skb *tx_skb;
+	struct macb_dma_desc *desc;
+	bool halt_timeout = false;
+	struct sk_buff *skb;
+	unsigned long flags;
+	unsigned int tail;
+	u32 packets = 0;
+	u32 bytes = 0;
 
-	q = queue - bp->queues;
 	netdev_vdbg(bp->netdev, "macb_tx_error_task: q = %u, t = %u, h = %u\n",
 		    q, queue->tx_tail, queue->tx_head);
 
@@ -1487,11 +1486,11 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 
 static void gem_rx_refill(struct macb_queue *queue)
 {
-	unsigned int		entry;
-	struct sk_buff		*skb;
-	dma_addr_t		paddr;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
+	struct sk_buff *skb;
+	unsigned int entry;
+	dma_addr_t paddr;
 
 	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail,
 			bp->rx_ring_size) > 0) {
@@ -1584,11 +1583,11 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		  int budget)
 {
 	struct macb *bp = queue->bp;
-	unsigned int		len;
-	unsigned int		entry;
-	struct sk_buff		*skb;
-	struct macb_dma_desc	*desc;
-	int			count = 0;
+	struct macb_dma_desc *desc;
+	struct sk_buff *skb;
+	unsigned int entry;
+	unsigned int len;
+	int count = 0;
 
 	while (count < budget) {
 		u32 ctrl;
@@ -1674,12 +1673,12 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 			 unsigned int first_frag, unsigned int last_frag)
 {
-	unsigned int len;
-	unsigned int frag;
+	struct macb *bp = queue->bp;
+	struct macb_dma_desc *desc;
 	unsigned int offset;
 	struct sk_buff *skb;
-	struct macb_dma_desc *desc;
-	struct macb *bp = queue->bp;
+	unsigned int frag;
+	unsigned int len;
 
 	desc = macb_rx_desc(queue, last_frag);
 	len = desc->ctrl & bp->rx_frm_len_mask;
@@ -1755,9 +1754,9 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 
 static inline void macb_init_rx_ring(struct macb_queue *queue)
 {
+	struct macb_dma_desc *desc = NULL;
 	struct macb *bp = queue->bp;
 	dma_addr_t addr;
-	struct macb_dma_desc *desc = NULL;
 	int i;
 
 	addr = queue->rx_buffers_dma;
@@ -1776,9 +1775,9 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 {
 	struct macb *bp = queue->bp;
 	bool reset_rx_queue = false;
-	int received = 0;
-	unsigned int tail;
 	int first_frag = -1;
+	unsigned int tail;
+	int received = 0;
 
 	for (tail = queue->rx_tail; budget > 0; tail++) {
 		struct macb_dma_desc *desc = macb_rx_desc(queue, tail);
@@ -1853,8 +1852,8 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 static bool macb_rx_pending(struct macb_queue *queue)
 {
 	struct macb *bp = queue->bp;
-	unsigned int		entry;
-	struct macb_dma_desc	*desc;
+	struct macb_dma_desc *desc;
+	unsigned int entry;
 
 	entry = macb_rx_ring_wrap(bp, queue->rx_tail);
 	desc = macb_rx_desc(queue, entry);
@@ -2474,10 +2473,10 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	unsigned int q = skb_get_queue_mapping(skb);
 	unsigned int desc_cnt, nr_frags, frag_size, f;
 	struct macb_queue *queue = &bp->queues[q];
+	netdev_tx_t ret = NETDEV_TX_OK;
 	unsigned int hdrlen;
 	unsigned long flags;
 	bool is_lso;
-	netdev_tx_t ret = NETDEV_TX_OK;
 
 	if (macb_clear_csum(skb)) {
 		dev_kfree_skb_any(skb);

-- 
2.53.0


