Return-Path: <netdev+bounces-305548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CQZ2LyE7TWqJxAEAu9opvQ
	(envelope-from <netdev+bounces-305548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 19:45:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E80F271E5EC
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 19:45:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=KsmoXaci;
	dmarc=pass (policy=none) header.from=samsung.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305548-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305548-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 940393044F09
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 17:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81153E5A01;
	Tue,  7 Jul 2026 17:44:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FDB3845D0
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:44:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446281; cv=none; b=NiUFiVOyPe53FdXJoNt6wfvYhwpadrrxS4oNZMewhfncY3otPG5b4AgygwRkmaiDgAdH+Kba1VVx06feZoJikGEPpAcRr/4BPiIRxsHQhlr0cEemDJmhMxM86FgCRAwFHKkouvN+77yXLYrYUDFbzvEKGBG+2BzgdTnOZc9S7+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446281; c=relaxed/simple;
	bh=hus5eAjRTVkJjQ92lu1Wkj26e2Kl0Wvta7FR9LlvKTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=vEE+O5gkfQa+7Z2Bq9LYhXbYed3MU555qeoNSSKhz2POjAXkp1qa/505MpNVGZJW3eiwiK6PrfuJHHrPfJAmT5aogxEoDsFtZUCAs71T6WwAsiWezxOdYM654LUKOXFZLKtRWzjUWYwt83pXrGl2Qy99qY1iGmnQwlqBiOBpgQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KsmoXaci; arc=none smtp.client-ip=210.118.77.11
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260707174438euoutp016a7bd9ae61a44c78aa9369aa4b6f250d~AEvEIFlOv0448904489euoutp01R
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:44:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260707174438euoutp016a7bd9ae61a44c78aa9369aa4b6f250d~AEvEIFlOv0448904489euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783446278;
	bh=/V3IDsSnQjAP3/DFshVE1YPFZDzJBaRoz5Q/CBJ2mdU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=KsmoXaciTtDB6sClKMx7k4Z4SHwRLTGPVL+/+u6L9lm0XADBbKPkwOn6BgeK9PMT1
	 wdh7CHhaqNtdraJ11IukdHnqO27Sf3gh3hU03aSjDEPBqzdOAV6yrpWT3Aa7+5bGnL
	 yhHUMC3VDjFNigem6uE4oD5r+QIK72cm9bcjzz4g=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260707174437eucas1p2cedaa017eea6cd5696535b17925a3b53~AEvDKjXIQ2942329423eucas1p2d;
	Tue,  7 Jul 2026 17:44:37 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260707174436eusmtip2f88fbdd78f52216b16d2a8d14239ea38~AEvCEQoaf1514515145eusmtip2F;
	Tue,  7 Jul 2026 17:44:36 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: k.tegowski@samsung.com, k.domagalski@samsung.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jakub
	Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net 0/2] net/stmmac: Verify more wrong DTS configuration
Date: Tue,  7 Jul 2026 19:44:29 +0200
Message-Id: <20260707174431.1264520-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260707174437eucas1p2cedaa017eea6cd5696535b17925a3b53
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260707174437eucas1p2cedaa017eea6cd5696535b17925a3b53
X-EPHeader: CA
X-CMS-RootMailID: 20260707174437eucas1p2cedaa017eea6cd5696535b17925a3b53
References: <CGME20260707174437eucas1p2cedaa017eea6cd5696535b17925a3b53@eucas1p2.samsung.com>
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
	TAGGED_FROM(0.00)[bounces-305548-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:from_mime,samsung.com:dkim,samsung.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E80F271E5EC

Commit 8a7bca6de6de protected against possible wrong number of TX/RX queues,
which could happen with new XGMAC hardware that has more supported queues than
currently available in driver.
Sashiko mentioned that there should also be protection against zero input
and some AXI related config, as these are possible kernel panics too.
While this series has lower value than original patch, since this
misconfiguration should not happen by pure mistake, there is no reason not
to fix it.

Jakub Raczynski (2):
  net/stmmac: Protect against zero queue DTS config
  net/stmmac: Verify provided DTS AXI setup

 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
2.34.1


