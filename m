Return-Path: <netdev+bounces-288089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDfADUhIBmo3hwIAu9opvQ
	(envelope-from <netdev+bounces-288089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:10:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC822547595
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BB6F30C74E5
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 21:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947E23D4103;
	Thu, 14 May 2026 21:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b="Mmcpe/7D";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b="EusHgG0p"
X-Original-To: netdev@vger.kernel.org
Received: from acj35aaf85.lhr1.oracleemaildelivery.com (acj35aaf85.lhr1.oracleemaildelivery.com [130.35.116.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C93D3008
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.35.116.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795706; cv=none; b=XJMY8Y/YZKwkH2kjbES+VItXltyIvPuKpe9rTOIIcf2HnPa5LmXwJIefd0dnYN6JeTfObEuYqk7QrzoH28bLoxF71OeVHFWPpQEiXAQkeXBn239sVzpH6VaGCda6ljgD7AUtRO/bGL9cZSH8KUPFZ5sFo8hLyFQcxVdfQExJTyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795706; c=relaxed/simple;
	bh=X5Fn3ohZpoJSJjP5QpCzv40uCoD93rfUnEoLX3OoLMk=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=u7z5sNq2T5iClYME5tEVfjJEva4mDtpI+9wLR9B7nW1CwpZgLXsmMl3NNIK/9sTiSVq/hfluclm3WKtSsxYhQNHvCqoUlOWiFzKgkLdh5g/kxTah4hbpbPA+2aqhbQo2tpUu1YGDbqBwwu7WHJxnPGd4Q004ARfp7hdF3GsYmvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b=Mmcpe/7D; dkim=pass (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b=EusHgG0p; arc=none smtp.client-ip=130.35.116.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oracle-uk-012026;
 d=raczylo.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=bJPU9678+y1cp2+iUvq03ogPthNxCP++IVi7e5ZAngg=;
 b=Mmcpe/7Du3DMmEvDHEh1Jd98F8lMVVHjtvPzGyklUoJyKJwsU4UCA22jjo1feimfO2gvkj1tFznt
   SM6yn1rbOxCa57bHG9DCuspDFyRx9VCGgbInMg569tNerBDyvu1u9zpyp+zZAZbvIJhfd9W76Inz
   yUVQ2ExvixcVz/lLcRa/B2svpu8TPZNJqM+ckJQ4BLdjynnnpqz0nrSRlMnwN1yPNwQN+3w0ib55
   G/QBGQ7u/X3/BAXuMhTSJXE/KWFASNB1DY2jPP5PAPxlyAMdndMyPsm12gIc2GVhN5zl6kW+Bc1y
   UevkweA3addoL/DlIwneaf4T/FKREBd2rzWXWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-lhr-20191104;
 d=lhr1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=bJPU9678+y1cp2+iUvq03ogPthNxCP++IVi7e5ZAngg=;
 b=EusHgG0pmf0laHpkS516Bc36r0Tj4DRprzrtfvqpF037S1kOJb8OAQ4PObPNiLmGzDZZuzBYM27G
   FjLMFOKbwhEEbqe4/ziyX/S0Sitt8sQYgwMHR/8wDmR1SOADPi3E59cn0E10rC60bQzNjo3pKFvV
   M4w8bOxzRB1GQrwnAjRjz0idX79aHa/ws5m7vhRxtSOApL7fxk1LPOWkQ3txgE9NTWyWcrvRMLKJ
   I/aUbZwgcQhF6wlLdFKE0giG55Sf4koAq2+bpb4R98JgLrU2uIKifU+g9LfiS4UKvG10ZuLXcWY6
   jDMTPlm3jjYLZ/o4fAo/DUKUKA8cHyy9ArI/hA==
Received: by omta-ad2-fd2-1402-uk-london-1.omtaad2.vcndplhr.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20260212 64bit (built Feb 12
 2026))
 with ESMTPS id <0TF10888CRJO6EE0@omta-ad2-fd2-1402-uk-london-1.omtaad2.vcndplhr.oraclevcn.com> for
 netdev@vger.kernel.org; Thu, 14 May 2026 21:55:00 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Lukasz Raczylo <lukasz@raczylo.com>
To: netdev@vger.kernel.org
Cc: Theo Lebrun <theo.lebrun@bootlin.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,	linux-rpi-kernel@lists.infradead.org
Subject: [PATCH net-next v2 1/3] net: macb: flush PCIe posted write after
 TSTART doorbell (PCIe-only)
Date: Thu, 14 May 2026 22:54:57 +0100
Message-id: <20260514215459.36109-2-lukasz@raczylo.com>
X-Mailer: git-send-email 2.54.0
In-reply-to: <20260514215459.36109-1-lukasz@raczylo.com>
References: <cover.1777064117.git.lukasz@raczylo.com>
 <20260514215459.36109-1-lukasz@raczylo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHf+Z0YX8zBMsksb6gSGL9ZV3VCbo9am2PhbSO1iipMaVnbSZPP4U7YWpbXzRHK
 g669lhZ1JQctwueluqlyYAuNG1sS6Qw9c23DubPxpYwzUcT/ijmsxuMtszhnzf26
 IgemJgq4nn+43nDKHtA1F3RaGDFOAqYTa9QF3z05exHW9IA3UWF07U5b1qryYN9k
 W8Mg5Qd/FTurdIFQGySgGKFTNfyR2Jk6EOPtirmIKL/mezUoN/TtZw1DE8LB+1nw
 Lh2SkPpoZNIiSCKIxY37etdiW7MleIVh599YZ+MuFrjcdfCQ/URx3zApn1OPNEmC
 5drO25UKe+gySG4lrV3nREhZ/c5AINu+k4RaqAzgB5BB6qEMte4LBzcQCMFFcTys
 RY5Oni/UvS9+v+5an4IQO150Wvp9HFHxxU765tSWoP4ftUuQOiQ88VPPnbpwPLM=
X-Rspamd-Queue-Id: BC822547595
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[raczylo.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[raczylo.com:s=oracle-uk-012026,lhr1.rp.oracleemaildelivery.com:s=prod-lhr-20191104];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-288089-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[raczylo.com:-,lhr1.rp.oracleemaildelivery.com:-];
	FROM_NEQ_ENVFROM(0.00)[lukasz@raczylo.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_SPAM(0.00)[0.907];
	DBL_BLOCKED_OPENRESOLVER(0.00)[launchpad.net:url,raczylo.com:email,raczylo.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

macb_start_xmit() and macb_tx_restart() kick transmission by
OR-ing MACB_BIT(TSTART) into NCR.  On PCIe-attached macb
instances (BCM2712 + RP1 PCIe south bridge on Raspberry Pi 5 is
the case I have in front of me), writes to NCR are posted PCIe
writes: they are not guaranteed to reach the device before the
issuing CPU returns.  If the TSTART doorbell does not reach the
MAC, no TX begins, no TCOMP completion arrives, and the ring
remains quiescent without any kernel-visible indication.

Add a read-back of NCR after each TSTART write.  The read is an
architected PCIe read barrier for earlier posted writes on the
same path; it ensures the doorbell has reached the MAC before
the function returns.  As a side effect on macb_start_xmit() it
also flushes the preceding macb_tx_lpi_wake() NCR write -- not
just TSTART -- since the barrier applies to all prior posted
writes by the same requester.

The cost is one non-posted PCIe read per TSTART.  To avoid
imposing this on SoC-integrated macb variants (Atmel, Microchip,
SiFive, Xilinx), where NCR is on-chip MMIO and no fabric
posted-write concern exists, gate the readback behind a new
MACB_CAPS_PCIE_POSTED_WRITES capability set only on
raspberrypi_rp1_config.

Note that the raspberrypi/linux vendor fork carries a local
patch around the TSTART site (a queue->tx_pending breadcrumb
that is promoted to queue->txubr_pending by the next TCOMP
interrupt, triggering macb_tx_restart()).  That workaround makes
the loss recoverable under traffic, but it cannot help if TCOMP
itself is not raised because no TX started -- which is exactly
the case targeted here.  The handshake is not present in
mainline.

Link: https://github.com/cilium/cilium/issues/43198
Link: https://bugs.launchpad.net/ubuntu/+source/linux-raspi/+bug/2133877
Signed-off-by: Lukasz Raczylo <lukasz@raczylo.com>
---
 drivers/net/ethernet/cadence/macb.h      |  4 ++++
 drivers/net/ethernet/cadence/macb_main.c | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 2de56017e..ce9037f9e 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -791,6 +791,10 @@
 #define MACB_CAPS_USRIO_HAS_MII			BIT(26)
 #define MACB_CAPS_USRIO_HAS_REFCLK_SOURCE	BIT(27)
 #define MACB_CAPS_USRIO_HAS_TSUCLK_SOURCE	BIT(28)
+/* Register writes are posted on the parent fabric and need a non-posted
+ * read-back to guarantee delivery.  Currently set only on RP1.
+ */
+#define MACB_CAPS_PCIE_POSTED_WRITES		BIT(29)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index a12aa2124..6879f3458 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1922,6 +1922,14 @@ static void macb_tx_restart(struct macb_queue *queue)
 
 	spin_lock(&bp->lock);
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
+	/*
+	 * On PCIe-attached parts, flush the posted-write queue so the
+	 * TSTART doorbell reliably reaches the MAC.  Without this the
+	 * write can sit in the fabric and the MAC never advances,
+	 * causing a silent TX stall.
+	 */
+	if (bp->caps & MACB_CAPS_PCIE_POSTED_WRITES)
+		(void)macb_readl(bp, NCR);
 	spin_unlock(&bp->lock);
 
 out_tx_ptr_unlock:
@@ -2560,6 +2568,12 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	spin_lock(&bp->lock);
 	macb_tx_lpi_wake(bp);
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
+	/*
+	 * Flush PCIe posted-write queue; see comment in macb_tx_restart().
+	 * Also flushes the preceding macb_tx_lpi_wake() NCR write.
+	 */
+	if (bp->caps & MACB_CAPS_PCIE_POSTED_WRITES)
+		(void)macb_readl(bp, NCR);
 	spin_unlock(&bp->lock);
 
 	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
@@ -5674,6 +5688,7 @@ static const struct macb_config raspberrypi_rp1_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_CLK_HW_CHG |
 		MACB_CAPS_JUMBO |
 		MACB_CAPS_GEM_HAS_PTP |
+		MACB_CAPS_PCIE_POSTED_WRITES |
 		MACB_CAPS_EEE |
 		MACB_CAPS_USRIO_HAS_MII,
 	.dma_burst_length = 16,
-- 
2.54.0


