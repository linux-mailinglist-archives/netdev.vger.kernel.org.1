Return-Path: <netdev+bounces-229309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 068DEBDA613
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A6DDC3548E5
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ADA311C06;
	Tue, 14 Oct 2025 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f2EZJFRX"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4630E0D8;
	Tue, 14 Oct 2025 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455571; cv=none; b=WpX4CzH1gz/gtcrejTWZUtqjOZBUR+UctLJH/FrhZhW7p+feN55yJWy1vV85UIrrK1USpLJmNT/0xB/Ufkvb/Dz9LKLlKPi2I3YuFlHxX/57kCh3yeTFn1dydyXinOKHZuaX3+k/jBEJKO6rPQrmx8e6GxaeBbiwoq9tg/9FNCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455571; c=relaxed/simple;
	bh=CT1bzRQQrvXj1L+037G7R/WgnGR8oL5lCpFHntM/vIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H0eBolFWwJY1DDMkYwZuOgUMF80HxnqfUQI/MesFOHl86eCv03nES/ddZG6JkHAdro/jgS7NIROAFACHFrML/vKtheaqEcky7DMmzzy1OTJe+1lkuqncqx9PBOTVyOyBZ9oe87EXtcn4RQcaeriacjy1fXuGbEz3+b4cXcrn5co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f2EZJFRX; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4D1B31A1381;
	Tue, 14 Oct 2025 15:26:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 225A6606EC;
	Tue, 14 Oct 2025 15:26:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3F306102F22A4;
	Tue, 14 Oct 2025 17:26:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760455566; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mE1ukws3xTG0cWL7icCcyRG8jWl2qscLbVc2UTcXqFk=;
	b=f2EZJFRXZ2ZMTUGjPe0bCerWThWyVyi2zbMaXj9oz8T3vpnH3OvmcydG6O8+fUulfMx5Ii
	lzxzSS739wVNf95F7NiIgRaIEabJYKL4p/O1Kp9e/uA+flP8kQnIP+vE3lvXoTJVAkDlwL
	VeitrSCQt8jbIiBNWd9A6rMhi4ud0g9siQ6D4eQbyS7mV9vvTy219/zmWJUI6IMRKsFlKO
	M1sQXAnmBDvzFNcje/6DficfL3GAvJdipe4MBQ6LJSwmczh870JEzSXdDnC7HVL6aZ/tRC
	klWSx+Ee7/A0OTRFKljapsTBYWB8kKmAOvpSiBFWNZ5DNeH30WuMiVs0eaCvDA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 14 Oct 2025 17:25:15 +0200
Subject: [PATCH net-next 14/15] net: macb: apply reverse christmas tree in
 macb_tx_map()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-macb-cleanup-v1-14-31cd266e22cd@bootlin.com>
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

The arguments grew over time; follow conventions and apply reverse
christmas tree (RCT).

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index dd3b13fa304715b4629c20120a908262af106a2d..e15fcdd43d778c685dbb927386904362b8dba8b9 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1988,14 +1988,14 @@ static unsigned int macb_tx_map(struct macb *bp,
 				struct sk_buff *skb,
 				unsigned int hdrlen)
 {
-	dma_addr_t mapping;
+	unsigned int f, nr_frags = skb_shinfo(skb)->nr_frags;
 	unsigned int len, i, tx_head = queue->tx_head;
+	u32 ctrl, lso_ctrl = 0, seq_ctrl = 0;
+	unsigned int eof = 1, mss_mfs = 0;
 	struct macb_tx_skb *tx_skb = NULL;
 	struct macb_dma_desc *desc;
 	unsigned int offset, size;
-	unsigned int f, nr_frags = skb_shinfo(skb)->nr_frags;
-	unsigned int eof = 1, mss_mfs = 0;
-	u32 ctrl, lso_ctrl = 0, seq_ctrl = 0;
+	dma_addr_t mapping;
 
 	/* LSO */
 	if (skb_shinfo(skb)->gso_size != 0) {

-- 
2.51.0


