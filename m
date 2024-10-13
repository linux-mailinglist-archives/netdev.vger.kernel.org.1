Return-Path: <netdev+bounces-135010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B37F99BC36
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 23:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5701C20FC6
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 21:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAD41A0B08;
	Sun, 13 Oct 2024 21:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEJsw491"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F28C175D2D;
	Sun, 13 Oct 2024 21:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728854879; cv=none; b=odlN9e1frXKDynSYB6otoiJxTEKvZ+og1VDvFJ2BKpxf4R4cDH0AiGKcK4ERZqq+ujRtdEL0bPLMNBPWNEBRWL+olZbW8sfjDBWisjGvz9eqZKCdfCakCpWab1RAPgDSdFeHprd1mRclxtVG2vzyBMJ2fjFGOln0mbpzkfy8isM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728854879; c=relaxed/simple;
	bh=zAAupFSvZACbXghIFfSS4EVe26kSkFg+ybuK1orZ7RM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kvkvtqlJ870OYciRjSzcqT222ru1ePmonAyelBP36ysWCQE8Zl0qDTA4c++hTwymK34qG9uLANMiE5Wxy9Y5l9z8w6/0qeYjQlHo65ccpQSQBQrrJT+i5s7/+AZwbtIf59CvagNS7rcLx6kYUYu8jkIShG595KoOUT0zKsdT21Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEJsw491; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF1F9C4CED9;
	Sun, 13 Oct 2024 21:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728854878;
	bh=zAAupFSvZACbXghIFfSS4EVe26kSkFg+ybuK1orZ7RM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EEJsw491D5rVI1FSdg0F4yFrrPIWDuBFqs28fKSIKcVwJIV59Mhazastk3oJvbHoG
	 i/WzGL6a1F4VJz+/wfDktNY6d4szuVOwUBFPxyQs9dz3+82hH4FOaz/dlt+7qd4LMQ
	 VnoIctukk6Y7991Qx5d1YO9bicOPGvgbdoP/WOMTnIkCSdT2DRunh0bOozBdcDeGo/
	 MitDy3su2vnlzWezceuR4UAjX0bs0HEILPLSF1GsswXIwDbtfyvyhwZ1teXv5+2ZJI
	 bZd7pPEEdEv+x14ZtJ89JulwUm/cNVxaULAfL9exw0eu8/Fi9nkXwPSpspwO2AnE3a
	 Ea1kvu/joXzbg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BB1CF2594;
	Sun, 13 Oct 2024 21:27:58 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Sun, 13 Oct 2024 23:27:50 +0200
Subject: [PATCH v3 15/16] MAINTAINERS: Add Jan Petrous as the NXP S32G/R
 DWMAC driver maintainer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241013-upstream_s32cc_gmac-v3-15-d84b5a67b930@oss.nxp.com>
References: <20241013-upstream_s32cc_gmac-v3-0-d84b5a67b930@oss.nxp.com>
In-Reply-To: <20241013-upstream_s32cc_gmac-v3-0-d84b5a67b930@oss.nxp.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Emil Renner Berthing <kernel@esmil.dk>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Iyappan Subramanian <iyappan@os.amperecomputing.com>, 
 Keyur Chudgar <keyur@os.amperecomputing.com>, 
 Quan Nguyen <quan@os.amperecomputing.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, NXP S32 Linux Team <s32@nxp.com>, 
 "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728854875; l=872;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=zmHx3KNbX8A6L/euQ4+Hu4yJAQBrFW95hHmYe/45/dc=;
 b=RGWSZgVVXDcvhXEDq6X4N4KOzc9Vs2WUbIYIGOBAGbaN5c778ikD3JcWUboQ9SFq1FnEUqVVd
 wpgujQ3WsjvCRakL9q30pisG1A12E5+ILIURNsQFfyz1XMt4w6ZiiLu
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

Add myself as NXP S32G/R DWMAC Ethernet driver maintainer.

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7387afe8f7ea..217a7edb25c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2757,6 +2757,13 @@ S:	Maintained
 F:	arch/arm64/boot/dts/freescale/s32g*.dts*
 F:	drivers/pinctrl/nxp/
 
+ARM/NXP S32G/S32R DWMAC ETHERNET DRIVER
+M:	Jan Petrous <jan.petrous@oss.nxp.com>
+L:	NXP S32 Linux Team <s32@nxp.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/nxp,dwmac-s32.yaml
+F:	drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
+
 ARM/Orion SoC/Technologic Systems TS-78xx platform support
 M:	Alexander Clouter <alex@digriz.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

-- 
2.46.0



