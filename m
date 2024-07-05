Return-Path: <netdev+bounces-109440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC6A9287B8
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471BA1F219CF
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 11:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BC31494DE;
	Fri,  5 Jul 2024 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9NE+K/o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C0B147C9B;
	Fri,  5 Jul 2024 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178458; cv=none; b=dtmjAr48pxk8wwqxthMWTCf7Kc2Obx+3Uav3sPlt7DrgvhXjE9Q1O0qOJjAm36SAcBZAQZPlRELlOXNgC6nJRYkvlhrMB44jb7+oLobx2CnXjeGAws9GvwRVNic2fRo+j+348B43miypa+OiilYWi3ICzyJDkooCP6XvTodDpnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178458; c=relaxed/simple;
	bh=DY7umAaPi6InwzE4ppZxfzvkdB/ljYV1/u71C9g/GL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WELS10Ho4bV681K0sfYB9CP6NAAU0dvt/1dNXFm5J+zCmlnSTLsUMt0xTHdjC3r2vd4kJjs9wDR1IldkXSXLzTWIlxw5iYfWWwdJELv/9OhjW5v/2Mn2+L8bjqPQ4R2TGLv/cgfTC+ei0Rx8o+xHsXyBKC6TldCQq8TBPbziCzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9NE+K/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CCC6C32781;
	Fri,  5 Jul 2024 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720178458;
	bh=DY7umAaPi6InwzE4ppZxfzvkdB/ljYV1/u71C9g/GL0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Z9NE+K/ouHMjYNKq2JrzU1UBdTjjGmg5TIi1Wp9S7wIHm4ZhMZz8n1dU73iXurKc+
	 8PvkY7jNYkY66YykzpVew2MNAGvLCi2GB3YeN39X9qz4hBW6TKU7LVL7oIGvL/MGmD
	 yIe1F98y2+Zo/GrlUT2X5oH9B0U/9v0UlMJdX7DcMB1lfQVpChZGNb3LUjnKeydgR8
	 VB9dMvf/ua9lB7Uu8FI9O2SDM3M2EloiYTYckuRq8hD1w822wNMq1FWHNX2PTcP+KK
	 gu/0X4evFxCaa5ryGMyK8c5BYJ2gJN9jniuhFAsgfCH/1FOS1xcuLVn+BJx+heO4Mj
	 EYv2EGx4IH5Nw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C926C3DA40;
	Fri,  5 Jul 2024 11:20:58 +0000 (UTC)
From: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Date: Fri, 05 Jul 2024 19:20:44 +0800
Subject: [PATCH 1/4] dt-bindings: net: bluetooth: Add support for Amlogic
 Bluetooth
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-btaml-v1-1-7f1538f98cef@amlogic.com>
References: <20240705-btaml-v1-0-7f1538f98cef@amlogic.com>
In-Reply-To: <20240705-btaml-v1-0-7f1538f98cef@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720178456; l=2284;
 i=yang.li@amlogic.com; s=20240418; h=from:subject:message-id;
 bh=9LhSM/sGy9FBnVW5ZXfyCBNi8BxU5wP7j6d7UIGPrbU=;
 b=GywkG4KO65SkzM2yOtSrlbEfdOHCEaL8uN4ft+XKfEfaqBrtv7MlRds1SSK8iS0plPFRm0/TK
 9FoUz5U23tsCTk+SjEZeuPFRypBj+wCo7PsEWBKycLv4GR7ndSZ8fHy
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
index 000000000000..d59e3206af62
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
+  amlogic,wcn-pwrseq:
+    default: 0
+    description: specify the power sequence used to power on Bluetooth
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  amlogic,firmware:
+    description: specify the path of firmware bin to load
+    $ref: /schemas/types.yaml#/definitions/string-array
+
+  amlogic,antenna-number:
+    default: 1
+    description: number of antenna
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  amlogic,a2dp-sink-enable:
+    default: 0
+    description: enable sink mode with controller
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - amlogic,wcn-pwrseq
+  - amlogic,firmware
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    serial {
+        bluetooth {
+            compatible = "amlogic,w155s2-bt";
+            amlogic,wcn-pwrseq = <1>;
+            amlogic,firmware = "amlogic/aml_w155s2_bt_uart.bin";
+        };
+    };

-- 
2.42.0



