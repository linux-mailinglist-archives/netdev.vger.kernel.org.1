Return-Path: <netdev+bounces-249364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E33D173FB
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 09:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E61C3016798
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 08:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE9A378D98;
	Tue, 13 Jan 2026 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMiyeAvu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E178335C1BA;
	Tue, 13 Jan 2026 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292453; cv=none; b=SXaA8gYZL5OpD6TgVrfBD+CmkmoBDoibtJ3n7JxWtCSomEd9elrk+kVTN6ySTVimbg2kz/FfRWiKotTgkf5rrE4LiNdFa+BcAXwhnnW7Xc7SX7DE38YwDZiCFeNqaWim8qv6ptXS+msepUH3GsAXcg/ofOmvTaK4C1LDc9soUm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292453; c=relaxed/simple;
	bh=NkL8q4Yk+gfVa/p6lSMEFG57URm0Jf2mxlxlnYGDoi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aufOHUxkD+0ylFQukKnZFoxQabVXnRszrONvuTNqqkEe4P6jEqhHTNkDsAU3I1+y4DTrKhWkqbkF7i6pWa5x3Xw5nPEZXYUHRhDMV4s8H1Ms5dSYyQ76mMw4rdUvrTQ5etpYW14cvxM2PmtJhDzuRzDGOqoDI1Y07uxUOc6JtpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMiyeAvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714DFC116C6;
	Tue, 13 Jan 2026 08:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768292452;
	bh=NkL8q4Yk+gfVa/p6lSMEFG57URm0Jf2mxlxlnYGDoi8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QMiyeAvuRCNNpFhlaxt0Hxu4VcXt49tYwTD/JaULda3VZxT33/RTrdOmVcDR9v2iu
	 1P4kNYDOcz0X1Mih+2xfFmP5EgbotXMIWAthZ/Fd2IvUYj95aAHpd1vg56AF13dWiN
	 /wbd546sk2JYee1tYkJpL2X9LYdFQs4bb0x72J4EawIXhxWW1O0SEYkT/gS4DD0U0L
	 8tEPh+cGUUT9uzeL8RnbxiEgDan7+mg/f8KA7dYYXJdQwEJJF5mi5QyePXsyEHzioC
	 twAulFRnoj6Pp7HLVj7Pw9vYYTXzcHvX/Pbow2JHuUFmOJpd+4IbW2RwYErr7rwzYK
	 mFKEfKYwrBC3A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 13 Jan 2026 09:20:27 +0100
Subject: [PATCH net-next v2 1/2] dt-bindings: net: airoha: npu: Add
 EN7581-7996 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-airoha-npu-firmware-name-v2-1-28cb3d230206@kernel.org>
References: <20260113-airoha-npu-firmware-name-v2-0-28cb3d230206@kernel.org>
In-Reply-To: <20260113-airoha-npu-firmware-name-v2-0-28cb3d230206@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Introduce en7581-npu-7996 compatible string in order to enable MT76 NPU
offloading for MT7996 (Eagle) chipset since it requires different
binaries with respect to the ones used for MT7992 on the EN7581 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
index 59c57f58116b568092446e6cfb7b6bd3f4f47b82..96b2525527c14f60754885c1362b9603349a6353 100644
--- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     enum:
       - airoha,en7581-npu
+      - airoha,en7581-npu-7996
       - airoha,an7583-npu
 
   reg:

-- 
2.52.0


