Return-Path: <netdev+bounces-307745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FIsVNMJ+V2pSTQAAu9opvQ
	(envelope-from <netdev+bounces-307745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 14:36:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 065C575E369
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 14:36:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=uemelT76;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307745-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307745-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=samsung.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FA1330090BE
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 12:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE8F448CEF;
	Wed, 15 Jul 2026 12:36:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551603644C4
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 12:36:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118974; cv=none; b=JRTqBDsje5UAYdsG+GX7DA3+xfRE9k1c7723jejd/Y8OmKJe6UT9Pe5Auf8GsIF9G/v2+DGwuIHTHALsSN/Tn1qJQ67R9zeM6NkuJ+2UG0TCZ9iATqMK1eaNhc2MYV1kzZ4klEQbc+F8k/m5eTGgtrqWxPQK392Zwt37UrPEEm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118974; c=relaxed/simple;
	bh=3K8tCYgOogiXE6opUYKajW5n8qGiG95G+MUViEbfnw0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=Rhe1czL9FN1YSMAsssRxWLsD1qqGPd6Vs9QQWRR5+ir4/KWmZKdQtvkJVWI7FAbD2p+Xi+K7So7XBgpGduzMM0kiZ4DUFCTWqV1ZVRro4MRgJw4G+MsPA6Mdrk1C6czSIhD7ebZrnolbAg92Ax/EPU6W617vk8MbVTLrB32d68w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uemelT76; arc=none smtp.client-ip=210.118.77.11
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260715123610euoutp01229193c2926d3676b4a6f11cf15a8133~CdsA1q74D1870818708euoutp01d
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 12:36:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260715123610euoutp01229193c2926d3676b4a6f11cf15a8133~CdsA1q74D1870818708euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1784118970;
	bh=SDVJJ1xLr7xWky9ho2VxmausoMg83j1se4IAydWbvyk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=uemelT76i6UY2X5tg7rTHBUs6lCA4V/nH0Rn6HMYiwuJOeOZwt8NkhTlejbY9RmMg
	 rT21VlTUCk5fwPyFFH2vrdP7JTLzH9XOILYjpKRvnWA36DsY0tXNFyUZfhEfm88kGo
	 k+nzcY9ku5kR88E6iC+hzTjm5XsLwxE8rKtl59+Q=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260715123609eucas1p276498c4701060ffbb6789cb096696a31~CdsAMHlXz0124001240eucas1p23;
	Wed, 15 Jul 2026 12:36:09 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260715123609eusmtip2e748e18c41f35c2b9b6c1ce83debc305~Cdr-s-uy20360603606eusmtip2D;
	Wed, 15 Jul 2026 12:36:09 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jakub
	Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net v3 0/2] net/stmmac: Secure against failures of DMA
 memory allocation
Date: Wed, 15 Jul 2026 14:36:00 +0200
Message-Id: <20260715123602.51950-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260715123609eucas1p276498c4701060ffbb6789cb096696a31
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260715123609eucas1p276498c4701060ffbb6789cb096696a31
X-EPHeader: CA
X-CMS-RootMailID: 20260715123609eucas1p276498c4701060ffbb6789cb096696a31
References: <CGME20260715123609eucas1p276498c4701060ffbb6789cb096696a31@eucas1p2.samsung.com>
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
	TAGGED_FROM(0.00)[bounces-307745-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 065C575E369
X-Rspamd-Action: no action

This series fixing two issues related to fails of
__alloc_dma_rx_desc_resources(). Original issue from 1st patch is related to
page_pool that has happened in testing env, while second was requested by
Sashiko to have similar change for DMA allocation. 
To have complete fix for all failures of __alloc_dma_rx_desc_resources(),
merge two fixes into series.

---
Changes in v3:
- Added null assignment to page pointers (suggested by sashiko)
- Convert IS_ERR_OR_NULL check to just NULL check

Changes in v2:
- Added reviewed by Maxime to first patch
- Dropped null check as page_pool_destroy() does provide that
- Modified comment to reflect that

Link to v2:
https://lore.kernel.org/all/20260707174115.1264466-1-j.raczynski@samsung.com/

Link to v1:
https://lore.kernel.org/netdev/20260630100953.747868-1-j.raczynski@samsung.com/

Jakub Raczynski (2):
  net/stmmac: Set Rx queue page_pool to NULL when freeing DMA resources
  net/stmmac: Prevent dma queue NULL free on allocation failure

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 32 ++++++++++++-------
 1 file changed, 21 insertions(+), 11 deletions(-)

-- 
2.34.1


