Return-Path: <netdev+bounces-283497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MwR1FfKJ9mnGWAIAu9opvQ
	(envelope-from <netdev+bounces-283497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 01:34:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A374A4B3AB8
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 01:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E66C3032CE9
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 23:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164B7322749;
	Sat,  2 May 2026 23:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQIHiS/j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C9C2C11E4;
	Sat,  2 May 2026 23:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777764337; cv=none; b=UHS4nKbWMBIsbSSr4Nl5rpLTfnOwOBC0SKQNc1qDllEstKwukI6I66iV6sANHAdHrhKOM53VWX2EQVBv5xttvjS+tyUwL2QUp+waSTeD2LYxvwfQZMcGNiIRqZKn5oqJcPrVcSfKVSryHdcLAAWDGb33PeCo8eVan4H5zxWDu8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777764337; c=relaxed/simple;
	bh=PU/PgJRELyFZ9axF6kSaLQk+fnNU+Qed4LVJD3zSKoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LNHVFH6eXf4fqHAcmrm3ZACDOHGbwvjUKUeIb1hloZyocMURtzyFf0dRj9R4hsUzbBVP8PAXv++lgxNoGzecvXImPxrG9dgQfFTCclBLGYh2MUbjKLR2a0Te1yGyYU/ENK43nuoyzVtaEoCVVwbqPVLRRJwl6roe8f5Y1DkkufQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQIHiS/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 62AD2C2BCF6;
	Sat,  2 May 2026 23:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777764337;
	bh=PU/PgJRELyFZ9axF6kSaLQk+fnNU+Qed4LVJD3zSKoY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZQIHiS/jKnUyyk1Kx6a95GRHM+hkpT5cRE3tORgtshMYtXKzx6KZ4kjqpHXIkVk/F
	 Y6yhidls8VmsczvZR5FcfwEtp6kdc5K5cWLYEs90bFYPXUFAUT379wY0hBI6FPNAeo
	 k8QdrknPlKWGfwphczAronlP//Pj1Snm9Hk8zL3/GNZJkuCj8dHzCborITqpQWkYIu
	 lWoN3zBsMKdqXvYk1NhLanIhd9PSC8LqDRND+tbHo8Y9d7RlC9KvQTxen8Cq1l/24n
	 YSyBlu+mAl5q/OGVQ6pKN5UHWjcsoZhMhNAZkHN99AF5RrJnUdPnOSQjuCrwsG8WVQ
	 zT4rzhBDnw6pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B22ECD3426;
	Sat,  2 May 2026 23:25:37 +0000 (UTC)
From: Ciprian Regus via B4 Relay <devnull+ciprian.regus.analog.com@kernel.org>
Date: Sun, 03 May 2026 02:24:54 +0300
Subject: [PATCH net-next 5/5] dt-bindings: net: Add bindings for the
 ADIN1140
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260503-adin1140-driver-v1-5-dd043cdd88f0@analog.com>
References: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
In-Reply-To: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777764335; l=2909;
 i=ciprian.regus@analog.com; s=20260330; h=from:subject:message-id;
 bh=fsypCuzG+8KsvoEcvGQ6yCJv/rH7hOitcPb70G23Ry8=;
 b=IfQ3JGxqRuCDGFpO/P9bRwjhIFJQOyUBMejKbfs/rBS33QxPU7X5rXn5hE4r4EhqBykipUBB2
 dkVrqgIOr5ZAehaPGZErUqfkPGoO24jQjlt5vghv6N9DQoutLODifLf
X-Developer-Key: i=ciprian.regus@analog.com; a=ed25519;
 pk=8WoNhI0kQcQUl8YqJO5ZevROYk9HP8lOIeIgIYgjfbc=
X-Endpoint-Received: by B4 Relay for ciprian.regus@analog.com/20260330 with
 auth_id=703
X-Original-From: Ciprian Regus <ciprian.regus@analog.com>
Reply-To: ciprian.regus@analog.com
X-Rspamd-Queue-Id: A374A4B3AB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-283497-lists,netdev=lfdr.de,ciprian.regus.analog.com];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[ciprian.regus@analog.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.739];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devicetree.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:mid,analog.com:email,analog.com:replyto,analog.com:url,0.0.0.0:email]

From: Ciprian Regus <ciprian.regus@analog.com>

Add DT bindings for the ADIN1140 10BASE-T1S MACPHY. Update the
MAINTAINERS entry to include the bindings file as well.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
 .../devicetree/bindings/net/adi,adin1140.yaml      | 69 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 70 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/adi,adin1140.yaml b/Documentation/devicetree/bindings/net/adi,adin1140.yaml
new file mode 100644
index 000000000000..26cd40d36f9b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/adi,adin1140.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/adi,adin1140.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADI ADIN1140 10BASE-T1S MAC-PHY
+
+maintainers:
+  - Ciprian Regus <ciprian.regus@analog.com>
+
+description: |
+  The ADIN1140 (also called AD3306) is a low power single port
+  10BASE-T1S MAC-PHY. It integrates an Ethernet PHY with a MAC
+  and all the associated analog circuitry.
+  The device implements the Open Alliance TC6 10BASE-T1x MAC-PHY
+  Serial Interface specification and is compliant with the
+  IEEE 802.3cg-2019 Ethernet standard for 10 Mbps single pair
+  Ethernet (SPE). The device has a 4-wire SPI interface for
+  communication between the MAC and host processor.
+
+allOf:
+  - $ref: /schemas/net/ethernet-controller.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,adin1140
+      - adi,ad3306
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 25000000
+
+  interrupts:
+    maxItems: 1
+    description: Interrupt from the MAC-PHY for receive data available
+      and error conditions
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
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet@0 {
+            compatible = "adi,adin1140";
+            reg = <0>;
+            spi-max-frequency = <23000000>;
+
+            interrupt-parent = <&gpio>;
+            interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
+
+            local-mac-address = [ 00 11 22 33 44 55 ];
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index f9784c25beac..55e1e78fe04e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1848,6 +1848,7 @@ M:	Ciprian Regus <ciprian.regus@analog.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/net/adi,adin1140.yaml
 F:	drivers/net/ethernet/adi/adin1140.c
 
 ANALOG DEVICES INC ETHERNET PHY DRIVERS

-- 
2.43.0



