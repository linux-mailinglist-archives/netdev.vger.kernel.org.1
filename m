Return-Path: <netdev+bounces-204344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE877AFA1F1
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 23:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FD301BC4B71
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 21:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C988723C515;
	Sat,  5 Jul 2025 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXc2UQ3w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17EF136349;
	Sat,  5 Jul 2025 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751749807; cv=none; b=jOIOdlActOFzIol+eSFd+rHBKpvHnCsmR2YkfloUmyN4/ztHZ4DKRV6EglSxKvAU9EG3FtCjQq5mzrCGwbJEn3PHG+njR6VCR1V3IJz/Uo5RsHwVDLR6o893LsYYCsixigNoH4qMtJPG9DtLhmtKqAWNlxiuXHxDjn7TQUAspok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751749807; c=relaxed/simple;
	bh=YNrA+5MDqsLBZeG4SVefmSXufeWSQS+ZGzYEQ0yDjm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ItAE6cs+GbdaFv3a0VhK4WxYX16i9OcKM5X6QYY7oa9HLcYWBhE2UwWZhtAUxMWLG9FBB562EEqVp+iz+Nz/AVp84rEE+fU4dIVMK4LR6Z3y/dbMDBLVJb7py8FcfnNvYygkPlf6uPkSy5fk4G7u2XiQnW64SUwEkCav0LZXjKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXc2UQ3w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87EFC4CEE7;
	Sat,  5 Jul 2025 21:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751749807;
	bh=YNrA+5MDqsLBZeG4SVefmSXufeWSQS+ZGzYEQ0yDjm8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kXc2UQ3wlyUfLvJ1Gx05eau5xlxa+DYqTEUHEmjSR142/kYIQAzaZkggW8W/2QGE8
	 XcCI8nvPFZhV1/W4s1aPOaAkoee0TfwxPW1K22NKRxkLcR6Y2/h9kgubL96V+OukLj
	 2ojU0W+AW5A+gBY8nkWtxCmOZN0t+ED6B/sfi1NSDVi5SZU9AcFMN/YerrKJzKQ+m4
	 TbooZAJ/12X7KIud8hLMVlkXN8F6JTIT51S94VHM/aVQ2+hWk+u+4h325Qm3ZkYoTc
	 25QBjEzAyM7sqAgKr8mmsB8UZryPpvwajWUbHOJUIdUK9DMnARGK9dPR+JcwQ2iJZK
	 at6/9KAvH0OMA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 05 Jul 2025 23:09:45 +0200
Subject: [PATCH net-next v2 1/7] dt-bindings: net: airoha: npu: Add memory
 regions used for wlan offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250705-airoha-en7581-wlan-offlaod-v2-1-3cf32785e381@kernel.org>
References: <20250705-airoha-en7581-wlan-offlaod-v2-0-3cf32785e381@kernel.org>
In-Reply-To: <20250705-airoha-en7581-wlan-offlaod-v2-0-3cf32785e381@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Document memory regions used by Airoha EN7581 NPU for wlan traffic
offloading.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../devicetree/bindings/net/airoha,en7581-npu.yaml   | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
index 76dd97c3fb4004674dc30a54c039c1cc19afedb3..db9269d1801bafa9be3b6c199a9e30cd23f4aea9 100644
--- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
@@ -41,15 +41,25 @@ properties:
       - description: wlan irq line5
 
   memory-region:
-    maxItems: 1
-    description:
-      Memory used to store NPU firmware binary.
+    items:
+      - description: NPU firmware binary region
+      - description: NPU wlan offload RX buffers region
+      - description: NPU wlan offload TX buffers region
+      - description: NPU wlan offload TX packet identifiers region
+
+  memory-region-names:
+    items:
+      - const: binary
+      - const: pkt
+      - const: tx-pkt
+      - const: tx-bufid
 
 required:
   - compatible
   - reg
   - interrupts
   - memory-region
+  - memory-region-names
 
 additionalProperties: false
 
@@ -79,6 +89,8 @@ examples:
                      <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
-        memory-region = <&npu_binary>;
+        memory-region = <&npu_binary>, <&npu_pkt>, <&npu_txpkt>,
+                        <&npu_txbufid>;
+        memory-region-names = "binary", "pkt", "tx-pkt", "tx-bufid";
       };
     };

-- 
2.50.0


