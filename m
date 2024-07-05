Return-Path: <netdev+bounces-109575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B6E928EF9
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 23:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705F32840D5
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 21:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04191145A00;
	Fri,  5 Jul 2024 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="mdXhu0i9"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA17146A60;
	Fri,  5 Jul 2024 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720216345; cv=none; b=c4cVg1haD+a7l941LsxK5IN57QdcOLFXw/uGNKFNuj+YW5i7RY2tRhCqCHXdrloGax3+t/862Rb0ne7Q+GUxX5U6+UXQqv0yFzsQyRlFU/GT1G/JlxhedAk1+2rKc482Ih7+M1qDPOGPZecpX/S3sp3F54qdRzzVQ5SlgCBHdGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720216345; c=relaxed/simple;
	bh=1vKtuRaH9gKpBZAiWoc/J32GV2s67Oe3VAbvYAW3/r8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LXBgyJNR/c4tZZisS52egzIH0uuXpi9mV+fC6OXjlV834ko32eX/qnJj38eOWYEhXMb8Ti0AcaF9gVACKseW5mMnIpr57yIKg1D1geLYi6G4Lz/TIGfLT8SZvxEgw95bDq/m8mXpBF2C6KIVm7BemVAq1qv/gqz8rjGX+tvNn8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=mdXhu0i9; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 7557A881AD;
	Fri,  5 Jul 2024 23:52:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720216342;
	bh=mmPEDXeUzKDrsT/n6IOWn3L16waosfQl1rURoOzvHSs=;
	h=From:To:Cc:Subject:Date:From;
	b=mdXhu0i9sEGQU+jYqEBa1WYW8msbexl/BdFKnVmV5RqqRq9y3U81zMFnl4BFYyzGv
	 Y22gZZDdHU2WFl2pCSdv9biPMs78mQTeHXQziptm1KQfKNUHtLQLVIEe6pfm7PwaRJ
	 +y8I+sLWIvAT7RkidujC+khA+fLTYBjhVCzZEi4Po25s6SivUVC7HWFCK3pyNGAcEI
	 u/1kjUpsQvePxCXKav9NnYOUrmL1hgXEnqUXPfq3lGoe8R2eS2ZIwwbm6RkN5vCoyr
	 XsrJC5MQc4Eq1/MmkVxwYbwTswbnWtlMmhuZK8JB4Un0uQd8jCv/4CO6k0CEdBTpF3
	 09C4j38Fs4cMQ==
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
Subject: [net-next,PATCH] dt-bindings: net: realtek,rtl82xx: Document RTL8211F LED support
Date: Fri,  5 Jul 2024 23:51:46 +0200
Message-ID: <20240705215207.256863-1-marex@denx.de>
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
 .../devicetree/bindings/net/realtek,rtl82xx.yaml   | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
index 18ee72f5c74a8..28c048368073b 100644
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
@@ -54,6 +51,17 @@ properties:
 
 unevaluatedProperties: false
 
+allOf:
+  - $ref: ethernet-phy.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ethernet-phy-id001c.c916
+    then:
+      properties:
+        leds: true
+
 examples:
   - |
     mdio {
-- 
2.43.0


