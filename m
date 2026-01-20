Return-Path: <netdev+bounces-251438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 290CAD3C576
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25BE05A23E8
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340123E9F6D;
	Tue, 20 Jan 2026 10:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/Y98pDh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8ED3C1985;
	Tue, 20 Jan 2026 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904273; cv=none; b=aGRDz1LTrUzlZ3eR64lm2c2N8T+i85jrd59ipOs9dACA/62yqv6Pbr3pXCbzv4Cw8Z9xJeSd8wejQnDP3NuH8333QtBi/zXAxWVIxqhKzClVIppHzcUfCImsA1sg2RnSdJvRD7+CDB5is9h/ViIygFNY7fyz1b8v0O4m/N3jxpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904273; c=relaxed/simple;
	bh=EMBL9zhbP2np+rXwfdAlIRd+meq4aIVMy3iGLvieQwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=apjDXZToXP65NpoKX2q4qCh+Rk4Q8JHownzTx5VX+h1Qm1GNOBJYJXzp5oFasILIM3pUfgW09cg1+x32J6fBs7QMdjSb33Yyaop8FlXsPEqClUbRCLGdfa/Xve7MBqEJ3J8k9yGxCTu7Fg25Orb3S63htedlJ53E0jvtIlIiMrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/Y98pDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A11C16AAE;
	Tue, 20 Jan 2026 10:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768904272;
	bh=EMBL9zhbP2np+rXwfdAlIRd+meq4aIVMy3iGLvieQwU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W/Y98pDhna0GDpK8N81FlPJoG0hk2lUQUtkaa/b0OV5QFoMB/T6Xd2a/+pGk8/T0D
	 jy2wJI/SCwbiqy7fi1ca21h1HQwWAi/s9C3rXQdjwJyH/Eji02ShKlKEYGgzCNoRLB
	 x6dHQVylROWRQm1+WT/OekQBgR8m00EAamiwXaQktSXDsv5yYd0WXfKKZigEojbNSa
	 RA23e/FoHTg3lDwEHmrnt9JPa65YYP+46dGyEFL2P+hrl4KDebUTxW95L8pxtKI+c/
	 F32M2vpkgtStHSdVVZEMsTZnwqtT68goupK5Cmig+uM1BGIZNUn5VRVSkJ4OUJPfYJ
	 /ivT3rkxELtpA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 20 Jan 2026 11:17:17 +0100
Subject: [PATCH net-next v4 1/2] dt-bindings: net: airoha: npu: Add
 firmware-name property
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-airoha-npu-firmware-name-v4-1-88999628b4c1@kernel.org>
References: <20260120-airoha-npu-firmware-name-v4-0-88999628b4c1@kernel.org>
In-Reply-To: <20260120-airoha-npu-firmware-name-v4-0-88999628b4c1@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Andrew Lunn <andrew@lunn.ch>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2

Add firmware-name property in order to introduce the capability to
specify the firmware names used for 'RiscV core' and 'Data section'
binaries. This patch is needed because NPU firmware binaries are board
specific since they depend on the MediaTek WiFi chip used on the board
(e.g. MT7996 or MT7992) and the WiFi chip version info is not available
in the NPU driver. This is a preliminary patch to enable MT76 NPU
offloading if the Airoha SoC is equipped with MT7996 (Eagle) WiFi chipset.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
index 19860b41286fd42f2a5ed15d5dc75ee0eb00a639..aefa19c5b42468dad841892fa5b75a47552762a0 100644
--- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
@@ -59,6 +59,11 @@ properties:
       - const: ba
     minItems: 1
 
+  firmware-name:
+    items:
+      - description: Firmware name of RiscV core
+      - description: Firmware name of Data section
+
 required:
   - compatible
   - reg
@@ -96,5 +101,7 @@ examples:
         memory-region = <&npu_firmware>, <&npu_pkt>, <&npu_txpkt>,
                         <&npu_txbufid>, <&npu_ba>;
         memory-region-names = "firmware", "pkt", "tx-pkt", "tx-bufid", "ba";
+        firmware-name = "airoha/en7581_npu_rv32.bin",
+                        "airoha/en7581_npu_data.bin";
       };
     };

-- 
2.52.0


