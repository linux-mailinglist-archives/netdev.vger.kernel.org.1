Return-Path: <netdev+bounces-184999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45549A980E5
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 09:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FF23AD076
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 07:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC72126B2C8;
	Wed, 23 Apr 2025 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="gcBDMTPT"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1E526A0E2;
	Wed, 23 Apr 2025 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745393393; cv=none; b=ZD8YxWcOzwqPgnz43eV++Odl2/YU5Ik8ncFoC5ycTiTMHn9TfHL8lfQRslvxEAUmifN+flOT+bj6n2cMpdZq0FKOJwIv1mHiQUnP2ndn/JdlcCr8bw/bbS7tqVKZSWFTQlVoIYD83d+l/vkQ/jaoi7KgLsZJZYXrTRc4LdxgmTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745393393; c=relaxed/simple;
	bh=+cnP4ca1FQ0tHxozULNiP7jBpOLaFhTWqxNNSQt6XeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gHvGWQKVqUDQkdqwZuCp4cKcmADqDrlA0iS8BFJZZwp5wia/Mv690spGSbeIcYdEJHAPK4ECD5ADhcOWI5IkdkCBk5bwJtbGVl34QKnywf0tdrQfaF0RomDyW7z+htzl86aSeajTgLnEw4nSGM8f78w3o7Mr4ndURV1Sg+hvgFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=gcBDMTPT; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC7D2102A8CA3;
	Wed, 23 Apr 2025 09:29:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745393383; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=M9en1AQ1xkOKdk7vgibZMZfU8KHPwXFBLopN+2g+czg=;
	b=gcBDMTPTFvqMMxgEXNvlyKk+f29uj+4XJF9v/YoOMo6pnFPB1bCGSEk7Z2SyuNA6e7xsa/
	ijZvl4EBZ+KE21I82ORff+e4KONH4WiP29EmQamUDUkXk4zsnky0GHtojxytQlJeAlkmA7
	Z9LivWaKaiGh0ZOfRFxq6VWZgqcdH+jkBGJ92/LJCXAMFqDuFl0rZihPLCi1Sf6XRFxvkh
	df8FFhOE6BCMxAJJ4rO0Ng4xBxKmygxXL3tN+zaNQ88BwHmnzdLajJ1qRdoD87g1XFTFjN
	wQb3nJb6W7LBMs0fGdHcbRgTlRR4vO9kFmiBMMqMNDtDjyLh7Xvs0wEzGzE2Bg==
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukma@denx.de>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [net-next v7 2/7] ARM: dts: nxp: mxs: Adjust the imx28.dtsi L2 switch description
Date: Wed, 23 Apr 2025 09:29:06 +0200
Message-Id: <20250423072911.3513073-3-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250423072911.3513073-1-lukma@denx.de>
References: <20250423072911.3513073-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The current range of 'reg' property is too small to allow full control
of the L2 switch on imx287.

As this IP block also uses ENET-MAC blocks for its operation, the address
range for it must be included as well.

Moreover, some SoC common properties (like compatible, clocks, interrupts
numbers) have been moved to this node.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

---
Changes for v2:
- adding extra properties (like compatible, clocks, interupts)

Changes for v3:
- None

Changes for v4:
- Rename imx287 with imx28 (as the former is not used in kernel anymore)

Changes for v5:
- None

Changes for v6:
- Add interrupt-names property

Changes for v7:
- Change switch interrupt name from 'mtipl2sw' to 'enet_switch'
---
 arch/arm/boot/dts/nxp/mxs/imx28.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
index bbea8b77386f..8aff2e87980e 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
+++ b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
@@ -1321,8 +1321,13 @@ mac1: ethernet@800f4000 {
 			status = "disabled";
 		};
 
-		eth_switch: switch@800f8000 {
-			reg = <0x800f8000 0x8000>;
+		eth_switch: switch@800f0000 {
+			compatible = "nxp,imx28-mtip-switch";
+			reg = <0x800f0000 0x20000>;
+			interrupts = <100>, <101>, <102>;
+			interrupt-names = "enet_switch", "enet0", "enet1";
+			clocks = <&clks 57>, <&clks 57>, <&clks 64>, <&clks 35>;
+			clock-names = "ipg", "ahb", "enet_out", "ptp";
 			status = "disabled";
 		};
 	};
-- 
2.39.5


