Return-Path: <netdev+bounces-300170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uxllIRuaMmq42gUAu9opvQ
	(envelope-from <netdev+bounces-300170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:59:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F91699EB3
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:59:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=Pq6F4yWI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300170-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300170-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38EC4301DCC8
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA090401485;
	Wed, 17 Jun 2026 12:58:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A193FF1A3;
	Wed, 17 Jun 2026 12:58:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781701116; cv=none; b=f4KoGphRNPD2Y3tl+mpS/TaJZrjtGLFRZfY+8BDvp4nVmZAUTT4I4mDhTdXIylnhNC8pcvPj1WDuRMesTC5zn4pw1dvoZammGLhWreLxIEGWgDk5IePGEz7COM/BFIxIlVFt3C8CLhYwbQBezqsuQnyBs9i8tJqgW0wcdbmXuNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781701116; c=relaxed/simple;
	bh=0eWG87bF+UQiigmHsijMuQgSNzNUYROVEuHX76zakPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nMOaVCsAcCunxcqvJ382mn3/KOW2DN/F1wr5LKqKAfVuEAtf9UUfZBT4+N95AcW4+t2C6F5QgrSZVIcCd/bgngpBxSzTYIbXs3jOERqUp9sHJFuaT4GeCfsg+1u/ZyLurWHhiCeYvpWQUzyVp98S4CHJVsySAuIDCg0SfRnyLhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pq6F4yWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DA9DC2BCB8;
	Wed, 17 Jun 2026 12:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781701116;
	bh=0eWG87bF+UQiigmHsijMuQgSNzNUYROVEuHX76zakPM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Pq6F4yWIHXs4ffd0bpZasJeo3ljg9xFO6mqdc3QgMr1Tnnvl1WuMp+HEo1fHatJ1y
	 qW18SOrs6E9XfKxrAuQ5kjPuhEuS6bfV4efWQ5sjuVsRjvaWrl8r9NR/GmuGJJt0W3
	 T7ja3FdRvwsJ32CPaMXbLfezYtoFJqyimaBFADD90+/xJA9mgNq/fEaZJ68uDI8Qfu
	 FAZrA5Byf+1AHWo7IKp29JjUUFCbFXWI8um67Hvx30XbWQ8lr4YIe2lQXCo9pPeq4/
	 N091ctDo0VQNix6BVcKGlkeOY2Dy127IN1FkpFFZqYI4zCkfCWGDd0w/xjNu97f1FG
	 taYc21sSW1Lvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3840CD98F0;
	Wed, 17 Jun 2026 12:58:35 +0000 (UTC)
From: Ricardo Pardini via B4 Relay <devnull+ricardo.pardini.net@kernel.org>
Date: Wed, 17 Jun 2026 14:58:28 +0200
Subject: [PATCH v4 1/3] dt-bindings: net: add Realtek RTL8125 PCIe Ethernet
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-rk3588-dts-rtl-eth-describe-dt-alias-v4-1-2bd38922d129@pardini.net>
References: <20260617-rk3588-dts-rtl-eth-describe-dt-alias-v4-0-2bd38922d129@pardini.net>
In-Reply-To: <20260617-rk3588-dts-rtl-eth-describe-dt-alias-v4-0-2bd38922d129@pardini.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2427;
 i=ricardo@pardini.net; h=from:subject:message-id;
 bh=H/nj8b3jgAzNWmVGGkZNntiD7Pr7SSJBU8YukvNeE5Y=;
 b=owGbwMvMwMFoHWf/eN7xty8ZT6slMWQZzfypb7GI17p1rhTr/VK3bKk7fwpjlPsbC5eXLd7++
 /Hlc46nOhn9WRgYORgsxRRZ1kgo83xb/+rUHY+OyTCDWJlApkiLNDAAAQsDX25iXqmRjpGeqbah
 nqGRjoGOMQMXpwBM9QND9v+ZPEwSkeJ9Z/hF9IyW+sjEV+RFGiy5LR9R+SXPsOFC8yaO2wHPC3i
 mb+yvcWv+1DVjUl/Ii4pFOxt4LgdYVvSdFln36eH0ANvjJqFzPtTWvQ+zMp50ObHZoJu9Y0W5yt
 7+P+2OIXP45mSs++Zkuf//47BfPKfiEw793CxmvCMw9x3b25v5fS4zuhazh4hXvwg4VBnhUc5kU
 xoiefu938Mtn6/156Um6FlF3+wtO890K/P+Mf/Ym6lRwZcSBMsE4+9sdYpbxC3j/qHG1jyoopT9
 yvbz/IYaV4ziLd4ekr2tfeeJ1f0TR+d8k34WaFit/IZT6piZ0ZwFJ7Pe3T1iLh5eE3HZw39y+JI
 m9jnRAA==
X-Developer-Key: i=ricardo@pardini.net; a=openpgp;
 fpr=AC18230CF6AFEACADC4888933B5E3FE39EC7EDE9
X-Endpoint-Received: by B4 Relay for ricardo@pardini.net/default with
 auth_id=588
X-Original-From: Ricardo Pardini <ricardo@pardini.net>
Reply-To: ricardo@pardini.net
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300170-lists,netdev=lfdr.de,ricardo.pardini.net];
	FORGED_RECIPIENTS(0.00)[m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:sebastian.reichel@collabora.com,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:ricardo@pardini.net,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,sntech.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[ricardo@pardini.net];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,pardini.net:replyto,pardini.net:email,pardini.net:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,devicetree.org:url,collabora.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03F91699EB3

From: Ricardo Pardini <ricardo@pardini.net>

Add a binding for fixed/soldered Realtek RTL8125 PCIe Ethernet
controller.

The "pciVVVV,DDDD" compatibles are the Open Firmware PCI Bus Binding
spelling, auto-derived from PCI-SIG vendor/device IDs, but they still
need a binding when used in a board DT - analogous to "usbVVVV,PPPP"
compatibles documented in their own bindings (e.g. microchip,lan95xx)
so board DTs attaching properties (fixed MAC, nvmem cell, ...) to
these PCI function nodes can be validated.

Suggested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Ricardo Pardini <ricardo@pardini.net>
---
 .../devicetree/bindings/net/realtek,rtl8125.yaml   | 43 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl8125.yaml b/Documentation/devicetree/bindings/net/realtek,rtl8125.yaml
new file mode 100644
index 0000000000000..eee13fbc1e6a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/realtek,rtl8125.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/realtek,rtl8125.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek RTL8125 2.5 Gigabit PCIe Ethernet Controller
+
+maintainers:
+  - Heiner Kallweit <hkallweit1@gmail.com>
+
+description:
+  The Realtek RTL8125 is a 2.5GBASE-T Ethernet controller with a PCIe host
+  interface.
+
+allOf:
+  - $ref: ethernet-controller.yaml#
+
+properties:
+  compatible:
+    const: pci10ec,8125
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
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
index c8d4b913f26c1..e5fbd82946aec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -134,6 +134,7 @@ M:	Heiner Kallweit <hkallweit1@gmail.com>
 M:	nic_swsd@realtek.com
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/realtek,rtl8125.yaml
 F:	drivers/net/ethernet/realtek/r8169*
 
 8250/16?50 (AND CLONE UARTS) SERIAL DRIVER

-- 
2.54.0



