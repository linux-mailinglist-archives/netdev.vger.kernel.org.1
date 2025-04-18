Return-Path: <netdev+bounces-184074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 476EEA931BD
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 08:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CD3D4655C8
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 06:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B4E268FEC;
	Fri, 18 Apr 2025 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Wq9c13y2"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C82B2641E9;
	Fri, 18 Apr 2025 06:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744956476; cv=none; b=nwbMAO52DrOtCswlmroaVZ5RqIAKBGkROmI5Ws/dZ2oIbSwF7/dDsLD66IKuFHPl04QE+6gcRbMVy4xnwe1n1uEpcxGvAc2nognVenoYrb5x3mfV6lHgOLNvzfBZpVjTlgEohTDf9NLkyeUyWXXLqdcoGA9bwVIxdDfSeDY0tZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744956476; c=relaxed/simple;
	bh=BrMNhqZl+0zkAODov3wygJxHlIe8R5ksa2XVadwAptw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XTC3/eyy6mdnq9rXjOuW4lMKSDN0s5fACBqDvdCrY3MiD2CM5GnFWlM+WH1fMeZfx0jFTd2YtYKO4T3gaKFbynfonMetO3KZYHvX5b+hYR/a5PqAHQI8FP3l1y1TRpQGk5lwbJQSA78BFoZnNQRn2DiBhJGxY7RCIQFG8Jdi5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Wq9c13y2; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA52110293397;
	Fri, 18 Apr 2025 08:07:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744956466; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ayBcBvwZtTlfCl+i4LAQIyGkr3eJ4aPEB/JfSb2XRlo=;
	b=Wq9c13y2Pr4R7I6K8cqXRmShpYZJXp6T7Zi/APumvmTTyP1c0kfz35BwNNpjOxaRs9AwdJ
	RnBzhFmT7/w9IuzvbCSnbxqkX00cOdsvm4/3eE9F76peZltbISc2BDwgZnxXrOLXJM5Las
	z1e0Qz7MXgvnalWrdGgkwC2YQ6lsBLQkjhpocmEta7XbMikLHIPX5PiyEQOIcNlUjSnBaT
	i0PINOtweKlxLiWuhnfOGU0PAl/ffAPJOr+ulZaWoNvT6dpY65B3GPRabhfoocF8PQBxNN
	WT0msVY78GuaftzzLyPT37xtsVmhP9NocMam1Np2AvlqIRhsjwl2YJ39pFFpbg==
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
Subject: [net-next v6 2/7] ARM: dts: nxp: mxs: Adjust the imx28.dtsi L2 switch description
Date: Fri, 18 Apr 2025 08:07:11 +0200
Message-Id: <20250418060716.3498031-3-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250418060716.3498031-1-lukma@denx.de>
References: <20250418060716.3498031-1-lukma@denx.de>
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
---
 arch/arm/boot/dts/nxp/mxs/imx28.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
index bbea8b77386f..2a484b215c8e 100644
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
+			interrupt-names = "mtipl2sw", "enet0", "enet1";
+			clocks = <&clks 57>, <&clks 57>, <&clks 64>, <&clks 35>;
+			clock-names = "ipg", "ahb", "enet_out", "ptp";
 			status = "disabled";
 		};
 	};
-- 
2.39.5


