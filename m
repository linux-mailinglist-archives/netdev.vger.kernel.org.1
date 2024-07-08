Return-Path: <netdev+bounces-110019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716CF92AB01
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 23:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D126283324
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102F34503B;
	Mon,  8 Jul 2024 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Sy5Os4lL"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662FC12E75;
	Mon,  8 Jul 2024 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720473428; cv=none; b=E/nKZKsN66jlhbVyZV8/RUNDWA1e70iQQBMIfpkPPGeVYhymlnsykLXmr4QFanj/LZw9KPIri1bCC3etDJ5wrTUncgetK4NhL6bC8IGHWvpDouNDNqyr1FLE1zg2kfFeXS49QRP5lT5Xc+uIrr96KoOjc5//vsXMV6YkP5kTz/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720473428; c=relaxed/simple;
	bh=Gb47NSgTk8KeMQ6QOIB2jgpIbdLRRyc+TmxrrJzs7gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XSlreJi8myYXEmjyCtK+RuJjUsFJ7iiryRsB7wkShPYYHuZfXFsS01FIvRQ1BvF/YTkrUamtfCaC9maTC26dfcjPPYmMv9CMa70k/AOi8/KTbiEYS4we0xXnQxBBTbYPUo9MdU2y522JDLhdkvkQg5z1gIbNPliRqtE0jGh8S3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Sy5Os4lL; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 141BA88005;
	Mon,  8 Jul 2024 23:17:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720473424;
	bh=vmX6dadCvDbjdG+XLXPShspD7u1SBCS3VN6+xYc+nxE=;
	h=From:To:Cc:Subject:Date:From;
	b=Sy5Os4lLbmaTptP/Sl5GAc2o6V39PPWWGgkQyV1RfoTsSullJ12FC51FG9xJWucqO
	 1Q/HcWf5fhnI56RfpXstILMh5pBmoeI5qhtOB8NTBt9AXAezMzeIAjpb8MZoSvZpsz
	 EnTlkR5hzDY6XwfB2C2Cgw8HMMbV2MM/5k4biK+iih7Aj78A9AKUqozKYrub5frumu
	 6Y7G+DWnqnlkSpfa1/wxEL/P/wXAMcNRTe3tkpedMgNW0Oy2r0FGIDCYm7Sm5Tiql3
	 gfkEiBKolEpw8kjtfH52pZ6fIEm+Hc23he/od52KInk/YCeuywvssUlAD8oX6Q/qXg
	 5siElgYSULtsA==
From: Marek Vasut <marex@denx.de>
To: netdev@vger.kernel.org
Cc: kernel@dh-electronics.com,
	Marek Vasut <marex@denx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org
Subject: [net-next,PATCH v2] dt-bindings: net: realtek,rtl82xx: Document RTL8211F LED support
Date: Mon,  8 Jul 2024 23:16:29 +0200
Message-ID: <20240708211649.165793-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The RTL8211F PHY does support LED configuration, document support
for LEDs in the binding document.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V2: Invert the conditional
---
 .../bindings/net/realtek,rtl82xx.yaml           | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
index 18ee72f5c74a8..d248a08a2136b 100644
--- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
@@ -14,9 +14,6 @@ maintainers:
 description:
   Bindings for Realtek RTL82xx PHYs
 
-allOf:
-  - $ref: ethernet-phy.yaml#
-
 properties:
   compatible:
     enum:
@@ -41,6 +38,8 @@ properties:
       - ethernet-phy-id001c.cad0
       - ethernet-phy-id001c.cb00
 
+  leds: true
+
   realtek,clkout-disable:
     type: boolean
     description:
@@ -54,6 +53,18 @@ properties:
 
 unevaluatedProperties: false
 
+allOf:
+  - $ref: ethernet-phy.yaml#
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: ethernet-phy-id001c.c916
+    then:
+      properties:
+        leds: false
+
 examples:
   - |
     mdio {
-- 
2.43.0


