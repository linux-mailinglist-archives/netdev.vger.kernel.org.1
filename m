Return-Path: <netdev+bounces-273613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CriBFPCy2mnLgYAu9opvQ
	(envelope-from <netdev+bounces-273613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:47:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70868369AF2
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C74B308850D
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B89C3E0256;
	Tue, 31 Mar 2026 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bFPPE8e0"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC52BD59C;
	Tue, 31 Mar 2026 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774960825; cv=none; b=FHnBSDfihaUltYrsAowHuSh0ytlYqQBJL1s6vRGV9KnSPZzqKfqVugj4iBMZu1xIWeUn+HWLfpVY3hU34LKrrAzPWr+66vYKYCzXmEibfP4tB3BEpnjW4pv9hNkAT3eyyr6Ci87uctMQAGLZ8H73raogMo5oWH6MLB+1uibyUxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774960825; c=relaxed/simple;
	bh=yUiDDpq+rr1MEEEogPrsjwi9iImRyO9leyo0H47IgzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwKhXa29EHd7404ekdmkJYf9j9dHFrAaYf3tTb8z7Xb9RPdiM7Xw7H3W6/BYqbNBCl1aO2SCt8bazpRD6TjdjnGpqUuWu5tTpLURDKn23f49gvNKSIF9TIhM4IgBayFeS2djyBfZI/mvFYAdJdITWJTZq2bT8MMttR0E8ob1ITk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bFPPE8e0; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774960822; x=1806496822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yUiDDpq+rr1MEEEogPrsjwi9iImRyO9leyo0H47IgzM=;
  b=bFPPE8e0hwWPG2g38m1TJ3B0w0fQEkZ7qmtfFqF6oNoRcbxtkhNe91m4
   +BrvwB1b58W8gWB2J6uasN0DZdAmCqLmKL/QgbWkx/1wdfkTa69E0UQMf
   +QyCPxHnjL+8Mhx2MtE52n01uJNhErlBK7Q0/t35iv7svJiFrllO7EJI3
   ZPdvXVq+aiJjDfEBy1P3OjbhToJspi6nzCmV1NvIaDNARvfzozsPhq7rF
   WrULKApcFsYtxVY6n++tPAoG13Dy5Upz488jt9D5E5mpbnQv0POen74fV
   sA4M9mV7s4mmYVAo42iUrNHqP3Fmnfh1LM1Snmpj3Nl4W5/DQ+3zLtc2L
   Q==;
X-CSE-ConnectionGUID: PC7S4TvrRzGRutD8ffSIyA==
X-CSE-MsgGUID: lEcwdU0sT7yLIWC35Cy+mw==
X-IronPort-AV: E=Sophos;i="6.23,151,1770620400"; 
   d="scan'208";a="55888995"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Mar 2026 05:40:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 31 Mar 2026 05:39:53 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 31 Mar 2026 05:39:52 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 1/2] dt-bindings: net: document Microchip PIC64-HPSC/HX MDIO controller
Date: Tue, 31 Mar 2026 05:38:53 -0700
Message-ID: <20260331123858.1912449-2-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331123858.1912449-1-charles.perry@microchip.com>
References: <20260331123858.1912449-1-charles.perry@microchip.com>
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
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273613-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[4000c21e000:email,0.0.0.0:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:dkim,microchip.com:email,microchip.com:mid,devicetree.org:url]
X-Rspamd-Queue-Id: 70868369AF2
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
    Changes in v3: none
    
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


