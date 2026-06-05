Return-Path: <netdev+bounces-295796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3aI8DL+3ImqCcgEAu9opvQ
	(envelope-from <netdev+bounces-295796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 13:49:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2BD647DC0
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 13:49:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=Wqe7pXeN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295796-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295796-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E77B9300EEB1
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 11:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727324D90D7;
	Fri,  5 Jun 2026 11:49:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DE34C6EF4;
	Fri,  5 Jun 2026 11:49:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660156; cv=none; b=OVsHf/lYgZZYcQdXcPKsAaSPxS9Vc4dHkJZHmrWXbdKcvSIQkYObgZHDzNsxslu9MX0Frf1t9b52ATaqwrOrDBqMCvq8zRpeSshh3zEBibkVluZ1fOdX5IBUFkOABgTsR+3RrbltHwLkAhtpx7yLRdSblPnJ3Dgy0l/4UTKupvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660156; c=relaxed/simple;
	bh=mtnM3Sj2cMIy3e+ie4Hp0c1qRbSYoX8+8V4uSy2F+p4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PEnxstC5Gv4qj1FEtprGQuYU4jfCiE2bDvijAkJyB8wjdmn4KDQiR/88NZeMuWPXLLtIqj0hH9tYApwqBumM68bIVhd5R3bXhcFQC2bxUMnzVbvxlIyOWWc6z4lNyz7fVwDWrTvR3J/bbEVxKGvLUfz+uKkw9kJWx9LGPf9XGhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wqe7pXeN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E54B0C2BCB9;
	Fri,  5 Jun 2026 11:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780660156;
	bh=mtnM3Sj2cMIy3e+ie4Hp0c1qRbSYoX8+8V4uSy2F+p4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Wqe7pXeNMzMqmThbgCf+suxMyK0BxZrH03eXV8xdWUyUZpMRRds63h6LFlDkkjWk7
	 gijoZP2+DgXAzPhJHqNr5zDa7pfM4PYsdI6Wqs2XbtISxTKImqyGdmpP6N2NtI5YRa
	 ziQ41iEa9uV6GLYhkx+Qnx9evHFAtyyCLttOJdPJz1hxeGKyykmvwQ9y80XNO29YRN
	 Ro+CGQTuis+xSXrHZwHNw9ubmwNwmSxSPAlJoALbNod2xkHm464w1JNfONaBgS+A5Q
	 x0A9Od4e86XdRZCeqCWWNr6JbVyLvu+8J7hcQKyA7mb6UZUnVNPyPNKV4+aJCTRfHA
	 ivARXzcQC1pKQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB19CD6E7C;
	Fri,  5 Jun 2026 11:49:15 +0000 (UTC)
From: Ricardo Pardini via B4 Relay <devnull+ricardo.pardini.net@kernel.org>
Date: Fri, 05 Jun 2026 13:49:08 +0200
Subject: [PATCH v3 1/3] dt-bindings: net: add Realtek r8169 family PCIe
 Ethernet
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-rk3588-dts-rtl-eth-describe-dt-alias-v3-1-8a8857b39daf@pardini.net>
References: <20260605-rk3588-dts-rtl-eth-describe-dt-alias-v3-0-8a8857b39daf@pardini.net>
In-Reply-To: <20260605-rk3588-dts-rtl-eth-describe-dt-alias-v3-0-8a8857b39daf@pardini.net>
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Ricardo Pardini <ricardo@pardini.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2818;
 i=ricardo@pardini.net; h=from:subject:message-id;
 bh=SwvhGPGzhgbbXrid/Pg1myL4wDhH+eVp/OO6aNuLepE=;
 b=owGbwMvMwMFoHWf/eN7xty8ZT6slMWQpbd/FWGppYr/MysQiwyooP2dW8OqTcdMl65jLxefU5
 +/tbgnrZPRnYWDkYLAUU2RZI6HM8239q1N3PDomwwxiZQKZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6BjrGDFycAjDV7Jnsf7h/aG+smiH5n33aR5fpvm1HGk9JbnOR+ZyvtGbSZr/NEez3vliZRHl
 cy7E6L+Ks8C9P8m7j7wDDBLH8I0EOmvz8TZ9qFmyIWO1xpnP5v56Gy9/WbjZL3K18Yj9nk8zWfa
 E1llPti9cd+c8s3l4XMYdt4qtXHh//e3EfPuldmfhwcdpFR+2Up5vcY2+KavrNsgktveWxITQku
 Nt3m8zNh9z7Fm+qv9j1gfX7Fv8H1eVn8qMjZj2c1Jfgkm35iiHDpjXhQar2FEXm/ZZc8g75vYqn
 Pr5NWHZLat+KSzHRaXK7Qw/6hy8WaDx/TPSaYZU5q96/O533e1JvOrX/nVA+71utW8T1O3VnTnT
 2dJQyAgA=
X-Developer-Key: i=ricardo@pardini.net; a=openpgp;
 fpr=AC18230CF6AFEACADC4888933B5E3FE39EC7EDE9
X-Endpoint-Received: by B4 Relay for ricardo@pardini.net/default with
 auth_id=588
X-Original-From: Ricardo Pardini <ricardo@pardini.net>
Reply-To: ricardo@pardini.net
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295796-lists,netdev=lfdr.de,ricardo.pardini.net];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:sebastian.reichel@collabora.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:ricardo@pardini.net,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,sntech.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[ricardo@pardini.net];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,devicetree.org:url,pardini.net:mid,pardini.net:email,pardini.net:replyto,collabora.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF2BD647DC0

From: Ricardo Pardini <ricardo@pardini.net>

Add a binding for fixed/soldered Realtek PCIe Ethernet controllers
driven by the r8169 driver (RTL8125/8126/8127/8168 and variants).

The "pciVVVV,DDDD" compatibles are the Open Firmware PCI Bus Binding
spelling, auto-derived from PCI-SIG vendor/device IDs, but they still
need a binding when used in a board DT - analogous to "usbVVVV,PPPP"
compatibles documented in their own bindings (e.g. microchip,lan95xx)
so board DTs attaching properties (fixed MAC, nvmem cell, ...) to
these PCI function nodes can be validated.

Suggested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
---
 .../devicetree/bindings/net/realtek,r8169.yaml     | 54 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/realtek,r8169.yaml b/Documentation/devicetree/bindings/net/realtek,r8169.yaml
new file mode 100644
index 0000000000000..6923211ff4c93
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/realtek,r8169.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/realtek,r8169.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek r8169 family PCIe Ethernet Controllers
+
+maintainers:
+  - Heiner Kallweit <hkallweit1@gmail.com>
+
+description:
+  PCI function node properties for fixed/soldered Realtek Ethernet
+  controllers driven by the r8169 driver.
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - pci10ec,8125  # RTL8125 2.5GbE
+      - pci10ec,8126  # RTL8126 5GbE
+      - pci10ec,8127  # RTL8127
+      - pci10ec,8161  # RTL8168 variant
+      - pci10ec,8162  # RTL8168 variant
+      - pci10ec,8168  # RTL8168/8111 GbE
+
+  reg:
+    maxItems: 1
+
+  local-mac-address: true
+  mac-address: true
+  nvmem-cells: true
+  nvmem-cell-names: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        ethernet@0,0 {
+            compatible = "pci10ec,8125";
+            reg = <0x10000 0 0 0 0>;
+            local-mac-address = [00 00 00 00 00 00];
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b539be153f6a4..6341de4fadb6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -134,6 +134,7 @@ M:	Heiner Kallweit <hkallweit1@gmail.com>
 M:	nic_swsd@realtek.com
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/realtek,r8169.yaml
 F:	drivers/net/ethernet/realtek/r8169*
 
 8250/16?50 (AND CLONE UARTS) SERIAL DRIVER

-- 
2.54.0



