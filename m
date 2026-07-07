Return-Path: <netdev+bounces-305546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Uf7lLm46TWp7xAEAu9opvQ
	(envelope-from <netdev+bounces-305546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 19:42:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EE471E5B5
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 19:42:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=cFbFWmrZ;
	dmarc=pass (policy=none) header.from=samsung.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305546-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305546-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0BFC304B997
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 17:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1F3438471;
	Tue,  7 Jul 2026 17:41:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E8E384CC6
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:41:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446104; cv=none; b=IESGooMhIlfs046PRe/vSyTiGvXhHssNTWo07QHuDDmjlSbR5UWDzak2g3sKHsv1/DnBzTwqWmBbN+paHCWbHJt375KFYMkPHk4rfNY6zqyE9N5wmf0QKNbFBJg3xy+XXbqEMCDHwXH1T5Hd/5mBuVPJJurTivZY4ewQL5MxLiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446104; c=relaxed/simple;
	bh=GHfONwn/bpfIhneQDq32RP98AToMZwhpL+MQfz4dijQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=BH40qXrSEOj/jw9IDOXCgWzWn6oz2GYEt/6pmHLjpRnWmd8iFLBN9mSLuGYukNGA1pylQV2r6UY900fy0aQjdqvFCu1yAAvmYxZii0YXQSuFEZU3JfeXIxdnTd979iG2j5LPGn4gwJc7SuqODUe3YVeZwoLJKOpJMHXeeuvfbhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cFbFWmrZ; arc=none smtp.client-ip=210.118.77.11
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260707174136euoutp0168de8d8262ec3f24ad42ddfd93efaf41~AEsZ8J8220448404484euoutp01K
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:41:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260707174136euoutp0168de8d8262ec3f24ad42ddfd93efaf41~AEsZ8J8220448404484euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783446096;
	bh=2uqhzatz7NlDzESa9PUCo71vFC+Z9fG5K7FS6DttHiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cFbFWmrZMKBqTlKeU7OTiwH7GnvgN+5xUCa3/BWttM+6oWP9X+WD0ZCCka4eDWnqL
	 rEvD4xrGAcdPF/xByYBb3G6XFUqRxELaJEY9V2vJ1A3niLLvUB8rQoz6thM3iXRHlL
	 zD3vwiKEND2gF03UmNxp14VHlWylEQcwQANpsgXg=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260707174135eucas1p1386ed6bc3c44c1a4e927a0a8bae8fd27~AEsZYmV6x1385013850eucas1p1Q;
	Tue,  7 Jul 2026 17:41:35 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260707174134eusmtip1c78c3c4b343d56ce01467ae68af74883~AEsYqzfhO1143211432eusmtip1D;
	Tue,  7 Jul 2026 17:41:34 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: k.tegowski@samsung.com, k.domagalski@samsung.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jakub
	Raczynski <j.raczynski@samsung.com>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>
Subject: [PATCH net v2 1/2] net/stmmac: Set Rx queue page_pool to NULL when
 freeing DMA resources
Date: Tue,  7 Jul 2026 19:41:14 +0200
Message-Id: <20260707174115.1264466-2-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707174115.1264466-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260707174135eucas1p1386ed6bc3c44c1a4e927a0a8bae8fd27
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260707174135eucas1p1386ed6bc3c44c1a4e927a0a8bae8fd27
X-EPHeader: CA
X-CMS-RootMailID: 20260707174135eucas1p1386ed6bc3c44c1a4e927a0a8bae8fd27
References: <20260707174115.1264466-1-j.raczynski@samsung.com>
	<CGME20260707174135eucas1p1386ed6bc3c44c1a4e927a0a8bae8fd27@eucas1p1.samsung.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[samsung.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305546-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:k.tegowski@samsung.com,m:k.domagalski@samsung.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:j.raczynski@samsung.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[samsung.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org,vger.kernel.org,bootlin.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12EE471E5B5

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

Fix this by assigning NULL to page_pool pointer on free.
Also remove NULL check as page_pool_destroy() does check for NULL param.

Fixes: da5ec7f22a0f1 ("net: stmmac: refactor stmmac_init_rx_buffers for stmmac_reinit_rx_buffers")
Signed-off-by: Yashwant Varur <yashwant.v@samsung.com>
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2a0d7eff88d3..3098971e0b66 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2172,8 +2172,8 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 		xdp_rxq_info_unreg(&rx_q->xdp_rxq);
 
 	kfree(rx_q->buf_pool);
-	if (rx_q->page_pool)
-		page_pool_destroy(rx_q->page_pool);
+	page_pool_destroy(rx_q->page_pool);
+	rx_q->page_pool = NULL;
 }
 
 static void free_dma_rx_desc_resources(struct stmmac_priv *priv,
-- 
2.34.1


