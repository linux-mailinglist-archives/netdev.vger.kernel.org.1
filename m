Return-Path: <netdev+bounces-307746-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t1PpKWCBV2oqTgAAu9opvQ
	(envelope-from <netdev+bounces-307746-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 14:47:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5FF75E522
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 14:47:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=Y4ARRXf+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307746-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307746-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=samsung.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0DCB230237F3
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 12:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F7C472793;
	Wed, 15 Jul 2026 12:36:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50487477E3D
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 12:36:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118980; cv=none; b=VJteHl6oM91gRfO3FD1gDgVoRXyUwG3dkctfXDnKoD5++KQtVSLVJcnLjfHp/3tpYr5FSRSEclixbe8mrZg9K/1m5mFxPiPqj7tGFLElVrLSe3qGbdSuLoM2LrKo2tEboaWpkjOpvLJ00ggsyba0pqQAEHbaMBb1xDmVamVLLp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118980; c=relaxed/simple;
	bh=GHfONwn/bpfIhneQDq32RP98AToMZwhpL+MQfz4dijQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=nXjZLcv7U2CllM4F9wSfErtjcI26bgZaqdyaSkiWeu5pg+wNRNdpkDpMLI3EM7CYii3mHEalw7W1LcAywaBWqIlFjiKrZSlmf+lufmAoINl9n/SzEJvMf+cMLIZABQMGWCmQYFu8sUjQo7LEoeZlpXJtGD32GqLkIm44v8alZIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Y4ARRXf+; arc=none smtp.client-ip=210.118.77.12
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260715123610euoutp0236160d28efe9a9dd5fb9a045a90289b2~CdsBU2ZF21797917979euoutp02C
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 12:36:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260715123610euoutp0236160d28efe9a9dd5fb9a045a90289b2~CdsBU2ZF21797917979euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1784118970;
	bh=2uqhzatz7NlDzESa9PUCo71vFC+Z9fG5K7FS6DttHiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y4ARRXf+GJzKGZmQz/G4oNqh5JkkL7uNFvoP1xvXPakuG7t4JlO9N7i28B/CBApxa
	 T3Pi87yI62z7VgVz3nhjeP6v2RCcSHYqgAnHCrNdmGirXS+pLbMzELO5hztd9w0scK
	 yAqWDfpmk0OfP5Htde2dMJvlwdtpPSXXRmYwFuZ0=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260715123610eucas1p100ea97629de7a87fa67016275cfb38f4~CdsAwxlzu0260302603eucas1p1Y;
	Wed, 15 Jul 2026 12:36:10 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260715123609eusmtip2ed2c8310254681e147758f83b064e203~CdsARqFta0361003610eusmtip2C;
	Wed, 15 Jul 2026 12:36:09 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jakub
	Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net v3 1/2] net/stmmac: Set Rx queue page_pool to NULL when
 freeing DMA resources
Date: Wed, 15 Jul 2026 14:36:01 +0200
Message-Id: <20260715123602.51950-2-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260715123602.51950-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260715123610eucas1p100ea97629de7a87fa67016275cfb38f4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260715123610eucas1p100ea97629de7a87fa67016275cfb38f4
X-EPHeader: CA
X-CMS-RootMailID: 20260715123610eucas1p100ea97629de7a87fa67016275cfb38f4
References: <20260715123602.51950-1-j.raczynski@samsung.com>
	<CGME20260715123610eucas1p100ea97629de7a87fa67016275cfb38f4@eucas1p1.samsung.com>
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[samsung.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,lists.infradead.org,samsung.com];
	TAGGED_FROM(0.00)[bounces-307746-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:j.raczynski@samsung.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[samsung.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:email,vger.kernel.org:from_smtp,samsung.com:dkim,samsung.com:email,samsung.com:mid,samsung.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A5FF75E522
X-Rspamd-Action: no action

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


