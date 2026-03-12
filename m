Return-Path: <netdev+bounces-266953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jG4MCouAsmmfNAAAu9opvQ
	(envelope-from <netdev+bounces-266953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 09:59:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB7726F4F9
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 09:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0BB631F7A43
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 08:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8176C38C2A9;
	Thu, 12 Mar 2026 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBniA297"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501A138B155;
	Thu, 12 Mar 2026 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773305745; cv=none; b=cDf5nTWx3LqV06u7RzXQtI9d79QXoKBH5r/tfkdfviJ5YC3fl6oAr7KcnHTug6WI9pEcCchb7nEm2kCxQqywsllgreSzSORwAwXNzviDKmXxExEb3wFnR41TNQhNo6kd1f16noZ++Em9cJBxk/OpieWmncQ8OSWoDVhDeiUUZuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773305745; c=relaxed/simple;
	bh=s/jQ//ebw4KqAvgADgrOOTy/WsLEyB3dmtPaZ6Cpdk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XJMb4Udf9eGPb7qX/+XELH9TVLssBSqYDYGSLOhz6lf4Lnh4OGMeFVTziMCoLRcd8M0iA7FkM469YSG3eb7AgjaivXWnbuXMl+fXKGRTHXBEZGBshSD95jQD3Su5MojLHxEgN7Wp74Z6F8F/y0gIIzgL6NnoW6vGVwCgXYRpsCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBniA297; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C850C4AF0C;
	Thu, 12 Mar 2026 08:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773305745;
	bh=s/jQ//ebw4KqAvgADgrOOTy/WsLEyB3dmtPaZ6Cpdk8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vBniA297oYg8KajLVFvenkHnd2/AqyM7uDuIZBqA3G6ly3EpfnHgAEN3IcW/RrPFJ
	 vmGSa8zRB+hyFxkvrycdWtpsV7Ez1Hn9nVmLep1CgwRbz6PdnUNQcRHUusSo6ODcFF
	 5XGKhXZoI+lN6dybfHdwSDVjcPl4H4GAbF2HIOOMtkh/+sCwXoHMEZ8DS13B4KyBJN
	 hmD6OdrAAkl/vSHBjFBfkhkraMSavZ8/anRATLASiluwSglZtmOmFiDEL8vw9Vusyk
	 8LMWeg/9YyjiqkFBxbBq8yAIu/QG42rZq5LbdDkK2k0Fr1mdoqtyXK5GND1fJ7apEB
	 BKVKQbs86CLBQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C7DFED2F4;
	Thu, 12 Mar 2026 08:55:45 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Thu, 12 Mar 2026 09:55:29 +0100
Subject: [PATCH v11 3/4] dt-bindings: net: nxp,s32-dwmac: Declare per-queue
 interrupts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-dwmac_multi_irq-v11-3-09621ccb040b@oss.nxp.com>
References: <20260312-dwmac_multi_irq-v11-0-09621ccb040b@oss.nxp.com>
In-Reply-To: <20260312-dwmac_multi_irq-v11-0-09621ccb040b@oss.nxp.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, rmk+kernel@armlinux.org.uk, 
 vladimir.oltean@nxp.com, boon.khai.ng@altera.com, 
 "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773305743; l=3563;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=kLYSxXpklZobUHpT1t8sjQ5xcEiZnOpNYJKyrbRsJvE=;
 b=Ya73RSKInLZM0vgDMMtZhrTlfhsfoe/ktD1Lj6sM/ze+Dn48xS3OxUwbb7N63RMOHGssMW+Y4
 cbpKEobIUi1Ad3Ob67fw/xH+ajQx5ksli6Ah6VvV6Bz1yTwCy5hez9P
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266953-lists,netdev=lfdr.de,jan.petrous.oss.nxp.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	HAS_REPLYTO(0.00)[jan.petrous@oss.nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,devicetree.org:url,oss.nxp.com:replyto,oss.nxp.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,microchip.com:email]
X-Rspamd-Queue-Id: ACB7726F4F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

The DWMAC IP on NXP S32G/R SoCs has connected queue-based IRQ lines,
set them to allow using Multi-IRQ mode.

Reviewed-by: Matthias Brugger <mbrugger@suse.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 .../devicetree/bindings/net/nxp,s32-dwmac.yaml     | 47 +++++++++++++++++++---
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
index 1b2934f3c87c..753a04941659 100644
--- a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-# Copyright 2021-2024 NXP
+# Copyright 2021-2026 NXP
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/net/nxp,s32-dwmac.yaml#
@@ -16,6 +16,8 @@ description:
   the SoC S32R45 has two instances. The devices can use RGMII/RMII/MII
   interface over Pinctrl device or the output can be routed
   to the embedded SerDes for SGMII connectivity.
+  The DWMAC instances have connected all RX/TX queues interrupts,
+  enabling load balancing of data traffic across all CPU cores.
 
 properties:
   compatible:
@@ -45,10 +47,25 @@ properties:
       FlexTimer Modules connect to GMAC_0.
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 11
 
   interrupt-names:
-    const: macirq
+    oneOf:
+      - items:
+          - const: macirq
+      - items:
+          - const: macirq
+          - const: tx-queue-0
+          - const: rx-queue-0
+          - const: tx-queue-1
+          - const: rx-queue-1
+          - const: tx-queue-2
+          - const: rx-queue-2
+          - const: tx-queue-3
+          - const: rx-queue-3
+          - const: tx-queue-4
+          - const: rx-queue-4
 
   clocks:
     items:
@@ -88,8 +105,28 @@ examples:
               <0x0 0x4007c004 0x0 0x4>;    /* GMAC_0_CTRL_STS */
         nxp,phy-sel = <&gpr 0x4>;
         interrupt-parent = <&gic>;
-        interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
-        interrupt-names = "macirq";
+        interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+                     /* CHN 0: tx, rx */
+                     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+                     /* CHN 1: tx, rx */
+                     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
+                     /* CHN 2: tx, rx */
+                     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
+                     /* CHN 3: tx, rx */
+                     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+                     /* CHN 4: tx, rx */
+                     <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "macirq",
+                          "tx-queue-0", "rx-queue-0",
+                          "tx-queue-1", "rx-queue-1",
+                          "tx-queue-2", "rx-queue-2",
+                          "tx-queue-3", "rx-queue-3",
+                          "tx-queue-4", "rx-queue-4";
         snps,mtl-rx-config = <&mtl_rx_setup>;
         snps,mtl-tx-config = <&mtl_tx_setup>;
         clocks = <&clks 24>, <&clks 17>, <&clks 16>, <&clks 15>;

-- 
2.47.0



