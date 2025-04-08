Return-Path: <netdev+bounces-180069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19378A7F70E
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 653FD7ABF13
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 07:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B439C2638BD;
	Tue,  8 Apr 2025 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geDFnaJ/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A5621ADCB;
	Tue,  8 Apr 2025 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744098340; cv=none; b=hcEV0Md7RGlar3SWSuSkrWi6Gjfr4JOu7icR9TfYu6HWgDRJSQs5y2lYoquHY0CEqSDajjdNG4d0HDcq+GcmTXFy8PBBQbrEN9FfMjWdXp/KxxjyxJaWfqts1h237gV+9LeZZu53gtxocv/5Mj5v8kIDnxGDN1ERinjv3p2sLJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744098340; c=relaxed/simple;
	bh=VWK3OtpuOBXytlc9D3rZd6q4OCon/h/rP9qMtiluY+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h1BEmMtgNp0GhxZxbclc0jXVcAQcZ5TWLSNtdYmbM/rhoip3xr6oAuntlxFlCIkmcwrWBfnHuKXf6vudmarGWBXld/jfLCzhoRZrzWDKol6T9gGyfsDlrJR5zo89Tr5WyBgMmUSlaML7Sh5dTCupqY8NWKnZX850IO5msDkwNVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geDFnaJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0F41C4CEE9;
	Tue,  8 Apr 2025 07:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744098340;
	bh=VWK3OtpuOBXytlc9D3rZd6q4OCon/h/rP9qMtiluY+8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=geDFnaJ/TllxOlvgHN02nQjp9u3c8TL9A4zdY/42INnPToVoasfLiHf2AioEy8ABU
	 KifjKNkCw9Ey9PxrWT6IvOmoiAlm5WiF8tYpQMTJoI0PLz5ZOkwN18Sy0OVwnMpJ9z
	 q+PFkpryGxOUkyl+BAngm31UfSuYz02wZkFirDNby3OetzUR9O20RPFSXZ5fLIwP9A
	 ynvjhYVMt2KI+z2z4BJgsBgiNJCzFEi5O40xmNJkBOBB41MXkRUYa3mqmmPape5+DP
	 3wZfYwTD4v6i05XewmU3tqk2fWzsFemmN/G6Hm5Troa9Mvi6Qd/498p1wBEXa04Nen
	 VfxRDjHQyIPMQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD64EC369A4;
	Tue,  8 Apr 2025 07:45:39 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Tue, 08 Apr 2025 09:45:32 +0200
Subject: [PATCH net-next v2 1/3] dt-bindings: net: ethernet-phy: add
 property mac-termination-ohms
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-dp83822-mac-impedance-v2-1-fefeba4a9804@liebherr.com>
References: <20250408-dp83822-mac-impedance-v2-0-fefeba4a9804@liebherr.com>
In-Reply-To: <20250408-dp83822-mac-impedance-v2-0-fefeba4a9804@liebherr.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744098338; l=1457;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=iLKP9AOUR9dV2pk730lAoIgqXbD0/33T/ilFfmJ5gKQ=;
 b=mbgAal4G5f4ZS5fnZUibV4eV7BW0CnS4g0YubRiQPjrskwHuXLtTuSBu/FSSbwF66tDwtn7dc
 3gYGJcaQrAvDSue1haoYNILCmxJtIqxboyqSKbLZsnlQpEYREIQbCWU
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Add property mac-termination-ohms in the device tree bindings for selecting
the resistance value of the builtin series termination resistors of the
PHY. Changing the resistance to an appropriate value can reduce signal
reflections and therefore improve signal quality.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 824bbe4333b7ed95cc39737d3c334a20aa890f01..93574c2726e5b2bc81a2dfb2462eb73c7cbfe6a8 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -238,6 +238,15 @@ properties:
       peak-to-peak specified in ANSI X3.263. When omitted, the PHYs default
       will be left as is.
 
+  mac-termination-ohms:
+    description:
+      The xMII signals need series termination on the driver side to match both
+      the output driver impedance and the line characteristic impedance, to
+      prevent reflections and EMI problems. Select a resistance value which is
+      supported by the builtin resistors of the PHY, otherwise the resistors may
+      have to be placed on board. When omitted, the PHYs default will be left as
+      is.
+
   leds:
     type: object
 

-- 
2.39.5



