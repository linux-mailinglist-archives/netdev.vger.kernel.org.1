Return-Path: <netdev+bounces-225669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4974BB96B1D
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 18:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314B32E384B
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B984A26AA93;
	Tue, 23 Sep 2025 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bAP6j7RV"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5BB1A9FB4
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643257; cv=none; b=gEFo2+Ikm7Ef3MwmdEoTqIvYYRK6K/gnDGstg3+RpqSJXX5BctTH9wyabaOBdb9ey7jII2NHx78/LBugcG5UyzV21RMSklnealbGklDrsQqwyVWztocVDPkFq7ox3bX/yEUk+nVTLoRjV+5EkAa20ERZbxg2XVRMM+JpR3ebNng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643257; c=relaxed/simple;
	bh=3zZCd4F5TNJy+F1irODC06X4kSaGRUOro4Xbmp9NzTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lCHrNFDAfTm5k/G9r++0+5DRLeG8UNjNk4u7/GFrDDhSsjxFeS+D9OF1MG0UjS0kYZS0ux6KEhokfI+bIWSwe9/SrS+pYExF7b+5SQGHGwXnHT0mGbQ7Ygp9G1Moee2XwGndrydK8Ha6DVgu3TmkLZJvr78aBtObP301F7+z8Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bAP6j7RV; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E10864E40CA1;
	Tue, 23 Sep 2025 16:00:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B5DFD60690;
	Tue, 23 Sep 2025 16:00:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF68C102F196F;
	Tue, 23 Sep 2025 18:00:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758643252; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AM4ZgSHOUeHDIPf7yX4LJ/KF76YVa1eQBXVvqrWoGMs=;
	b=bAP6j7RVC7xP6hzBXnf3rxPuXBp46dGUH2uHL3e/jldDU8SdqLN0nXgGTwCLh+dpDD8eGF
	/WJM5KEBCQwIuncMzceWhHN79L0oqCfH4P0tXjBOrfoPuGwksas8RTjpKmRQnRTd0kg6YX
	TJlqZ8N4zWzgIi593BzSQicv+izp6rwc3bNoPfPUo1Ds5JmgltsmenwgkfAkDguJUtE2uq
	DwbbqJ8IFSQ140b77Y3lrvCE6flHzWmVnCNAK/C2uIMZ1gXpHSs/5Wizv6xerf0ADY7/zh
	9gBisAgFIgILVtq0IK2rQ0vRHLuhZ2HEpDgL0iRreQWA/eAljfLfssmoIQPTVQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Sep 2025 18:00:23 +0200
Subject: [PATCH net v6 1/5] dt-bindings: net: cdns,macb: allow tsu_clk
 without tx_clk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250923-macb-fixes-v6-1-772d655cdeb6@bootlin.com>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Allow providing tsu_clk without a tx_clk as both are optional.

This is about relaxing unneeded constraints. It so happened that in the
past HW that needed a tsu_clk always needed a tx_clk.

Fixes: 4e5b6de1f46d ("dt-bindings: net: cdns,macb: Convert to json-schema")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 559d0f733e7e7ac2909b87ab759be51d59be51c2..6e20d67e7628cd9dcef6e430b2a49eeedd0991a7 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -85,7 +85,7 @@ properties:
     items:
       - enum: [ ether_clk, hclk, pclk ]
       - enum: [ hclk, pclk ]
-      - const: tx_clk
+      - enum: [ tx_clk, tsu_clk ]
       - enum: [ rx_clk, tsu_clk ]
       - const: tsu_clk
 

-- 
2.51.0


