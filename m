Return-Path: <netdev+bounces-231566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EF1BFA9D0
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA14580BBD
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A2F2FC873;
	Wed, 22 Oct 2025 07:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zjE22bom"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002E22FB99C;
	Wed, 22 Oct 2025 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118723; cv=none; b=ilZPYtiN+akp0YrPJC3lipbxgcY/IzDEao3ZHYT4orBr3cJpbKCyzdRS8FF1T2TCnxqGfvczvmjSdNyiuUiJGOBiNRYdUv9JkOLpZVF0hVNgNjhmcEV//aqS2N9b/WZi9JXV58PsrgfIoYvzkxD253Np5t03y6T8BZexYuZIusQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118723; c=relaxed/simple;
	bh=ecl41pJPvihqp274/tCmJbHVxegBEYmfWIspInAauLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HdOnqC4gZiyc5uctd/qb+rtjgCRhoqFwtQMMpc2BN4YONtwqZtZ9LrSQ9EtdbOcYfYkSGvD1qxFqpEeV2P6SGKcP+/KoEf/KUHSWJCQ79C8QLCKik2t1+gh5hESKghAszrSyqeIxG97R/5PlXEY0NKuSuilA1lhRcnC6mSb32e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zjE22bom; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4DCDE4E41278;
	Wed, 22 Oct 2025 07:38:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 237F8606DC;
	Wed, 22 Oct 2025 07:38:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8E29A102F2426;
	Wed, 22 Oct 2025 09:38:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761118719; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pmwrc2WN3p4aZD7/+0Kz3OTk3QOTsF3e2T792MwxUoo=;
	b=zjE22bomf/cgt74vyWrsJBOY3pYcEogC2pteHwAfotDVBgBJVvi/+sac4QEpShWMNOmxnA
	GaIJu6RHLTMOg+c7W99wPnZ2+XVBRqAU8LSLEd+kkmMIN35qZvcTPj/Osjn0QMVO1dPFb5
	zACrRymyrcEJHa/n31HhUTMtoOch09loFkANjOeiV2k1Ar6P8Ksm7JWpfax0Lmd3VgFURY
	z9Xn8LlGFXegqBYUkIIp6NcTI4gltvkyRgMVfSkzqsNMqMeUC2qNOo5/mVR7+Ejhme13vm
	XxkYxAPc7XeGhoD1IQHoM/tqpxngnEWMAdwg61J4r4DSxoc2Fig/yzvY8QKrfQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 22 Oct 2025 09:38:12 +0200
Subject: [PATCH net-next v2 3/5] net: macb: add no LSO capability
 (MACB_CAPS_NO_LSO)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251022-macb-eyeq5-v2-3-7c140abb0581@bootlin.com>
References: <20251022-macb-eyeq5-v2-0-7c140abb0581@bootlin.com>
In-Reply-To: <20251022-macb-eyeq5-v2-0-7c140abb0581@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

LSO is runtime-detected using the PBUF_LSO field inside register DCFG6.
Allow disabling that feature if it is broken by using bp->caps coming
from match data.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      | 1 +
 drivers/net/ethernet/cadence/macb_main.c | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 93e8dd092313..05bfa9bd4782 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -778,6 +778,7 @@
 #define MACB_CAPS_DMA_64B			BIT(21)
 #define MACB_CAPS_DMA_PTP			BIT(22)
 #define MACB_CAPS_RSC				BIT(23)
+#define MACB_CAPS_NO_LSO			BIT(24)
 
 /* LSO settings */
 #define MACB_LSO_UFO_ENABLE			0x01
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 0817a99bb369..71a472c85a23 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4562,8 +4562,11 @@ static int macb_init(struct platform_device *pdev)
 	/* Set features */
 	dev->hw_features = NETIF_F_SG;
 
-	/* Check LSO capability */
-	if (GEM_BFEXT(PBUF_LSO, gem_readl(bp, DCFG6)))
+	/* Check LSO capability; runtime detection can be overridden by a cap
+	 * flag if the hardware is known to be buggy
+	 */
+	if (!(bp->caps & MACB_CAPS_NO_LSO) &&
+	    GEM_BFEXT(PBUF_LSO, gem_readl(bp, DCFG6)))
 		dev->hw_features |= MACB_NETIF_LSO;
 
 	/* Checksum offload is only available on gem with packet buffer */

-- 
2.51.1


