Return-Path: <netdev+bounces-305555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0uwHMn07TWqnxAEAu9opvQ
	(envelope-from <netdev+bounces-305555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 19:46:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1C871E625
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 19:46:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=MQEN2kXJ;
	dmarc=pass (policy=none) header.from=samsung.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305555-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305555-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4278D300C001
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 17:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC9443E9F4;
	Tue,  7 Jul 2026 17:46:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE18C43C7A4
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:45:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446361; cv=none; b=eYHkvTsvvJ65BmtrAJTd0uFfjp8WeLzY8Cu9Zh/jacMdUA4wkd7zQfFpk3Hfp4tdfye9lmd9ol7nPMpww/wGw66F99j/2K4Rt4NT5QLtg5UuGdKAFsmCovS1Mj0tJgXhvkaEqFezvVZsAnqdFjtiw6IxmKxoo0bZt0SjxnnMR1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446361; c=relaxed/simple;
	bh=zgf6bYj2qzoxiVAmp6lF++UBvv8mYszlAZyhPneA22U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=d+q0M0Zi0LrFhKfg6y6ivfOz2kqRh9S4Uw3Us3CPkjYr4m02frskQFNogJ5hDpFvMt3ZgenWGBtLbKUIAGtITeG6hsoiW2qy47NqCKEX6JXvd3F3Lp0P7yh31yjYfN9B0QInBfFzFgOnQGCzvqALD3Kk+hqOBIAhY/uGq5o+WsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MQEN2kXJ; arc=none smtp.client-ip=210.118.77.12
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260707174557euoutp0271b2ce0d31a084d0ec3efc788228bd94~AEwNWI5o02060220602euoutp02q
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:45:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260707174557euoutp0271b2ce0d31a084d0ec3efc788228bd94~AEwNWI5o02060220602euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783446357;
	bh=Rm9MRGSl4GczQZf6rw7zLloar1+rboEsZM2ZEp7jaAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MQEN2kXJq8lzQPqaPbvmZBWkvIBAa9Jqf60VpiuIhk1mgwV9VaZsUqoU77z+//Wx9
	 H/yhb1wNSBcUe+yNsRdl+30Y256Ig4TtZLXuJ4Y4hFR2Lcnyhdng2e5VR4H0G0Ljk/
	 W4AL0CTrNYrIpgv9XLPPS2a9kogB56QNeyYALzYY=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260707174556eucas1p2fd039c22df294462f75715f490d6559c~AEwM34DsU2928629286eucas1p29;
	Tue,  7 Jul 2026 17:45:56 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260707174556eusmtip26f81bf233f44fb324944fb9100858ea6~AEwMN8hge2398923989eusmtip2Z;
	Tue,  7 Jul 2026 17:45:56 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: k.tegowski@samsung.com, k.domagalski@samsung.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jakub
	Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net v3 2/2] net/stmmac: Fix free-after-use panic when
 interface goes does with XDP
Date: Tue,  7 Jul 2026 19:45:51 +0200
Message-Id: <20260707174551.1264558-3-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707174551.1264558-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260707174556eucas1p2fd039c22df294462f75715f490d6559c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260707174556eucas1p2fd039c22df294462f75715f490d6559c
X-EPHeader: CA
X-CMS-RootMailID: 20260707174556eucas1p2fd039c22df294462f75715f490d6559c
References: <20260707174551.1264558-1-j.raczynski@samsung.com>
	<CGME20260707174556eucas1p2fd039c22df294462f75715f490d6559c@eucas1p2.samsung.com>
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-305555-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:k.tegowski@samsung.com,m:k.domagalski@samsung.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:j.raczynski@samsung.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[samsung.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org,vger.kernel.org];
	DKIM_TRACE(0.00)[samsung.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,samsung.com:from_mime,samsung.com:email,samsung.com:mid,samsung.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E1C871E625

When running XDP forwarding and interface gets shut down, kernel might panic
or show SLUB "poison overwritten" errors due to a race condition between
NAPI polling and resource freeing.

Observed error is one of following:
- Poison overwrriten
[ 1889.547746] eth1: Link is Down
[ 1889.549940] =============================================================================
[ 1889.549954] BUG kmalloc-4k (Tainted: G    B             ): Poison overwritten
[ 1889.549959] -----------------------------------------------------------------------------
[ 1889.549963] 0xffffff882dcc4d80-0xffffff882dcc4da7 @offset=19840. First byte 0x0 instead of 0x6b
[ 1889.549969] Allocated in __alloc_dma_tx_desc_resources+0x60/0x10c [stmmac] age=169 cpu=7 pid=27759
[ 1889.550020]  __kmem_cache_alloc_node+0x100/0x2e8
[ 1889.550032]  __kmalloc+0x58/0x1a0
[ 1889.550039]  __alloc_dma_tx_desc_resources+0x60/0x10c [stmmac]
[ 1889.550052]  alloc_dma_desc_resources+0xec/0x164 [stmmac]
[ 1889.550064]  stmmac_setup_dma_desc+0xec/0x1e4 [stmmac]
[ 1889.550076]  stmmac_open+0x28/0x94 [stmmac]
[...]

- Wrong memory address
[ 1901.546692] Unable to handle kernel paging request at virtual address dead000000000122
[...]
[ 1902.964068] Call trace:
[ 1902.967193]  free_to_partial_list+0x560/0x600
[ 1902.972227]  __slab_free+0x1a8/0x420
[ 1902.976480]  __kmem_cache_free+0x204/0x218
[ 1902.981254]  kfree+0x6c/0x128
[ 1902.984900]  kvfree+0x3c/0x4c
[ 1902.988545]  page_pool_release+0x234/0x27c
[ 1902.993320]  page_pool_destroy+0xcc/0x190
[ 1902.998006]  __free_dma_rx_desc_resources+0x100/0x360 [stmmac]
[ 1903.004516]  free_dma_desc_resources+0x8c/0xac [stmmac]
[ 1903.010419]  stmmac_release+0x1c0/0x2b4 [stmmac]
[...]

Root cause is stmmac_release() stops DMA and frees TX/RX ring buffers and
page pools while XDP could still be accessing these resources in the
background, because napi_synchronize() from napi_disable() does not ensure
XDP is done.

This makes small window where IRQ is still possible after NAPI has finished.
Problem is that stmmac_release() handles closing XDP in different order than
stmmac_xdp_disable_pool(), which is not affected by this issue, where
synchronize_rcu() is executed after napi_disable() and disable_rx/tx_queue().

Fix this by following:
- Set STMMAC_DOWN flag before stopping DMA to signal XDP to stop and discard
- Call synchronize_rcu() after stopping DMA but before freeing resources to
  ensure all ongoing NAPI operations complete, in similar order to
  stmmac_xdp_disable_pool()
- Clear STMMAC_DOWN flag in __stmmac_open() to restore normal operation.
  This was only done for stmmac_reset_subtask() during abnormal operation,
  which is not enough. This flag does not affect normal operation as it is
  used only for XDP apps. Usage of such flags is far from optimal and would
  be good to rewrite, but it would be quite an effort

Also replace stmmac_disable_all_queues() with __stmmac_disable_all_queues(),
as it is barren after this change.

Fixes: bba2556efad66 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Co-developed-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 28 ++++++++++++++-----
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b9ffff001baf..9d971ae35d48 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -262,7 +262,11 @@ static void stmmac_verify_args(void)
 		pr_warn("stmmac: module parameter 'flow_ctrl' is obsolete - please remove from your module configuration\n");
 }
 
-static void __stmmac_disable_all_queues(struct stmmac_priv *priv)
+/**
+ * stmmac_disable_all_queues - Disable all queues
+ * @priv: driver private structure
+ */
+static void stmmac_disable_all_queues(struct stmmac_priv *priv)
 {
 	u8 rx_queues_cnt = priv->plat->rx_queues_to_use;
 	u8 tx_queues_cnt = priv->plat->tx_queues_to_use;
@@ -286,16 +290,15 @@ static void __stmmac_disable_all_queues(struct stmmac_priv *priv)
 }
 
 /**
- * stmmac_disable_all_queues - Disable all queues
+ * stmmac_drain_xdp - Cleanup for XDP apps
  * @priv: driver private structure
  */
-static void stmmac_disable_all_queues(struct stmmac_priv *priv)
+static void stmmac_drain_xdp(struct stmmac_priv *priv)
 {
 	u8 rx_queues_cnt = priv->plat->rx_queues_to_use;
 	struct stmmac_rx_queue *rx_q;
 	u8 queue;
 
-	/* synchronize_rcu() needed for pending XDP buffers to drain */
 	for (queue = 0; queue < rx_queues_cnt; queue++) {
 		rx_q = &priv->dma_conf.rx_queue[queue];
 		if (rx_q->xsk_pool) {
@@ -303,8 +306,6 @@ static void stmmac_disable_all_queues(struct stmmac_priv *priv)
 			break;
 		}
 	}
-
-	__stmmac_disable_all_queues(priv);
 }
 
 /**
@@ -4149,6 +4150,9 @@ static int __stmmac_open(struct net_device *dev,
 
 	stmmac_reset_queues_param(priv);
 
+	/* Clear DOWN flag when opening the interface */
+	clear_bit(STMMAC_DOWN, &priv->state);
+
 	ret = stmmac_hw_setup(dev);
 	if (ret < 0) {
 		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
@@ -4243,6 +4247,9 @@ static void __stmmac_release(struct net_device *dev)
 	/* Stop and disconnect the PHY */
 	phylink_stop(priv->phylink);
 
+	/* Set DOWN flag to prevent XDP from processing new packets */
+	set_bit(STMMAC_DOWN, &priv->state);
+
 	stmmac_disable_all_queues(priv);
 
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
@@ -4256,6 +4263,8 @@ static void __stmmac_release(struct net_device *dev)
 	/* Stop TX/RX DMA and clear the descriptors */
 	stmmac_stop_all_dma(priv);
 
+	stmmac_drain_xdp(priv);
+
 	/* Release and free the Rx/Tx resources */
 	free_dma_desc_resources(priv, &priv->dma_conf);
 
@@ -6412,7 +6421,7 @@ static int stmmac_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
 	if (!tc_cls_can_offload_and_chain0(priv->dev, type_data))
 		return ret;
 
-	__stmmac_disable_all_queues(priv);
+	stmmac_disable_all_queues(priv);
 
 	switch (type) {
 	case TC_SETUP_CLSU32:
@@ -7122,6 +7131,9 @@ void stmmac_xdp_release(struct net_device *dev)
 	/* Stop TX/RX DMA channels */
 	stmmac_stop_all_dma(priv);
 
+	/* Drain leftover XDP buffers */
+	stmmac_drain_xdp(priv);
+
 	/* Release and free the Rx/Tx resources */
 	free_dma_desc_resources(priv, &priv->dma_conf);
 
@@ -8208,6 +8220,8 @@ int stmmac_suspend(struct device *dev)
 	/* Stop TX/RX DMA */
 	stmmac_stop_all_dma(priv);
 
+	stmmac_drain_xdp(priv);
+
 	stmmac_legacy_serdes_power_down(priv);
 
 	/* Enable Power down mode by programming the PMT regs */
-- 
2.34.1


