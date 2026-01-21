Return-Path: <netdev+bounces-251912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JUlDUTycGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:35:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A11925943A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A67C9AF43D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C3C48BD2E;
	Wed, 21 Jan 2026 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1ULJnrF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A138148AE21;
	Wed, 21 Jan 2026 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005436; cv=none; b=OFprBdprw3iWENQMuLV500ZrhfIkiOEcHhHk0ys65Dvx+5t0NLCr3SRoZn58UkeZw2BQ6qhiXCeSJf/FUFKTR9+q97uyYstoy5zY9pv4tEjksObR3GlUri5zODmpar6Ad+0xgj8061nh3b4DdU6fnws323isuSMhdPwjkL3pn5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005436; c=relaxed/simple;
	bh=bDsa5qr79ONQyLB8IWcNyqXU1o6S3KzvbCNukf7liXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TzLWyZOrfPXpPVhXmpVIsqHoHP01ZyVIB3hXcCT41Xq/cWohqEWW5t10OpCtVgSmwwOKUj9SeccB6ypCUfwBqN+K2BwwkJcxNuawYGacHQY5qdpV7PH7e96WBrxc6R288NCzriGlRzXsgfDeV3P7MxQQeTcJ6rPeFf2xn8gMQHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1ULJnrF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51D5FC19425;
	Wed, 21 Jan 2026 14:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769005436;
	bh=bDsa5qr79ONQyLB8IWcNyqXU1o6S3KzvbCNukf7liXQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=f1ULJnrFWRK2oIYY+AkPZt7+jDEIrep0EbMb2kPzctwEvLUySDijOstfftQ5v24RC
	 vztc+aot8Ftxr8/asdU0AbAxOzpa1SgfpfvvhhKPIYn8HWEshFtoFyQOr7HiG1ADdM
	 nOIxpWCp3SsTuTGRK+7aC7+olluzvWrjqmeAsf6rwzPRDCUlDA5JqUykfslSSSUCGx
	 YzJT+8LOonhNATO5TxRV3auzRVvRIstgsDTmhkwI062wL0f5/CWC4/98mCOKZf6ZPT
	 JgzcG91UL5pUAom+0AlBevBNjRyJoI8lb9Z24Qf+pEZyEUewTizgA332WDsUD9EfVa
	 6Tt2kVhosq4/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492CED2ECF9;
	Wed, 21 Jan 2026 14:23:56 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Wed, 21 Jan 2026 15:23:36 +0100
Subject: [PATCH RFC v2 2/4] dt-bindings: net: nxp,s32-dwmac: Declare
 per-queue interrupts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-dwmac_multi_irq-v2-2-3b829230d071@oss.nxp.com>
References: <20260121-dwmac_multi_irq-v2-0-3b829230d071@oss.nxp.com>
In-Reply-To: <20260121-dwmac_multi_irq-v2-0-3b829230d071@oss.nxp.com>
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
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769005434; l=3038;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=FKbkDY6yPX+AkAtZztOM7Nw6IaGU94yLN0TxsfuzqXA=;
 b=ICCzzPbRwQTsDldkrmty0eQwlypncRsjY/LZ6AnF9Tj9xGncFlNqpjVGOEFLu6K1tABzJJiBw
 cFS2eB87LWNCG5WV80R5y5xInl2JdG5ny08mfpXlxCNb895qs7n2oV0
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251912-lists,netdev=lfdr.de,jan.petrous.oss.nxp.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev,dt];
	HAS_REPLYTO(0.00)[jan.petrous@oss.nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,oss.nxp.com:mid,oss.nxp.com:replyto,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,devicetree.org:url]
X-Rspamd-Queue-Id: A11925943A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

The DWMAC IP on NXP S32G/R SoCs has connected queue-based IRQ lines,
set them to allow using Multi-IRQ mode when supported.

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 .../devicetree/bindings/net/nxp,s32-dwmac.yaml     | 42 +++++++++++++++++++---
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
index 2b8b74c5feec..e1ebc3bea095 100644
--- a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-# Copyright 2021-2024 NXP
+# Copyright 2021-2026 NXP
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/net/nxp,s32-dwmac.yaml#
@@ -33,10 +33,22 @@ properties:
       - description: GMAC PHY mode control register
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 11
 
   interrupt-names:
-    const: macirq
+    - items:
+        - const: macirq
+        - const: rx-queue-0
+        - const: tx-queue-0
+        - const: rx-queue-1
+        - const: tx-queue-1
+        - const: rx-queue-2
+        - const: tx-queue-2
+        - const: rx-queue-3
+        - const: tx-queue-3
+        - const: rx-queue-4
+        - const: tx-queue-4
 
   clocks:
     items:
@@ -75,8 +87,28 @@ examples:
         reg = <0x0 0x4033c000 0x0 0x2000>, /* gmac IP */
               <0x0 0x4007c004 0x0 0x4>;    /* GMAC_0_CTRL_STS */
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



