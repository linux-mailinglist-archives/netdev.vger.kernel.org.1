Return-Path: <netdev+bounces-178274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D75A6A7643D
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 12:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97870188AB3C
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 10:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615B41E1E1F;
	Mon, 31 Mar 2025 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="QM4gKkGm"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19671E00B4;
	Mon, 31 Mar 2025 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743417115; cv=none; b=BmES7yHuCVe+bM/vKvRvZ2GlankIA9GA3Wh6MSmJK2/JhTgvr5H+d5LOUl1+MXDPGBsB4hWaeTlNaLWK9S0EvUogF3Rn7Ewk3AOBiQZp6I/MPCah4SOHv9Iuh9XkvE9GQqfQx6xjN2eMr5/ZEdLhE2AxL93kfVdbnGdIicLNiFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743417115; c=relaxed/simple;
	bh=XzktveYIQyILOursaynb7gIpEL6ihJvMabNJJ9qx4+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jBSOVIn2tRAY+2dFojGCjhFHIRYgea28DyTikTV0H21MTEqgc09ja1FnXsQh+1RiVs/4F8TdEEnCx/zAOv9iMLEXM20I0WVqWvE7IPTomDqt7c6xFVrqK/Eas3wmHQSqiOEqclf+CiiM3LDNtjde2ZoXJfA+qBzU5NwRBfTbB3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=QM4gKkGm; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 006DF10252BEC;
	Mon, 31 Mar 2025 12:31:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743417111; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=GGShjO7hQBTExt7fUgvPLyYsosFKagGzgAx5eN0hYW0=;
	b=QM4gKkGmU6yXvGHLNPrt5YEh9frQsi1OIipC19nIMlu/7DaST98znafx2pXwYt67Q7qXze
	vqRz3GLwua1n1bI2c/wzPK34K9HYO46Eb+Brvi4KBHfC9B7/i0Ne0bbx3UsOQmOx8d2dO0
	Pr7moHo+G/2cuRkg9QdVdLZj4KYHYh8w9NGWd3S5lXcBuwM/rPAHW1qi529AOYe6VC9wZ4
	BY3PCREQUT4XRX6+1bsyb3dBVyj5Y9qh5KBV+jIxz766+Pix24Q+YVp67jEXBL5c8NdE+l
	2aICupGZ2KjkyhBObiZRe/OwSLXMUQjqU5GjNv/uPjFSriB1SsVBr4TuqVO+7w==
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
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v3 2/4] ARM: dts: nxp: mxs: Adjust the imx28.dtsi L2 switch description
Date: Mon, 31 Mar 2025 12:31:14 +0200
Message-Id: <20250331103116.2223899-3-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331103116.2223899-1-lukma@denx.de>
References: <20250331103116.2223899-1-lukma@denx.de>
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

---
Changes for v2:
- adding extra properties (like compatible, clocks, interupts)

Changes for v3:
- None
---
 arch/arm/boot/dts/nxp/mxs/imx28.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
index bbea8b77386f..4117a5003b36 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
+++ b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
@@ -1321,8 +1321,12 @@ mac1: ethernet@800f4000 {
 			status = "disabled";
 		};
 
-		eth_switch: switch@800f8000 {
-			reg = <0x800f8000 0x8000>;
+		eth_switch: switch@800f0000 {
+			compatible = "nxp,imx287-mtip-switch";
+			reg = <0x800f0000 0x20000>;
+			interrupts = <100>, <101>, <102>;
+			clocks = <&clks 57>, <&clks 57>, <&clks 64>, <&clks 35>;
+			clock-names = "ipg", "ahb", "enet_out", "ptp";
 			status = "disabled";
 		};
 	};
-- 
2.39.5


