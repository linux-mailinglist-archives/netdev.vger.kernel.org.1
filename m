Return-Path: <netdev+bounces-231563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7314BFA9B2
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 09:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF1C18880C4
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 07:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501CC2F3C1D;
	Wed, 22 Oct 2025 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lHMUCVTE"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA57C2F363E
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118720; cv=none; b=VcyBRl1QioE7KZY+YKL3RIoUf2FyyRxpfTOHR8RalI/aofGY2MQDfDthXj5ly/t8cWEgIVz2ZbmXie1DDjZJMbGZulV7eYlo+uhfAWwjoUvy704e+EnY1tjW5ZSdmi+wI2MkxOSdjQ3FG8+DyQJoB0PPGpbXWYVIQeAdJ+maufw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118720; c=relaxed/simple;
	bh=k4MMwotRueKQ73IFVBunfx4WBg3XwCGO4UhdsRh7hww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XJZg+X92lxHRzVkXv4b6wIwHqMJii1E9JtCA92Bu2mzqzzs8o4QgmYLoaELg4wzDdRSfbLg5aT47cIiPe+nfq3i/9Otk9KFombrFDHV3RjpP8NnPKWdD1Mu5SWKV41A75YU7TZvkJpkFc11VDyuw/nZ0O5WyRNxQRVZetVJ6BdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lHMUCVTE; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 96E06C0B8B9;
	Wed, 22 Oct 2025 07:38:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4B6AC606DC;
	Wed, 22 Oct 2025 07:38:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D2502102F2429;
	Wed, 22 Oct 2025 09:38:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761118715; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=L/XpHoQ2KPQc9riZ+r/LMfIVvh/XodPx0VGR9VmHzQ0=;
	b=lHMUCVTESZ6XAwXDRj3ZuKEmu+tEJG5Ab94czNKnvFzLiSGHTQTigA4J06IjxO7y0NIRHn
	f+WPfN/mfOUwJNPKdx+bLvR7Oz4VarTAByGBwJ4amNTsrpS/OGupXpmOGIoifjzTUHs9oF
	e8Wk1p33qqCerz8CFGCpGRvFQ1DW7bDjoHvpoNWLnqMGcukINRRMi/oH8SL5CL+3qakZQ+
	vwy4trbmnkOGLL31Yn4SyxeIgXuixl9aZu+hlAUPPR5cf9MLBwh+yil40vW2FIP4Iy/JNJ
	K4kguJ7rXPzqy67LZA3JV4E+hoGjZT4DDQQN4U+QmSM/dKxu4ZgW4p5LjRTbWw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 22 Oct 2025 09:38:10 +0200
Subject: [PATCH net-next v2 1/5] dt-bindings: net: cdns,macb: add Mobileye
 EyeQ5 ethernet interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251022-macb-eyeq5-v2-1-7c140abb0581@bootlin.com>
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
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add "cdns,eyeq5-gem" as compatible for the integrated GEM block inside
Mobileye EyeQ5 SoCs. It is different from other compatibles in two main
ways: (1) it requires a generic PHY and (2) it is better to keep TCP
Segmentation Offload (TSO) disabled.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 02f14a0b72f9..ea8337846ab2 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -57,6 +57,7 @@ properties:
           - cdns,np4-macb             # NP4 SoC devices
           - microchip,sama7g5-emac    # Microchip SAMA7G5 ethernet interface
           - microchip,sama7g5-gem     # Microchip SAMA7G5 gigabit ethernet interface
+          - mobileye,eyeq5-gem        # Mobileye EyeQ5 SoCs
           - raspberrypi,rp1-gem       # Raspberry Pi RP1 gigabit ethernet interface
           - sifive,fu540-c000-gem     # SiFive FU540-C000 SoC
 
@@ -183,6 +184,15 @@ allOf:
         reg:
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mobileye,eyeq5-gem
+    then:
+      required:
+        - phys
+
 unevaluatedProperties: false
 
 examples:

-- 
2.51.1


