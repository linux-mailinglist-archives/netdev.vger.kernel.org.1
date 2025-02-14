Return-Path: <netdev+bounces-166439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1FDA35FFA
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 15:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C8F188DD50
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 14:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AFA266182;
	Fri, 14 Feb 2025 14:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l19t5JgT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA930265CB9;
	Fri, 14 Feb 2025 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739542466; cv=none; b=aV6pWrsPYHdsj/YXWcuG5yHzoPIG+EN027D4SHPr/iIOGKYNdAQEHyPQQSBUBChUbn+TJXyneqYk+0Brs6cTmw8+SiVR+spCO/kqjL2qZ6ve8ThnkfqRZf7ZOul36zyUoZAF8ZJSta0ghZ/imgXiA8yEe/bsqhexgs4wOwhQTNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739542466; c=relaxed/simple;
	bh=X0hXmpZOayOUfTOXaHNHsHvruiKJo+c4qZv/9LPz9tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DAzKqBgWzZ1etLFayPQKbCsLvKqdYrKna+lO96ZGKFt0We2leoqMAN4YvVjyD2WQH9AzGN7JtZ0HnC8fF9uO3zy8VxAxTq8jvN3FtBF37RhnZ3I/+GqfSVwlJ8scvCcm1O7L5FoqmJbzr1/r9Nzqr2thAbD3Vp9792LsxtPLkeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l19t5JgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 565A9C4CEE6;
	Fri, 14 Feb 2025 14:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739542466;
	bh=X0hXmpZOayOUfTOXaHNHsHvruiKJo+c4qZv/9LPz9tg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=l19t5JgTo04RKrFFInAWGzTddfs4OmVAU9GfGDYgok4jtW052pN6Ve86XEEDcL2Fe
	 NTpnT8wgMtI4XKnIhbMR596GOPQ3I9xevQZPIXxaTZEkFXyM8sjMnbvmFoD4xe2qeu
	 xjQE7M1W0mU9kFHzBeQ0CkN3BjKTnq7NCSo2lyl7TQ6ttaQp0CuygvnOrURQcWZh9m
	 eQrxXTadBDPHn6TnK4/v8ZQG1u3WUYmnYpzS+o94Kvx8s231WgRhTcM8EAfIvc7//a
	 m9+PH3FiJfiNLptClDD0C6/grj5E76+dMhnRrw5yFByvKoiVlQpsHTNrAuAn/MtahN
	 SEl+nmg6EP2aw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E33C021A4;
	Fri, 14 Feb 2025 14:14:26 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Fri, 14 Feb 2025 15:14:09 +0100
Subject: [PATCH net-next v5 1/3] dt-bindings: net: ethernet-phy: add
 property tx-amplitude-100base-tx-percent
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-dp83822-tx-swing-v5-1-02ca72620599@liebherr.com>
References: <20250214-dp83822-tx-swing-v5-0-02ca72620599@liebherr.com>
In-Reply-To: <20250214-dp83822-tx-swing-v5-0-02ca72620599@liebherr.com>
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
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739542465; l=1291;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=gyZm/1v6xiCoF5uqR707anExlbQRcIOzUUiGOITwpxE=;
 b=SBuwnrqzF6QTwF9+w/3C5Swl95+cSy18Hddgj0XLt3YUL+Xezz/oAjTOX3UE/6LO4LWycnCv7
 okgKIiFFh9OCNpQfWZxy7RBfGjBzqiq/orDoP9Kf6e3AZGDT81egVQr
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 2c71454ae8e362e7032e44712949e12da6826070..824bbe4333b7ed95cc39737d3c334a20aa890f01 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -232,6 +232,12 @@ properties:
       PHY's that have configurable TX internal delays. If this property is
       present then the PHY applies the TX delay.
 
+  tx-amplitude-100base-tx-percent:
+    description:
+      Transmit amplitude gain applied for 100BASE-TX. 100% matches 2V
+      peak-to-peak specified in ANSI X3.263. When omitted, the PHYs default
+      will be left as is.
+
   leds:
     type: object
 

-- 
2.39.5



