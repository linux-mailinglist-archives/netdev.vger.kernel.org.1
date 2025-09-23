Return-Path: <netdev+bounces-225673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7677EB96B53
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 18:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5355F16290B
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB3330E828;
	Tue, 23 Sep 2025 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oCPT2N+5"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5172E6CD7;
	Tue, 23 Sep 2025 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643268; cv=none; b=KqsitCeegNdba+ONysuvHCMtNuyXMZlbL2Fq01mBsQ+SdXU2W7cd4JZyXAkyQ1ddMtaFEV8k8Kq7RL6dVPzrHT5PfHA/dkfvFCJkxAOHKNGFmB2CHGJz0vz8u5rposBSBKNvUYQ/BSawPU483UoXdOnrWJrfZ1KIGqXWQMnwKvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643268; c=relaxed/simple;
	bh=g1cgiTqj2joH+HKf0UEB4v8bq+7CC7nitAZJQPFH9vg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jit/UxAVAN73Xr5c8Hhw+jywmEtf9yybWJkc5yhfG7bUAs8t5BPc7TcJ0yxypp9wpio4Chok19HdpJKWld8Hbbdgt7DXm074VFXJzxNUa9l2rq3SsMkTsIvoT238GKiXu9mZXonlFG8YXSpJDSVg2An9uWmrMHemXiUyVWPJ6Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oCPT2N+5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6AB611A0E8B;
	Tue, 23 Sep 2025 16:01:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4198160690;
	Tue, 23 Sep 2025 16:01:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0CA4D102F1973;
	Tue, 23 Sep 2025 18:01:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758643263; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1Ep+4XdSk4yubGJp+WrQBV4whUT9jw1dtd1k2oi0K9o=;
	b=oCPT2N+5l94laIsFzDBpIDthddcL67CpsOU/a10RrpZ8Ic9epFqpdyCYWIC6PbvexHFXZs
	YYn6MmLO1Y2IDk/OTD4mvQYvE2/y7bvwndCLRu/7uG1FWz4yKQaOOw5bCDXkcGMAUuZEUT
	9D/R71xsiI6ncsjPjjYYfdG6zl88yD4iGTy2smnFrbKX5/8KRXVeY6PQwuQWaulJxxQFCq
	iktjcbtz/A54Bg+zou+lk0cUilDFpSloaga3KAx+LbIpY0tkyG1NeuKjbafFOpWsUmHvWu
	MlWe5A3ZI3/+rDEgwF3wt2yS3Qa4fLyA92HqawPvC3+BaqfYKr9WqUWOH2z5wQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Sep 2025 18:00:27 +0200
Subject: [PATCH net v6 5/5] net: macb: avoid dealing with endianness in
 macb_set_hwaddr()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250923-macb-fixes-v6-5-772d655cdeb6@bootlin.com>
References: <20250923-macb-fixes-v6-0-772d655cdeb6@bootlin.com>
In-Reply-To: <20250923-macb-fixes-v6-0-772d655cdeb6@bootlin.com>
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
 drivers/net/ethernet/cadence/macb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index fc082a7a5a313be3d58a008533c3815cb1b1639a..4af2ec705ba52c0686ece344b85d88984db853b8 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -274,9 +274,9 @@ static void macb_set_hwaddr(struct macb *bp)
 	u32 bottom;
 	u16 top;
 
-	bottom = cpu_to_le32(*((u32 *)bp->dev->dev_addr));
+	bottom = get_unaligned_le32(bp->dev->dev_addr);
 	macb_or_gem_writel(bp, SA1B, bottom);
-	top = cpu_to_le16(*((u16 *)(bp->dev->dev_addr + 4)));
+	top = get_unaligned_le16(bp->dev->dev_addr + 4);
 	macb_or_gem_writel(bp, SA1T, top);
 
 	if (gem_has_ptp(bp)) {

-- 
2.51.0


