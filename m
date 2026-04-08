Return-Path: <netdev+bounces-276551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBBYAy1X1mn5DwgAu9opvQ
	(envelope-from <netdev+bounces-276551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:25:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E033BCCDD
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B96FD30659D3
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 13:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159EA303A32;
	Wed,  8 Apr 2026 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2ec1Lyqf"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C6D2F39B4;
	Wed,  8 Apr 2026 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775654341; cv=none; b=SIuK+riEds/oKkjvpe5JQqAom/i0tY34ok+INuEzqbUm274KDyMyNR9TjotM9282Fz/+bX5Xmm02wont0pV5RIipf509nAeAOlK1a3UYHrZ4lEqM1ox/op8GLJXWk9AyqeZ/I8pOXZErvTE7QY5ZsYjmpITNY3YZ4WTB+oeo9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775654341; c=relaxed/simple;
	bh=yuIyXukk9Sp6FPHkyBlGYAvLU1bo1+o8OkZSeIJ63Uw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWdcAX0fWXQki8QYCbwezwug7ROStR01HEnUElCDxG3HfMbsdmE7y8KJ3T7tM1y0ViSi/U0XWR3w/P9VqurTKG8DyaxV7oQxC+CXUBuntr6iOYluKA5n/fibF/bgnprWg4XBif4SAck18y9BNWWHaD4/XJGtZbLNvly1JhAeodk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2ec1Lyqf; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775654338; x=1807190338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yuIyXukk9Sp6FPHkyBlGYAvLU1bo1+o8OkZSeIJ63Uw=;
  b=2ec1LyqfEd73kqO64pEVQXXs0yEytkC6s5xtsPJun8ILcYacsdVTxo+i
   n3Nj2ip8tywE019xehvjBk0qSauCmrLkbTp4OvUCJz98UX3fveRmuJQzw
   bWSgjWhglqClQCw3m+9rMQXPWkew8E7xzX3EqHbh9YvTFTBn03TJYdiZO
   KfAyn6JAkPYk1CmEF/6OlgECIC8AskrB6dgx6lRGceifPGW44vGxMSS46
   qv1DdgqoiUylDKvWDX+3LzbWQ1bH5q+EwRGSXLKGwPo4uMyQXN2PgLTdn
   ZZVVUVTpwPVnuxen3b6rfZUZQJHO57jyUpdVsfLhrMgGTprk3mXWpc35f
   A==;
X-CSE-ConnectionGUID: BR2izZaeTd24uGudQ9OtxQ==
X-CSE-MsgGUID: bLZGc0KtRX6MiyL09H3ZXA==
X-IronPort-AV: E=Sophos;i="6.23,167,1770620400"; 
   d="scan'208";a="287197573"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Apr 2026 06:18:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 8 Apr 2026 06:18:49 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 8 Apr 2026 06:18:49 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: <MameMaria.Mbaye@microchip.com>, Charles Perry
	<charles.perry@microchip.com>, Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v5 1/3] dt-bindings: net: document Microchip PIC64-HPSC/HX MDIO controller
Date: Wed, 8 Apr 2026 06:18:14 -0700
Message-ID: <20260408131821.1145334-2-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260408131821.1145334-1-charles.perry@microchip.com>
References: <20260408131821.1145334-1-charles.perry@microchip.com>
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
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276551-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,microchip.com:dkim,microchip.com:email,microchip.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8E033BCCDD
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
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---

Notes:
    Changes in v5:
      - Collect Conor's Acked-by
      - Remove the "|" in "description: |" (Rob)
      - Don't mention how many instances of the MDIO controller there are (Rob)
      - Hex addresses are now in lowercase (Rob)
      - Drop the phy DT label in the example (Rob)
    
    Changes in v4: none
    Changes in v3: none
    
    Changes in v2:
      - Make "clocks" and "interrupts" required (Andrew)
      - Add a default value to "clock-frequency" (Andrew)
    
    Changes in v5: none
    Changes in v4: none
    Changes in v3: none
    
    Changes in v2:
      - Make "clocks" and "interrupts" required (Andrew)
      - Add a default value to "clock-frequency" (Andrew)

 .../net/microchip,pic64hpsc-mdio.yaml         | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml

diff --git a/Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml b/Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
new file mode 100644
index 000000000000..20f29b71566b
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
+description:
+  This is the MDIO bus controller present in Microchip PIC64-HPSC/HX SoCs. It
+  supports C22 and C45 register access and is named "MDIO Initiator" in the
+  documentation.
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
+        mdio@4000c21e000 {
+            compatible = "microchip,pic64hpsc-mdio";
+            reg = <0x400 0x0c21e000 0x0 0x1000>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            clocks = <&svc_clk>;
+            interrupt-parent = <&saplic0>;
+            interrupts = <168 IRQ_TYPE_LEVEL_HIGH>;
+
+            ethernet-phy@0 {
+                reg = <0>;
+            };
+        };
+    };
-- 
2.47.3


