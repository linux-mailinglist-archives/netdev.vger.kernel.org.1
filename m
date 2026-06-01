Return-Path: <netdev+bounces-293841-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNdpLJe3HWrKdAkAu9opvQ
	(envelope-from <netdev+bounces-293841-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:47:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A36B9622C5E
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E23B3049330
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 16:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289B530F533;
	Mon,  1 Jun 2026 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eqDM2KZ5"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A0328DB49
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331599; cv=none; b=oLXVfqk4useP5XU1gWJcHyW5CyGxlhQ5TM1KJB81yFyNS5nLON72rfw/zPmuYH+QNDPaTj6FQcz7BeI/CF3jz995ngl7DdHO5lzL6Am5+Ql3DVSBQQsvIktP6DUe/+9bkIra6O+l4ynARhaazwuAiBgOiEss0sODwKJkioMvKNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331599; c=relaxed/simple;
	bh=R6oacgb6u+FRUbMIy1SL1+zpCgVvtYUvK98RFmsd68Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=TIQwhRldSKamvjwgPufBGvJwiGdVRZhQjSDRZYlNX1mADJ2juZW5YTdoLVCWN5WIMmpUH6RT+v0MNTGkqKdlpqd7x0melm+YWOfOQ6HqGAwiA/HgxO7ydusCWPOR2vnYHnchU8Dt+uEb/zoitGi+3AEcT6vjAmmMiCsyCcb1k/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eqDM2KZ5; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260601163315euoutp017c44e9f8aa9b53530903c7bab2b937a8~1AidCVADe1557815578euoutp01S
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 16:33:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260601163315euoutp017c44e9f8aa9b53530903c7bab2b937a8~1AidCVADe1557815578euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780331595;
	bh=WUIaUx0rGITov71rKu++SndRUhrql//BJqKiXQZ3MBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eqDM2KZ5ikR38Hfv5T4zfpub2KIWAgxRN3URFQkk7F6vwopcE/viJLkbJo5zrstQu
	 d2JhtUNDsirn691kUrLHXrwJ5ZhOLlZ9vPB7vOwlZ+CH+mTeDlEwVk41Jxrun8Y/II
	 AIIRsuia2/lMCnNGIDAkpsvkCCDN+RZqIhPfH2eI=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260601163314eucas1p2974abe77a39e7fad5ef125f20fd48aa4~1AicCy9r80909509095eucas1p29;
	Mon,  1 Jun 2026 16:33:14 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260601163313eusmtip11b6885ad49566f84e192958a2cb1ddcc~1Aia-v6l91059310593eusmtip1C;
	Mon,  1 Jun 2026 16:33:13 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
	k.domagalski@samsung.com, k.tegowski@samsung.com, cs0617.lee@samsung.com,
	Jakub Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net-next v2 2/2] net/stmmac: Fix free-after-use panic when
 interface goes down
Date: Mon,  1 Jun 2026 18:32:58 +0200
Message-Id: <20260601163258.554300-3-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260601163258.554300-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260601163314eucas1p2974abe77a39e7fad5ef125f20fd48aa4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260601163314eucas1p2974abe77a39e7fad5ef125f20fd48aa4
X-EPHeader: CA
X-CMS-RootMailID: 20260601163314eucas1p2974abe77a39e7fad5ef125f20fd48aa4
References: <20260601163258.554300-1-j.raczynski@samsung.com>
	<CGME20260601163314eucas1p2974abe77a39e7fad5ef125f20fd48aa4@eucas1p2.samsung.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,vger.kernel.org,samsung.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293841-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,samsung.com:mid,samsung.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A36B9622C5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When stmmac interface releases, kernel might panic with wrong memory access or
show SLUB "poison overwritten" errors due to a race condition between
NAPI polling and resource freeing.

Observed error is one of following:
- Poison overwriten
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

Fix is by applying napi_synchronize() instead of synchronize_rcu() to
every RX or RXTX queue, instead of only for XDP. Also synchronize_rcu() is
not correct nor sufficient function to assure NAPI has finished processing.

There might be need for potential clearing again after IRQ disable,
but this is very hard to reproduce. If this happens, we need to recheck
after IRQ disable.

Co-developed-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3a66f2842527..2c6abd5efd55 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -292,16 +292,18 @@ static void __stmmac_disable_all_queues(struct stmmac_priv *priv)
 static void stmmac_disable_all_queues(struct stmmac_priv *priv)
 {
 	u8 rx_queues_cnt = priv->plat->rx_queues_to_use;
-	struct stmmac_rx_queue *rx_q;
 	u8 queue;
 
-	/* synchronize_rcu() needed for pending XDP buffers to drain */
 	for (queue = 0; queue < rx_queues_cnt; queue++) {
-		rx_q = &priv->dma_conf.rx_queue[queue];
-		if (rx_q->xsk_pool) {
-			synchronize_rcu();
-			break;
+		struct stmmac_channel *ch = &priv->channel[queue];
+
+		if (stmmac_xdp_is_enabled(priv) &&
+		    test_bit(queue, priv->af_xdp_zc_qps)) {
+			napi_synchronize(&ch->rxtx_napi);
+		} else {
+			napi_synchronize(&ch->rx_napi);
 		}
+
 	}
 
 	__stmmac_disable_all_queues(priv);
-- 
2.34.1


