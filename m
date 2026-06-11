Return-Path: <netdev+bounces-298099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v9aBMnWdKmqttgMAu9opvQ
	(envelope-from <netdev+bounces-298099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:35:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E4E671629
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:35:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=NIdX8YmI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298099-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298099-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=samsung.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BFCD308311D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776FE3E7BCD;
	Thu, 11 Jun 2026 11:34:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6AC32E6BD
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:34:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781177654; cv=none; b=f51DrNf+cw9Oft0lfUGlx2s5GGXziASgTkvlOktR4A8m9jfSLD8sy4H1+zHd0cDcrOQxlgF/2rorX/4fKhQnVPjGxsEoVXmonoiBKdXDPf6HtTIo4qYeKNK5uXZgIWh9BG22Xb75Ih37TqGoxdzZpBelDGP6a+HWssv/Vy1Wf2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781177654; c=relaxed/simple;
	bh=MFNkG++ILJO1VB2TAolFq97usUaFhNl3TxM1icN10qs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=MLRM0tnEZpCNCCpM20JBvabz1xLL1mHYfFuL67synZbBlMzKetOPXUrHoDZDJ+5psZWZ1cbOdxwIIiP8kEo7oBwQU1Gm0dLvrmcXnhfU/ry9ICsgty6mPRmnFGxwb8OZgF0GhSnGRRa3K2L8xT6nx7ciGnpwrfLvSuCKjAaZ86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NIdX8YmI; arc=none smtp.client-ip=210.118.77.11
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260611113406euoutp013024693eb7db45bff9e4bfe9023b5cc0~4A6HMGjl_1538015380euoutp01K
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:34:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260611113406euoutp013024693eb7db45bff9e4bfe9023b5cc0~4A6HMGjl_1538015380euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1781177646;
	bh=8g2s0jRme3xUJx8EMCMyxhTKGTJa++SGeLY0Z7juRnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NIdX8YmIUTHL+ezpixoL1bl7YKRn/YaajDk0go6pC7VhOlqrpWcphQpKyP+FXUIAE
	 06MvCu/06W9KhzauLXex68Y3eEowgx8y6EQMjP8GDYX6mf/7mSRH5DFuadtMEpy4l5
	 kvE3ZLQwiuGtsU+SdtFlqaVXPrTe65U/SuKrclRQ=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260611113405eucas1p1d1c8a7d26109ebb9e8073dd24cf0187c~4A6GxH_kk2472224722eucas1p1U;
	Thu, 11 Jun 2026 11:34:05 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260611113404eusmtip2579709418077f6c33db53653589f05f0~4A6Fu84SU3268332683eusmtip2D;
	Thu, 11 Jun 2026 11:34:04 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, k.domagalski@samsung.com,
	k.tegowski@samsung.com, Jakub Raczynski <j.raczynski@samsung.com>, Sashiko
	<sashiko-bot@kernel.org>
Subject: [PATCH net 2/2] net/stmmac: Apply MTL_MAX queue limit if config
 missing
Date: Thu, 11 Jun 2026 13:33:58 +0200
Message-Id: <20260611113358.3379518-3-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611113358.3379518-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260611113405eucas1p1d1c8a7d26109ebb9e8073dd24cf0187c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260611113405eucas1p1d1c8a7d26109ebb9e8073dd24cf0187c
X-EPHeader: CA
X-CMS-RootMailID: 20260611113405eucas1p1d1c8a7d26109ebb9e8073dd24cf0187c
References: <20260611113358.3379518-1-j.raczynski@samsung.com>
	<CGME20260611113405eucas1p1d1c8a7d26109ebb9e8073dd24cf0187c@eucas1p1.samsung.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[samsung.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298099-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,vger.kernel.org,lists.infradead.org,samsung.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:k.domagalski@samsung.com,m:k.tegowski@samsung.com,m:j.raczynski@samsung.com,m:sashiko-bot@kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[samsung.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83E4E671629

When "snps,rx-queues-to-use" or "tx-queues-to-use" config in DTS is provided
current code will apply U8_MAX value for queues_to_use if there is input of
higher value. But actual maximum number of supported queues is set via
macro MTL_MAX_RX_QUEUES and MTL_MAX_TX_QUEUES, which currently have value of 8.

This value of U8_MAX will be capped to value provided by core in DMA
capabilities (dma_conf), but it does so only if core provides it.
This is true for XGMAC (dwxgmac2) and some GMAC (dwmac4),
but not for (dwmac1000). This capping is at later stage in stmmac_hw_init(),
and during stmmac_mtl_setup() we might parse fields outside allocated memory
if queues_to_use is over defines MTL_MAX_ values,
for example following rx_queues_cfg is array of size of MTL_MAX_RX_QUEUES.

Fix this by capping value to MTL_MAX during config parsing.

Fixes: 94808793fed71 ("net: stmmac: use u8 for ?x_queues_to_use and number_?x_queues")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 5cae2aa72906..dc5f951a311d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -156,8 +156,8 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 
 	/* Processing RX queues common config */
 	if (!of_property_read_u32(rx_node, "snps,rx-queues-to-use", &value)) {
-		if (value > U8_MAX)
-			value = U8_MAX;
+		if (value > MTL_MAX_RX_QUEUES)
+			value = MTL_MAX_RX_QUEUES;
 		plat->rx_queues_to_use = value;
 	}
 
@@ -210,8 +210,8 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
 
 	/* Processing TX queues common config */
 	if (!of_property_read_u32(tx_node, "snps,tx-queues-to-use", &value)) {
-		if (value > U8_MAX)
-			value = U8_MAX;
+		if (value > MTL_MAX_TX_QUEUES)
+			value = MTL_MAX_TX_QUEUES;
 		plat->tx_queues_to_use = value;
 	}
 
-- 
2.34.1


