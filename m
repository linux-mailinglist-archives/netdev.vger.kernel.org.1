Return-Path: <netdev+bounces-229301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 01712BDA5A3
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C162355FDF
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8844F30275B;
	Tue, 14 Oct 2025 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I8YNO75J"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6B1302155;
	Tue, 14 Oct 2025 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455556; cv=none; b=lFWeY2TI0/8KGVZwx0XVOSAt9JLk3Jrs/baxFeWyEpmPPG81kNHvnJtNpdZCJQ69P39t1oCpcgQExSBzL1GQ+k9vbL3/EGZ9Qj+1mX3r4sQU9s3XF/xUl+zx+ZFhk8HPtt+p+wz1nc7NDV9iJoW6WsChtDmJ7GsS4vP0QuxfcW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455556; c=relaxed/simple;
	bh=J5rZfAdi1cqYrIEeP3rLvq9dDQUmAah5at1bAeS14qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JPPHTdWg7CFM4V0/Sd9ImGiTVqLCoUOLoBJjnGK1B2tdZutG1B0CI6VnYuEra6ExiDM34LKosQ0DRUky8iVDQCMgRp1loJSNnMwUoJQCyNnmQlsJc6P1rZiaBYByPbasTf2xKA2Ght3a9BI8A6dcphYnTV/qpxCG6zKfcp27vaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I8YNO75J; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E72F21A1381;
	Tue, 14 Oct 2025 15:25:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BCB80606EC;
	Tue, 14 Oct 2025 15:25:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9CB60102F22B2;
	Tue, 14 Oct 2025 17:25:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760455551; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kI0fvsqkgZcbGlYbMMgADSeWdOBIygdLfdA0Um1kIHU=;
	b=I8YNO75J2QXIdgLDAiSsbGDGmz2XSIhCRqlVvU2cJT0kDd/rWg+78g/vYGhLIKUB+T1V2R
	reNXzIznlOzbQcUZcpVO1buNqU6nSimsCtLnS2a1Y6USjEoFNf0Qy3zUSjuBW253Qv9eD7
	y7t30c6KAGt2U8D9SbKKOf83KNJD/v1pBxSiosXUnD9lkneYFuN013vPdkesM8L9r01U7L
	sNGoJzxD8SIVqHuwmnExmOj3xyilw6/MYGdnBUs+Q2nod89grqAs0XBA5cDcoZPpWLUyb9
	fwSvCEprHgQ0jTLV1gIesR2tJystCu77JrCITpFoYsuW7xhg6V6n3lbz92eFnQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 14 Oct 2025 17:25:07 +0200
Subject: [PATCH net-next 06/15] net: macb: simplify
 macb_dma_desc_get_size()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-macb-cleanup-v1-6-31cd266e22cd@bootlin.com>
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
In-Reply-To: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

macb_dma_desc_get_size() does a switch on bp->hw_dma_cap and covers all
four cases: 0, 64B, PTP, 64B+PTP. It also covers the #ifndef
MACB_EXT_DESC separately, making it four codepaths.

Instead, notice the descriptor size grows with enabled features and use
plain if-statements on 64B and PTP flags.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 33e99aab1dcb360a699d0e80762ef421001d19a1..7f74e280a3351ee7f961ff5ecd9550470b2e68eb 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -121,29 +121,16 @@ struct sifive_fu540_macb_mgmt {
  */
 static unsigned int macb_dma_desc_get_size(struct macb *bp)
 {
-#ifdef MACB_EXT_DESC
-	unsigned int desc_size;
+	unsigned int desc_size = sizeof(struct macb_dma_desc);
 
-	switch (bp->hw_dma_cap) {
-	case HW_DMA_CAP_64B:
-		desc_size = sizeof(struct macb_dma_desc)
-			+ sizeof(struct macb_dma_desc_64);
-		break;
-	case HW_DMA_CAP_PTP:
-		desc_size = sizeof(struct macb_dma_desc)
-			+ sizeof(struct macb_dma_desc_ptp);
-		break;
-	case HW_DMA_CAP_64B_PTP:
-		desc_size = sizeof(struct macb_dma_desc)
-			+ sizeof(struct macb_dma_desc_64)
-			+ sizeof(struct macb_dma_desc_ptp);
-		break;
-	default:
-		desc_size = sizeof(struct macb_dma_desc);
-	}
-	return desc_size;
+#ifdef MACB_EXT_DESC
+	if (bp->hw_dma_cap & HW_DMA_CAP_64B)
+		desc_size += sizeof(struct macb_dma_desc_64);
+	if (bp->hw_dma_cap & HW_DMA_CAP_PTP)
+		desc_size += sizeof(struct macb_dma_desc_ptp);
 #endif
-	return sizeof(struct macb_dma_desc);
+
+	return desc_size;
 }
 
 static unsigned int macb_adj_dma_desc_idx(struct macb *bp, unsigned int desc_idx)

-- 
2.51.0


