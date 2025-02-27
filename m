Return-Path: <netdev+bounces-170196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE39A47C03
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 12:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87593B13BE
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 11:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD19222D4E3;
	Thu, 27 Feb 2025 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="j9uRAdCL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m3289.qiye.163.com (mail-m3289.qiye.163.com [220.197.32.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3F8137E;
	Thu, 27 Feb 2025 11:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655342; cv=none; b=DsM6lSlwV5+/MMDQOVqS5Z0n9OmIxYe4bOhw7wmahh/uwetHFZmNQRRHapUuw/SZLFY/Si7UiEcd73h80mD44wdXi7S8Q4Nrgi/GFSmkWKHC91YgqKCBJ3skhfUBzgzO1wo7xk93MdwbEJNoLGv8SHYlr4iUiCVXqdWvGNcYA+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655342; c=relaxed/simple;
	bh=Iz86wunlX8HUmL1XH3Sb+R8oMx3eu/od7nb4OIXVqX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tG+yEgwHUktaHMkJrJPfAU54SiYmxlKdu4Bcm6ZUZBFxWYfISoJwyithNu3ryWPhxXOP+NP7UyyvzIWJrdq1uiF3OHWm2ag+f0H8qGjHImlOnXdqYG8WNHursILSOie5DjrUVITCvcYxfCeRrODoejtSMiNkRJ+nCMzhwUakDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=j9uRAdCL; arc=none smtp.client-ip=220.197.32.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id c65b3753;
	Thu, 27 Feb 2025 19:06:54 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	Jose Abreu <joabreu@synopsys.com>,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Rob Herring <robh@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Wu <david.wu@rock-chips.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/3] dt-bindings: net: Add support for rk3562 dwmac
Date: Thu, 27 Feb 2025 19:06:50 +0800
Message-Id: <20250227110652.2342729-1-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUMdTFYaGB0fTkgYQkwYTB5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9547168b4f03afkunmc65b3753
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBA6CQw6LTINIw0LKBISDCwI
	GkMwFDNVSlVKTE9LTU5PT0pNSUxMVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTUpNNwY+
DKIM-Signature:a=rsa-sha256;
	b=j9uRAdCLAZBHyRBM1IUi9c3b2iIQOdTnuvJYVQRSibTDS2vPxDZgM9Kh5jNR7JJhEOVr6gv0fcG8RyEpo1XI1DybHcqnXSDVGdsAQod763cpywfJrLJvxipXeODZZVgniCX3amL7w9YMfU01llaOFXSsf4SwYRnFxIFkO7z45Ow=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=xV+WNQl8ROCA2e9xUBpBg/FLDkWJ/IRVuqOd98DcSZE=;
	h=date:mime-version:subject:message-id:from;

Add a rockchip,rk3562-gmac compatible for supporting the 2 gmac
devices on the rk3562.
rk3562 only has 4 clocks availabl for gmac module.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v2:
- Fix schema entry and add clocks minItem change

 .../bindings/net/rockchip-dwmac.yaml          | 23 +++++++++++++++----
 .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index f8a576611d6c..81ddad924e35 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -24,6 +24,7 @@ select:
           - rockchip,rk3366-gmac
           - rockchip,rk3368-gmac
           - rockchip,rk3399-gmac
+          - rockchip,rk3562-gmac
           - rockchip,rk3568-gmac
           - rockchip,rk3576-gmac
           - rockchip,rk3588-gmac
@@ -32,9 +33,6 @@ select:
   required:
     - compatible
 
-allOf:
-  - $ref: snps,dwmac.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -52,6 +50,7 @@ properties:
               - rockchip,rv1108-gmac
       - items:
           - enum:
+              - rockchip,rk3562-gmac
               - rockchip,rk3568-gmac
               - rockchip,rk3576-gmac
               - rockchip,rk3588-gmac
@@ -59,7 +58,7 @@ properties:
           - const: snps,dwmac-4.20a
 
   clocks:
-    minItems: 5
+    minItems: 4
     maxItems: 8
 
   clock-names:
@@ -117,6 +116,22 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  - $ref: snps,dwmac.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3562-gmac
+    then:
+      properties:
+        clocks:
+          minItems: 4
+    else:
+      properties:
+        clocks:
+          minItems: 5
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 91e75eb3f329..97d42ab8d374 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -82,6 +82,7 @@ properties:
         - rockchip,rk3328-gmac
         - rockchip,rk3366-gmac
         - rockchip,rk3368-gmac
+        - rockchip,rk3562-gmac
         - rockchip,rk3576-gmac
         - rockchip,rk3588-gmac
         - rockchip,rk3399-gmac
-- 
2.25.1


