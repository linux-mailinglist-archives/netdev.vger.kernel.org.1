Return-Path: <netdev+bounces-305536-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lE2kDG0wTWpYwQEAu9opvQ
	(envelope-from <netdev+bounces-305536-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 18:59:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9DD71E0DD
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 18:59:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jaHkNRUq;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305536-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305536-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48D9F3006236
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 16:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA73436BF8;
	Tue,  7 Jul 2026 16:59:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C110122A1D4
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 16:59:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443557; cv=none; b=JnkQfXU+ibtBlQmnoslDQfOprj3cqrE4H+pBBOaa1RQFe2GgAbzBM1F0tv5OOI4evfVBHl3f/hR/zRbcvrFYzzcR+sLmobpk+SV7eJeUoc0MTe5/klG4hfpTjFkQaiQyL6glf3XstcUV51DNJy3btc0zC3Rda/XXnZ/Ytu4wYek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443557; c=relaxed/simple;
	bh=rLTIXsUFvhE4fPJRyCHtI/YdnYDF2SJFC4itsl7RNIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p8luEO1p8Sj0dXE/kZR0ORkJC0eKw6UXUWvtYDFvZkzeptDhLHF3aBx2mdCby1BmG8q0EEfbaoq4Uhjm9SMq+tWOLjgIrP0OidHoc8nr55h6Twk/KW+q7V0esUwFC6GMh7XMNl0iIS+FeW1GiGiSgFRZtPWvOJOcsmmbLSy7z3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaHkNRUq; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-476a130c138so4600417f8f.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783443554; x=1784048354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O3xHqpT60AQCS9WwSt5iUYZRKfih6DmjUlC/H1ZF5ck=;
        b=jaHkNRUqjLF/kIZi2OftbUiE6Dy+Uh+TrRvgwmROaA1ZDPhRpUNcdV9H/DbMhO0SyW
         bt7WKNXjwzxkO3YPJm1svxtVm9hBH6s3+mmDyH44uQqCSa8JAgNBqRo+3n4ogD0HmiFI
         1N2rTMoj/FeyR7AY+sP+4bzb2umLEjKCOHNGDCjIKdQ/6Hk1mGJWMcoHt3k4x+G/+KSh
         BvMErCdmr1OZ9VdQh2TE+DWCejMHn2rzuMGTWIUE4lwYxkb4Swf1QkUWkejdg0zy/QU5
         geSs9zOyhoSdW2SS6OdjtYvR2D8/WsiZNwz+CSn5zEtzLHX2ZbPx2KVo6SYHPxC8PTyH
         +TrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783443554; x=1784048354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O3xHqpT60AQCS9WwSt5iUYZRKfih6DmjUlC/H1ZF5ck=;
        b=FZqibtDk9OlTsszQo14rXVCS+nLu0Mr5BXFEaZ2URHZMa3H03MlwSBWKoKtjVqdu47
         KYNzV4uVtNJ6yAHAB3/P119OBtIw8YQqUJ62TxNTRvOQQQ06L+uaPEIbUuxRBN2jUvPc
         mZu2/R/YtWUcgI/LTFB2wQZEVcg3dYWPLE9PEcOYRiAakkYrYsgRie1vFAASS44qzKVh
         /EiJTP/M/nSVd+B5FHLQ3iUWj+rOE/u3tbhpZncrcKDAKXpBdI7O4d6jPtcNCo8NQVDK
         aOJfLgMpYvxYLTSgu8E0Sjp1WX8ev4toxF9athcnv6bX9PUo5eqI237OtOVtl0mjrzCx
         GCHQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq4+CW5fIMTajcBlW7j+hIMLi7ERL7I0swdDvPcWAL9iIvCIIRD56fiusZl6AXQjtffkm9L4mo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz949rM5OqFQYBBnWGIb9C6BExN9btMxROS7+JXX7SYreC11Ipa
	XuH2fEKbaLnvjQK5kShlI0RviDZKDId1B11mL0AA7LSXj6oh+IxJ9iHG
X-Gm-Gg: AfdE7ckFjIOmQ6xNR1fPrlYM+QhEDmJ7cINKy9zxL99tad8gF9ywsGa/jZVfI6UWIme
	CEzpst6i5q01B/+lBq7tmk7BMDAdwkj9gB5EXfZ8A+d580TOyDGAelFavkaHfOA7sscnnq0xmNz
	Fb7kiwP6XQaF8uC7ffi5q+ab/7HkIprOMzKhj+H9YCPqytFqNECoaRwqkumUh84isC9AW1hmEsI
	LC9iZZAJvgUs7iSdSSwa0KsF1UWzQEZnaKUrbXgkR0MmhgpdWd8Hc69UmED5uotRtf63qscJzLy
	AdJo9cprtTsFdvDxyQM+ZAqPeav3lCWodB00QyfZx8T5LarkkthK+EiD5HP1riJ4fz8x4oXUeTH
	IaZZoDoh3rsMnpCQLoBIPZYNfhrmI+UaiO/ZSUSMcvwvz2k4IpVmllSxFDStUlMdHwPrjneBBhm
	MVVnSceY03Ng==
X-Received: by 2002:a05:6000:25e8:b0:477:6874:5413 with SMTP id ffacd0b85a97d-47de66fb84fmr6725303f8f.58.1783443553932;
        Tue, 07 Jul 2026 09:59:13 -0700 (PDT)
Received: from avermoal ([2a00:1fa2:c26a:61e7:59d1:ea98:4610:84d1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039af67sm41069300f8f.17.2026.07.07.09.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:59:13 -0700 (PDT)
From: Mikhail Lukianchikov <avermoal@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	UNGLinuxDriver <UNGLinuxDriver@microchip.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Lukianchikov <avermoal@gmail.com>
Subject: [PATCH] dt-bindings: net: convert microchip,lan78xx.txt to YAML schema
Date: Tue,  7 Jul 2026 22:58:40 +0600
Message-ID: <20260707165840.107409-1-avermoal@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305536-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[avermoal@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,microchip.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:Rengarajan.S@microchip.com,m:UNGLinuxDriver@microchip.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:avermoal@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avermoal@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,microchip.com:email,devicetree.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E9DD71E0DD

Convert the Microchip LAN78xx family (LAN7800, LAN7801, LAN7850) binding
documentation from plain text to DT schema format using YAML.

The conversion was validated with 'make dt_binding_check'

Signed-off-by: Mikhail Lukianchikov <avermoal@gmail.com>
---
 .../bindings/net/microchip,lan78xx.txt        |  53 --------
 .../bindings/net/microchip,lan78xx.yaml       | 113 ++++++++++++++++++
 2 files changed, 113 insertions(+), 53 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/microchip,lan78xx.txt
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan78xx.yaml

diff --git a/Documentation/devicetree/bindings/net/microchip,lan78xx.txt b/Documentation/devicetree/bindings/net/microchip,lan78xx.txt
deleted file mode 100644
index 11a679530ae6..000000000000
--- a/Documentation/devicetree/bindings/net/microchip,lan78xx.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-Microchip LAN78xx Gigabit Ethernet controller
-
-The LAN78XX devices are usually configured by programming their OTP or with
-an external EEPROM, but some platforms (e.g. Raspberry Pi 3 B+) have neither.
-The Device Tree properties, if present, override the OTP and EEPROM.
-
-Required properties:
-- compatible: Should be one of "usb424,7800", "usb424,7801" or "usb424,7850".
-
-The MAC address will be determined using the optional properties
-defined in ethernet.txt.
-
-Optional properties of the embedded PHY:
-- microchip,led-modes: a 0..4 element vector, with each element configuring
-  the operating mode of an LED. Omitted LEDs are turned off. Allowed values
-  are defined in "include/dt-bindings/net/microchip-lan78xx.h".
-
-Example:
-
-/* Based on the configuration for a Raspberry Pi 3 B+ */
-&usb {
-	usb-port@1 {
-		compatible = "usb424,2514";
-		reg = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		usb-port@1 {
-			compatible = "usb424,2514";
-			reg = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			ethernet: ethernet@1 {
-				compatible = "usb424,7800";
-				reg = <1>;
-				local-mac-address = [ 00 11 22 33 44 55 ];
-
-				mdio {
-					#address-cells = <0x1>;
-					#size-cells = <0x0>;
-					eth_phy: ethernet-phy@1 {
-						reg = <1>;
-						microchip,led-modes = <
-							LAN78XX_LINK_1000_ACTIVITY
-							LAN78XX_LINK_10_100_ACTIVITY
-						>;
-					};
-				};
-			};
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/net/microchip,lan78xx.yaml b/Documentation/devicetree/bindings/net/microchip,lan78xx.yaml
new file mode 100644
index 000000000000..743667c1e761
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/microchip,lan78xx.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/microchip,lan78xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN78xx Gigabit Ethernet controller
+
+maintainers:
+  - Rengarajan Sundararajan <Rengarajan.S@microchip.com>
+  - UNGLinuxDriver <UNGLinuxDriver@microchip.com>
+
+description:
+  The LAN78XX devices are usually configured by programming their OTP or with
+  an external EEPROM, but some platforms (e.g. Raspberry Pi 3 B+) have neither.
+  The Device Tree properties, if present, override the OTP and EEPROM.
+
+allOf:
+  - $ref: /schemas/usb/usb-device.yaml#
+  - $ref: /schemas/net/ethernet-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - usb424,7800
+      - usb424,7801
+      - usb424,7850
+  reg:
+    maxItems: 1
+    description: USB port number
+  local-mac-address:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 6
+    maxItems: 6
+    description:
+      MAC address to use if not stored in OTP or EEPROM. If present,
+      overrides OTP/EEPROM.
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+
+patternProperties:
+  "^ethernet-phy(@[0-9a-f]+)?$":
+    type: object
+    description: |
+      PHY node for the embedded or external PHY. The PHY address is
+      given by the 'reg' property.
+    properties:
+      reg:
+        maxItems: 1
+        description: PHY address.
+      microchip,led-modes:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 1
+        maxItems: 4
+        description:
+          Array of LED mode values for each of up to 4 LEDs.
+          Omitted LEDs are turned off. Allowed values are defined
+          in include/dt-bindings/net/microchip-lan78xx.h.
+    required:
+      - reg
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/net/microchip-lan78xx.h>
+    / {
+        usb: usb {
+            compatible = "usb-host";
+            #address-cells = <1>;
+            #size-cells = <0>;
+        };
+    };
+    &usb {
+        usb-port@1 {
+            compatible = "usb424,2514";
+            reg = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            usb-port@1 {
+                compatible = "usb424,2514";
+                reg = <1>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                ethernet@1 {
+                    compatible = "usb424,7800";
+                    reg = <1>;
+                    local-mac-address = [00 11 22 33 44 55];
+
+                    mdio {
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+                        ethernet-phy@1 {
+                            reg = <1>;
+                            microchip,led-modes = <
+                                LAN78XX_LINK_1000_ACTIVITY
+                                LAN78XX_LINK_10_100_ACTIVITY
+                            >;
+                        };
+                    };
+                };
+            };
+        };
+    };
+...
-- 
2.52.0


