Return-Path: <netdev+bounces-293837-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGUtF7O1HWrKdAkAu9opvQ
	(envelope-from <netdev+bounces-293837-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:39:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B702A622B2C
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F28630151CE
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 16:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442EF2F8EB3;
	Mon,  1 Jun 2026 16:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hv6vJ5Z6"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C5028C854
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331190; cv=none; b=TBoNgRIHhttEkOs7ZoXjQ8pnX1R3T6rka6U2wkLMSHLOY9ye3J2ZEgHgrs+xRcPiAWy2BjRpKP36jgqsHt2jaOjLGxnKyhqLbMYmxmF9eY0n18sbwtZ4eEo449fCEXdOPoV78/0bhS63moJ8Fgot7FONym/z4o/nfK6u2Rt8rsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331190; c=relaxed/simple;
	bh=VNbcVZfp3kK+qOIwunOPLnoQhx1gkkdNleUhc3qTw/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=b5o6Lf3+fQxtfWwW0qeu4WMUDSK4X2HBalMoT2ViyEu/A4xBXkwbH4deb2OGpS7OoJltKV66Nl5ryJ+JlfivD8HSaqxSgVCYCqYWKeAbfzIbiHWRjHX133OR+QpDKy5Gwf7wQE1kZK6ATCmPTczxOPRsDCXi4wSI2QaN5CFRsyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hv6vJ5Z6; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260601162619euoutp021af62c56d53a759653484eb23e8d91a9~1AcZ7JTEN0786707867euoutp02L
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 16:26:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260601162619euoutp021af62c56d53a759653484eb23e8d91a9~1AcZ7JTEN0786707867euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780331179;
	bh=61tt8PTo63X1TeAn41WneI1CM27dHkmn6nnvNcdEW2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hv6vJ5Z6ndL2WidcgKzW2yTa6vGF5rIWu/vZeJtDOkJf7Rp+Izrv5O5QPV7m4qzbk
	 6P39Qjlb0fIF/j95Z7tF4pTQzsgSYjTszMkxVuvW18G3b1meBhiwn9lrIZNsKLT5zA
	 kXn38Q2FHYavpHRDGII1TXIoNZofBORl7nppJWaI=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260601162618eucas1p14be36902c4948647448160da08aaebc5~1AcZF6ILh0792807928eucas1p1t;
	Mon,  1 Jun 2026 16:26:18 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260601162618eusmtip1680877e4bb5d9ba5b3611b76bb33901e~1AcYeKqHA0485104851eusmtip1e;
	Mon,  1 Jun 2026 16:26:18 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
	k.domagalski@samsung.com, k.tegowski@samsung.com, cs0617.lee@samsung.com,
	Jakub Raczynski <j.raczynski@samsung.com>
Subject: [PATCH net-next v2 2/3] net/stmmac/dwxgmac: Extend MTL/DMA support
 to 16 queues
Date: Mon,  1 Jun 2026 18:25:36 +0200
Message-Id: <20260601162537.553512-3-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260601162537.553512-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260601162618eucas1p14be36902c4948647448160da08aaebc5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260601162618eucas1p14be36902c4948647448160da08aaebc5
X-EPHeader: CA
X-CMS-RootMailID: 20260601162618eucas1p14be36902c4948647448160da08aaebc5
References: <20260601162537.553512-1-j.raczynski@samsung.com>
	<CGME20260601162618eucas1p14be36902c4948647448160da08aaebc5@eucas1p1.samsung.com>
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
	TAGGED_FROM(0.00)[bounces-293837-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,samsung.com:email,samsung.com:mid,samsung.com:dkim]
X-Rspamd-Queue-Id: B702A622B2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

New datasheets for XGMAC (3.20a and 3.40a, depending on product) support up to
16 MTL/DMA queues. Before we increase max amount through macro,
prepare dwxgmac functions to handle that.

Co-developed-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Chang-Sub Lee <cs0617.lee@samsung.com>
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 ++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 23 +++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

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
index dbedf31bb2ab..4aba62680938 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -278,12 +278,31 @@ static void dwxgmac2_set_mtl_tx_queue_weight(struct stmmac_priv *priv,
 static void dwxgmac2_map_mtl_to_dma(struct mac_device_info *hw, u32 queue,
 				    u32 chan)
 {
+	struct net_device *ndev = hw->priv_data->dev;
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value, reg;
 
-	reg = (queue < 4) ? XGMAC_MTL_RXQ_DMA_MAP0 : XGMAC_MTL_RXQ_DMA_MAP1;
-	if (queue >= 4)
+	switch (queue) {
+	case 0 ... 3:
+		reg = XGMAC_MTL_RXQ_DMA_MAP0;
+		break;
+	case 4 ... 7:
+		reg = XGMAC_MTL_RXQ_DMA_MAP1;
 		queue -= 4;
+		break;
+	case 8 ... 11:
+		reg = XGMAC_MTL_RXQ_DMA_MAP2;
+		queue -= 8;
+		break;
+	case 12 ... 15:
+		reg = XGMAC_MTL_RXQ_DMA_MAP3;
+		queue -= 12;
+		break;
+	default:
+		netdev_err(ndev, "%s: Incorrect queue mapping %d\n",
+			   __func__, queue);
+		return;
+	}
 
 	value = readl(ioaddr + reg);
 	value &= ~XGMAC_QxMDMACH(queue);
-- 
2.34.1


