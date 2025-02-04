Return-Path: <netdev+bounces-162523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5860DA272E2
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29B4161B95
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1407B2163BE;
	Tue,  4 Feb 2025 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVC7EYy4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B12163AA;
	Tue,  4 Feb 2025 13:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738674569; cv=none; b=aiUUEkcr5HnQlx2VoQb/a/Oi40iOTwydR95Glk51O43GUweDvOWcPV8Ue8mJkEDuSu81m8WVIibFwLW811yCQ5U27adlZUrkUxWr1iUN2gsyhm38BLCHDxMDphtDrjazeyWp4UXjnvSdEanaPK8Z66aT7op6HE2KqoCuLc7VCJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738674569; c=relaxed/simple;
	bh=uNGakl59qJpoPer7rH8CqPwfhuVgpinVfY0HFvwe0dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gEn4LX6nNy3m8seblihXvtxPmAMmmVy3XDOwnFUofxtCDrs8vbJKT7SVUZ54TyVEp4v0CvDwU7LbBZXBfiRmNkJLI0cuwsc23RUt/7yI9KY9tvJ51kd/MZ6/77QDlgJmqI3tBg+r1hyX2/LTmunldIWY/veuXOXURQvi0lsgg0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVC7EYy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FC0DC4CEE6;
	Tue,  4 Feb 2025 13:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738674569;
	bh=uNGakl59qJpoPer7rH8CqPwfhuVgpinVfY0HFvwe0dk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XVC7EYy49neYunu7sbQ4zB5TdEZQ+HBTNts0j5hXNPFPMnPKv1bUHUWyEI2AimGH4
	 Ka342MftR1K0kjMgYyVQx5zv9LkuWKHiY39+ioOeBOr3mU2XQOyN8dual1upMCOzrl
	 0MFJdgZV1IgzP9bN/hz4r0dv/a2+n9LMwxrZmHIWAR6IBA+gs3S79YFt4qvMva4Jsk
	 paJFuEt+HwOmHaDOzOZPGVYj1BQni9ONZX4dOrbH8+Cxo9fNL3c6WPuIv91WzAH9R0
	 96krnDOUchRkSDu5Wj8ykhgKFbHo4d407q3Q1yMZDwO5/HorLaX9tAnkS0RFS4/H5u
	 KOwcnMjEi78TA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F54C02196;
	Tue,  4 Feb 2025 13:09:29 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Tue, 04 Feb 2025 14:09:15 +0100
Subject: [PATCH net-next v3 1/3] dt-bindings: net: ethernet-phy: add
 property tx-amplitude-100base-tx-percent
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-dp83822-tx-swing-v3-1-9798e96500d9@liebherr.com>
References: <20250204-dp83822-tx-swing-v3-0-9798e96500d9@liebherr.com>
In-Reply-To: <20250204-dp83822-tx-swing-v3-0-9798e96500d9@liebherr.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738674559; l=1249;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=s00iyFuKz8UzLLfIh0z0U6zzS8bBlyQj8K8lOchvczI=;
 b=UlxNzjCWowzu+lbfqGh7k4BTqsZ0KaVPCMf5LoIs6ovZ81mTRfPefhNoD4liDZrAOQVyHB63/
 VIg9i06lHRiCfcZ0D4tKDx6nyrr4Kc5hoI1pCTRa9MZ7+diTTFv8T0E
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Add property tx-amplitude-100base-tx-percent in the device tree bindings
for configuring the tx amplitude of 100BASE-TX PHYs. Modifying it can be
necessary to compensate losses on the PCB and connector, so the voltages
measured on the RJ45 pins are conforming.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 2c71454ae8e362e7032e44712949e12da6826070..04f42961035f273990fdf4368ad1352397fc3774 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -232,6 +232,13 @@ properties:
       PHY's that have configurable TX internal delays. If this property is
       present then the PHY applies the TX delay.
 
+  tx-amplitude-100base-tx-percent:
+    description: |
+      Transmit amplitude gain applied for 100BASE-TX. When omitted, the PHYs
+      default will be left as is.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 100
+
   leds:
     type: object
 

-- 
2.39.5



