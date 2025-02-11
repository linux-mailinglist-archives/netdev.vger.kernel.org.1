Return-Path: <netdev+bounces-165086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F0DA305D4
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 09:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D8EF7A2FF9
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 08:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1793D1F03CF;
	Tue, 11 Feb 2025 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1nzHf+9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE39F1F03C4;
	Tue, 11 Feb 2025 08:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739262836; cv=none; b=eauIfznRHemVLTsO4PTICN1yBk59KoTV+fT5DPpqLUnV9HljxuVRiz8oC28fXrYf+21ryPo5x9/C0e0mDZZREsXVD3/XTnRRcTB9upbU/PWM3zZ2Xu5fP0+2FzawFMKOSo8lzdKQbgw4ixTGHPr5LmKNXTvZlRzI/9VVrx0DBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739262836; c=relaxed/simple;
	bh=Tgg4Lnwrg8jjds9vmzK1DKGROT5TwIeiOvy361I2DMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CMi6Nh/jVoDN3cN8JOn17dvkOnC5qhTID5j3TYbCA+ZLBaQtkpMJJ2hE2RiDfKQUekiGiCCj6uXELVlm0SNiCYD0YZkuBFHqb5ossl3aJF503TdCusGGs6h3UfWQULO2Ugd/bNhRtyV2HgjFmYnB197acJZ0RPLGbMNaWdaEE6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1nzHf+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6572CC4CEE6;
	Tue, 11 Feb 2025 08:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739262835;
	bh=Tgg4Lnwrg8jjds9vmzK1DKGROT5TwIeiOvy361I2DMo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X1nzHf+9wlPFe4GjrIcKvaJ8XEZ2IUSsnlLDLQ9nrWZlG6yETatZ9uQLLREVHhNwJ
	 Jx49e1qMu/AAiBxWtHwGRws2mSU3hierfqpTT6513QBp+CBZYnMfxV5Gak9gYHMi2M
	 2z5ryeSwH6bpdvp6GsRQ3MaQyIOJAXFF/xkuT34RWF3L6GjIPxOQVWre64B8xVx4kT
	 TWhDPW3C3cm6+FzoKo/cuu7jQ1Ee+jh1RXIqGvUtuGsudf8bCcmjbG+h/RIMurt1wF
	 OOhMB3F+OiO2vbOfw28XiwQkPTQ9YV1gREqEbzmAMGzUWGcnXCL6F2HN0oM5bC+nHb
	 nZjHMsSVulSLw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E31DC0219D;
	Tue, 11 Feb 2025 08:33:55 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Tue, 11 Feb 2025 09:33:47 +0100
Subject: [PATCH net-next v4 1/3] dt-bindings: net: ethernet-phy: add
 property tx-amplitude-100base-tx-percent
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-dp83822-tx-swing-v4-1-1e8ebd71ad54@liebherr.com>
References: <20250211-dp83822-tx-swing-v4-0-1e8ebd71ad54@liebherr.com>
In-Reply-To: <20250211-dp83822-tx-swing-v4-0-1e8ebd71ad54@liebherr.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739262831; l=1194;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=ro3XaEK9ivn2YdVF9jgpWJDrlBMtuG5ywyyC+eUKCKc=;
 b=etb1fP538cRpuDsLZ2zaY0RXA3Z6765GKmhV970cPgR9jTLDR+O1GUqJwoSz32b/p2cMSzwg4
 55SnxKgerOXDHsVtFrdaMsfVY5pavMYMwLj+zoZXmdd/y1XVZH+JFvV
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
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 2c71454ae8e362e7032e44712949e12da6826070..e0c001f1690c1eb9b0386438f2d5558fd8c94eca 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -232,6 +232,12 @@ properties:
       PHY's that have configurable TX internal delays. If this property is
       present then the PHY applies the TX delay.
 
+  tx-amplitude-100base-tx-percent:
+    description:
+      Transmit amplitude gain applied for 100BASE-TX. When omitted, the PHYs
+      default will be left as is.
+    default: 100
+
   leds:
     type: object
 

-- 
2.39.5



