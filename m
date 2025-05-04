Return-Path: <netdev+bounces-187635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5A5AA870C
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 16:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFCA3A7098
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 14:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBB01DE3A5;
	Sun,  4 May 2025 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="SxgCuQ8J"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17BD1BD01F;
	Sun,  4 May 2025 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746370576; cv=none; b=uWsMuOBfIV6T01CmikADe2jsTg6cpYILiu3OfD82s9YZ6ggDI3yqvcTv0YnVdStxiBmhQXhoF7SCAOQd/SCLNDZxVE+O5WTblgSJB4grs5IQmSbp+GMIRXltGH3nhiz6RbMTzQmGeBNbOCg0XnEMg208p8THTY1Udq7A4w3aEsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746370576; c=relaxed/simple;
	bh=ZK5lDIGZkeAAeeR6im7ykWBfR3PFo/sbACxkB3oWoJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eBAjvqRWGOmtMTvajYMUWLegeUGX6DsQueXdeOWx1JC+nrpE8Nh4NY6O40A5Iu3zq9vhG+qbHkG5STg3xodLe4twFmIRtnQWvdMbkPAwK9bHj0VxkaqTBw/YpZV1/03cdzr3pHRg1S7zV5im+pPFxxKysKewxK17Hh5RX8ypMVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=SxgCuQ8J; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 18FDA1048C2EB;
	Sun,  4 May 2025 16:56:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1746370572; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=SdfUQpsCMfta5H0a1mTW3qUrCZbaTy+KihLdbg8QDZE=;
	b=SxgCuQ8JXQYZhO17gG+EMwuPub9t/S1KkAisjy8+7gIh/ph4BKChQMt2HCfiIIw/QPyL6s
	xNl1OJ/5wWANkSKkiNzOU4XH/oUlRAOIYrr46yO8S+hbAtsQH7vvNWbhIvQXNG3+4CH+3x
	37KLNiaNhnBzRVhY+rpUIpQLZnz4gV63asZBJ5QJpGOh2AvI2cODPvWszcr2LLm6/tyenF
	0d3Lhgrptd8Z6mSe6TUHqtK872nnxatgYDbwBzyaxcXagfazYt0nYezE/pENWBvcDNx+m+
	o+mYxjHR5B1QCT5HeWQVLlNvWxgvMZ1bcHC8eSZl5ZD8O0FXFF01uukkFndHGQ==
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
Subject: [net-next v11 2/7] ARM: dts: nxp: mxs: Adjust the imx28.dtsi L2 switch description
Date: Sun,  4 May 2025 16:55:33 +0200
Message-Id: <20250504145538.3881294-3-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250504145538.3881294-1-lukma@denx.de>
References: <20250504145538.3881294-1-lukma@denx.de>
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

Changes for v8:
- None

Changes for v9:
- None

Changes for v10:
- None

Changes for v11:
- None
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


