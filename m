Return-Path: <netdev+bounces-115272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C5C945B37
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F181F24EC6
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 09:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1191DC481;
	Fri,  2 Aug 2024 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrRkcso3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730BE1DAC4A;
	Fri,  2 Aug 2024 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591625; cv=none; b=g98SK1RVyNBrzCUu32c11NKIrupAArrRxdWYb6HSeFWvDCI2NE5/bjGoNTX0qqSqFet0qtyxt1H/OKFqPqBR/piFAoj69IC+Pa+6PdOZCTXWZHrROJhblUHtzzv+MvtgfgGOoGR38tJJYLxz20B3JcDPM8VhOyKThqhEwt07tMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591625; c=relaxed/simple;
	bh=bF4ED4NrrC8dMHCfZvWLMB8aVMN3QYy8q3le4qszIoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M6SHqS9mbyz0sHoygGeBsvjCNG7aoWl3aK35DyszikQawyPZtkApICSWsJ/Af76HV36/fbF23XSFcrJLZx0UBRyARh65QR5QB3LitHE+qq97ZOf+2cQQXbX4UfJuH1psJtaLRkTq106TrR3c16kNLvq1DjlfZ+LmIiWO4nzhH4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrRkcso3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F08EAC4AF09;
	Fri,  2 Aug 2024 09:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722591625;
	bh=bF4ED4NrrC8dMHCfZvWLMB8aVMN3QYy8q3le4qszIoE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SrRkcso3LeFN0KOM5VAQsFmQmV20aZzPvytVqKP4xWj+NYWzXI0P4CwwfjFA8L5X+
	 GSraZiryal2zbHWhawasP1xWkLOGiPcDd8Eij1khyLN6TREKzIXTQUPgT6yZrfk7hJ
	 fgchyJ2wGepLjBFsEbQqAa4PZsK/3HaYZaeYZsqNT7QfkAoDL32fR951X6Ubyb04oJ
	 UmcShHJGHGya2huRobc1iK0GAKPxzcESMnXvWfdZV6UagX0m1/5nu4pjPMG2OS0hTu
	 3TAsiDYGR5es+28PDUYCgdaAHRNHZA7wSXjCyBgcTImkjBLj+O4zv6u737FauES9iL
	 NNFrHKa3W2/zA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE879C3DA7F;
	Fri,  2 Aug 2024 09:40:24 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Fri, 02 Aug 2024 17:39:47 +0800
Subject: [PATCH v3 1/3] dt-bindings: net: bluetooth: Add support for
 Amlogic Bluetooth
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-btaml-v3-1-d8110bf9963f@amlogic.com>
References: <20240802-btaml-v3-0-d8110bf9963f@amlogic.com>
In-Reply-To: <20240802-btaml-v3-0-d8110bf9963f@amlogic.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Yang Li <yang.li@amlogic.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722591623; l=2151;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=jit1Vgrwmm8Xigd6jWG3AYnjzF/YLlq67lp25AQso5I=;
 b=ZEK+MJkZmwHPV+HVoYUuAnMXbNQe8Jl4DSa+h1deIBEtfayDJAzEShJafcjwOrJ33ymOsCHgf
 jXIcUUJZ4/pC45LxP3HJkXTQWG8Us3sGvzOEtzoUYl8bVandsr/RwxL
X-Developer-Key: i=yang.li@amlogic.com; a=ed25519;
 pk=86OaNWMr3XECW9HGNhkJ4HdR2eYA5SEAegQ3td2UCCs=
X-Endpoint-Received: by B4 Relay for yang.li@amlogic.com/20240418 with
 auth_id=180
X-Original-From: Yang Li <yang.li@amlogic.com>
Reply-To: yang.li@amlogic.com

From: Yang Li <yang.li@amlogic.com>

Add binding document for Amlogic Bluetooth chipsets attached over UART.

Signed-off-by: Yang Li <yang.li@amlogic.com>
---
 .../bindings/net/bluetooth/amlogic,w155s2-bt.yaml  | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
new file mode 100644
index 000000000000..c0c4209cd687
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
@@ -0,0 +1,62 @@
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
+      - const: amlogic,w155s2-bt
+      - items:
+          - enum:
+              - amlogic,w265s1-bt
+              - amlogic,w265p1-bt
+              - amlogic,w265s2-bt
+          - const: amlogic,w155s2-bt
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
+  - enable-gpios
+  - vddio-supply
+  - clocks
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



