Return-Path: <netdev+bounces-262601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5VSvK5FnpWkcAAYAu9opvQ
	(envelope-from <netdev+bounces-262601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 11:33:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A03181D695F
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 11:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C40AB30DE18B
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 10:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6493A0B1C;
	Mon,  2 Mar 2026 10:24:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED3639E17E;
	Mon,  2 Mar 2026 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447083; cv=none; b=reTfwLIqd2m7G631+0mOQbiEWXfyphEPKAtFNnUxtAZplFmSZs/mPonOaXm1RAFgup6LI005D7n6ExcJxjmjeFlnZUsgr7bSqVVXYsFUITN1Fy11/1AlD5YfoS4bkGxs980Qp9zYq7i0178xfDjYe6N3oBWOMzx/AXCtsHwHfmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447083; c=relaxed/simple;
	bh=8NZwoYwb2VCG1LCRSHv+AVjZPo5V+zxxU36gRDN2zqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=b7XVl5q5U+JwbQamdazlByD8/1clsI3yTtPlIw5jG0SMssckujR0d8etSqm+RLxpFZS7S+uJyOxK4Rdtt/yZvs3+fud58ngDz2wp37LVKUsPx3m4zpZFBIRbcuYwHyRwmdBEMgYV9cz330BEiX4b3Gmmzt3qJW81os1fojc8mVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 2 Mar
 2026 18:24:30 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Mar 2026 18:24:30 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 2 Mar 2026 18:24:28 +0800
Subject: [PATCH net-next v6 1/5] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260302-rgmii_delay_2600-v6-1-68319a4c4110@aspeedtech.com>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
In-Reply-To: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772447070; l=3348;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=8NZwoYwb2VCG1LCRSHv+AVjZPo5V+zxxU36gRDN2zqs=;
 b=PrXtRYnWTobVOcowR92HfRVdDkG0LYGyRqdY74i9iNH9IHMIvgJ2igdf+fDectjVVH1j3VUZ4
 IAkoYlhVILJBXeARS7VrfUPv6pi7wmIWtKakW3rLfqU79Ohesamajv6
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[aspeedtech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262601-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacky_chou@aspeedtech.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.965];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,aspeedtech.com:mid,aspeedtech.com:email]
X-Rspamd-Queue-Id: A03181D695F
X-Rspamd-Action: no action

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
 .../devicetree/bindings/net/faraday,ftgmac100.yaml | 42 +++++++++++++++++-----
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
index d14410018bcf..4cac216f7339 100644
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
@@ -77,17 +101,17 @@ required:
 allOf:
   - $ref: ethernet-controller.yaml#
   - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - aspeed,ast2600-mac
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - aspeed,ast2600-mac
     then:
       properties:
-        resets: true
-    else:
-      properties:
-        resets: false
+        aspeed,scu: false
+        rx-internal-delay-ps: false
+        tx-internal-delay-ps: false
 
 unevaluatedProperties: false
 

-- 
2.34.1


