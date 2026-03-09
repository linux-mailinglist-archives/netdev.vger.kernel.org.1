Return-Path: <netdev+bounces-265673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO++BDEKr2nXMQIAu9opvQ
	(envelope-from <netdev+bounces-265673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:58:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FE023E16F
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C022F3047DD9
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 17:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4373EBF28;
	Mon,  9 Mar 2026 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaSlAMAC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB223E95B2;
	Mon,  9 Mar 2026 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078936; cv=none; b=eZI3BHf6sBWw0r/qMAq0vj8ZWRNRm+1EDer18ZTLTu6fyyEk6Iy+UGd6yM4MDmiItsQM4IM6DdSaxK+fbRghN0pP4ld5sH9asmPyvw9jrQY56dKI09a5tfLx9HpqKMD+IDOwO6ElzvsV0KQH16MEzi25/wTmGrdkQUa7URJB8/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078936; c=relaxed/simple;
	bh=t5KwaNb/RUlMNvnjAQljSY30lTI+e060jlUtQ9txKe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U5AU/F5Gj6SmmKPRi7ZoNsAU83Lj5HC62cs5l//6AIGW3ojTgjIhP/e3JacbgzsMtFTAeB3+rZ1G5CZIAOFUl1IAp7kCA2EifXO9coMC4GY/PTgB1wY9Bu1pDajghx0WWYx5ACrjM5J4QZhmgZ7RfjdKeK+j6VNEoPLWMZLlYdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaSlAMAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3316BC2BCB1;
	Mon,  9 Mar 2026 17:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773078936;
	bh=t5KwaNb/RUlMNvnjAQljSY30lTI+e060jlUtQ9txKe8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aaSlAMAC91kH4el1lqrRZCh+AkoqmbnplxTYhek6aXPmHCkvs/RtQE/m9C9nB7Dyl
	 972MUmC6Bc5vKNZ+vq1KE62f0zr8SLqjvOeE7ygzvWV8lbhmZS6Kl3HruPVzI6jnfu
	 s9CvI7zr7oLzmeo9vc6rrXVh7OdYnIdu2V4sAMn5gnI6Ov7WdBajwT/Ft1/l8OShzf
	 LHotcfz8L8NmZk55ZNOkJZ4CQWaLEcVLzMJge9lseS7GvkllFVFKMuW1iDDzAIXYVc
	 /5gyIWwc0w8AidEdLfS84eI9stTZmjAqAEn+Nhn2EhnFfFPf4ciqrWq9+GmKc2O32R
	 kAwWtFf7hfl+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289E6FCA16D;
	Mon,  9 Mar 2026 17:55:36 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Mon, 09 Mar 2026 18:55:22 +0100
Subject: [PATCH v8 3/5] arm64: dts: s32: set Ethernet channel irqs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-dwmac_multi_irq-v8-3-f0cc5bc811a7@oss.nxp.com>
References: <20260309-dwmac_multi_irq-v8-0-f0cc5bc811a7@oss.nxp.com>
In-Reply-To: <20260309-dwmac_multi_irq-v8-0-f0cc5bc811a7@oss.nxp.com>
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
 "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773078934; l=4163;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=GJtLVXXJ6B4rcW9eI+Zdnzjbg44iN/frnopr12Ti4EU=;
 b=dRgGMtpIhwLE31Kfv0ZvOKeCnsTl3jIHIkX0AEFXq8hvvZBREhA704LaPYuG0VXdG7PZe5o3j
 QLTH3l1SequA0XOclFdfI0RyKZ2WpjMSuk+Yi1rtavjwvSRMXNnpEu0
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com
X-Rspamd-Queue-Id: A0FE023E16F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265673-lists,netdev=lfdr.de,jan.petrous.oss.nxp.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	HAS_REPLYTO(0.00)[jan.petrous@oss.nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,4033c000:email,suse.com:email,oss.nxp.com:replyto,oss.nxp.com:mid,nxp.com:email]
X-Rspamd-Action: no action

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

The GMAC Ethernet controller found on S32G2/S32G3 and S32R45
contains up to 5 RX and 5 TX channels.
It can operate in two interrupt modes:

  1) Sharing IRQ mode: only MAC IRQ line is used
     for all channels.

  2) Multiple IRQ mode: every channel uses two IRQ lines,
     one for RX and second for TX.

Specify all IRQ twins for all channels.

Reviewed-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi | 26 +++++++++++++++++++++++---
 arch/arm64/boot/dts/freescale/s32g3.dtsi | 26 +++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index 51d00dac12de..5a553d503137 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -3,7 +3,7 @@
  * NXP S32G2 SoC family
  *
  * Copyright (c) 2021 SUSE LLC
- * Copyright 2017-2021, 2024-2025 NXP
+ * Copyright 2017-2021, 2024-2026 NXP
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -732,8 +732,28 @@ gmac0: ethernet@4033c000 {
 			reg = <0x4033c000 0x2000>, /* gmac IP */
 			      <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
 			interrupt-parent = <&gic>;
-			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "macirq";
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     /* CHN 0: tx, rx */
+				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     /* CHN 1: tx, rx */
+				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
+				     /* CHN 2: tx, rx */
+				     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
+				     /* CHN 3: tx, rx */
+				     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+				     /* CHN 4: tx, rx */
+				     <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq",
+					  "tx-queue-0", "rx-queue-0",
+					  "tx-queue-1", "rx-queue-1",
+					  "tx-queue-2", "rx-queue-2",
+					  "tx-queue-3", "rx-queue-3",
+					  "tx-queue-4", "rx-queue-4";
 			snps,mtl-rx-config = <&mtl_rx_setup>;
 			snps,mtl-tx-config = <&mtl_tx_setup>;
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index e314f3c7d61d..b43e6f001f4d 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
- * Copyright 2021-2025 NXP
+ * Copyright 2021-2026 NXP
  *
  * Authors: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
  *          Ciprian Costea <ciprianmarian.costea@nxp.com>
@@ -809,8 +809,28 @@ gmac0: ethernet@4033c000 {
 			reg = <0x4033c000 0x2000>, /* gmac IP */
 			      <0x4007c004 0x4>;    /* GMAC_0_CTRL_STS */
 			interrupt-parent = <&gic>;
-			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "macirq";
+			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+				     /* CHN 0: tx, rx */
+				     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+				     /* CHN 1: tx, rx */
+				     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
+				     /* CHN 2: tx, rx */
+				     <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
+				     /* CHN 3: tx, rx */
+				     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+				     /* CHN 4: tx, rx */
+				     <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq",
+					  "tx-queue-0", "rx-queue-0",
+					  "tx-queue-1", "rx-queue-1",
+					  "tx-queue-2", "rx-queue-2",
+					  "tx-queue-3", "rx-queue-3",
+					  "tx-queue-4", "rx-queue-4";
 			snps,mtl-rx-config = <&mtl_rx_setup>;
 			snps,mtl-tx-config = <&mtl_tx_setup>;
 			status = "disabled";

-- 
2.47.0



