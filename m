Return-Path: <netdev+bounces-112015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04771934916
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 09:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E67283518
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 07:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAA077F13;
	Thu, 18 Jul 2024 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1BKQZWy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAED0770E1;
	Thu, 18 Jul 2024 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721288577; cv=none; b=eoQufXxpu+J91hq4Ms01JhtSgcvOT23iumnUua7Xybf1UpK0Bq1ydg4TiP8UkKJSMd0HD8+POYMuGE4IghVJSdimSljxVR7dfenkaiYzly0wv44j1wF7/ur1YBd/Q+85yjoFLCBJh9HpqwKkm4pa1nlvQXl6vsbCLx75CcsrDpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721288577; c=relaxed/simple;
	bh=sLBkUfaYzf0dpKQ0mfniXvel0oep7g9yqdcHGIQMq1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SUIEL3taz7rtnGjUxQK9eOLIVpvP2lyj6c4EYMQGl9zwT7dcLsFsCMNmAv7Fb5wXjvreVc3eBT9Mqc70Moi7xdRS7m722gCjHoELvCbJlcsnHWAifq2W5Iv5ySMJy4SPcftc6tNG38mLB/LD6gEZwC3eSSVeAFe/a3udQDQm2kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1BKQZWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F81EC4AF0B;
	Thu, 18 Jul 2024 07:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721288577;
	bh=sLBkUfaYzf0dpKQ0mfniXvel0oep7g9yqdcHGIQMq1c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=l1BKQZWyMno+HbzaCud11b+xDaT2lWJRA7j0fPw3MM2W3K04gZPkZstV7hib4RZFC
	 EQFxARgeGeoAnes5Rds3yBXPNhMMMEchEFvYEEB6u97foVjD+DswTjd6uL+hSCm9q0
	 aGGeuw6/mrris93ICYEKggXVai68WKH1YggIRYHLAJegtUdyLdde3I+GNV64b+E8Rb
	 f0V0FbbxVESaB+rc78JSEMBYbXir1NhBl5Fr7uG9OFfXRmPw/roLFeRLRW1OqZYfPy
	 UkS3CNqSq4DICybZKMXPQoXP4tvHdaO9cfWrwLw38WIrNhhIZ8zwU41T2O/ucpIxii
	 DO2ImJGzX/pQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C33EC3DA60;
	Thu, 18 Jul 2024 07:42:57 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Thu, 18 Jul 2024 15:42:19 +0800
Subject: [PATCH v2 1/3] dt-bindings: net: bluetooth: Add support for
 Amlogic Bluetooth
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240718-btaml-v2-1-1392b2e21183@amlogic.com>
References: <20240718-btaml-v2-0-1392b2e21183@amlogic.com>
In-Reply-To: <20240718-btaml-v2-0-1392b2e21183@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721288574; l=2303;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=NKfAxG46ev+07V5JY7lMTYG79SYAEMUTi1t2oAUebxk=;
 b=jsgDStLviGT7mtA3ZU/XMwos7ZYmLuGJkJ+hvVDc9KbANvD3w8LRmEjz7QsmrH/1NmSgX/PQN
 isyZRrRo3pvA38npP8NqmOjOYsHXjbq8rZcX59+bJBuS+H+DgvQ7elS
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
 .../bindings/net/bluetooth/amlogic,w155s2-bt.yaml  | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
new file mode 100644
index 000000000000..2e433d5692ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
@@ -0,0 +1,66 @@
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
+  This binding describes UART-attached Amlogic bluetooth chips.
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
+  bt-enable-gpios:
+    maxItems: 1
+    description: gpio specifier used to enable BT
+
+  bt-supply:
+    description: bluetooth chip 3.3V supply regulator handle
+
+  clocks:
+    maxItems: 1
+    description: clock provided to the controller (32.768KHz)
+
+  antenna-number:
+    default: 1
+    description: device supports up to two antennas
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  firmware-name:
+    description: specify the path of firmware bin to load
+    $ref: /schemas/types.yaml#/definitions/string-array
+
+required:
+  - compatible
+  - bt-enable-gpios
+  - bt-supply
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
+        bt-enable-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
+        bt-supply = <&wcn_3v3>;
+        clocks = <&extclk>;
+        firmware-name = "amlogic/aml_w155s2_bt_uart.bin";
+    };
+

-- 
2.42.0



