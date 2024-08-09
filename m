Return-Path: <netdev+bounces-117093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E439594C9B6
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 07:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A162C2849F0
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 05:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C6316C869;
	Fri,  9 Aug 2024 05:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skjAZ70q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C7116C6A4;
	Fri,  9 Aug 2024 05:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723182155; cv=none; b=BytY2vi+Z1k6OsC4lnKVrR9Av1eJPKmD9eVIDx9jg15HgC0ymiNLBbENxWM0eeI0PO55N5u7GDhopxQQPNmT/gmbWcDY8TVzQQXv2aLPMXZugT9VEXzPwUomPpKKlfjAWJ6ZdNmdvv2BvHBMBiD1Hi1vqpdiz2d2IPx3ZLvGLRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723182155; c=relaxed/simple;
	bh=BdnaGAHUbDo+CAAY6sUw/V7K3OlwIoWt7tsFTDXLrNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PPmMGnsR4+nVZSCp+x6WLRAqWVp4XUkVN22wugKzuEQYNZh79T54ZM1S1dNF1JooU6EEfe8UYXDscnr+h5uM0aJ48EgyLdsYBCz18rN0I0XLVCCh0RdNjOzpszlyoeRKHb8kaDte7GISy5/uKaTL5yjULeMaWUnO8SONFr6MO3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skjAZ70q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AD17C4AF0B;
	Fri,  9 Aug 2024 05:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723182154;
	bh=BdnaGAHUbDo+CAAY6sUw/V7K3OlwIoWt7tsFTDXLrNk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=skjAZ70q1M8rSnjOxevTOdVlImgc7w4wfJVV5T8V7UZ/DHNr5558DPj7vMNUVaRoZ
	 sJwbLfmwY9huNpLmSOK13ztyvAznPNGPyBxPG4Z1BLN10M/y675icbkv7Ze3YXESxB
	 JtLefMR191oHIKUV/q4KwJwieorJkppZk1dq499VEbjOd1WgEC7Oa3pRjm1IAKaR8w
	 zW7R1CAGPiaB++fNWYF/mxqelLhNeWIQKZ2fTJXDLHESDM2NroWFH0N0lW9ExfE93M
	 VU+uVGPPwOAG9aiTvHdvtriEgu5z15b40etOZr+M/GZcuWuT2R5Yf5kL0SjPhfum3Y
	 8w53fkTdcQjUg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6469CC3DA4A;
	Fri,  9 Aug 2024 05:42:34 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Fri, 09 Aug 2024 13:42:24 +0800
Subject: [PATCH v4 1/3] dt-bindings: net: bluetooth: Add support for
 Amlogic Bluetooth
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-btaml-v4-1-376b284405a7@amlogic.com>
References: <20240809-btaml-v4-0-376b284405a7@amlogic.com>
In-Reply-To: <20240809-btaml-v4-0-376b284405a7@amlogic.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Yang Li <yang.li@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723182152; l=2227;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=fCyoX+AnuaJrE//USqykfOes2DIAQw09k3gJ7c/oY2k=;
 b=aL6xK80lWiSlJEJWs2YuSWUEg7xxYXgeh1tuWbihxwS4rTcu1gNUY6tn2Stndbag2jIR8tmME
 rgobOu7U6wDCQ1mzD2grD2XR+dBdFoPlmKIyQrFJV2jhduSSQRTEmvS
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

Add binding document for Amlogic Bluetooth chipsets attached over UART.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 .../bindings/net/bluetooth/amlogic,w155s2-bt.yaml  | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
new file mode 100644
index 000000000000..6fd7557039d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2024 Amlogic, Inc. All rights reserved
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/amlogic,w155s2-bt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Bluetooth chips
+
+description:
+  The W155S2 is an Amlogic Bluetooth and Wi-Fi combo chip. It works on
+  the standard H4 protocol via a 4-wire UART interface, with baud rates
+  up to 4 Mbps.
+
+maintainers:
+  - Yang Li <yang.li@amlogic.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,w265s1-bt
+              - amlogic,w265p1-bt
+          - const: amlogic,w155s2-bt
+      - enum:
+          - amlogic,w155s2-bt
+          - amlogic,w265s2-bt
+
+  clocks:
+    maxItems: 1
+    description: clock provided to the controller (32.768KHz)
+
+  enable-gpios:
+    maxItems: 1
+
+  vddio-supply:
+    description: VDD_IO supply regulator handle
+
+  firmware-name:
+    maxItems: 1
+    description: specify the path of firmware bin to load
+
+required:
+  - compatible
+  - clocks
+  - enable-gpios
+  - vddio-supply
+  - firmware-name
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    bluetooth {
+        compatible = "amlogic,w155s2-bt";
+        clocks = <&extclk>;
+        enable-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
+        vddio-supply = <&wcn_3v3>;
+        firmware-name = "amlogic/aml_w155s2_bt_uart.bin";
+    };
+

-- 
2.42.0



