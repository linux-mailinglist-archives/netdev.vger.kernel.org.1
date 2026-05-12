Return-Path: <netdev+bounces-286946-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MPSK8OtAmpTvgEAu9opvQ
	(envelope-from <netdev+bounces-286946-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:34:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F47519974
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C4253031ADB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 04:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327AA328B77;
	Tue, 12 May 2026 04:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JeVAT78n"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A132B2147E5;
	Tue, 12 May 2026 04:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778560431; cv=none; b=JCKcZ7HIjuzhacTZk6lVdfy2snLcA//6wwQa5WkEQ54Tr9OiXGI3IlnaEZJfC/sAX17A3Y4eE8SdQUv0KvFeDEBTgbE1Xkt0QaHtUmuNfPsRD84yfSk6e6QFwjvdtl3ansgfHdu1gjNH5M6i6I2/zUu058iq7MfULtcxbgMgUWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778560431; c=relaxed/simple;
	bh=FTb3G2vLYxM7tcE6j6MbZT2m19/M+dWLgv+cqwFrwzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uORG9VJG09wkQXDta3ZNENrGf+xqEefJwF+MbinWbxCuexxH2d5Loe327TGVftiDn1FYFaJT3fStfAZQSygnG4WPBJISp0VsRtsz1/5Rh0XW4XCXIlM4skXpXqv4TOtVGlUz+mjwHLe25eAYrKOUAtAM4Rorpk/aQdAI8j+yKQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JeVAT78n; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1778560427;
	bh=FTb3G2vLYxM7tcE6j6MbZT2m19/M+dWLgv+cqwFrwzQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JeVAT78nzlYc/Aa1+9p/QVL7ruR5Nilj03GC1XUPGzEuwzBZZAqRd5R48hcC7GZDY
	 2rP0lukEu+qCZcBDEATs0KA3R9KJUX25CIhVl93ajt08/yrbTlCiY1WZ46SRMcvXf5
	 MKRXnDvBN5IByfGdcIRIycU+LUHGs+DNJJUbjoXsrXSJGQEKB+uxwstNVXUAtw8abV
	 JMt1oNxCMBlWlvzFl9XePXe1etOvvEaowwcTaB6V714Q0jG+/GM5j5mIpwjEntnyEY
	 60NZRisGwrdZgGfYkJusFsbsVjX2GJt+YKG92Fl1nvXGAlOhFIgcHbsUiwBtWvV5q9
	 4FdxY7Mzscsuw==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CDF2817E1513;
	Tue, 12 May 2026 06:33:46 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 12 May 2026 06:33:18 +0200
Subject: [PATCH net-next v3 1/6] dt-bindings: net: Add support for Airoha
 AN8801/R GbE PHY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-add-airoha-an8801-support-v3-1-1edb34e363ae@collabora.com>
References: <20260512-add-airoha-an8801-support-v3-0-1edb34e363ae@collabora.com>
In-Reply-To: <20260512-add-airoha-an8801-support-v3-0-1edb34e363ae@collabora.com>
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778560425; l=3167;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=XMccUmrUacqO4GAsqwSfQksObded8gKYNJE+Y06QrTE=;
 b=NSOOV8lIX8V4jVnh0iqlH6eVarUNgt/lyaNS7auNTKBaNbOmkbNcjLbjHwP96kHSJgIB23BVo
 RcvpBwQZWLWBwpArq2jO5u+mhnz9QHeB+KK9g4r1ywjhofJxIfL6n9J
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=
X-Rspamd-Queue-Id: 41F47519974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286946-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,gmail.com,armlinux.org.uk];
	FREEMAIL_CC(0.00)[airoha.com,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.1:email];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[louisalexis.eyraud@collabora.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.64.0.131:received,148.251.105.195:received,100.90.174.1:received];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devicetree.org:url,0.0.0.2:email]
X-Rspamd-Action: no action

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
index 000000000000..b90b21b55053
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
2.54.0


