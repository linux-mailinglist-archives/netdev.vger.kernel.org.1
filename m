Return-Path: <netdev+bounces-281064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMPkJPHw62nWTAAAu9opvQ
	(envelope-from <netdev+bounces-281064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 00:38:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6AE463D4D
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 00:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D1FC300E265
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 22:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E18341ADD;
	Fri, 24 Apr 2026 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b="TSogRzS1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b="K6Lrzat6"
X-Original-To: netdev@vger.kernel.org
Received: from acj35aaf125.lhr1.oracleemaildelivery.com (acj35aaf125.lhr1.oracleemaildelivery.com [130.35.116.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39079337688
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.35.116.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777070318; cv=none; b=opaeCeJSVjnfIWujaPZ7P+d1tiGV38Je9aSEUqJFbBveEoP7UVZH69Z6hDRzNZ1pkf61inZnUYNTqfZXd3zNks2k5GaaY+Cxkwkl0zPJTXHVqfDH99jOpy4oc7StcOKd1qSdomykd4ZTfdzhhQ7IRkxPm0z0dFK/pJuWwkiP94A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777070318; c=relaxed/simple;
	bh=7xxX0CkMupQcfPTzee8ry5FcQlhHy6640eeW3exSrBA=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=OPET/3VJGY5ociaWd7XIUDKARQXqtanIvnACQRbHLAn+hu5rlbl4Vb9bNATY6k+zFjHjLw0Zj1kAwGeBaDmnaiur72VEWnW7Z2OwWl3wYF2+xqj+wz7s0rCbbkGteKjzx07WgTWhADVdSiQXZbFTwCb8bd5Yfj1vqtXr6xPS19o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b=TSogRzS1; dkim=pass (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b=K6Lrzat6; arc=none smtp.client-ip=130.35.116.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oracle-uk-012026;
 d=raczylo.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=G7jLGar8TG1IVsYdC7k9CyHPoJnsdAXy6l5eRrUEDPc=;
 b=TSogRzS1n1mycUmGkpmYO5lL143T5F2DMNbAzHxby4VN9n+lBPx4X1pxHYIWS4Yz8SWQ6CxJhGZp
   mm/8BqKibo+dj2yRBdedcLA7b3fh5EPg+ccD2MMR9an2M4CXHNs7UV2eDjHsh13BfbU/V9WAztdV
   iQ+UCZbuIDOCD2svSrwc+XP1hA3zPF1JfEFtnsRbmoTbyqaNwR+M2bHurgFh/NwbUpTVAS9PzpKV
   49+Ck2rXbp3S1gSsRSxK0f5GM/VQ31HtHoOgAuMp0g4AksPZ26Ni8tw8rp4fMr0+Oiu1r8J3bwk7
   Ib1HCo+M/ZkbT6nEqruSNs3pw2KtTfHwfLJxxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-lhr-20191104;
 d=lhr1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=G7jLGar8TG1IVsYdC7k9CyHPoJnsdAXy6l5eRrUEDPc=;
 b=K6Lrzat6IjmF3/fCzjVKWErIcKFurJsh9BWs8qg6DrOLMapseRWURZaUGx6w96Wni29md4zpbZBS
   igEXTi9UTIqixe0TH+Si302yJzZvWxDZmaNukN69ndI8duiBJTo5KFH3Uj3nTX6xHNRRHROj64hH
   jLnPYeDKqfMgy7vkPSfdHB9+kmvL+8VdEMZbXtjTLn9WgygrW24yatazGbmd+ltBuNkxUQ+Exccg
   eC4ICio5PYR5w/PbN7uS+xVEaW4xBj0qOyMPraOY+jwNO5eqT392nfo/5ml6VahfCNonp/k+Iqww
   h7dLoLOkHIHdFmxKv1lOuQasu8vsL7i/cwfOkQ==
Received: by omta-ad1-fd2-401-uk-london-1.omtaad1.vcndplhr.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20260212 64bit (built Feb 12
 2026))
 with ESMTPS id <0TE0005VUS8A7ZE0@omta-ad1-fd2-401-uk-london-1.omtaad1.vcndplhr.oraclevcn.com> for
 netdev@vger.kernel.org; Fri, 24 Apr 2026 22:38:34 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Lukasz Raczylo <lukasz@raczylo.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,	linux-rpi-kernel@lists.infradead.org
Subject: [RFC PATCH net-next 1/3] net: macb: flush PCIe posted write after
 TSTART doorbell
Date: Fri, 24 Apr 2026 23:38:31 +0100
Message-id:
 <3106d546d494f2f52ec832e7f7d04f534286e254.1777064117.git.lukasz@raczylo.com>
X-Mailer: git-send-email 2.53.0
In-reply-to: <cover.1777064117.git.lukasz@raczylo.com>
References: <cover.1777064117.git.lukasz@raczylo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFzDiYTuS9jvqSCDQoXiqVnkU2yDl7DFh57yZB8VktRLO86c1eFyO5ekvNWCLwV
 PHyd9gw8WA5srfV/TRAF0XPcqN0ckK5QcJIF7eobe03u2sRYs57fa3Mgmg2gAtMw
 1CT7xUBuqHay+QGcBkLVevgREbdvX1cGfWq/pj43bFZqOKH7jp3vStUCpFn3WnqV
 TyGYwGpmpEoP9tMuixXrpE2OujxyjmkJjmge/RsB5fLCB/drQzdkkH4AuS/ipJKk
 0RySA/KdV3OpQ2gZrrNZCCa3WiCohIFMCKYGaLEacN0QZBrdCcc8iPUNce3IAcGf
 fxWvkC+id2HOacV04teARomQrNeXUQmRGPKZ/ZT3wcfkMLKNdUE7efBM/EkwoXJw
 XV9gjqUV6s/ge8dwcHoSco74Y2yDf7H3Ua+uDwEQX9UaKavseF06+TkUOp99
X-Rspamd-Queue-Id: DF6AE463D4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[raczylo.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[raczylo.com:s=oracle-uk-012026,lhr1.rp.oracleemaildelivery.com:s=prod-lhr-20191104];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	TAGGED_FROM(0.00)[bounces-281064-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz@raczylo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[raczylo.com:-,lhr1.rp.oracleemaildelivery.com:-];
	NEURAL_HAM(-0.00)[-0.812];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,launchpad.net:url,raczylo.com:mid,raczylo.com:email]

macb_start_xmit() and macb_tx_restart() kick transmission by
OR-ing MACB_BIT(TSTART) into NCR.  On PCIe-attached macb instances
(BCM2712 + RP1 PCIe south bridge on Raspberry Pi 5 is the setup we
have in front of us), writes to NCR are posted PCIe writes: they
are not guaranteed to reach the device before the issuing CPU
returns.  If the TSTART doorbell does not reach the MAC, no TX
begins, no TCOMP completion arrives, and the ring remains
quiescent without any kernel-visible indication.

Note that the raspberrypi/linux vendor fork carries a local patch
around the TSTART site (a queue->tx_pending breadcrumb that is
promoted to queue->txubr_pending by the next TCOMP interrupt,
triggering macb_tx_restart()).  That workaround makes the loss
recoverable under traffic, but it cannot help if TCOMP itself is
not raised because no TX started -- which is exactly the case we
are targeting here.  The handshake is not present in mainline.

Add a read-back of NCR after each TSTART write in macb_start_xmit()
and macb_tx_restart().  The read is an architected PCIe read
barrier for earlier posted writes on the same path; it ensures the
doorbell has reached the MAC before the functions return.

We do not yet have direct hardware evidence that TSTART is being
lost on the RP1 path (that would require a PCIe protocol analyser,
or at minimum a before/after counter on queue->tx_stall_last_tail
with and without this patch applied in isolation).  This patch is
one of a three-patch series ("candidate fixes for silent TX stall
on BCM2712/RP1"); see the cover letter for context.  We have
verified the series compiles and applies cleanly against mainline
HEAD and against raspberrypi/linux rpi-6.18.y @ f2f68e79f16f;
runtime verification is pending.

Link: https://github.com/cilium/cilium/issues/43198
Link: https://bugs.launchpad.net/ubuntu/+source/linux-raspi/+bug/2133877
Signed-off-by: Lukasz Raczylo <lukasz@raczylo.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index a12aa2124..b6cca55ad 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1922,6 +1922,13 @@ static void macb_tx_restart(struct macb_queue *queue)
 
 	spin_lock(&bp->lock);
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
+	/*
+	 * Flush the PCIe posted-write queue so the TSTART doorbell
+	 * reliably reaches the MAC.  Without this, the write can sit
+	 * in the fabric and the MAC never advances, causing a silent
+	 * TX stall.
+	 */
+	(void)macb_readl(bp, NCR);
 	spin_unlock(&bp->lock);
 
 out_tx_ptr_unlock:
@@ -2560,6 +2567,11 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	spin_lock(&bp->lock);
 	macb_tx_lpi_wake(bp);
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
+	/*
+	 * Flush the PCIe posted-write queue; see the comment in
+	 * macb_tx_restart() for the reasoning.
+	 */
+	(void)macb_readl(bp, NCR);
 	spin_unlock(&bp->lock);
 
 	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
-- 
2.53.0


