Return-Path: <netdev+bounces-286744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEKPOXEVAmr+ngEAu9opvQ
	(envelope-from <netdev+bounces-286744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:44:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4934B513AE0
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 021A9312F3B2
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708CB43C074;
	Mon, 11 May 2026 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PyW0zfGz"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898D7438FF1
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518278; cv=none; b=aOsJmwTF6v3Thw352UwVVyevuXPI49ms71QNCaFPmHz/4ud51eYGF5THIA9ZJ+yrqDvLynKxjIXBrVy4G1RlclUBe5ROhgrPdsO8/OgQDmgwts7cg4ydnwY34Jr6G3DrBQ0SWysB0X0/sqjh8PBagotGLZULaOw8jFHfaZEFSI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518278; c=relaxed/simple;
	bh=BCZWxwIaK3dc0G8cmCU4n/FQGfystTZsg3Df5O+4iEc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=igOOD56ZPUlR0jhPDuh5a5+tbFMh8GZFCOOvgVdYgkkouBQWo4dkvw7VgF6j+2rJbkPgsqbuy7HJw9kDzPw46togHoEaFtZncPKhyAizoW/gcUEC3VEHHr2/pZHnguuKxu6vv0A+taBzfRvLiyw38gke18gEMvDm7Y1HnoVvlnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=PyW0zfGz; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260511165107euoutp02a1f52466e89ed9ffdbf76510bb50078c~ukPESZ9Zg2270322703euoutp02c
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 16:51:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260511165107euoutp02a1f52466e89ed9ffdbf76510bb50078c~ukPESZ9Zg2270322703euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1778518267;
	bh=s82Ys0O+LBzr8TEdQCyvmso4MfpaUCT1Vf9SllYbqWk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=PyW0zfGzCJrRCFZiZiWp7be17dqfHT5MzSGOPM2HJ9Cwe81BJZZILuVZeukNgpPel
	 8xrFi1iToC3+KR6IoJXND2j8GH4I7BTkqpdOxVQ19EkC+V3FqkwS1TEzH5fKo0SAkZ
	 MDx0UY0zaYhgpPtapQq8aYuNs0nU75U/ZJcUjUBc=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260511165107eucas1p1882391435991ffc19670a60a43bbde01~ukPD7D08L2499324993eucas1p17;
	Mon, 11 May 2026 16:51:07 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260511165106eusmtip27fcbc128b327ecadec7f7aeae11efec7~ukPDQoo5J2954729547eusmtip24;
	Mon, 11 May 2026 16:51:06 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	k.domagalski@samsung.com, k.tegowski@samsung.com, Jakub Raczynski
	<j.raczynski@samsung.com>, Chang-Sub Lee <cs0617.lee@samsung.com>
Subject: [PATCH net] net/stmmac: Fix free-after-use panic when interface
 goes does with XDP
Date: Mon, 11 May 2026 18:50:45 +0200
Message-Id: <20260511165045.3091475-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260511165107eucas1p1882391435991ffc19670a60a43bbde01
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260511165107eucas1p1882391435991ffc19670a60a43bbde01
X-EPHeader: CA
X-CMS-RootMailID: 20260511165107eucas1p1882391435991ffc19670a60a43bbde01
References: <CGME20260511165107eucas1p1882391435991ffc19670a60a43bbde01@eucas1p1.samsung.com>
X-Rspamd-Queue-Id: 4934B513AE0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,samsung.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286744-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[samsung.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,samsung.com:mid,samsung.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
page pools while NAPI/XDP could still be accessing these resources in the
background.

Fix this by following:
- Set STMMAC_DOWN flag before stopping DMA to signal XDP to stop
- Call synchronize_rcu() after stopping DMA but before freeing resources to
  ensure all ongoing NAPI operations complete
- Add STMMAC_DOWN flag checks in XDP code paths (XDP_TX and XDP_REDIRECT) to
  drop packets when interface is going down. This has already been done for
  stmmac_xdp_xmit() so make it consistent
- Clear STMMAC_DOWN flag in __stmmac_open() to restore normal operation.
  This was only done for stmmac_reset_subtask() during abnormal operation,
  which is not enough. This does not affect normal operation as this flag is
  used only for XDP apps

Co-developed-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3591755ea30b..3b7b7b0cab9b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4147,6 +4147,9 @@ static int __stmmac_open(struct net_device *dev,
 
 	stmmac_reset_queues_param(priv);
 
+	/* Clear DOWN flag when opening the interface */
+	clear_bit(STMMAC_DOWN, &priv->state);
+
 	ret = stmmac_hw_setup(dev);
 	if (ret < 0) {
 		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
@@ -4251,9 +4254,18 @@ static void __stmmac_release(struct net_device *dev)
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
 
+	/* Set DOWN flag to prevent XDP from processing new packets */
+	set_bit(STMMAC_DOWN, &priv->state);
+
 	/* Stop TX/RX DMA and clear the descriptors */
 	stmmac_stop_all_dma(priv);
 
+	/* Ensure NAPI has finished before freeing resources.
+	 * This prevents use-after-free when NAPI is mid-execution
+	 * accessing TX/RX ring buffers and page pool during ifconfig down.
+	 */
+	synchronize_rcu();
+
 	/* Release and free the Rx/Tx resources */
 	free_dma_desc_resources(priv, &priv->dma_conf);
 
@@ -5267,6 +5279,9 @@ static int stmmac_xdp_xmit_back(struct stmmac_priv *priv,
 	if (unlikely(!xdpf))
 		return STMMAC_XDP_CONSUMED;
 
+	if (unlikely(test_bit(STMMAC_DOWN, &priv->state)))
+		return -ENETDOWN;
+
 	queue = stmmac_xdp_get_tx_queue(priv, cpu);
 	nq = netdev_get_tx_queue(priv->dev, queue);
 
@@ -5308,7 +5323,9 @@ static int __stmmac_xdp_run_prog(struct stmmac_priv *priv,
 		res = stmmac_xdp_xmit_back(priv, xdp);
 		break;
 	case XDP_REDIRECT:
-		if (xdp_do_redirect(priv->dev, xdp, prog) < 0)
+		if (unlikely(test_bit(STMMAC_DOWN, &priv->state)))
+			res = STMMAC_XDP_CONSUMED;
+		else if (xdp_do_redirect(priv->dev, xdp, prog) < 0)
 			res = STMMAC_XDP_CONSUMED;
 		else
 			res = STMMAC_XDP_REDIRECT;
-- 
2.34.1


