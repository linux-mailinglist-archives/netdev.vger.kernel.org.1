Return-Path: <netdev+bounces-286749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMAnBOwOAmoSngEAu9opvQ
	(envelope-from <netdev+bounces-286749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:16:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7E8513387
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2942A319B488
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2AE43E49F;
	Mon, 11 May 2026 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JgbOrZm4"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE6443DA5E
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518475; cv=none; b=bXxy2qXuyLmmM40x7r7HLVXT7n3Jms+woV+bx/NzsbFebEn3YSJaV2NxN26HsN14qgfK3enZjxZ1NNJruAsxob28/luIzgibiMm5ImVfwRvJlsNIH1+I+h7YjjCcO+ns7+LfuCJ2iwXpvvpsOaRik7KJs5HsuPJR9y8eGfQq/Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518475; c=relaxed/simple;
	bh=n4179BlTXbZg1lTfgcWIqzvKZKuWDfe5OP9CmHCK1Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=YjMrJyUTsWcrGv5+OzxODgGyrrj6Nhd/htrMZPMVlouNfhe/PFC2LjOl0MHVmX+ZY+5XJl5CkzeembJeZKhEQH69BnIr/XhlQdFNz6DWKZxrRXJMmJdiNp73Dm1ulLcsp6+qFY/elT4VzUArPPDOHO7Qn9FZ9Zn7g08YN6T4Ass=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JgbOrZm4; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260511165432euoutp028d73d88463012cb8f2920c4c9c1034df~ukSCsDQ_O2270322703euoutp02d
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 16:54:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260511165432euoutp028d73d88463012cb8f2920c4c9c1034df~ukSCsDQ_O2270322703euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1778518472;
	bh=da/DjnI9tZGTa9NOBdQBCg0Fra8F1d+y89DrAoA5ByY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JgbOrZm4oZlQcUl062o2hzUc/GLg+YYhFvdUWQ35EyPVLVs3yveO8IeW+LQD4s2QX
	 Lg8MLb6GBXHu7iCevey1DNyyxKmaL7Olg50uon9y3ytke9QiNY1JKy7Zfr6KGThgT/
	 pOgJmeF00kXgW6QnXetBe53BQ6e+FKOdVqQtzRQ8=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260511165431eucas1p28254403c5d4117b900dca4ca613bb532~ukSCAIUY13107631076eucas1p2e;
	Mon, 11 May 2026 16:54:31 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260511165431eusmtip1bd396eeaf036a77b6203fba2e08697e0~ukSBbLWp_2784027840eusmtip1E;
	Mon, 11 May 2026 16:54:30 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	k.domagalski@samsung.com, k.tegowski@samsung.com, Jakub Raczynski
	<j.raczynski@samsung.com>
Subject: [PATCH net-next 2/3] net/stmmac/dwxgmac: Extend MTL/DMA support to
 16 queues
Date: Mon, 11 May 2026 18:54:15 +0200
Message-Id: <20260511165416.3093015-3-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511165416.3093015-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260511165431eucas1p28254403c5d4117b900dca4ca613bb532
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260511165431eucas1p28254403c5d4117b900dca4ca613bb532
X-EPHeader: CA
X-CMS-RootMailID: 20260511165431eucas1p28254403c5d4117b900dca4ca613bb532
References: <20260511165416.3093015-1-j.raczynski@samsung.com>
	<CGME20260511165431eucas1p28254403c5d4117b900dca4ca613bb532@eucas1p2.samsung.com>
X-Rspamd-Queue-Id: 0E7E8513387
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,samsung.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286749-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,samsung.com:email,samsung.com:mid,samsung.com:dkim]
X-Rspamd-Action: no action

New datasheets for XGMAC (3.20a and 3.40a, depending on product) support up to
16 MTL/DMA queues. Before we increase max amount through macro,
prepare dwxgmac functions to handle that.

Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 ++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 24 +++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 51943705a2b0..bd333afe7e1b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -257,6 +257,8 @@
 #define XGMAC_MTL_INT_STATUS		0x00001020
 #define XGMAC_MTL_RXQ_DMA_MAP0		0x00001030
 #define XGMAC_MTL_RXQ_DMA_MAP1		0x00001034
+#define XGMAC_MTL_RXQ_DMA_MAP2		0x00001038
+#define XGMAC_MTL_RXQ_DMA_MAP3		0x0000103c
 #define XGMAC_QxMDMACH(x)		GENMASK((x) * 8 + 7, (x) * 8)
 #define XGMAC_QxMDMACH_SHIFT(x)		((x) * 8)
 #define XGMAC_QDDMACH			BIT(7)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 98b3e0cc84fa..76f8214a6e5b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -266,9 +266,29 @@ static void dwxgmac2_map_mtl_to_dma(struct mac_device_info *hw, u32 queue,
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value, reg;
 
-	reg = (queue < 4) ? XGMAC_MTL_RXQ_DMA_MAP0 : XGMAC_MTL_RXQ_DMA_MAP1;
-	if (queue >= 4)
+	switch (queue / 4) {
+	// queue 0 ~ 3
+	case 0:
+		reg = XGMAC_MTL_RXQ_DMA_MAP0;
+		break;
+	// queue 4 ~ 7
+	case 1:
+		reg = XGMAC_MTL_RXQ_DMA_MAP1;
 		queue -= 4;
+		break;
+	// queue 8 ~ 11
+	case 2:
+		reg = XGMAC_MTL_RXQ_DMA_MAP2;
+		queue -= 8;
+		break;
+	// queue 12 ~ 15
+	case 3:
+		reg = XGMAC_MTL_RXQ_DMA_MAP3;
+		queue -= 12;
+		break;
+	default:
+		return;
+	}
 
 	value = readl(ioaddr + reg);
 	value &= ~XGMAC_QxMDMACH(queue);
-- 
2.34.1


