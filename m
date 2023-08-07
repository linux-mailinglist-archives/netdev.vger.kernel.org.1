Return-Path: <netdev+bounces-24873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBD9771F12
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768D8281296
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 11:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA86D2EE;
	Mon,  7 Aug 2023 11:01:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4E9523C
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 11:01:18 +0000 (UTC)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752A31724;
	Mon,  7 Aug 2023 04:01:16 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377B12pa054602;
	Mon, 7 Aug 2023 06:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1691406062;
	bh=UJqiuiKnYbE4izJZILqA6muqEBOkUzeolNYz0QPgsyU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DTcfH9LaWYHQeePEgVlU0YbhXCST+LGwIJpwcgys/CEkhlPuPxL+IB1klCedjeYOH
	 hDJSLQREK3xvHmH/F9ZHjmrDxVHljkQcBhqVlUeBCFO8d/blx2dZhsEsiQl7uC8PZM
	 BqNaWTXv+JfegfBhfvuz1u10QmP0Bl6VMynlrZFQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377B12n9021305
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Aug 2023 06:01:02 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 06:01:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 06:01:01 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377B11SA073102;
	Mon, 7 Aug 2023 06:01:01 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 377B10M8028368;
	Mon, 7 Aug 2023 06:01:01 -0500
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
Subject: [PATCH v2 1/5] dt-bindings: net: Add ICSS IEP
Date: Mon, 7 Aug 2023 16:30:44 +0530
Message-ID: <20230807110048.2611456-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807110048.2611456-1-danishanwar@ti.com>
References: <20230807110048.2611456-1-danishanwar@ti.com>
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

From: Md Danish Anwar <danishanwar@ti.com>

Add DT binding documentation for ICSS IEP module.

Signed-off-by: Md Danish Anwar <danishanwar@ti.com>
---
 .../devicetree/bindings/net/ti,icss-iep.yaml  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ti,icss-iep.yaml

diff --git a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
new file mode 100644
index 000000000000..d3c5d91e9464
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
@@ -0,0 +1,37 @@
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
+    enum:
+      - ti,am654-icss-iep   # for K3 AM65x SoCs
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
+    icssg0_iep0: iep@2e000 {
+        compatible = "ti,am654-icss-iep";
+        reg = <0x2e000 0x1000>;
+        clocks = <&icssg0_iepclk_mux>;
+    };
-- 
2.34.1


