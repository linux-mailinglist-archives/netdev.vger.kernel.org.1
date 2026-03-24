Return-Path: <netdev+bounces-270985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOzuKcJswmmncwQAu9opvQ
	(envelope-from <netdev+bounces-270985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:51:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D80306BF1
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73D6A30565DE
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982BC38238F;
	Tue, 24 Mar 2026 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="A0hOpZeF"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC823E3C74;
	Tue, 24 Mar 2026 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349419; cv=none; b=NzksU4FzcJubS7jTEPZTjFgD+W1G+Z2gMFQvq2kyPXiIEj0q9pm0Vb91eyXOBexKHf2vLB8dwMUeZBG9WgKEDeW34GMn+RTYdIRh5uJcKFR+9EAGz2TMdC5D6m3G1F48qjCMtu4SCIAPkswV4lsZ7sffo4SoiLG9MCBloVhczv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349419; c=relaxed/simple;
	bh=WprweT4wU4c5WeT/btKLTnLngB4K42XTYOSoMUk3+So=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IpkZmwqQTEuTm4kfkDjYXy8lhYpXqSJjt1Y9x9U8c6RIsysD1LaDB9ddW9rzkpk9Fd0UVUeRAhE8O/FazeWR1i7XCbV9uygSQ2UOMHKf9ky2Lx8acZ9u/D22nAbLzzXS4+DJtVXCXiCLGsaguvvoYu5VpWdFyd1MoVy+Btjvsa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=A0hOpZeF; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774349417; x=1805885417;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=WprweT4wU4c5WeT/btKLTnLngB4K42XTYOSoMUk3+So=;
  b=A0hOpZeFctKFSEXi4IgBd/xhQR/XGXQpE9heX2kRMzhcW6Z3inoKmiaL
   ZP1FjQ+bILqSKkxzWEqsNiJ1swqgO6gDc85P3dd+YWbe38raPyBkk5Dk3
   2jiIHTjoTdpDk//MQshZp9/Bu8MHJicPMlwHxaTh8LR14nZiytFZDhQ1P
   m7A4/ChCA4kY/w4inkVPBTvlVD9pDvvSUwGyt7gQA15uJnGM+wVviHICW
   CiwNETFq3CM1LR5DhfTT+C2QCHwlb0YGSavuUfcfuH5Pxb7/S+7rYZDI+
   SCVG9S4cmu+SXIW38sUWfk99jI9SPgOZL9sWOUnpdHRDYHmlXKYIR+dI8
   w==;
X-CSE-ConnectionGUID: XI13arZSSLqPAvmg8vZ9dw==
X-CSE-MsgGUID: EiRkJ2IQS6iRQzMs3KFSWw==
X-IronPort-AV: E=Sophos;i="6.23,138,1770620400"; 
   d="scan'208";a="222375786"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 03:50:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 24 Mar 2026 03:50:10 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 24 Mar 2026 03:50:06 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Tue, 24 Mar 2026 11:46:45 +0100
Subject: [PATCH net-next v2 2/9] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260324-dsa_lan9645x_switch_driver_base-v2-2-f7504e3b0681@microchip.com>
References: <20260324-dsa_lan9645x_switch_driver_base-v2-0-f7504e3b0681@microchip.com>
In-Reply-To: <20260324-dsa_lan9645x_switch_driver_base-v2-0-f7504e3b0681@microchip.com>
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
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-270985-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	DBL_PROHIBIT(0.00)[0.0.0.2:email,0.0.0.3:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,0.0.0.1:email,microchip.com:dkim,microchip.com:email,microchip.com:mid,devicetree.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.0.7:email]
X-Rspamd-Queue-Id: 15D80306BF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add bindings for LAN9645X switch. We use a fallback compatible for the
smallest SKU microchip,lan96455s-switch.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Changes in v2:
- rename file to microchip,lan96455s-switch.yaml
- remove led vendor property
- add {rx,tx}-internal-delay-ps for rgmii delay
- remove labels from example
- remove container node from example
---
 .../net/dsa/microchip,lan96455s-switch.yaml        | 119 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 120 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml
new file mode 100644
index 000000000000..0282e25c05d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml
@@ -0,0 +1,119 @@
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
+          rx-internal-delay-ps:
+            const: 2000
+
+          tx-internal-delay-ps:
+            const: 2000
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
+    ethernet-switch@4000 {
+        compatible = "microchip,lan96459f-switch", "microchip,lan96455s-switch";
+        reg = <0x4000 0x244>;
+
+        ethernet-ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                phy-mode = "gmii";
+                phy-handle = <&cuphy0>;
+            };
+
+            port@1 {
+                reg = <1>;
+                phy-mode = "gmii";
+                phy-handle = <&cuphy1>;
+            };
+
+            port@2 {
+                reg = <2>;
+                phy-mode = "gmii";
+                phy-handle = <&cuphy2>;
+            };
+
+            port@3 {
+                reg = <3>;
+                phy-mode = "gmii";
+                phy-handle = <&cuphy3>;
+            };
+
+            port@7 {
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
index 7ae698067c41..8232da1b3951 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17278,6 +17278,7 @@ M:	Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
 M:	UNGLinuxDriver@microchip.com
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml
 F:	include/linux/dsa/lan9645x.h
 F:	net/dsa/tag_lan9645x.c
 

-- 
2.52.0


