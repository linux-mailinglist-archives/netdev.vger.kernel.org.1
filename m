Return-Path: <netdev+bounces-303076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZMgbKY+ZQ2oSdAoAu9opvQ
	(envelope-from <netdev+bounces-303076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:25:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4886E2CDF
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:25:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=epDwIvns;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303076-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303076-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=samsung.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55597306CC43
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 10:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1593F075D;
	Tue, 30 Jun 2026 10:19:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6793BFE25
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 10:19:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814745; cv=none; b=hOCtiO+rwJwTAMTq4Z4/xDGV6Z/N8+ZWuChq0mC1J0QNQSKw1h4SauX+oAw5+DskCrEcyn3t56ywm/8kum8cDDMmzEnQEOvG+ou0Mksow5ofUiCm1ZzlC06TBdZLF/hsxg9Yk+ud7u3DVZYqLcvO2D26F6DIKQCbrREf33ZHwc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814745; c=relaxed/simple;
	bh=m2D1VAm3vHfN3u+29nWtThV6eLcY8ZfqQjnYYy8is10=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=XHNUrkR4qetvVXNkNFxsc9lolS3Jrd6LA1sF+R1/ATBmv0rJ9UyNFwGPVXyRuddzaki8qKV/fwQA53W6blJoUQITdVpFz2acuYg8sTvYyUk7OdC8epkPbT1EhB4guodTxr4A7XlzXO7Fznvrky+vGp43WKvXILAOERf2grQ3Ox0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=epDwIvns; arc=none smtp.client-ip=210.118.77.12
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260630101158euoutp02e305b9c13f2ef6d11fb4f490518f867f~91C09JGMJ1162311623euoutp02A
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 10:11:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260630101158euoutp02e305b9c13f2ef6d11fb4f490518f867f~91C09JGMJ1162311623euoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1782814318;
	bh=QXblLV/UXM0l53Sla0Cza2+eCG4M8DfzQr6z9zDQS68=;
	h=From:To:Cc:Subject:Date:References:From;
	b=epDwIvnsufTCO5RsoQAyQdITxCaSbW6zIIgZItA4CRmyNZqgqy+wMm87ZgBuyjXD7
	 sYtwNZMMfXAndg3A9Tg7dYYpdq20h1uTXJH/XitAeou7F3HnyLCiXwLCq6u1mDTDiu
	 YZnWgrqQL1ZWcn0HdeEbNqQ8m0fLJPUMgQfwUixI=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260630101157eucas1p1b1cef0db9381391bdd9400f1d255ce49~91C0iez0R0447904479eucas1p1h;
	Tue, 30 Jun 2026 10:11:57 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260630101157eusmtip13d3eb59deffa0613d508577eb7b5d863~91Cz_ZCi-2068620686eusmtip1-;
	Tue, 30 Jun 2026 10:11:57 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	linux-kernel@vger.kernel.org, k.tegowski@samsung.com,
	k.domagalski@samsung.com, Jakub Raczynski <j.raczynski@samsung.com>,
	Yashwant Varur <yashwant.v@samsung.com>
Subject: [PATCH net] net/stmmac: Set Rx queue page_pool to NULL when freeing
 DMA resources
Date: Tue, 30 Jun 2026 12:09:54 +0200
Message-Id: <20260630100953.747868-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260630101157eucas1p1b1cef0db9381391bdd9400f1d255ce49
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260630101157eucas1p1b1cef0db9381391bdd9400f1d255ce49
X-EPHeader: CA
X-CMS-RootMailID: 20260630101157eucas1p1b1cef0db9381391bdd9400f1d255ce49
References: <CGME20260630101157eucas1p1b1cef0db9381391bdd9400f1d255ce49@eucas1p1.samsung.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[samsung.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303076-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:linux-kernel@vger.kernel.org,m:k.tegowski@samsung.com,m:k.domagalski@samsung.com,m:j.raczynski@samsung.com,m:yashwant.v@samsung.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,samsung.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:dkim,samsung.com:email,samsung.com:mid,samsung.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F4886E2CDF

When freeing RX descriptor resources, there is standard clearing of
descriptor page_pool via page_pool_destroy() which does destroy
page but does not set its pointer to NULL, which must be done by driver
calling this function.
It is not done in __free_dma_rx_desc_resources() when stopping interface,
which is generally not an issue, because __alloc_dma_rx_desc_resources() does
setup this regardless of previous state.
But above is true assuming reinitialization is successful.

In case of failure of page_pool_create() in __alloc_dma_rx_desc_resources(),
all non-NULL pages will be freed, including those already cleared.
So there is possible kernel panic due to wrong paging request at address.

Fix this by assigning NULL to page_pool pointer on free

Fixes: da5ec7f22a0f1 ("net: stmmac: refactor stmmac_init_rx_buffers for stmmac_reinit_rx_buffers")
Signed-off-by: Yashwant Varur <yashwant.v@samsung.com>
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3591755ea30b..4b8f2814d3b5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2172,8 +2172,10 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 		xdp_rxq_info_unreg(&rx_q->xdp_rxq);
 
 	kfree(rx_q->buf_pool);
-	if (rx_q->page_pool)
+	if (rx_q->page_pool) {
 		page_pool_destroy(rx_q->page_pool);
+		rx_q->page_pool = NULL;
+	}
 }
 
 static void free_dma_rx_desc_resources(struct stmmac_priv *priv,
-- 
2.34.1


