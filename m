Return-Path: <netdev+bounces-227505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFAABB1810
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 20:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F48D194774B
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 18:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A722D63EF;
	Wed,  1 Oct 2025 18:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b="HHdG3Ruz"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD732D5934;
	Wed,  1 Oct 2025 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759343632; cv=pass; b=Bw8b2rfxTyy5qRgEobY1LJTZZlUpJl3/ca4wo8OJTq2yHiDpqGfumCpxqePL0VZZXZqz3hCk59Hl9teLKluppoOegooS4ajDfA/JaBvHm/nKpQIdv0tWLlEaJeFcmM0ENprD4BMVNOQrHOaNG0WGZc6C+z8BXNB/W1sHT9sgnmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759343632; c=relaxed/simple;
	bh=6XPuX0m01ZFf2GseM0abEL1RU1m4cMag66VApjnqATw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A3BgHzDZ6LLvGjUSPAMQWWVv7cPWdiDnNiRqCJxQRLHXIEXOyog0YjvyaZISb7ONuRn1Uz7m+LgUs3NF4irc/u63SR5x8rhy4FbAjY80gIW+bzzxUAUXOb5ZNXPtNluWRq09OFITS/2RV6VPWyn7K02lmXXVT8pAuBpflnH+oUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ariel.dalessandro@collabora.com header.b=HHdG3Ruz; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1759343611; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gXAEQVDCK74OK0TzgTvTVA+MUfiCZiPJSqtb6A0RzFDlVAzkGWfdzklQ8xaf+QQ1bDrbZhTRe+Axr4oTSkK4UFTZNMkcDg2ZE2OqqeYTZjGoQXR8hf2OQ9iVPBNkpe93v4cjguLw3w8hIh7OYGF8/fX59rz0xB0+pVXtv5I8JGE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759343611; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5Tf1KRNvIh/o3Lawrm1/DSWDlI3pzmdrutlzoqFE9jM=; 
	b=WVl7sfPLoh73cyvsUaNf5DoDdmjA7cK0cAPKbo7E/XC4dwdGklj0IphxKz0vqB54Q8oFOWbzul0VEH/ek5nZGf7/AxDi4vuWGewAPd2CJ3s46kdnOZcZCFu8ZkuR+CZsBRQ+ZCK8ggaTzCv5d+Gjku6JgdNwjTLbbV6iVviJ4QU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ariel.dalessandro@collabora.com;
	dmarc=pass header.from=<ariel.dalessandro@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759343611;
	s=zohomail; d=collabora.com; i=ariel.dalessandro@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=5Tf1KRNvIh/o3Lawrm1/DSWDlI3pzmdrutlzoqFE9jM=;
	b=HHdG3Ruz4P6R9QgHFOYqkeIpbu1ln3qlPVXfSOXm7OUfyiZxyfaHqX0E5Khr3HWK
	e+KQ1qOKYMrdkKpHO9hHjAxLH2HiXhKn+Vlc2JMYrVvli3IKwLze0hSbbbwWZO4mY4l
	rqPFhfYx8Uko3TPhwfbvvwhHDKkwVP0viKtOYakE=
Received: by mx.zohomail.com with SMTPS id 1759343610165605.9822601405356;
	Wed, 1 Oct 2025 11:33:30 -0700 (PDT)
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To: andrew+netdev@lunn.ch,
	angelogioacchino.delregno@collabora.com,
	ariel.dalessandro@collabora.com,
	conor+dt@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	krzk+dt@kernel.org,
	kuba@kernel.org,
	luiz.dentz@gmail.com,
	pabeni@redhat.com,
	robh@kernel.org
Cc: devicetree@vger.kernel.org,
	kernel@collabora.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v3] dt-bindings: net: Convert Marvell 8897/8997 bindings to DT schema
Date: Wed,  1 Oct 2025 15:33:20 -0300
Message-ID: <20251001183320.83221-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Convert the existing text-based DT bindings for Marvell 8897/8997
(sd8897/sd8997) bluetooth devices controller to a DT schema.

While here, bindings for "usb1286,204e" (USB interface) are dropped from
the DT   schema definition as these are currently documented in file [0].

[0] Documentation/devicetree/bindings/net/btusb.txt

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 .../net/bluetooth/marvell,sd8897-bt.yaml      | 79 ++++++++++++++++++
 .../devicetree/bindings/net/btusb.txt         |  2 +-
 .../bindings/net/marvell-bt-8xxx.txt          | 83 -------------------
 3 files changed, 80 insertions(+), 84 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/marvell,sd8897-bt.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/marvell-bt-8xxx.txt

diff --git a/Documentation/devicetree/bindings/net/bluetooth/marvell,sd8897-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/marvell,sd8897-bt.yaml
new file mode 100644
index 0000000000000..a307c64cfa4d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/marvell,sd8897-bt.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/marvell,sd8897-bt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell 8897/8997 (sd8897/sd8997) bluetooth devices (SDIO)
+
+maintainers:
+  - Ariel D'Alessandro <ariel.dalessandro@collabora.com>
+
+allOf:
+  - $ref: /schemas/net/bluetooth/bluetooth-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - marvell,sd8897-bt
+      - marvell,sd8997-bt
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  marvell,cal-data:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description:
+      Calibration data downloaded to the device during initialization.
+    maxItems: 28
+
+  marvell,wakeup-pin:
+    $ref: /schemas/types.yaml#/definitions/uint16
+    description:
+      Wakeup pin number of the bluetooth chip. Used by firmware to wakeup host
+      system.
+
+  marvell,wakeup-gap-ms:
+    $ref: /schemas/types.yaml#/definitions/uint16
+    description:
+      Wakeup latency of the host platform. Required by the chip sleep feature.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    mmc {
+        vmmc-supply = <&wlan_en_reg>;
+        bus-width = <4>;
+        cap-power-off-card;
+        keep-power-in-suspend;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        bluetooth@2 {
+            compatible = "marvell,sd8897-bt";
+            reg = <2>;
+            interrupt-parent = <&pio>;
+            interrupts = <119 IRQ_TYPE_LEVEL_LOW>;
+
+            marvell,cal-data = /bits/ 8 <
+                0x37 0x01 0x1c 0x00 0xff 0xff 0xff 0xff 0x01 0x7f 0x04 0x02
+                0x00 0x00 0xba 0xce 0xc0 0xc6 0x2d 0x00 0x00 0x00 0x00 0x00
+                0x00 0x00 0xf0 0x00>;
+            marvell,wakeup-pin = /bits/ 16 <0x0d>;
+            marvell,wakeup-gap-ms = /bits/ 16 <0x64>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/net/btusb.txt b/Documentation/devicetree/bindings/net/btusb.txt
index f546b1f7dd6d2..a68022a57c51e 100644
--- a/Documentation/devicetree/bindings/net/btusb.txt
+++ b/Documentation/devicetree/bindings/net/btusb.txt
@@ -14,7 +14,7 @@ Required properties:
 
 
 Also, vendors that use btusb may have device additional properties, e.g:
-Documentation/devicetree/bindings/net/marvell-bt-8xxx.txt
+Documentation/devicetree/bindings/net/bluetooth/marvell,sd8897-bt.yaml
 
 Optional properties:
 
diff --git a/Documentation/devicetree/bindings/net/marvell-bt-8xxx.txt b/Documentation/devicetree/bindings/net/marvell-bt-8xxx.txt
deleted file mode 100644
index 957e5e5c2927c..0000000000000
--- a/Documentation/devicetree/bindings/net/marvell-bt-8xxx.txt
+++ /dev/null
@@ -1,83 +0,0 @@
-Marvell 8897/8997 (sd8897/sd8997) bluetooth devices (SDIO or USB based)
-------
-The 8997 devices supports multiple interfaces. When used on SDIO interfaces,
-the btmrvl driver is used and when used on USB interface, the btusb driver is
-used.
-
-Required properties:
-
-  - compatible : should be one of the following:
-	* "marvell,sd8897-bt" (for SDIO)
-	* "marvell,sd8997-bt" (for SDIO)
-	* "usb1286,204e"      (for USB)
-
-Optional properties:
-
-  - marvell,cal-data: Calibration data downloaded to the device during
-		      initialization. This is an array of 28 values(u8).
-		      This is only applicable to SDIO devices.
-
-  - marvell,wakeup-pin: It represents wakeup pin number of the bluetooth chip.
-		        firmware will use the pin to wakeup host system (u16).
-  - marvell,wakeup-gap-ms: wakeup gap represents wakeup latency of the host
-		      platform. The value will be configured to firmware. This
-		      is needed to work chip's sleep feature as expected (u16).
-  - interrupt-names: Used only for USB based devices (See below)
-  - interrupts : specifies the interrupt pin number to the cpu. For SDIO, the
-		 driver will use the first interrupt specified in the interrupt
-		 array. For USB based devices, the driver will use the interrupt
-		 named "wakeup" from the interrupt-names and interrupt arrays.
-		 The driver will request an irq based on this interrupt number.
-		 During system suspend, the irq will be enabled so that the
-		 bluetooth chip can wakeup host platform under certain
-		 conditions. During system resume, the irq will be disabled
-		 to make sure unnecessary interrupt is not received.
-
-Example:
-
-IRQ pin 119 is used as system wakeup source interrupt.
-wakeup pin 13 and gap 100ms are configured so that firmware can wakeup host
-using this device side pin and wakeup latency.
-
-Example for SDIO device follows (calibration data is also available in
-below example).
-
-&mmc3 {
-	vmmc-supply = <&wlan_en_reg>;
-	bus-width = <4>;
-	cap-power-off-card;
-	keep-power-in-suspend;
-
-	#address-cells = <1>;
-	#size-cells = <0>;
-	btmrvl: bluetooth@2 {
-		compatible = "marvell,sd8897-bt";
-		reg = <2>;
-		interrupt-parent = <&pio>;
-		interrupts = <119 IRQ_TYPE_LEVEL_LOW>;
-
-		marvell,cal-data = /bits/ 8 <
-			0x37 0x01 0x1c 0x00 0xff 0xff 0xff 0xff 0x01 0x7f 0x04 0x02
-			0x00 0x00 0xba 0xce 0xc0 0xc6 0x2d 0x00 0x00 0x00 0x00 0x00
-			0x00 0x00 0xf0 0x00>;
-		marvell,wakeup-pin = /bits/ 16 <0x0d>;
-		marvell,wakeup-gap-ms = /bits/ 16 <0x64>;
-	};
-};
-
-Example for USB device:
-
-&usb_host1_ohci {
-    #address-cells = <1>;
-    #size-cells = <0>;
-
-    mvl_bt1: bt@1 {
-	compatible = "usb1286,204e";
-	reg = <1>;
-	interrupt-parent = <&gpio0>;
-	interrupt-names = "wakeup";
-	interrupts = <119 IRQ_TYPE_LEVEL_LOW>;
-	marvell,wakeup-pin = /bits/ 16 <0x0d>;
-	marvell,wakeup-gap-ms = /bits/ 16 <0x64>;
-    };
-};
-- 
2.51.0


