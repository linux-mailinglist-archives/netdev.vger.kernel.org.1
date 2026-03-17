Return-Path: <netdev+bounces-268712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGe2EvmhuWn9LQIAu9opvQ
	(envelope-from <netdev+bounces-268712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:48:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 408822B125B
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A10630299EB
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 18:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D497C3F7E99;
	Tue, 17 Mar 2026 18:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zc76JUbG"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682381519B4;
	Tue, 17 Mar 2026 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773237; cv=none; b=c8UZR8RfUTGQkSFCD9lhNjK5tllcBm1X1TiUAhnZtOjptAWZg/9wzIhT3iZlH9n3b5O748aYTekI62PZuOsrvUaJPvmJwPunmXBcPmnGAoD25djt4XTclwPC4bMODYpR1K1uuT3nyfAC6C+ZjsKt4i47EcgnhAkVjGKcJsbjDAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773237; c=relaxed/simple;
	bh=CqWV1M3Z7tlt5lmqpc6dFtALph+6wv1R9tic9kEpMCw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3vz8uLdEjTwCiZ7x2mBb/bNl7qMV2f7bZ3K1NBU9E5IE17PtV0XK//Eq5Rf7yqVcktPBOl/1hvRYL6nnFjpaqiDM/Dtj3Quyj0ZxurE6f5Z3lWDORSeneSzDjjdAPC0qagVdKgiW1HfQeC7DyqGUSRNHwx6vElKE7FLYS2duAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zc76JUbG; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773773236; x=1805309236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CqWV1M3Z7tlt5lmqpc6dFtALph+6wv1R9tic9kEpMCw=;
  b=zc76JUbG4DUUYHEfEj6iehXOmkKq+jqKPFX6cPTzzaQG90qQJn9ceGRu
   xBO6ohylR8KzOwb5ArvSldrU7eLVv+wdmACDgUU3Nru0zGdlSVLOiUTDR
   KJurWHCAI21RSOqx9BfGO1J5XC5CCHTkTOXaJoCd35sdEj3zcYJyb3tqX
   hcNaapbK9t4kEC2cbYIm6Gj1nsPX6EqBy8yG6+fwWcVct7+zm7aOHMRIs
   flCP3jw49RLcwyoHa0bxxngW3SFoPc3sJ1Ph0+CgP5zVP5XiAnNi3Kjws
   r+Aca2K1qlmMpQ3vqktsJrc/8rE0QnU0Ybnld2diKn/M4Fml2sh8QnrlR
   Q==;
X-CSE-ConnectionGUID: wahvWo40QRmVOyIEFQPcXQ==
X-CSE-MsgGUID: NlvPBpvzQW2p+IYSJnx22w==
X-IronPort-AV: E=Sophos;i="6.23,126,1770620400"; 
   d="scan'208";a="222060300"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 11:47:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 17 Mar 2026 11:46:44 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 17 Mar 2026 11:46:43 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit
	<hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 1/2] dt-bindings: net: document Microchip PIC64-HPSC/HX MDIO controller
Date: Tue, 17 Mar 2026 11:46:09 -0700
Message-ID: <20260317184610.315852-2-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317184610.315852-1-charles.perry@microchip.com>
References: <20260317184610.315852-1-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268712-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,devicetree.org:url,4000c21e000:email,microchip.com:dkim,microchip.com:email,microchip.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 408822B125B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This MDIO hardware is based on a Microsemi design supported in Linux by
mdio-mscc-miim.c. However, The register interface is completely different
with pic64hpsc, hence the need for separate documentation.

The hardware supports C22 and C45.

The documentation recommends an input clock of 156.25MHz and a prescaler
of 39, which yields an MDIO clock of 1.95MHz.

The hardware supports an interrupt pin to signal transaction completion
which is not strictly needed as the software can also poll a "TRIGGER"
bit for this.

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 .../net/microchip,pic64hpsc-mdio.yaml         | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml

diff --git a/Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml b/Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
new file mode 100644
index 000000000000..21c76199c11b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/microchip,pic64hpsc-mdio.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/microchip,pic64hpsc-mdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip PIC64-HPSC/HX MDIO controller
+
+maintainers:
+  - Charles Perry <charles.perry@microchip.com>
+
+description: |
+  Microchip PIC64-HPSC/HX SoCs have two MDIO bus controller. This MDIO bus
+  controller supports C22 and C45 register access. It is named "MDIO Initiator"
+  in the documentation.
+
+allOf:
+  - $ref: mdio.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: microchip,pic64hpsc-mdio
+      - items:
+          - const: microchip,pic64hx-mdio
+          - const: microchip,pic64hpsc-mdio
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-frequency: true
+
+  interrupts:
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
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mdio@4000C21E000 {
+            compatible = "microchip,pic64hpsc-mdio";
+            reg = <0x400 0x0C21E000 0x0 0x1000>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            phy0: ethernet-phy@0 {
+                reg = <0>;
+            };
+        };
+    };
-- 
2.47.3


