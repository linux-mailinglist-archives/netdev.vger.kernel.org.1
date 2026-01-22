Return-Path: <netdev+bounces-252176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O5+K1qecWmgKQAAu9opvQ
	(envelope-from <netdev+bounces-252176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:49:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5798F61782
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C86794430D2
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41323469F7;
	Thu, 22 Jan 2026 03:41:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FC938B7BD;
	Thu, 22 Jan 2026 03:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769053306; cv=none; b=X+walaYKfOryWJ05CZLYHqWN5RlPEhhh8dUrwvfL9YyCMG2tuHRSoaSj4QMmRxank6cyO5ze9UNp0jb7mRCfMHheD41c2lxt/uNKy304Tc6htXWredouwS5Ui+rzj4C+cG6obRbxyXF2/OrnzprkHrV97uXtMt326l7KtMVzVZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769053306; c=relaxed/simple;
	bh=DKhvQ67nV21WwtrEBAmhZSLhfW28WuaLWbRRnZu8AOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfwQNbSR4GiFmjL/pwCyahfvnH6PHPyJSesiaWExGdyLWVFFOs9XzycIJvmCfXytiJRU7OsWxC72O9LMQUo6CPncSnXNVQtj09eedTZSlKaEjj0fKgjF0yKJDrpzWtq5FoYLkF38KC7TKAN7u+mNvobOMc1PbQd8aam6xRZTDZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vilZd-000000006Jt-1DXF;
	Thu, 22 Jan 2026 03:41:33 +0000
Date: Thu, 22 Jan 2026 03:41:29 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v8 1/4] dt-bindings: net: dsa: add MaxLinear MxL862xx
Message-ID: <d078aa92bae134647c9f61e24b963b82c1af3c5e.1769053079.git.daniel@makrotopia.org>
References: <cover.1769053079.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769053079.git.daniel@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-252176-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5798F61782
X-Rspamd-Action: no action

Add documentation and an example for MaxLinear MxL86282 and MxL86252
switches.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v8: no changes
v7: no changes
v6: no changes
v5: no changes
RFC v4:
 * remove labels from example
 * remove 'bindings for' from commit title
RFC v3: no changes
RFC v2: better description in dt-bindings doc
---
 .../bindings/net/dsa/maxlinear,mxl862xx.yaml  | 154 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 160 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml b/Documentation/devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml
new file mode 100644
index 0000000000000..77e48f0c7b1e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml
@@ -0,0 +1,154 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/maxlinear,mxl862xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MaxLinear MxL862xx Ethernet Switch Family
+
+maintainers:
+  - Daniel Golle <daniel@makrotopia.org>
+
+description:
+  The MaxLinear MxL862xx switch family are multi-port Ethernet switches with
+  integrated 2.5GE PHYs. The MxL86252 has five PHY ports and the MxL86282
+  has eight PHY ports. Both models come with two 10 Gigabit/s SerDes
+  interfaces to be used to connect external PHYs or SFP cages, or as CPU
+  port.
+
+allOf:
+  - $ref: dsa.yaml#/$defs/ethernet-ports
+
+properties:
+  compatible:
+    enum:
+      - maxlinear,mxl86252
+      - maxlinear,mxl86282
+
+  reg:
+    maxItems: 1
+    description: MDIO address of the switch
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        switch@0 {
+            compatible = "maxlinear,mxl86282";
+            reg = <0>;
+
+            ethernet-ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    phy-handle = <&phy0>;
+                    phy-mode = "internal";
+                };
+
+                port@1 {
+                    reg = <1>;
+                    phy-handle = <&phy1>;
+                    phy-mode = "internal";
+                };
+
+                port@2 {
+                    reg = <2>;
+                    phy-handle = <&phy2>;
+                    phy-mode = "internal";
+                };
+
+                port@3 {
+                    reg = <3>;
+                    phy-handle = <&phy3>;
+                    phy-mode = "internal";
+                };
+
+                port@4 {
+                    reg = <4>;
+                    phy-handle = <&phy4>;
+                    phy-mode = "internal";
+                };
+
+                port@5 {
+                    reg = <5>;
+                    phy-handle = <&phy5>;
+                    phy-mode = "internal";
+                };
+
+                port@6 {
+                    reg = <6>;
+                    phy-handle = <&phy6>;
+                    phy-mode = "internal";
+                };
+
+                port@7 {
+                    reg = <7>;
+                    phy-handle = <&phy7>;
+                    phy-mode = "internal";
+                };
+
+                port@8 {
+                    reg = <8>;
+                    label = "cpu";
+                    ethernet = <&gmac0>;
+                    phy-mode = "usxgmii";
+
+                    fixed-link {
+                        speed = <10000>;
+                        full-duplex;
+                    };
+                };
+            };
+
+            mdio {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                phy0: ethernet-phy@0 {
+                    reg = <0>;
+                };
+
+                phy1: ethernet-phy@1 {
+                    reg = <1>;
+                };
+
+                phy2: ethernet-phy@2 {
+                    reg = <2>;
+                };
+
+                phy3: ethernet-phy@3 {
+                    reg = <3>;
+                };
+
+                phy4: ethernet-phy@4 {
+                    reg = <4>;
+                };
+
+                phy5: ethernet-phy@5 {
+                    reg = <5>;
+                };
+
+                phy6: ethernet-phy@6 {
+                    reg = <6>;
+                };
+
+                phy7: ethernet-phy@7 {
+                    reg = <7>;
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 92768bceb929f..3c4990a90968c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15614,6 +15614,12 @@ S:	Supported
 F:	drivers/net/phy/mxl-86110.c
 F:	drivers/net/phy/mxl-gpy.c
 
+MAXLINEAR MXL862XX SWITCH DRIVER
+M:	Daniel Golle <daniel@makrotopia.org>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml
+
 MCAN DEVICE DRIVER
 M:	Markus Schneider-Pargmann <msp@baylibre.com>
 L:	linux-can@vger.kernel.org
-- 
2.52.0

