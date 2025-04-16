Return-Path: <netdev+bounces-183415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0134A909BA
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED4797AD0EA
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E46A217723;
	Wed, 16 Apr 2025 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvWSCU7/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D020216E26;
	Wed, 16 Apr 2025 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744823700; cv=none; b=NNuC6JzsBfeTc8eqIgMT6fzu/tFFIK4wqLSqGDn0f42n99w6KTe6Qj2CciPTPhIfQjub6ZYO5w3vHsfix1uYSijICNYWAtvxZx62r/1zar2oxKW/Tp90SlJd+WD5rdirbIclbJq+hLb3qpP+MW5wlTo8lLulbY6i2Rhs5KeSr3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744823700; c=relaxed/simple;
	bh=M4tjwq1WsXbtdjPU1kDrBGTCE1LBsVcwlCPfPSkrIG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o2fGkjfc84wnxHCf7xac2Jncyex09sd3RQCoj9Zxi7ehzFJ+KLQiyZUJ2AmKHh73CrNeQXAsZLXUDWo6UqUcZj4dsNP/cEmSsuzs3hb13+y+AwIB34wQosJep4UngXtYBF7PdIKK5BNf8dE+rzoGrkKIGhon6ypk0Urba+nnRjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvWSCU7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8456CC4CEF4;
	Wed, 16 Apr 2025 17:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744823699;
	bh=M4tjwq1WsXbtdjPU1kDrBGTCE1LBsVcwlCPfPSkrIG4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JvWSCU7/s1OPOp29nUowgvgUdJgNC5pmgPl6A4KZj6furTOGEqHit8AHjQEBIcEBA
	 AzDxa42cubsqzt1+6bn4nufzc2G9AGVIU4J2HcdDuXjFDDqZdCWzbjk+Q5gs7g/bmn
	 XxPOnMbKjCcaZNOSOHHe3RP2EZ57tLiMOiVfjCK5WoXOfFiqQNJvfWKs34cmSlz1Tc
	 xhdy4q6fxttBxecvOn+DxKAUUEKpUzsaH68Kwd8JXTQK7kCLA/GYnBJjgy/Buz5iYE
	 4haeByfTANHvwW+VujdZJ+zBH2YvDV9ouA20iM9rQPKWxt2+PxraW0mzIBNBUqwJfN
	 U38pNV28fZS8A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D9DC369C4;
	Wed, 16 Apr 2025 17:14:59 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Wed, 16 Apr 2025 19:14:47 +0200
Subject: [PATCH net-next v3 1/4] dt-bindings: net: ethernet-phy: add
 property mac-termination-ohms
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-dp83822-mac-impedance-v3-1-028ac426cddb@liebherr.com>
References: <20250416-dp83822-mac-impedance-v3-0-028ac426cddb@liebherr.com>
In-Reply-To: <20250416-dp83822-mac-impedance-v3-0-028ac426cddb@liebherr.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Andrew Davis <afd@ti.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744823698; l=1479;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=W06lAoB8Jv78d0khXNAifsDKyfyzdH2gHN2GrvRj/lg=;
 b=8/NvEZKKh+Qh07muudfgPl+CobttKPe/dIYCo/6qpaXAyDrTUDrT0vQBuyl8cLqncY4NzjazH
 327bpfB7LnvBVI1pXYlyN/MW9h6jVytm4HsT8vkOPaOr+c2HBdBly+d
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
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 824bbe4333b7ed95cc39737d3c334a20aa890f01..71e2cd32580f2e9e1af88e6f74517ccb92d1c20f 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -238,6 +238,16 @@ properties:
       peak-to-peak specified in ANSI X3.263. When omitted, the PHYs default
       will be left as is.
 
+  mac-termination-ohms:
+    maximum: 200
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



