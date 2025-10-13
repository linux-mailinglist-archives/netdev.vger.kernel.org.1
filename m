Return-Path: <netdev+bounces-228727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACDBBD3502
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E930A34C880
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 13:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542EB2367DF;
	Mon, 13 Oct 2025 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qko9u2Z4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD011E8332;
	Mon, 13 Oct 2025 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760363953; cv=none; b=NuMpdemUMxrhXBZXymFVUPQjSE/XyjtEq2AEEPnp4b5B5hd1Z2Ts8c/CZHsMTJE8GIOtbZC6tGGfIF5xDxuReNhpXJ6eWp5uDlZANbT8y+rAeDmL4RqjxHorWqaNy+BgQRcLP246W15uU2NDICnrcVL00TnnIaXwNrP8gWzr/rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760363953; c=relaxed/simple;
	bh=DVCS3bylNjH7EkRFP6KdwLJ/KwU51zQBlBSdigt0eO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jxZgG6n2YjS2Q40ZXmsNqY9ecc0N1ehDjyS1Xwqd8WQEvYIA/MfEjhsAQb7i2EscR3RZBb7xo9ERV814ose7h4P18sxDaciAF49XXITs5z5F+4a8cmbYBC6sBHI1ckPnehgmKJEyKNmkKocf7MBzI6jJ6z3zTG6w/EOqunauuIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qko9u2Z4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9248AC4CEFE;
	Mon, 13 Oct 2025 13:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760363952;
	bh=DVCS3bylNjH7EkRFP6KdwLJ/KwU51zQBlBSdigt0eO0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qko9u2Z4Kc24Ezl6U28K8Gei03GKiBL3fEfiaZp579AtXBx0yoFMgpuhLSGgYOBNc
	 5PGMhRDMq0DzeoFMHsFGpWmT2tD8QnD9ZTJ8kEVMxW8ZOnsZf8qLD8yr/Cn5LA9BOA
	 3klP5+HTr1XTJdTUzs8jMfp/u8bhwNpUVIPvLfhTmtAPcdzwWF6YYK3P+OCGz7IM9i
	 p1TKmztYoHnXaxoL0DJyUVaYTy+UXgvhtYd7cPKy4E+T7K8tGz/yxb4CfmQMgntswC
	 1UYHj+NHb9+So4Uhdwp0VkuEjoLOhPLudRfgKx8kyxvuKfR28YmyPdBBFet9LJgZG9
	 KiQcEdaiUVDyA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 13 Oct 2025 15:58:49 +0200
Subject: [PATCH net-next v3 1/3] dt-bindings: net: airoha: npu: Add AN7583
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-airoha-npu-7583-v3-1-00f748b5a0c7@kernel.org>
References: <20251013-airoha-npu-7583-v3-0-00f748b5a0c7@kernel.org>
In-Reply-To: <20251013-airoha-npu-7583-v3-0-00f748b5a0c7@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Introduce AN7583 NPU support to Airoha EN7581 NPU device-tree bindings.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
index c7644e6586d329d8ec2f0a0d8d8e4f4490429dcc..59c57f58116b568092446e6cfb7b6bd3f4f47b82 100644
--- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
+++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     enum:
       - airoha,en7581-npu
+      - airoha,an7583-npu
 
   reg:
     maxItems: 1

-- 
2.51.0


