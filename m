Return-Path: <netdev+bounces-226725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B91A5BA4761
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C944A3392
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20139221DAD;
	Fri, 26 Sep 2025 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+gU9jHQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB34D10FD;
	Fri, 26 Sep 2025 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901417; cv=none; b=ARikv/F0MZ1T/cuzsIo42twgWZp0Mb91K9fzuXbvLZYvV6bHn8cWHLuG16NltEoKLIAu9+P3KETApUTJ3/asiFdhDINSE8sokw80HsMoENvHUOeWVTt7dsJLqQKy75v9hSKOkLjQde8+6cOQPv0NcBYHPmyF3KvQxq+mgRbfGCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901417; c=relaxed/simple;
	bh=EYs89Jn2WO18lvHPSIvjiHZSODy76dkZb7stpKU2PPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G4nXIlUaNVViV+ybbydV6YeNEJAa76uSdbOHdmyMxDhlkjXjnhjVNNI+aP3LpJutklWGoTC8d8o7HK58T38tBRJfjSW3i9XyMaF6kH+d/e3G4el4rym6Zl0hX52TlTNWe24xeslM9BGeKhPw0w1nl8asgqGcaTYNmoQ5PVrU32o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+gU9jHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BA6C4CEF4;
	Fri, 26 Sep 2025 15:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758901416;
	bh=EYs89Jn2WO18lvHPSIvjiHZSODy76dkZb7stpKU2PPA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q+gU9jHQA5/VjYvnTxBJ+2iIklT7sczY0csmgFIMF+W+uKVic2i27JNzxulrrfN+U
	 YqnWWBzWs6h0fy2CI42NoqYnU0ng7rUZABJfEm5Vlx2TfD41fSbXt5HszpnFU5a5UZ
	 auN2092VTMCB9HTxjRtqRC832c0dgNoHhbfsBFMHjziuAVYlF7R2DjQrEJsnGOm7hK
	 RUwuVVABDqiYyKKCT9X/I4BJNOdwpvCe7oLWPE1esVe5qz+H0fOumteDjBYAwQuP+9
	 QYufhAoebKm8/NsCZI1qdhEkBUw440mTJeroblpXRFS9yWnW0axjnwJSaBWUi7L1bH
	 7RCAjXu7fkESQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 26 Sep 2025 17:43:22 +0200
Subject: [PATCH net-next 1/2] dt-bindings: net: airoha: npu: Add AN7583
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-airoha-npu-7583-v1-1-447e5e2df08d@kernel.org>
References: <20250926-airoha-npu-7583-v1-0-447e5e2df08d@kernel.org>
In-Reply-To: <20250926-airoha-npu-7583-v1-0-447e5e2df08d@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce AN7583 NPU support to Airoha EN7581 NPU device-tree bindings.

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


