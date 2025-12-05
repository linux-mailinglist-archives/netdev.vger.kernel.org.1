Return-Path: <netdev+bounces-243771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0473CA708C
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 10:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C59223236134
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 09:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E679232826E;
	Fri,  5 Dec 2025 09:53:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA99A326959;
	Fri,  5 Dec 2025 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764928418; cv=none; b=W0u/p0USDUe4TCkbK22wum0syeR5pU4R1WSi5QCWCcriG1MUtUN3tTcpHRO4HoMlLixrHe411cDfNr+8uzygOtTlszx683CzdjK/i0vtfJBO2wh6VAuvgTptZpu39dCgXTH8slb7WarsjSQRLObrMte3ilEdVrDCC7gu76ZVN6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764928418; c=relaxed/simple;
	bh=10M+NTu6cKgwCMa/PYvFJoSlsso1k74bA21xmxMKlok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=N2TQLRZBmFxTAXHjzUoGQeUpPS1/BYHTEzJapzMjSM6JwRaBivoHDgGSz1J2xSTuXUK9s6G/aOdX/qvD0e3rVTpK17Md6yM0CZ1CExMuaPj9G/Po/JumKHZIOEnsJC3aAgHbCD56WKX2YiuuKRVJMRq9MqL7CTzdCrt+k2bBmEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 5 Dec
 2025 17:53:15 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 5 Dec 2025 17:53:15 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Fri, 5 Dec 2025 17:53:15 +0800
Subject: [PATCH net-next v5 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251205-rgmii_delay_2600-v5-1-bd2820ad3da7@aspeedtech.com>
References: <20251205-rgmii_delay_2600-v5-0-bd2820ad3da7@aspeedtech.com>
In-Reply-To: <20251205-rgmii_delay_2600-v5-0-bd2820ad3da7@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <taoren@meta.com>, Jacky Chou
	<jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764928395; l=2965;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=10M+NTu6cKgwCMa/PYvFJoSlsso1k74bA21xmxMKlok=;
 b=Kh2WP6QLBI3wSvDKNvjpCbZYvYBuRfBemttZPEqGdj/Ge9IxrY3cZQc6Xr69W9YTeqqLiTmJa
 9+yHR4PJKdGDUalzjzU4tP10JMDte6PU5geXmz+L06GIe8aumCVoqoa
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

The AST2600 contains two dies, each with its own MAC, and these MACs
require different delay configurations.
Previously, these delay values were configured during the bootloader
stage rather than in the driver. This change introduces the use of the
standard properties defined in ethernet-controller.yaml to configure
the delay values directly in the driver.

Each Aspeed platform has its own delay step value. And for Aspeed platform,
the total steps of RGMII delay configuraion is 32 steps, so the total delay
is delay-step-ps * 32.
Default delay values are declared so that tx-internal-delay-ps and
rx-internal-delay-ps become optional. If these properties are not present,
the driver will use the default values instead.
Add conditional schema constraints for Aspeed AST2600 MAC controllers:
- For MAC0/1, per delay step for rgmii is 45 ps
- For MAC2/3, per delay step for rgmii is 250 ps
- Both require the "aspeed,scu" and "aspeed,rgmii-delay-ps" properties.
Other compatible values remain unrestricted.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 .../devicetree/bindings/net/faraday,ftgmac100.yaml | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
index d14410018bcf..00f7a0e56106 100644
--- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
+++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
@@ -69,6 +69,30 @@ properties:
   mdio:
     $ref: /schemas/net/mdio.yaml#
 
+  aspeed,scu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the SCU (System Control Unit) syscon node for Aspeed platform.
+      This reference is used by the MAC controller to configure the RGMII delays.
+
+  rx-internal-delay-ps:
+    description:
+      RGMII Receive Clock Delay defined in pico seconds. There are 32
+      steps of RGMII delay for Aspeed platform. Each Aspeed platform has its
+      own delay step value, it is fixed by hardware design. Total delay is
+      calculated by delay-step * 32. A value of 0 ps will disable any
+      delay. The Default is no delay.
+    default: 0
+
+  tx-internal-delay-ps:
+    description:
+      RGMII Transmit Clock Delay defined in pico seconds. There are 32
+      steps of RGMII delay for Aspeed platform. Each Aspeed platform has its
+      own delay step value, it is fixed by hardware design. Total delay is
+      calculated by delay-step * 32. A value of 0 ps will disable any
+      delay. The Default is no delay.
+    default: 0
+
 required:
   - compatible
   - reg
@@ -85,6 +109,9 @@ allOf:
     then:
       properties:
         resets: true
+        aspeed,scu: true
+        rx-internal-delay-ps: true
+        tx-internal-delay-ps: true
     else:
       properties:
         resets: false

-- 
2.34.1


