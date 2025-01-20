Return-Path: <netdev+bounces-159778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC7DA16DBF
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 14:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E642416943D
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 13:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10911E25FC;
	Mon, 20 Jan 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oa/M5wTF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE26E1E22FC;
	Mon, 20 Jan 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737381030; cv=none; b=MGu010LXLVVToR/rAY8DoBG0BI9QS72q0/yiIOTrwsSLMLtFDJi6FBmXA/NCwAY2/7m0eQGZGHWtvejFff9VlA3rqJEUqeWdhEoRM4lgKhHEckcLCXhUkD0jiXfXGbV1HjhrNDB5QmKT115ATMsqg4/TEiMzuCbjoSdfQltdeXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737381030; c=relaxed/simple;
	bh=1ximHPbMmEHEBuLgHpQFBwbcsdYKRx5fYUW+fBDJ4NI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p+g2jiHX9LROvkt6A2/DsiE7sR4uz+ElEEsi+Y8A/bJKLOAArUFYFiFPhObQ7BnZAkecrC28lrxy4eN6ksgj1hpXKKRRo/2cJ3iLLU/VLbqwVuI6As/BUC8ic0fCxcVCb0DqWGLh5iX1zZZbUACbN23ajAcJc1oqk2BtvLYJX1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oa/M5wTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1ADBFC4CEE5;
	Mon, 20 Jan 2025 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737381030;
	bh=1ximHPbMmEHEBuLgHpQFBwbcsdYKRx5fYUW+fBDJ4NI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Oa/M5wTFtX1O5DURgESD8reMP52NQxnwuU7vQoh1MHLuOIyW59dlIvYZcRInzT+kx
	 OmOypZuCEfe9SloL/4NjdH4/hVWWviqxNZRP5TiZXzMgXbu5wsCtnAi66e7ZAUb/h/
	 ctc6LeBGbXXZLCWxvJRY9JqEM3d3RSPzTYZVQEEjj78rz2UPQ+glN/aSD9ATXmclrg
	 6MP4jMuMhPSQ4/SoMCkKiewFlHdE8fLwCmwNlZf775XXqHUWrRfzvhfaDt8o1vxggh
	 561hCTyDrFACkW6qwatot5YtxAZMMdl9Wye+3HKNGKDS7NFouQUKnik/k2xf1WWXYQ
	 NK4aU5wi7HcQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0928AC02185;
	Mon, 20 Jan 2025 13:50:30 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Mon, 20 Jan 2025 14:50:21 +0100
Subject: [PATCH net-next v2 1/3] dt-bindings: net: ethernet-phy: add
 property tx-amplitude-100base-tx-gain-milli
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-dp83822-tx-swing-v2-1-07c99dc42627@liebherr.com>
References: <20250120-dp83822-tx-swing-v2-0-07c99dc42627@liebherr.com>
In-Reply-To: <20250120-dp83822-tx-swing-v2-0-07c99dc42627@liebherr.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737381028; l=1340;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=o9/uYCQMqtj7aA5WdqSP5I74ZoABiwwXrCBqYSBeaRI=;
 b=HzyehliKyx0cDcSOOj1zdjTN00xtHbx8p1oWQhEu6VA+ZEHW4tacLpYoWV+UINcjc+I4h7prx
 Qi9d8HHyTAmD0s4KUAnN6oAkRgRiacX5MoX82SV9n0eucRtIOeerheh
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Add property tx-amplitude-100base-tx-gain-milli in the device tree bindings
for configuring the tx amplitude of 100BASE-TX PHYs. Modifying it can be
necessary to compensate losses on the PCB and connector, so the voltages
measured on the RJ45 pins are conforming.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 2c71454ae8e362e7032e44712949e12da6826070..ce65413410c2343a3525e746e72b6c6c8bb120d0 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -232,6 +232,14 @@ properties:
       PHY's that have configurable TX internal delays. If this property is
       present then the PHY applies the TX delay.
 
+  tx-amplitude-100base-tx-gain-milli:
+    description: |
+      Transmit amplitude gain applied (in milli units) for 100BASE-TX. When
+      omitted, the PHYs default will be left as is. If not present, default to
+      1000 (no actual gain applied).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 1000
+
   leds:
     type: object
 

-- 
2.39.5



