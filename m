Return-Path: <netdev+bounces-43510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF157D3B45
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 17:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05344281453
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 15:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC851C697;
	Mon, 23 Oct 2023 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YwBQaOdE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9771C291;
	Mon, 23 Oct 2023 15:48:07 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E6AE9;
	Mon, 23 Oct 2023 08:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698076086; x=1729612086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b9l7jWwFPMAuzQs/YBtDqS7+V1WAQBtPurYwM8FLNtI=;
  b=YwBQaOdEIDc4sz3OiL0snkWXbHAUkLmzLWdRhvVZkZwaQi8T8tDvJQEv
   XutM6nbjywMZR5hzNJWV4c+DB3da7qQNCZ+z2DU+v+Y10H/eCGzf/jg2x
   ifdZZzwriynmHE03Y9fjbYBkngttn4kIx/x+ZEIwUmUp9/nwQioA8cByr
   pE9QWrDO1OajBFFbOH3QK0j1w3X9yNS/551W5Md7v+wR3mkpB2zVEekh/
   eWrZG6RKq5xZeTUw5r9OlnSWEVJ30JfHW5E73QoMFqPmrjKjl8dELODp4
   kNuOzN+9PI1zY0QZ+4jfcFW8HFHTeO01Gbo6wTdIdoqSBltov5dJP3tK5
   g==;
X-CSE-ConnectionGUID: klqWPg5QRmSazEzEhLffbg==
X-CSE-MsgGUID: OkqgdSelQ7et0cyfBRDkVw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="241208148"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2023 08:48:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 23 Oct 2023 08:48:02 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 23 Oct 2023 08:47:50 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
	<steen.hegelund@microchip.com>, <rdunlap@infradead.org>, <horms@kernel.org>,
	<casper.casan@gmail.com>, <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
	<Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v2 4/9] dt-bindings: net: add OPEN Alliance 10BASE-T1x MAC-PHY Serial Interface
Date: Mon, 23 Oct 2023 21:16:44 +0530
Message-ID: <20231023154649.45931-5-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add DT bindings OPEN Alliance 10BASE-T1x MACPHY Serial Interface
parameters. These are generic properties that can apply to any 10BASE-T1x
MAC-PHY which uses OPEN Alliance TC6 specification.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 .../devicetree/bindings/net/oa-tc6.yaml       | 72 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/oa-tc6.yaml

diff --git a/Documentation/devicetree/bindings/net/oa-tc6.yaml b/Documentation/devicetree/bindings/net/oa-tc6.yaml
new file mode 100644
index 000000000000..9f442fa6cace
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/oa-tc6.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/oa-tc6.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OPEN Alliance 10BASE-T1x MAC-PHY Specification Common Properties
+
+maintainers:
+  - Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
+
+description:
+  These are generic properties that can apply to any 10BASE-T1x MAC-PHY
+  which uses OPEN Alliance TC6 specification.
+
+  10BASE-T1x MAC-PHY Serial Interface Specification can be found at:
+    https://opensig.org/about/specifications/
+
+properties:
+  $nodename:
+    pattern: "^oa-tc6(@.*)?"
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  oa-cps:
+    maxItems: 1
+    description:
+      Chunk Payload Size. Configures the data chunk payload size to 2^N,
+      where N is the value of this bitfield. The minimum possible data
+      chunk payload size is 8 bytes or N = 3. The default data chunk
+      payload size is 64 bytes, or N = 6. The minimum supported data chunk
+      payload size for this MAC-PHY device is indicated in the CPSMIN
+      field of the CAPABILITY register. Valid values for this parameter
+      are 8, 16, 32 and 64. All other values are reserved.
+
+  oa-txcte:
+    maxItems: 1
+    description:
+      Transmit Cut-Through Enable. When supported by this MAC-PHY device,
+      this bit enables the cut-through mode of frame transfer through the
+      MAC-PHY device from the SPI host to the network.
+
+  oa-rxcte:
+    maxItems: 1
+    description:
+      Receive Cut-Through Enable. When supported by this MAC-PHY device,
+      this bit enables the cut-through mode of frame transfer through the
+      MAC-PHY device from the network to the SPI host.
+
+  oa-prote:
+    maxItems: 1
+    description:
+      Control data read/write Protection Enable. When set, all control
+      data written to and read from the MAC-PHY will be transferred with
+      its complement for detection of bit errors.
+
+additionalProperties: true
+
+examples:
+  - |
+    oa-tc6 {
+        #address-cells = <1>;
+	#size-cells = <0>;
+	oa-cps = <64>;
+	oa-txcte;
+	oa-rxcte;
+	oa-prote;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 1c165026bbd4..9580be91f5e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15975,6 +15975,7 @@ OPEN ALLIANCE 10BASE-T1S MACPHY SERIAL INTERFACE FRAMEWORK
 M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/oa-tc6.yaml
 F:	Documentation/networking/oa-tc6-framework.rst
 F:	drivers/include/linux/oa_tc6.h
 F:	drivers/net/ethernet/oa_tc6.c
-- 
2.34.1


