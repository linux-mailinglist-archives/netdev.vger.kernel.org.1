Return-Path: <netdev+bounces-272007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDQpNjUixWmC7AQAu9opvQ
	(envelope-from <netdev+bounces-272007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:10:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 342A0334FB5
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DED6D303C8CF
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911C63F1661;
	Thu, 26 Mar 2026 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZGbUBS5J"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CF1397683;
	Thu, 26 Mar 2026 12:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774526734; cv=none; b=mT4ML8wixSUskfL+31cWP8kMz3jF5fC9Rtja6KlGpEzPUdPbsCey5KRCQsqcyvrOdhxYCPTcsa2W2L0opOQZwATBTORtk/aGwDsEsLQ+/BPh2gyZhuFz2UaBo9OA7/BHcoZ6ch9h6/XRYzfqvIqChyEvKfSRUMUB9xfzCeem/lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774526734; c=relaxed/simple;
	bh=Zgf20bu0xGzHqUFQHCNtBUZtwRdwhJSQCkmmV2fc+ys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dfOYDGhECupUaaxL8m/NJ5ZuJOAgo6afMXKJ7iezFrFQ7aF/qxAQhOHDXDIV138Hsv5Ex1E6J6OzGftVkWOGqQsokn0DtPMzfejiQuHqyB7zAoe+K65u6eQX3tIg12eLbLOlYmY1xMWpowIAPDECnn5eBdTd6sIza6giyWs5tKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZGbUBS5J; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1774526731;
	bh=Zgf20bu0xGzHqUFQHCNtBUZtwRdwhJSQCkmmV2fc+ys=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZGbUBS5JiTuFi7VBT2/pW5362F8o0aMKire94QYUJY/NQgk9COoAQp47Y3DmioUVy
	 UcXlgGWd+Rx4IJFjKE05TarlhL2GtHYMeUrr1TcESsDvQK/lD3/PZgZ8CFsVg4Fppy
	 inDIUapqFS6xkKIllL1AfE7dl9LswO9OeHYczFztAE+vnlpBzGQxu54WEX0Xw8F57V
	 Fdl8XE0K4cC6LjevWUloVYuKwJQX/1jVDyqKRzmHF5Hb5XsqeFEre1oNJVTdDyijcZ
	 aK9666e06IIgHK5XYla7IN0ZcCcTgniJLIvdiV32qCWfy7Y/8sGQmif135m5iVB6wk
	 r5suKlMf6K4gw==
Received: from yukiji.home (lfbn-idf1-1-2269-27.w92-151.abo.wanadoo.fr [92.151.67.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DDD6B17E6082;
	Thu, 26 Mar 2026 13:05:30 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 26 Mar 2026 13:04:12 +0100
Subject: [PATCH net-next v2 1/4] dt-bindings: net: Add support for Airoha
 AN8801/R GbE PHY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-add-airoha-an8801-support-v2-1-1a42d6b6050f@collabora.com>
References: <20260326-add-airoha-an8801-support-v2-0-1a42d6b6050f@collabora.com>
In-Reply-To: <20260326-add-airoha-an8801-support-v2-0-1a42d6b6050f@collabora.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: kevin-kw.huang@airoha.com, macpaul.lin@mediatek.com, 
 matthias.bgg@gmail.com, kernel@collabora.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774526729; l=3223;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=FA5AQZRyCjhwT8o7QRGwdmO6VLOKQrbpn6fhImI/4Og=;
 b=cA3GQztJxtw0FPttw+KwoD4r9hKjNYsOOFsNSP9sD/iJLAaWXOrkWzaLWrZmTzB3qAu/BJXCo
 9oB3+Sy2ceSCnyWXAXLLwcafvIXQf8m1C/n9PGK8lmDhmQHri7VX5jV
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272007-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,gmail.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[airoha.com,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.1:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,devicetree.org:url,collabora.com:dkim,collabora.com:email,collabora.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,0.0.0.2:email]
X-Rspamd-Queue-Id: 342A0334FB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Add a new binding to support the Airoha AN8801R Series Gigabit
Ethernet PHY.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../devicetree/bindings/net/airoha,an8801.yaml     | 85 ++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/airoha,an8801.yaml b/Documentation/devicetree/bindings/net/airoha,an8801.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..b90b21b5505367309b5df8ece54ea38664f6b50f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,an8801.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/airoha,an8801.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8801R Series PHY
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+description:
+  The Airoha AN8801R is a low power single-port Ethernet PHY Transceiver
+  with Single-port serdes interface for 1000Base-X/RGMII; this chip is
+  compliant with 10Base-T, 100Base-TX and 1000Base-T IEEE 802.3(u,ab)
+  and supports Energy Efficient Ethernet (802.3az), Full Duplex Control
+  Flow (802.3x), auto-negotiation, crossover detect and autocorrection,
+  Wake-on-LAN with Magic Packet, and Jumbo Frame up to 9 Kilobytes.
+  This PHY also supports up to three user-configurable LEDs, which are
+  usually used for LAN Activity, 100M, 1000M indication.
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ethernet-phy-idc0ff.0421
+
+  reg:
+    maxItems: 1
+
+  leds: true
+
+  wakeup-source:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enable Wake-on-LAN support
+
+required:
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@0 {
+            compatible = "ethernet-phy-idc0ff.0421";
+            reg = <0>;
+
+            leds {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                    reg = <0>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    function = LED_FUNCTION_LAN;
+                    default-state = "keep";
+                };
+
+                led@1 {
+                    reg = <1>;
+                    color = <LED_COLOR_ID_GREEN>;
+                    function = LED_FUNCTION_LAN;
+                    function-enumerator = <1>;
+                    default-state = "keep";
+                };
+
+                led@2 {
+                    reg = <2>;
+                    color = <LED_COLOR_ID_YELLOW>;
+                    function = LED_FUNCTION_LAN;
+                    function-enumerator = <2>;
+                    default-state = "keep";
+                };
+            };
+        };
+    };

-- 
2.53.0


