Return-Path: <netdev+bounces-215305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A67B2E00A
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 16:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EE0E7B33DD
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 14:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FF03218D9;
	Wed, 20 Aug 2025 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I3jqBNGl"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D11C320CCC
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701753; cv=none; b=kDi5AeXevnvCQvHTd0T0L9zTWzP2ILCFTm1hnXFW36U2mmkdsrOBZirFPsztoQx5Em/Xz6B9gSKZ57ygT2wLobJJJpiMAY+lihAAxvrFGB7EImiQObeHzCNHzOXZmY3bfFIvuEHLAXDhivQaFvg4r6uf9m/eM9EPkCwue8aC4m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701753; c=relaxed/simple;
	bh=DGvp8XTAbNeIQIdK1hHPZKMKWnCqv1hyvU/+vQAFNb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aDrHtl5Q89pkjtuKy1NtQmR9nozQjNw5t3AJc45Flb2DQbLH1uRg5JGbGBLyXZwRXq9BIcptVdQqJUP8wZ+GE1UrvsX2LX0+v94FnT1N26+FWstYjmj+IOS5YFlXpMhU+VRaAhHZKG8HK3nBWAE79Vo0YmZNDlki5et8KeuP87o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I3jqBNGl; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7A0DA1A09DD;
	Wed, 20 Aug 2025 14:55:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 533E0606A0;
	Wed, 20 Aug 2025 14:55:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DCF1D1C22C74C;
	Wed, 20 Aug 2025 16:55:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755701748; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AccY9f1aSR6b7hyUSSVrdnIcUcn+hK4CKvMlg1bZh4Y=;
	b=I3jqBNGl4aI/AnqqHFxxPDrOM2AU6VjZ8Y7W5o/jL2pm4yetFcSdnuufWDgOi1DRcb8ejB
	21hYPgfdZKsaxc82zUbixcy27a2zVNY0qn1QaWEKjmiQynTN3XyjPY/xhgB7S+kegLPk6q
	u1xZ0mBj0Ab3odoBjupC2jmmtZFb8vaeCe1/vZBLR0wB3/VtPpVD0h6xKLWwIH+xB8nNqN
	EvVJBNFA3Qo8uGORFrrcYzCUg1s81Kx2WPYJXbysabdR6PiKCqb0FTPhT7es0wjCCO2bkC
	S5aHXWoa0amU7g8cMhjxSfIHyujM0MtOpqJfpAYWo5wMJCBVItPOJhwrTieGGg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 20 Aug 2025 16:55:05 +0200
Subject: [PATCH net v4 1/5] dt-bindings: net: cdns,macb: allow tsu_clk
 without tx_clk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250820-macb-fixes-v4-1-23c399429164@bootlin.com>
References: <20250820-macb-fixes-v4-0-23c399429164@bootlin.com>
In-Reply-To: <20250820-macb-fixes-v4-0-23c399429164@bootlin.com>
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
2.50.1


