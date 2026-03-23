Return-Path: <netdev+bounces-270758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KDiH7u4wWm/UwQAu9opvQ
	(envelope-from <netdev+bounces-270758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:03:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0D82FE081
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80031301F3BB
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8B5382296;
	Mon, 23 Mar 2026 22:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UAB2gtuY"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A3436B076;
	Mon, 23 Mar 2026 22:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303415; cv=none; b=CvdILwEJY0BNPUPkqODBiFx/9xhn9axEtRVdZYu8JbT09xVyzr7B/L0czVB2clrYn1ax8w7tTymXCY3D5SAz9woIoxC7q4qfNff9qb1sLLpq8tA7inbjDsUHW43JJH0wqYwVK66Hqh0apMqXIGKIaOshhNiS9NCHqpYcBcSQlbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303415; c=relaxed/simple;
	bh=zK70z78hvfYzmL1ZSSd4XVv1IObYxslhdrOlu+be608=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0DmIz/XvzCXzgKoO2zL3yzBkJ5pL3jH0/6+k3h32Pu+GxwkO+d33ejeDtPc2RYRzLwyShZLM/1BnQxgOdh3Bqo+gnkTWpWfgKC3qeva1IE02PaZ5DBeebSrNV8mjlLfKjy3d91O7Ng3Or8FClXKPyy2jw0tpd7YjbdTYP4iBIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UAB2gtuY; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774303414; x=1805839414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zK70z78hvfYzmL1ZSSd4XVv1IObYxslhdrOlu+be608=;
  b=UAB2gtuYrM05spiMpgrIRzlUnUw7SndSGMUG2O3NXaJ5ZXQA+fu84kg2
   EysjEvzlfqlTatgCA7p6WjZS5IrbrS7YhBMWn6T8D9lWJuv32SO3BXLs1
   4dicetnJl2IW7OYiVkqJ6GYU4ZArnZPaZID7Y0UYnUqKgdt/P1UQHQhss
   0KalXZMDX0PswSDDSHRp/i8ntkpq0x04RBKkSunIoWZMCP7pb3HYP+ilH
   T5iT9IT9oOodKpFdh+nPKITNnFriAjn8z7+GX3MZ4zlamNQg5Yc0kC0eY
   +W2i5WHhkBpzzR7uDbM/oI1DYYCaH9FG6lhqUYgwajAynpujPQkCJqa9y
   A==;
X-CSE-ConnectionGUID: sn68fJ6gSty0fdZcGeqDMQ==
X-CSE-MsgGUID: l7F8d5J2RHqC5U0KKtZDLg==
X-IronPort-AV: E=Sophos;i="6.23,138,1770620400"; 
   d="scan'208";a="222348044"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 15:03:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 23 Mar 2026 15:03:07 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 23 Mar 2026 15:03:07 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 1/2] dt-bindings: net: document Microchip PIC64-HPSC/HX MDIO controller
Date: Mon, 23 Mar 2026 15:02:53 -0700
Message-ID: <20260323220254.3822444-2-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323220254.3822444-1-charles.perry@microchip.com>
References: <20260323220254.3822444-1-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270758-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,0.0.0.0:email,microchip.com:dkim,microchip.com:email,microchip.com:mid]
X-Rspamd-Queue-Id: 1F0D82FE081
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This MDIO hardware is based on a Microsemi design supported in Linux by
mdio-mscc-miim.c. However, The register interface is completely different
with pic64hpsc, hence the need for separate documentation.

The hardware supports C22 and C45.

The documentation recommends an input clock of 156.25MHz and a prescaler
of 39, which yields an MDIO clock of 1.95MHz.

The hardware supports an interrupt pin to signal transaction completion
which is not strictly needed as the software can also poll a "TRIGGER"
bit for this.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---

Notes:
    Changes in v2:
      - Make "clocks" and "interrupts" required (Andrew)
      - Add a default value to "clock-frequency" (Andrew)

 .../net/microchip,pic64hpsc-mdio.yaml         | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml

diff --git a/Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml b/Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
new file mode 100644
index 000000000000..d690afe3d3cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/microchip,pic64hpsc-mdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PIC64-HPSC/HX MDIO controller
+
+maintainers:
+  - Charles Perry <charles.perry@microchip.com>
+
+description: |
+  Microchip PIC64-HPSC/HX SoCs have two MDIO bus controller. This MDIO bus
+  controller supports C22 and C45 register access. It is named "MDIO Initiator"
+  in the documentation.
+
+allOf:
+  - $ref: mdio.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: microchip,pic64hpsc-mdio
+      - items:
+          - const: microchip,pic64hx-mdio
+          - const: microchip,pic64hpsc-mdio
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-frequency:
+    default: 2500000
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mdio@4000C21E000 {
+            compatible = "microchip,pic64hpsc-mdio";
+            reg = <0x400 0x0C21E000 0x0 0x1000>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            clocks = <&svc_clk>;
+            interrupt-parent = <&saplic0>;
+            interrupts = <168 IRQ_TYPE_LEVEL_HIGH>;
+
+            phy0: ethernet-phy@0 {
+                reg = <0>;
+            };
+        };
+    };
-- 
2.47.3


