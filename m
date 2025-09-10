Return-Path: <netdev+bounces-221774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041CCB51D65
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5EC8567E51
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 16:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46220335BBB;
	Wed, 10 Sep 2025 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qPmH3VJY"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB43335BBC;
	Wed, 10 Sep 2025 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521017; cv=none; b=YMQJEwWtNcnMHRRHB+AV1z8K0/ZtIYkYmoBoHIeqW2CeqJ4IRsIYiabJWL8S2/SMqjzq9TqUs+9iUxgpRVVta+m/XAvCqxjh6IFWr3JJSUf37+MBpGo1b2R9XG/d/Zm8F1fjc4xzKEX+YrboQLU/sA6iKiwldjPqXKFInQtrPK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521017; c=relaxed/simple;
	bh=4nq8DRBsVSBsAblqH/EyOXPCcAMalYSbOuE50hkeaK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hs229lNivUFYmJL2IVIfZJRLa0gTwlJHdD+gfOiRbxv0Uz8MFvVFVPWf4CdtjPOhzf7gMFfKHu0KinUBluF15ZRRxulNOAEHZHLzbsZlPEab0r1aM8CIlAbjEJkymoPtfa3hoC7J1jIAm6jWiBqzjhv79Yck9Nq02jmdJTdOJio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qPmH3VJY; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D7C4A1A0D55;
	Wed, 10 Sep 2025 16:16:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C6713606D4;
	Wed, 10 Sep 2025 16:16:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3B1E6102F28EA;
	Wed, 10 Sep 2025 18:16:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757521007; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LXdNFB9s1KI4qT/Zy8uuZBXtEbtV6EJNZuxTcSFMG8U=;
	b=qPmH3VJYltK62LYVdoa2NjIMGklmTfGDAvEDUum//CZyZ8bTHTC3KiWqJjZJWhdDrmRPoq
	aLvu/EbyObDesJOfz7pjes1Bz2y0pKs6ujaPSAbIz0fd3p2rBjGwZ8oPw16jKzBK1cFtZC
	kMK3I35Jwr5pH3hE2lemyiFiHIGkqfkxAe8fhOkhn3w8wajf9M5hm12WIWrE5T7Y5O6IWA
	Ak9q8WsHFWaidb5Soh7sQIkHby0EhjVYRbx7ljuEvZIC7Ste0FQEcq59l1btlZCFY5X738
	66AaroBfnZhOmoxhouXmV56wm7X2+SQQaHtEyX1+2m5e2UvYpGC0x9d/3htMgA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 10 Sep 2025 18:15:34 +0200
Subject: [PATCH net v5 5/5] net: macb: avoid dealing with endianness in
 macb_set_hwaddr()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250910-macb-fixes-v5-5-f413a3601ce4@bootlin.com>
References: <20250910-macb-fixes-v5-0-f413a3601ce4@bootlin.com>
In-Reply-To: <20250910-macb-fixes-v5-0-f413a3601ce4@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Harini Katakam <harini.katakam@xilinx.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Sean Anderson <sean.anderson@linux.dev>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

bp->dev->dev_addr is of type `unsigned char *`. Casting it to a u32
pointer and dereferencing implies dealing manually with endianness,
which is error-prone.

Replace by calls to get_unaligned_le32|le16() helpers.

This was found using sparse:
   ⟩ make C=2 drivers/net/ethernet/cadence/macb_main.o
   warning: incorrect type in assignment (different base types)
      expected unsigned int [usertype] bottom
      got restricted __le32 [usertype]
   warning: incorrect type in assignment (different base types)
      expected unsigned short [usertype] top
      got restricted __le16 [usertype]
   ...

Reviewed-by: Sean Anderson <sean.anderson@linux.dev>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index fc082a7a5a313be3d58a008533c3815cb1b1639a..c16d60048185b4cb473ddfcf4633fa2f6dea20cc 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -271,12 +271,10 @@ static bool hw_is_gem(void __iomem *addr, bool native_io)
 
 static void macb_set_hwaddr(struct macb *bp)
 {
-	u32 bottom;
-	u16 top;
+	u32 bottom = get_unaligned_le32(bp->dev->dev_addr);
+	u16 top = get_unaligned_le16(bp->dev->dev_addr + 4);
 
-	bottom = cpu_to_le32(*((u32 *)bp->dev->dev_addr));
 	macb_or_gem_writel(bp, SA1B, bottom);
-	top = cpu_to_le16(*((u16 *)(bp->dev->dev_addr + 4)));
 	macb_or_gem_writel(bp, SA1T, top);
 
 	if (gem_has_ptp(bp)) {

-- 
2.51.0


