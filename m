Return-Path: <netdev+bounces-157585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300F8A0AEDB
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0B2166F3C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 05:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A1A231A31;
	Mon, 13 Jan 2025 05:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tILiT9c0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DCC230D3F;
	Mon, 13 Jan 2025 05:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736746829; cv=none; b=bDvvi6s+Q6g7nAXadWsRLJHusxk3WJHXiE8Dy3NEA/qwnEmmKhvNMDLyGRsGEGtU6sR4SyI4nnmf1ga6etkmqsGc+szt9uYVsi1ZZ8cl80LY6jRYC3mMgVqHUnA9pASYDYhbmmbWEfHJBsYjiW88M5lbBScFlxuwbKgQazvv8g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736746829; c=relaxed/simple;
	bh=CLZcbAU93N4TjwBLkwJQHBxUzOEuR3RPnGpnzoVIcHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ixwT749EQ8splyK6pFTBJrMeJ+3KwqvMAWNMu72Q9c317vCU33VH1/fSdNwkzUDGdfMKsyr0O6HUozDinqtyXZ9UPHE+yaiqYN0/T76Ba4nK2+HsLR9gKcq3jy/+UY6KNuOyQGpUC6LL9f68jTmR49L+rLkyY+H0X7OxfI/XuSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tILiT9c0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23334C4CEE4;
	Mon, 13 Jan 2025 05:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736746829;
	bh=CLZcbAU93N4TjwBLkwJQHBxUzOEuR3RPnGpnzoVIcHY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tILiT9c0H4j+v/35WcBfhwl+NQbGj9RRt6O5m54/FGWg8q9v0XW/82RqlRauxq6wf
	 4WeLG/17towTxiMj1W/B+RLIOH7xmNgVBV+OO0EibSBWXgiOp6a1eMlfp8WJDPaw3Q
	 VOVdadNqZmAn2kclpso9LbrP018hQxKvy+DoRTcpFywYCN/mdK4v5g2PWnAjlulGrr
	 qwQwD/vMr7cjyza4wtrbnYOs6TtyPSW9ozoa/bP3F8RggMBahicGS4eknI06CkFKau
	 euIMhuNUWKyD5xQARYbS9v+QPrPxm34py5VsIV61WXvD3gNGj+4muwyBR1hbUZyPM4
	 RQvEUuRx2rPMg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED88E7719F;
	Mon, 13 Jan 2025 05:40:29 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 13 Jan 2025 06:40:12 +0100
Subject: [PATCH net-next 1/2] dt-bindings: net: dp83822: Add support for
 changing the transmit amplitude voltage
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-dp83822-tx-swing-v1-1-7ed5a9d80010@liebherr.com>
References: <20250113-dp83822-tx-swing-v1-0-7ed5a9d80010@liebherr.com>
In-Reply-To: <20250113-dp83822-tx-swing-v1-0-7ed5a9d80010@liebherr.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736746828; l=1391;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=CZ9EoWKNP+/yooo8m8ATI3MQdPGKi2t5WYkqruGrKw0=;
 b=c5f72qmNQb5JqM9ZYOTk316s1HqpmHm+ubmPZGydKgvEGgl4AIPtz3jmnIMLY7MGYK1UrFPLT
 tVdcQmVAauuBrRyKanAb7ENtKR1ZRDK8TMXkuwHWRRGUTHt0omFYolp
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Add support for changing the transmit amplitude voltage in 100BASE-TX mode.
Add binding to support this feature.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 Documentation/devicetree/bindings/net/ti,dp83822.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83822.yaml b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
index 50c24248df266f1950371b950cd9c4d417835f97..b44f7068011b8e594f2ba245c526f4f48e3c5963 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83822.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83822.yaml
@@ -122,6 +122,16 @@ properties:
       - free-running
       - recovered
 
+  ti,tx-amplitude-100base-tx-millivolt:
+    description: |
+       DP83822 PHY only.
+       Transmit amplitude voltage for 100BASE-TX in millivolt. When omitted,
+       the PHY's default will be left as is.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1600, 1633, 1667, 1700, 1733, 1767, 1800, 1833,
+           1867, 1900, 1933, 1967, 2000, 2033, 2067, 2100]
+    default: 2000
+
 required:
   - reg
 
@@ -137,6 +147,7 @@ examples:
         rx-internal-delay-ps = <1>;
         tx-internal-delay-ps = <1>;
         ti,gpio2-clk-out = "xi";
+        ti,tx-amplitude-100base-tx-millivolt = <2100>;
       };
     };
 

-- 
2.39.5



