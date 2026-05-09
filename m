Return-Path: <netdev+bounces-286125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFA5BDD5/mnu0gAAu9opvQ
	(envelope-from <netdev+bounces-286125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 11:06:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 082B14FEE5D
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 11:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 286C9300980E
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 09:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836053921E9;
	Sat,  9 May 2026 09:06:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79CC39182F;
	Sat,  9 May 2026 09:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778317608; cv=none; b=jfaBkQElTk9+GIvSz+NuNHdBV8tnmNSQZEbGLL0s8U3gcGQCeAaArtgUcWHXXJp7FC9Ovkn/pY2SjnM6V8MkTRezVldETRZPBllRRsNiWVW9R5cvz260yZRktKIqHBCmQcUGV87QMvtN3XyPfGNTNirxQr9yEX32UP76SnIxzAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778317608; c=relaxed/simple;
	bh=h1+7lv2En9A9Y3oByUmfMZdtOTfI2m9v4qFbQvPD20E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swBjW9TiThlScE1foaC4dxNCCv8PfvMvMQXiZ0mChsYvIU95WHAJ+D5rWmBzKU1+BwXsL572OPXIakSoor8GYXFZY230oAJI+1AzWf4MgFjSJoyhjZfFE0fKZh38Wo06W2dKFfknW0yWCPpf+FcUAH8b3tfoa3iHn7hLzjoP/LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B6D18202343;
	Sat,  9 May 2026 11:06:44 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7F6CB20232C;
	Sat,  9 May 2026 11:06:44 +0200 (CEST)
Received: from lsvm11u0000621.swis.ap-northeast-2.aws.nxp.com (lsvm11u0000621.swis.ap-northeast-2.aws.nxp.com [10.52.8.159])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9CE4618002D1;
	Sat,  9 May 2026 17:06:42 +0800 (+08)
From: Minghuan Lian <minghuan.lian@nxp.com>
To: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Minghuan Lian <minghuan.lian@nxp.com>
Subject: [PATCH net-next 1/4] dt-bindings: net: dsa: add NXP i.MX RT1180 NETC switch
Date: Sat,  9 May 2026 18:06:29 +0900
Message-ID: <20260509090632.2959553-2-minghuan.lian@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509090632.2959553-1-minghuan.lian@nxp.com>
References: <20260509090632.2959553-1-minghuan.lian@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Queue-Id: 082B14FEE5D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nxp.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-286125-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minghuan.lian@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.325];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.2:email,0.0.0.1:email];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[i.mx:url,0.0.0.0:email,nxp.com:email,nxp.com:mid,0.0.0.3:email,devicetree.org:url]
X-Rspamd-Action: no action

Document the Devicetree binding for the TSN-capable NETC Ethernet switch
integrated in NXP i.MX RT1180.

The i.MX RT1180 is an MCU and does not run Linux. In heterogeneous
multi-SoC systems, the RT1180 runs firmware that manages the NETC
switch, while the host SoC runs Linux and exposes the switch ports
through the DSA framework using a dedicated CPU (conduit) port
connected to a host Ethernet controller.

The control plane is accessed through a management link to the
companion MCU. Current systems use SPI, but future integrations may
use a different transport (e.g. in-band management over an Ethernet
port). Therefore this binding defines a generic compatible string for
the NETC switch and an optional SPI-specific compatible string for
SPI-attached deployments.

Signed-off-by: Minghuan Lian <minghuan.lian@nxp.com>
---
 .../net/dsa/nxp,imxrt1180-netc-switch.yaml    | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/nxp,imxrt1180-netc-switch.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,imxrt1180-netc-switch.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,imxrt1180-netc-switch.yaml
new file mode 100644
index 0000000000000..6ca1f5eba8748
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/nxp,imxrt1180-netc-switch.yaml
@@ -0,0 +1,118 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/nxp,imxrt1180-netc-switch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX RT1180 NETC Ethernet Switch
+
+description: |
+  The NXP i.MX RT1180 integrates a TSN-capable NETC Ethernet switch.
+
+  The i.MX RT1180 is an MCU and does not run Linux. In heterogeneous multi-SoC
+  systems, the RT1180 runs firmware that manages the switch, while the host SoC
+  runs Linux and exposes the switch ports using the DSA framework, with a
+  dedicated CPU (conduit) port connected to a host Ethernet controller.
+
+  The switch control plane is accessed through a management link to the
+  companion MCU. Current systems may use SPI, but other transports may be used
+  in the future (for example, in-band management over an Ethernet port).
+
+maintainers:
+  - Minghuan Lian <minghuan.lian@nxp.com>
+
+allOf:
+  # Base: always a DSA switch
+  - $ref: /schemas/net/dsa/dsa.yaml#
+
+  # If the SPI-specific compatible is used, allow SPI properties and require reg.
+  - if:
+      properties:
+        compatible:
+          type: array
+          contains:
+            const: nxp,imxrt1180-netc-switch-spi
+    then:
+      $ref: /schemas/spi/spi-peripheral-props.yaml#
+      required:
+        - reg
+
+properties:
+  compatible:
+    oneOf:
+      # SPI-attached switch representation (current integration)
+      - items:
+          - const: nxp,imxrt1180-netc-switch-spi
+          - const: nxp,imxrt1180-netc-switch
+      # Transport-agnostic representation (future integration)
+      - const: nxp,imxrt1180-netc-switch
+
+  reg:
+    description: |
+      SPI chip select number (only for SPI-attached deployments).
+    maxItems: 1
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-switch@0 {
+            compatible = "nxp,imxrt1180-netc-switch-spi",
+                         "nxp,imxrt1180-netc-switch";
+            reg = <0>;
+            spi-max-frequency = <12000000>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    label = "hms0p0";
+                    phy-mode = "internal";
+                    fixed-link {
+                        speed = <100>;
+                        full-duplex;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    label = "hms0p1";
+                    phy-mode = "internal";
+                    fixed-link {
+                        speed = <1000>;
+                        full-duplex;
+                    };
+                };
+
+                port@2 {
+                    reg = <2>;
+                    label = "hms0p2";
+                    phy-mode = "internal";
+                    fixed-link {
+                        speed = <1000>;
+                        full-duplex;
+                    };
+                };
+
+                port@3 {
+                    reg = <3>;
+                    label = "cpu";
+                    ethernet = <&eth0>;
+                    phy-mode = "internal";
+                    fixed-link {
+                        speed = <1000>;
+                        full-duplex;
+                    };
+                };
+            };
+        };
+    };
-- 
2.43.0


