Return-Path: <netdev+bounces-28404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBE777F582
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 13:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5FFE1C212DF
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F7D134D6;
	Thu, 17 Aug 2023 11:45:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FA6134C7
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 11:45:58 +0000 (UTC)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644EE1982;
	Thu, 17 Aug 2023 04:45:57 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37HBjf7q074793;
	Thu, 17 Aug 2023 06:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1692272741;
	bh=/S129qc4Vgiz0bB2OCCGkCbAQ9jhHRVPgmlEhcsclfU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KehU2BhepF/+3NgiREyHOMjtYG5cEUviZu4x5OzvkmVltkH6BnpL2MEaZpS8n/vkJ
	 9G34KvTA/FN7H0/i9ZuzxbLgOfK+JSVQyEzZcgejiggphgaYijeDRiyESOBEo7uMv5
	 WRa0FmFezc32ZLJ7Ksu7xP66Yw5AdhcpQXu6AuyA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37HBjffB124748
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Aug 2023 06:45:41 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Aug 2023 06:45:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Aug 2023 06:45:41 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37HBjfaf006792;
	Thu, 17 Aug 2023 06:45:41 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 37HBje7m002780;
	Thu, 17 Aug 2023 06:45:40 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Randy Dunlap <rdunlap@infradead.org>, Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran
	<richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        MD Danish Anwar <danishanwar@ti.com>
CC: <nm@ti.com>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 1/5] dt-bindings: net: Add ICSS IEP
Date: Thu, 17 Aug 2023 17:15:23 +0530
Message-ID: <20230817114527.1585631-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817114527.1585631-1-danishanwar@ti.com>
References: <20230817114527.1585631-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add DT binding documentation for ICSS IEP module.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 .../devicetree/bindings/net/ti,icss-iep.yaml  | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ti,icss-iep.yaml

diff --git a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
new file mode 100644
index 000000000000..75668bea8614
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/ti,icss-iep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ICSS Industrial Ethernet Peripheral (IEP) module
+
+maintainers:
+  - Md Danish Anwar <danishanwar@ti.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - ti,am642-icss-iep
+              - ti,j721e-icss-iep
+          - const: ti,am654-icss-iep
+
+      - const: ti,am654-icss-iep
+
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: phandle to the IEP source clock
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+
+    /* AM65x */
+    icssg0_iep0: iep@2e000 {
+        compatible = "ti,am654-icss-iep";
+        reg = <0x2e000 0x1000>;
+        clocks = <&icssg0_iepclk_mux>;
+    };
+
+    /* J721E */
+    icssg0_iep1: iep@2f000 {
+        compatible = "ti,j721e-icss-iep","ti,am654-icss-iep";
+        reg = <0x2e000 0x1000>;
+        clocks = <&icssg0_iepclk_mux>;
+    };
+
+
+    /* AM64x */
+    icssg0_iep2: iep@2b000 {
+        compatible = "ti,am642-icss-iep", "ti,am654-icss-iep";
+        reg = <0x2e000 0x1000>;
+        clocks = <&icssg0_iepclk_mux>;
+    };
-- 
2.34.1


