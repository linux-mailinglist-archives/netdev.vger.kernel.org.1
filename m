Return-Path: <netdev+bounces-293839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iO90LJe2HWrKdAkAu9opvQ
	(envelope-from <netdev+bounces-293839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:43:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3172A622C0C
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99358303E2F1
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 16:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6A23016E3;
	Mon,  1 Jun 2026 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hbPD9o2i"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8A530146C
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331596; cv=none; b=KWMn+LRoK0g9cVzlazq1CKUtzro/0e5OvRXys9YPh3Z2aE284830jB1Ow+pTy0zQGApAHz4BvzIjxmwy0f1nIkU3mzG2UZUyPmoBjftXZFv1a1/4zXbP/sF4/4sWMKMwgj22dGKs9TyQvrrnkUPohj6TXt+2lLC86nwQblP4Ais=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331596; c=relaxed/simple;
	bh=MrT8KCpNuJ2beuJ0fBZyYSQeC1y2cht3fAid+dBOeQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=JauXrHrhSEI1ehxzEnAn8MqLbDiVjQbuP6LLUuq+RTMYln4B4FE75rDdmQ7w5G+qfK2fNnle1dxlvy8yRBDpueJvfgLhkAQkTDLXPEaz4B5QuLAIIlwikJorNTl7k+9e6NIGdJrKles5iUE8NOvgCdFNQ4gfzK3fKax9O6bN/64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hbPD9o2i; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260601163313euoutp022c4ba4df8c0588794c5bdc9088481b33~1AibxTn1H0786707867euoutp02V
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 16:33:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260601163313euoutp022c4ba4df8c0588794c5bdc9088481b33~1AibxTn1H0786707867euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780331594;
	bh=CwVX9Xlp1GxUSggNQyPTSVCeqeA8PpQKM2TtfU6IUbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbPD9o2i6p7TiY/7esmf9y/wuEKlgwa1qe+M54zJkAJNSgRZ4tOluZqDMSgfzeKB2
	 2R7e67LlhbssFjY02ghfJ1yk/wOzhBaelRHnCuUyQqh64bWeEiwSL9FdUes0vfhyPV
	 1bwL8cnvTnRi8CWmCQCDYPohz5gBQjlATpPdDtd0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260601163313eucas1p20203ee427dc9d3733a9218835f4f7ed3~1Aia6RTyf0909509095eucas1p28;
	Mon,  1 Jun 2026 16:33:13 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260601163312eusmtip1876d78af876174606227e42fad1180f3~1AiaSpEkC0917909179eusmtip1m;
	Mon,  1 Jun 2026 16:33:12 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
	k.domagalski@samsung.com, k.tegowski@samsung.com, cs0617.lee@samsung.com,
	Jakub Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net-next v2 1/2] net/stmmac: Check for STMMAC_DOWN flag in
 all XDP paths
Date: Mon,  1 Jun 2026 18:32:57 +0200
Message-Id: <20260601163258.554300-2-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260601163258.554300-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260601163313eucas1p20203ee427dc9d3733a9218835f4f7ed3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260601163313eucas1p20203ee427dc9d3733a9218835f4f7ed3
X-EPHeader: CA
X-CMS-RootMailID: 20260601163313eucas1p20203ee427dc9d3733a9218835f4f7ed3
References: <20260601163258.554300-1-j.raczynski@samsung.com>
	<CGME20260601163313eucas1p20203ee427dc9d3733a9218835f4f7ed3@eucas1p2.samsung.com>
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
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,vger.kernel.org,samsung.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293839-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,samsung.com:mid,samsung.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3172A622C0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently STMMAC_DOWN flag is only set/cleared by stmmac_reset_subtask(),
to notify driver to stop processing of TX/RX frames. One of these processing
paths is for XDP, but it is only ever checked in stmmac_xdp_xmit(), which
leaves all other XDP paths vulnerable to processing data while interface is
restarting.

Make verification of STMMAC_DOWN flag consistent by applying check to all XDP
RX paths.

Co-developed-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3591755ea30b..3a66f2842527 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5267,6 +5267,9 @@ static int stmmac_xdp_xmit_back(struct stmmac_priv *priv,
 	if (unlikely(!xdpf))
 		return STMMAC_XDP_CONSUMED;
 
+	if (unlikely(test_bit(STMMAC_DOWN, &priv->state)))
+		return STMMAC_XDP_CONSUMED;
+
 	queue = stmmac_xdp_get_tx_queue(priv, cpu);
 	nq = netdev_get_tx_queue(priv->dev, queue);
 
@@ -5308,7 +5311,9 @@ static int __stmmac_xdp_run_prog(struct stmmac_priv *priv,
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


