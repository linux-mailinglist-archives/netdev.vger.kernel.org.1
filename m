Return-Path: <netdev+bounces-263183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IJjAjDWpmnHWgAAu9opvQ
	(envelope-from <netdev+bounces-263183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:38:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD9A1EF90F
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6922931A5481
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 12:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68948346A0A;
	Tue,  3 Mar 2026 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="k4ViqbmM"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977BA344DA4;
	Tue,  3 Mar 2026 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772540636; cv=none; b=N95GBrpADv57Z6X0KvEViIh3R3/AcGfmp2Gbz6YKPtpJJHL+iYJ7fSZrhT9LXUHCkNrrjcNQNla9BWnqg0b0bgpQRtA9iWPJUYcfCHn7GyvBEpa+cWVR6V/ZfMxCcSVZM5vUWe7pvW1gJrQTXyuxF/GKulQx1ov1ALSmxssYu2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772540636; c=relaxed/simple;
	bh=Kjyovhs8Lxs6YwyNnkUmriJuuT4MKPZ15t6xIB1cWH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QLsV5t0jioE4l2XJZAEnBxWRRpp28A+tCrpj4rxtGoutCQyLPHEfFvvWLSIF2Ud/alaz9TpzBFveAAotVBYdKqo5hyBVBioCsw0FP2v6El+VDoSrhRlgbtSLFgna3TLhI1yUH2k2A2kBjdqZ2Sa5sR81Kod7KHmny+2k85ezvWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=k4ViqbmM; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772540634; x=1804076634;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Kjyovhs8Lxs6YwyNnkUmriJuuT4MKPZ15t6xIB1cWH4=;
  b=k4ViqbmMinqlgrYghnfzDoTZy7C0aeZHulcgfXT6xnt7mDc2Op3XX748
   P773DDBl3nZXNhrAlvKxczAmvsO0HXmDbReAJ79W0tYcWKsJTkNGAti2U
   o0HJSylSqyHbGly82BeVgttJzv9Xcau/kbIR5SXphW2sB+1nPdyx0pcYm
   t5aR8YCAW2aHE5/b3eX6JZ7nvn3xO4l4bE5Q3AAwHyx18F3xRgS7OelVx
   xlKzxQV1uPWtv+W+8uCcezx247tCAtD+O24BCDlHJuR0si9m97eKbetIc
   KMOvpGkFx7fxavyhlN6KFYwX8At2HfW7UD8yJudf3mM5TuCESZDJNA5/W
   w==;
X-CSE-ConnectionGUID: Bvv5iBs2RB2HNvVYiRTm5Q==
X-CSE-MsgGUID: a/mrEwe1Qtq1nkw5nKuaRg==
X-IronPort-AV: E=Sophos;i="6.21,321,1763449200"; 
   d="scan'208";a="53397695"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 05:23:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 3 Mar 2026 05:23:26 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 3 Mar 2026 05:23:23 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Tue, 3 Mar 2026 13:22:28 +0100
Subject: [PATCH net-next 2/8] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
In-Reply-To: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
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
X-Rspamd-Queue-Id: 5BD9A1EF90F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263183-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:dkim,microchip.com:email,microchip.com:mid,0.0.0.0:email,0.0.0.2:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,0.0.0.1:email,0.0.0.7:email,0.0.0.3:email]
X-Rspamd-Action: no action

Add bindings for LAN9645X switch. We use a fallback compatible for the
smallest SKU microchip,lan96455s-switch.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
 .../net/dsa/microchip,lan9645x-switch.yaml         | 137 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 138 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan9645x-switch.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan9645x-switch.yaml
new file mode 100644
index 000000000000..4a19dfa7e9d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan9645x-switch.yaml
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/microchip,lan9645x-switch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN9645x Ethernet switch
+
+maintainers:
+  - Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
+
+description: |
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
+$ref: dsa.yaml#
+
+patternProperties:
+  "^(ethernet-)?ports$":
+    type: object
+    additionalProperties: true
+    patternProperties:
+      "^(ethernet-)?port@[0-8]$":
+        type: object
+        description: Ethernet switch ports
+
+        $ref: dsa-port.yaml#
+
+        properties:
+          microchip,led-drive-mode:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: |
+              Set the LED drive mode for the copper PHY associated with
+              this port.
+
+                0 - LED1 and LED2 in open-drain mode
+                1 - LED1 in active drive mode (can be used for single-LED
+                    configurations requiring active drive)
+                2 - Reserved
+                3 - LED1 and LED2 in active drive mode
+            minimum: 0
+            maximum: 3
+
+        unevaluatedProperties: false
+
+oneOf:
+  - required:
+      - ports
+  - required:
+      - ethernet-ports
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+      ethernet-switch@0 {
+        reg = <0>;
+        compatible = "microchip,lan96459f-switch", "microchip,lan96455s-switch";
+        pinctrl-0 = <&lan9645x_leds>;
+        pinctrl-names = "default";
+
+        ethernet-ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          port@0 {
+            reg = <0>;
+            label = "lan0";
+            phy-mode = "gmii";
+            phy-handle = <&cuphy0>;
+          };
+
+          port@1 {
+            reg = <1>;
+            label = "lan1";
+            phy-mode = "gmii";
+            phy-handle = <&cuphy1>;
+            microchip,led-drive-mode = <3>;
+          };
+
+          port@2 {
+            reg = <2>;
+            label = "lan2";
+            phy-mode = "gmii";
+            phy-handle = <&cuphy2>;
+          };
+
+          port@3 {
+            reg = <3>;
+            label = "lan3";
+            phy-mode = "gmii";
+            phy-handle = <&cuphy3>;
+          };
+
+          port@7 {
+            reg = <7>;
+            label = "lan7";
+            phy-mode = "rgmii-id";
+            ethernet = <&cpu_host_port>;
+            fixed-link {
+              speed = <1000>;
+              full-duplex;
+              pause;
+            };
+          };
+        };
+      };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 2712aaf7cedd..ab92b342877b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17291,6 +17291,7 @@ M:	Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
 M:	UNGLinuxDriver@microchip.com
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/dsa/microchip,lan9645x-switch.yaml
 F:	include/linux/dsa/lan9645x.h
 F:	net/dsa/tag_lan9645x.c
 

-- 
2.52.0


