Return-Path: <netdev+bounces-124495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB482969ACA
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643FD2864AF
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 10:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FEA1CDFA3;
	Tue,  3 Sep 2024 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YQCkenbt"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414C71C768C;
	Tue,  3 Sep 2024 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360608; cv=none; b=IivxNzd6r8l8gXneoWWP9/rGeC7CQVfXgEXRZjufK8kqR5Ob6V9tHAXR/xj+aKXm7jSywh8Rn+Jxa8sft1cuaIYNscI2dCQybm3ZPaMixrb8h/6UffzJF0FHNMBZbdUCeBOpnLA/NeJgS5YJY67F3TvsMsCk3DHIzmTwGbqA41Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360608; c=relaxed/simple;
	bh=wLJAyXZJlBfix3vbTRt1mSiR8OrctbS/AdSN3GODMTo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oaSiKDlEew+Z/sR3xvdn8vH/X8ulvNWtPZWRHHrocGu+4TNyF2Y3LE14fBop0QZFCpNn09OgqpMBh6TO0VMhU7jZmHYISHeSuD+3+HGQv7KScyyS7WesJuPIG6+u+ZzR9sdPQNqzzCjUsOHxp6oaiGJgpeBPqWywwM36O1SnaPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YQCkenbt; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725360607; x=1756896607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wLJAyXZJlBfix3vbTRt1mSiR8OrctbS/AdSN3GODMTo=;
  b=YQCkenbtACsDQpNYq5rU9zqQKSkrATHkD9L7cjwjtTg4jl+moDa1OUPh
   AkqiQ3fh6SiCZyl+GRrVLnXJNhndLProPUdkd3yeYqaP0VCTiNYFClE2h
   INunuxgCa42IWHmZ0kPy2RyRx1OvCsoTuFvtChC/mmdb+8+nyYC2j15wt
   7QAedysr9t3EHIU90T/fNFdgSnrumy/it+kjCcQ5LVmEtnh9Ywb6jLkIP
   UkYFCcYc2hIX0OVYgjvgbzCydOtKLqr9JTMw7ajvR8D+18CYlGwTf5bje
   +tePp0RHWkairHYr6nOoXFEyjpWJ1xL+HBqfW0Epu9dDJPIy0+mbtrgtE
   w==;
X-CSE-ConnectionGUID: /L46bepbTPyfYHrKhIsMng==
X-CSE-MsgGUID: MJQr3xo4TluPDUwjFFBQTw==
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="34314910"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Sep 2024 03:50:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 3 Sep 2024 03:49:55 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 3 Sep 2024 03:49:45 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>,
	<alexanderduyck@fb.com>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<rdunlap@infradead.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, <markku.vorne@kempower.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH net-next v7 14/14] dt-bindings: net: add Microchip's LAN865X 10BASE-T1S MACPHY
Date: Tue, 3 Sep 2024 16:17:05 +0530
Message-ID: <20240903104705.378684-15-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903104705.378684-1-Parthiban.Veerasooran@microchip.com>
References: <20240903104705.378684-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

The LAN8650/1 combines a Media Access Controller (MAC) and an Ethernet
PHY to enable 10BASE-T1S networks. The Ethernet Media Access Controller
(MAC) module implements a 10 Mbps half duplex Ethernet MAC, compatible
with the IEEE 802.3 standard and a 10BASE-T1S physical layer transceiver
integrated into the LAN8650/1. The communication between the Host and the
MAC-PHY is specified in the OPEN Alliance 10BASE-T1x MACPHY Serial
Interface (TC6).

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 .../bindings/net/microchip,lan8650.yaml       | 80 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan8650.yaml

diff --git a/Documentation/devicetree/bindings/net/microchip,lan8650.yaml b/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
new file mode 100644
index 000000000000..b7b755b27b78
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/microchip,lan8650.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN8650/1 10BASE-T1S MACPHY Ethernet Controllers
+
+maintainers:
+  - Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
+
+description:
+  The LAN8650/1 combines a Media Access Controller (MAC) and an Ethernet
+  PHY to enable 10BASE‑T1S networks. The Ethernet Media Access Controller
+  (MAC) module implements a 10 Mbps half duplex Ethernet MAC, compatible
+  with the IEEE 802.3 standard and a 10BASE-T1S physical layer transceiver
+  integrated into the LAN8650/1. The communication between the Host and
+  the MAC-PHY is specified in the OPEN Alliance 10BASE-T1x MACPHY Serial
+  Interface (TC6).
+
+allOf:
+  - $ref: /schemas/net/ethernet-controller.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: microchip,lan8650
+      - items:
+          - const: microchip,lan8651
+          - const: microchip,lan8650
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Interrupt from MAC-PHY asserted in the event of Receive Chunks
+      Available, Transmit Chunk Credits Available and Extended Status
+      Event.
+    maxItems: 1
+
+  spi-max-frequency:
+    minimum: 15000000
+    maximum: 25000000
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - spi-max-frequency
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ethernet@0 {
+        compatible = "microchip,lan8651", "microchip,lan8650";
+        reg = <0>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&eth0_pins>;
+        interrupt-parent = <&gpio>;
+        interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
+        local-mac-address = [04 05 06 01 02 03];
+        spi-max-frequency = <15000000>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 934a81151530..8456af576825 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14969,6 +14969,7 @@ MICROCHIP LAN8650/1 10BASE-T1S MACPHY ETHERNET DRIVER
 M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/microchip,lan8650.yaml
 F:	drivers/net/ethernet/microchip/lan865x/lan865x.c
 
 MICROCHIP LAN87xx/LAN937x T1 PHY DRIVER
-- 
2.34.1


