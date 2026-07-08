Return-Path: <netdev+bounces-305914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +UwbA3mGTmpZOgIAu9opvQ
	(envelope-from <netdev+bounces-305914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:18:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F867291BC
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:18:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=khDnkbYW;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305914-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305914-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B523C300EC8D
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 17:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CE04963B2;
	Wed,  8 Jul 2026 17:12:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADCD37C933;
	Wed,  8 Jul 2026 17:12:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530756; cv=none; b=boyK8YjXY/rfDecXdmHSX6r7MWU9BgNSvaRnIfrJfm7dem5CHmZYVe0ZYzXeIQd/KG5lyCLeXgk9Hagi+/QSwWGlC7i3PWAuf0mTwjdzb6MbiVLf3G0PRl/QCBI+fxict9NgfPTfpydD8dzi4PXT8Vt8IS3aSLFYYe3YvN0niKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530756; c=relaxed/simple;
	bh=DTJ/AVTjSgEn0aE1ysyJ9vYZ6cwhQVTh3u4GriDXbs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f7+bhuxf0iFI/G2rUWPyphG92TZ0suBmlD4jm0Nld6XdjTobYFZv+BpVT/WPzR5tJ5d3HPvHmt81X4wRP40T6WXQhXB0N+R4tG53lxS7oI3YO0T2Bb5JtaDxAGqQPqavtelIufCZJG9Pma5D2q5Y5Abkt+eUGtCsYlUzCPn977k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khDnkbYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69167C2BCB9;
	Wed,  8 Jul 2026 17:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783530756;
	bh=DTJ/AVTjSgEn0aE1ysyJ9vYZ6cwhQVTh3u4GriDXbs0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=khDnkbYWuuK0NUq99S5Sd5V1e37G8Ql+CnZHlqk1ys7YndA7WXkYX3X657+X8Tql+
	 Q4HaAC5F1y0swFXU0+8wjkQhR09oFoP8zZFVikZHlKl/x7SBJOycDW435mZ8BD3H2X
	 39o4x4TJ/xC+KqlrPfrvLrGl0DHo8P7SaKaWNbZqXS4s2C4SL3W7G421j2AJDEQHRi
	 WTjmJggkzdUweE96DDJn9st+zJDoRW4XCyI8HrFTi40vfO0fJLWMOIbteQS58pTW9+
	 iZNW0fjASsAyUT5BJWcGKI9dBROGlhD0hU52m669m8VfmgMVuwwYtRhrGk26gFjPXe
	 Asiidl/YBChjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A44C44503;
	Wed,  8 Jul 2026 17:12:36 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Wed, 08 Jul 2026 10:12:31 -0700
Subject: [PATCH net-next v7 01/15] dt-bindings: net: add onsemi's S2500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260708-s2500-mac-phy-support-v7-1-478c877aa1a9@onsemi.com>
References: <20260708-s2500-mac-phy-support-v7-0-478c877aa1a9@onsemi.com>
In-Reply-To: <20260708-s2500-mac-phy-support-v7-0-478c877aa1a9@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783530757; l=4147;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=XAd0t4FugeDllDDK5kiSCMkGzC57YFB6VV27txzu9F8=;
 b=yOuUt1vTs2/2r0sh6vktake3ENj6ZwLdqe6EstcNo/7bJVbakL0+gi/NAtUdIFLvSzoaoKrDY
 ia2Pi/PtyqyBz5z/QyM9tmU+fQc/wk8903z9IF59RixJGlaPO4+K/jw
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305914-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:pier.beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:selvamani.rajagopal@onsemi.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:Selvamani.Rajagopal@onsemi.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[Selvamani.Rajagopal@onsemi.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,qualcomm.com:email,onsemi.com:url,onsemi.com:replyto,onsemi.com:mid,onsemi.com:email,trustedfirmware.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84F867291BC

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Add device tree binding for the onsemi S2500 IEEE 802.3cg
compliant Ethernet transceiver device.

We use IRQF_TRIGGER_FALLING, though OPEN Alliance 10BASE-T1x
Serial Interface specification calls for IRQF_TRIGGER_LOW.

This is to match IRQF_TRIGGER_FALLING used by OA TC6 framework code.
This bug fix requires changes to the stable branch. At that time,
this will be changed to IRQF_TRIGGER_LOW.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v7
  - Added the missing review tag
  - Removed the word YAML from the commit message
changes in v6
  - Moved the signed off information to the right place.
changes in v5
  - no changes
changes in v4:
  - added spi-max-frequency as suggested by AI review
  - changed interrupt to IRQ_TYPE_EDGE_FALLING as it is
    being taken care in net (stable) branch
changes in v3
  - Removed URL link that failed verification
changes in v2
  - removed spi-max-frequency entry
  - changed the compatible string to s2500
changes in v1
  - Added the first version of YAML file for onsemi MAC-PHY
---
 .../devicetree/bindings/net/onnn,s2500.yaml        | 67 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 +++
 2 files changed, 74 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/onnn,s2500.yaml b/Documentation/devicetree/bindings/net/onnn,s2500.yaml
new file mode 100644
index 000000000000..11edf10508d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/onnn,s2500.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/onnn,s2500.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: onsemi S2500 10BASE-T1S MACPHY Ethernet Controllers
+
+maintainers:
+  - Piergiorgio Beruto <pier.beruto@onsemi.com>
+  - Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>
+
+description:
+  The S2500 combines a Media Access Controller (MAC) and an
+  Ethernet PHY to enable 10BASE‑T1S networks. The Ethernet Media Access
+  Controller (MAC) module implements a 10 Mbps half duplex Ethernet MAC,
+  compatible with the IEEE 802.3 standard and a 10BASE-T1S physical layer
+  transceiver integrated into the S2500. The communication between
+  the host and the MAC-PHY is specified in the OPEN Alliance 10BASE-T1x
+  MACPHY Serial Interface (TC6).
+
+allOf:
+  - $ref: /schemas/net/ethernet-controller.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: onnn,s2500
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Interrupt from MAC-PHY asserted in the event of Receive Chunks
+      Available, Transmit Chunk Credits Available and Extended Status
+      Event.
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 25000000
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - spi-max-frequency
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ethernet@0 {
+        compatible = "onnn,s2500";
+        reg = <0>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&eth0_pins>;
+        interrupt-parent = <&gpio>;
+        interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+        spi-max-frequency = <15000000>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 52f1a55eca99..fab0804329db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20188,6 +20188,13 @@ S:	Supported
 W:	http://www.onsemi.com
 F:	drivers/net/phy/ncn*
 
+ONSEMI S2500 10BASE-T1S MACPHY ETHERNET DRIVER
+M:	Selva Rajagopal <selvamani.rajagopal@onsemi.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/net/onnn,s2500.yaml
+F:	drivers/net/ethernet/onsemi/s2500/s2500_*
+
 OP-TEE DRIVER
 M:	Jens Wiklander <jens.wiklander@linaro.org>
 L:	op-tee@lists.trustedfirmware.org (moderated for non-subscribers)

-- 
2.43.0



