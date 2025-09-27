Return-Path: <netdev+bounces-226898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372B8BA6046
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 16:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C27787A6B49
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 14:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B952E2644;
	Sat, 27 Sep 2025 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyWQz9MD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB152512FF;
	Sat, 27 Sep 2025 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758981847; cv=none; b=MCnVyLy8cNAqKy+h8odujBz1Ookw10PncNnDoHvtKgB0h4aREQKPLzGoclT99tMXJkKgJ/yittH0CaWCKTSBQeKJgzeoVW0hYUm7z2ONggOmoVviTLMQTwfEJ382UHEtvBLg1PYOHJYeq4amDefNMh7PvWEOTXSvLFWBVa9iWsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758981847; c=relaxed/simple;
	bh=EYs89Jn2WO18lvHPSIvjiHZSODy76dkZb7stpKU2PPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OZAm49minu1jxWRIYJJ1C0poZmkUyJbaME4HLbC8KIMweF22YHbZtPkizjVj6FzjZ+nqo6melP7nWqeCbFe4MKgFrz3halwsq3J4pJLTfeJ/cBsk5bDajRLIwyZWGyY0wG9NvLJNOX7FH5SLj+b5Wqaluw13qdO4/EFLxpi1LpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyWQz9MD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2BDC4CEE7;
	Sat, 27 Sep 2025 14:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758981847;
	bh=EYs89Jn2WO18lvHPSIvjiHZSODy76dkZb7stpKU2PPA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kyWQz9MDPeW4oJ+FpK16EgdYGzGud9+/rOgx6+zE8C6NshKuttiHoOQuu+Ia7Gx1y
	 KJovtAAJQmfLHhQasJMckkhgr7aaFQWahgUXq1aFVM66ZLVuS5XJ0GX65bW88tHRfP
	 G0q2v8oHVWgFAJA7eb/muxT1budaWIf8aYCdxNIxzWaOWKAwwj+7ceXXDCTo4+mpB3
	 936EBaUUrZ7R77gAlKg0j5d1iu562o7PSWfRK8yseosvDklXMxJodpuY9orNbZqQdi
	 PoPiaiScbTrIKFJ6WMo5J0IlWJJtaZ5x7CemH4QqaxIt7RH03YQA0dkxlUsxwXaS8r
	 rdMZQtqydosCA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 27 Sep 2025 16:03:40 +0200
Subject: [PATCH net-next v2 1/3] dt-bindings: net: airoha: npu: Add AN7583
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-airoha-npu-7583-v2-1-e12fac5cce1f@kernel.org>
References: <20250927-airoha-npu-7583-v2-0-e12fac5cce1f@kernel.org>
In-Reply-To: <20250927-airoha-npu-7583-v2-0-e12fac5cce1f@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
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


