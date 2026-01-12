Return-Path: <netdev+bounces-248946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBF0D11B02
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 11:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF3A6306526E
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 10:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3478F2868B4;
	Mon, 12 Jan 2026 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dclXk0is"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113C4275B1A;
	Mon, 12 Jan 2026 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212031; cv=none; b=HF3mfJmQzka0BxXykD3mtaKYymJe5ELjVpEa0MQd8tlObFszsevVVMsromIZo201AngiFJDf1xn3tlEh+CUbxVYp9D1TOf0cSHQy8avmNR63QcnwkXkIcTnhMh/RUlIvZEfB6I9BsbRqolByGxM7YxAXb3hzJBi8KxxYn6Sv/t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212031; c=relaxed/simple;
	bh=latuIr4yu3n1Qb62/xle1lx8+WDbz53Oapq3nBYcRTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MwKurzJH5HWgxr6nRPeUndb7sNbb8U/nhSJwDEShNW9QZiJbddLa4POL1aNHKgSlFHsYei4E/HgqFQNNIXGf4zrBtJ/XFT20av+eNu1q6hb8rJmn+IvevcTVMeYAwm5sgUm5CEGKuDI/meTqoNW/FOvG2tKlvplc7G9ZwXNVyqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dclXk0is; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33847C19422;
	Mon, 12 Jan 2026 10:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768212030;
	bh=latuIr4yu3n1Qb62/xle1lx8+WDbz53Oapq3nBYcRTs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dclXk0isN4CjPhqrg9d2Cq2uRJLgYhlPKyIQOE0FO6PmY9qtdsoeK+gGfJ4F+WOxd
	 o11QdEReWFu91T1AbfhHpD5hc+Y1Z9CQAhD6JvgVUQL56Fo8D1tl2GWKGjzq7BgigW
	 IBokpxynYfZbD/W2U7BW2ux4+k4gLbuUcKz6cpUKOjwqMNLtnqMM1GEdmeIL4mUaZ1
	 fnH9bewzZqGK+Z6P7P36KI2ne6VNjV2UUK4yr1kQsALxVhAK1XTGkC/crpY0juQcgh
	 n3TRQeticRQ6PeNGIugnOVi7PVVVBPwTAnmV+XzA0FdIS9Uqk4nS+/YXZTELzgICNr
	 2fUWAIsXjabow==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 12 Jan 2026 11:00:07 +0100
Subject: [PATCH net-next 1/2] dt-bindings: net: airoha: npu: Add
 firmware-name property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-airoha-npu-firmware-name-v1-1-d0b148b6710f@kernel.org>
References: <20260112-airoha-npu-firmware-name-v1-0-d0b148b6710f@kernel.org>
In-Reply-To: <20260112-airoha-npu-firmware-name-v1-0-d0b148b6710f@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Add firmware-name property in order to introduce the capability to
specify the firmware names used for RiscV core/Data section binaries.
This is a preliminary patch to enable NPU offloading for MT7996 (Eagle)
chipset since it requires a different binary with respect to the one
used for MT7992 on EN7581 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
index 59c57f58116b568092446e6cfb7b6bd3f4f47b82..e008cf92e0975b43b433030908c35340361bc71c 100644
--- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
@@ -58,6 +58,11 @@ properties:
       - const: tx-pkt
       - const: tx-bufid
 
+  firmware-name:
+    items:
+      - description: Firmware name of RiscV core
+      - description: Firmware name of Data section
+
 required:
   - compatible
   - reg
@@ -95,5 +100,7 @@ examples:
         memory-region = <&npu_firmware>, <&npu_pkt>, <&npu_txpkt>,
                         <&npu_txbufid>;
         memory-region-names = "firmware", "pkt", "tx-pkt", "tx-bufid";
+        firmware-name = "airoha/en7581_npu_rv32.bin",
+                        "airoha/en7581_npu_data.bin";
       };
     };

-- 
2.52.0


