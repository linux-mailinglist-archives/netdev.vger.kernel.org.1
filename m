Return-Path: <netdev+bounces-292330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP5tFfYFF2oO1gcAu9opvQ
	(envelope-from <netdev+bounces-292330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:55:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCFD5E6547
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBE6D310A732
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273DC3F39E7;
	Wed, 27 May 2026 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="06lar+R6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA84352C5C;
	Wed, 27 May 2026 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893402; cv=none; b=Tojnz8rlQUudKCDEDKhORyQ0VLH0UtBJPDiRaM9Rr46lBL34un3UTAqjACuByn5H5HpbPu2yYkllGCcagJUsUshx/ZghumciSW+U7gAZCX9hxorJTMKUZ2dAINL7qa7a+zTqnAHoD6OguL3+6UoymTFGghOXNmRAdkacunYedtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893402; c=relaxed/simple;
	bh=SalqavblfpjEFcIIRR3Sc1qpysX8S50BH5OBhtyL7FY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Tqwq926E+ViilThunuXc5gZ6jDPXuFCgSzEiMhUblwX5FDES7WgsW0w/ON2GWP2a5/luMmxW/ADB+1UHporarCj1n82yWvzlZPok78Dk1PQ/TCm1lDQhCNcUPoCssu5iaRZ+aUxsaSNrN+tzTbzTPmjKdjiu2zDs9ASxxFA6AO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=06lar+R6; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1779893400; x=1811429400;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=SalqavblfpjEFcIIRR3Sc1qpysX8S50BH5OBhtyL7FY=;
  b=06lar+R6T++PNMGHGRr8Bt7XEuZ2C7x9Y4yxdog3NMY7huLcH3QMspZC
   a6UlgdnMUfwnpN9WB6yyAB/RJkqvmJ2YVAiuUjy3jBW5axUChN4M3IWkI
   kclfbCyGc49hRmrbmOv/H4Wad3Hog2ALK+bVTPX4QGbQnY0ne9UzNvRcM
   l+EykSO4snDPeDvyyJPnaVqF0e9vDXkTofBRKhiNWocPB4nkXEa6OQ5+0
   ocw0II2fgjp3uCn5DmJpQh6rPRE0Kup0fxGoBzdEwSG+IwkmOLe3OzRl5
   Wr8VawhosZaHYctZQ43pzHSgMj4Xl3Knd4oXy0sUIMllZlQbC+sYFW43q
   A==;
X-CSE-ConnectionGUID: bNzMd6SARU+LyNGLby8F6Q==
X-CSE-MsgGUID: JOOFyMYATaeaAihwT0OXdg==
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="225366049"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 07:49:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Wed, 27 May 2026 07:49:57 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 27 May 2026 07:49:54 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Wed, 27 May 2026 16:49:17 +0200
Subject: [PATCH net-next v6 2/9] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260527-dsa_lan9645x_switch_driver_base-v6-2-4d409ae64f3c@microchip.com>
References: <20260527-dsa_lan9645x_switch_driver_base-v6-0-4d409ae64f3c@microchip.com>
In-Reply-To: <20260527-dsa_lan9645x_switch_driver_base-v6-0-4d409ae64f3c@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, Russell King
	<linux@armlinux.org.uk>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292330-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.7:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,0.0.0.1:email]
X-Rspamd-Queue-Id: EDCFD5E6547
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add bindings for LAN9645X switch. We use a fallback compatible for the
smallest SKU microchip,lan96455s-switch.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes in v5:
- No changes.

Changes in v4:
- No changes.

Changes in v3:
- remove additionalProperties: true
- remove unnecessary | from description
- change top level $ref to dsa.yaml#/$defs/ethernet-ports
- use ethernet-ports and ethernet-port
- move ethernet-ports under properties instead of patternProperties
- move unevaluatedProperties: false after $ref
- update example to use ethernet-ports and ethernet-port

Changes in v2:
- rename file to microchip,lan96455s-switch.yaml
- remove led vendor property
- add {rx,tx}-internal-delay-ps for rgmii delay
- remove labels from example
- remove container node from example
---
 .../net/dsa/microchip,lan96455s-switch.yaml        | 111 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 112 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml
new file mode 100644
index 000000000000..043fb48922b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/microchip,lan96455s-switch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN9645x Ethernet switch
+
+maintainers:
+  - Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
+
+description:
+  The LAN9645x switch is a multi-port Gigabit AVB/TSN Ethernet switch with
+  five integrated 10/100/1000Base-T PHYs. In addition to the integrated PHYs,
+  it supports up to 2 RGMII/RMII, up to 2 BASE-X/SERDES/2.5GBASE-X and one
+  Quad-SGMII interfaces.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - microchip,lan96455s-switch
+      - items:
+          - enum:
+              - microchip,lan96455f-switch
+              - microchip,lan96457f-switch
+              - microchip,lan96459f-switch
+              - microchip,lan96457s-switch
+              - microchip,lan96459s-switch
+          - const: microchip,lan96455s-switch
+
+  reg:
+    maxItems: 1
+
+  ethernet-ports:
+    type: object
+    patternProperties:
+      "^ethernet-port@[0-8]$":
+        type: object
+        description: Ethernet switch ports
+
+        $ref: dsa-port.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          rx-internal-delay-ps:
+            const: 2000
+
+          tx-internal-delay-ps:
+            const: 2000
+
+$ref: dsa.yaml#/$defs/ethernet-ports
+
+required:
+  - compatible
+  - reg
+  - ethernet-ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ethernet-switch@4000 {
+        compatible = "microchip,lan96459f-switch", "microchip,lan96455s-switch";
+        reg = <0x4000 0x244>;
+
+        ethernet-ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ethernet-port@0 {
+                reg = <0>;
+                phy-mode = "gmii";
+                phy-handle = <&cuphy0>;
+            };
+
+            ethernet-port@1 {
+                reg = <1>;
+                phy-mode = "gmii";
+                phy-handle = <&cuphy1>;
+            };
+
+            ethernet-port@2 {
+                reg = <2>;
+                phy-mode = "gmii";
+                phy-handle = <&cuphy2>;
+            };
+
+            ethernet-port@3 {
+                reg = <3>;
+                phy-mode = "gmii";
+                phy-handle = <&cuphy3>;
+            };
+
+            ethernet-port@7 {
+                reg = <7>;
+                phy-mode = "rgmii";
+                ethernet = <&cpu_host_port>;
+                rx-internal-delay-ps = <2000>;
+                tx-internal-delay-ps = <2000>;
+
+                fixed-link {
+                    speed = <1000>;
+                    full-duplex;
+                    pause;
+                };
+            };
+        };
+    };
+...
+
diff --git a/MAINTAINERS b/MAINTAINERS
index ff75e252cc29..d96b76a5494c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17437,6 +17437,7 @@ M:	Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
 M:	UNGLinuxDriver@microchip.com
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml
 F:	include/linux/dsa/lan9645x.h
 F:	net/dsa/tag_lan9645x.c
 

-- 
2.52.0


