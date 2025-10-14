Return-Path: <netdev+bounces-229235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6904CBD99D9
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 15E7735507D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59559314B6F;
	Tue, 14 Oct 2025 13:09:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56823314A97
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447388; cv=none; b=fYIHhLqTPiLivGFlc617euRYnl4iFWTERToKs3KeLRjj5tcDNRoSaikMXTWdtCHEvU5+fOjM3kA+Ny4NrUZG29HVHME1gPXG60mPJOiqRcvQfMMwR5w4bc1Nf7qGeKBIjD05dNOvJ41BAQgMJPi6OBBQoEOUTxl2aEQxFr005Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447388; c=relaxed/simple;
	bh=2tt4zSuVjsO7A5I6VZ49Wzvg4d7IGcTk/fszUM8KpGE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Bm3HXQ9mg6W3a/YyGJtptQqjCF5yWK75QnY/rwVH8MXWO6JtYhr20s76SoWMuPD8yeRjxNqe2PxvaT5oT+NOKp18ARLLzGtUR2Jb/ynj6xuNCxzR95e/Onqt+hXJyuXjVQKnu6Yvz+5N0Tbchwt5EQEC+jvcxMu2yr2gcSTn3do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1v8emV-0007EX-7j; Tue, 14 Oct 2025 15:09:35 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Subject: [PATCH v4 0/2] Mainline Protonic PRT8ML board
Date: Tue, 14 Oct 2025 15:09:30 +0200
Message-Id: <20251014-imx8mp-prt8ml-v4-0-88fed69b1af2@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIpL7mgC/23OTQ6CMBCG4auQrq3pzxSKK+9hXICdQhOBpiDBE
 O5uwQ1Bl++XzJOZSY/BYU8uyUwCjq53XRsDTgl51EVbIXUmNhFMKJYxTl0z6cZTHwbdPCnjJUp
 INaQqJ/HGB7Ru2rzbPXbt+qEL740f+bp+pZyzgzRyyqg1DAo0XKUZu3psq9cQutZNZ4Nk5UaxJ
 /SREJGQRkMJFpU0+JeQO0LAkZDrF5Brk9mMFzn8EMuyfABQVCBoNQEAAA==
X-Change-ID: 20250701-imx8mp-prt8ml-01be34684659
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@oss.nxp.com>, 
 Jonas Rebmann <jre@pengutronix.de>, David Jander <david@protonic.nl>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
X-Mailer: b4 0.15-dev-7abec
X-Developer-Signature: v=1; a=openpgp-sha256; l=1732; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=2tt4zSuVjsO7A5I6VZ49Wzvg4d7IGcTk/fszUM8KpGE=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsh4590zpX7/AScjzaOeE/jEDCeLfg54/7/Lk/e1XZc9a
 82plvYdHaUsDGJcDLJiiiyxanIKQsb+180q7WJh5rAygQxh4OIUgIkI32D4p3204cQBibtq+i5V
 UVqbpdczaV2c6vY/wf1r/buOuUfcbBkZdny5vndi3az3j9/aHkxeuSPAizO6P3fu5qsHf73prpn
 9lRkA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

This series adds the Protonic PRT8ML device tree as well as some minor
corrections to the devicetree bindings used.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
Changes in v4:
- Dropped "dt-bindings: net: dsa: nxp,sja1105: Add reset-gpios
  property", applied to netdev/net-next.git (Thanks, Jakub)
- Comment on deleted OPP and deleted dma, correct tps65987ddh node names
  (Thanks, Peng)
- Link to v3: https://lore.kernel.org/r/20250924-imx8mp-prt8ml-v3-0-f498d7f71a94@pengutronix.de

Changes in v3:
- Add comment on the intentional limitation to 100Mbps RGMII
- Link to v2: https://lore.kernel.org/r/20250918-imx8mp-prt8ml-v2-0-3d84b4fe53de@pengutronix.de

Changes in v2:
- Dropped "ASoC: dt-bindings: asahi-kasei,ak4458: Reference common DAI
  properties", applied to broonie/sound for-next (Thanks, Mark)
- Updated description of the reset-gpios property in sja1105 binding to
  address the issues of connecting this pin to GPIO (Thanks, Vladimir)
- Added the fec, switch and phy for RJ45 onboard ethernet after
  successful testing
- Consistently use interrupts-extended
- Link to v1: https://lore.kernel.org/r/20250910-imx8mp-prt8ml-v1-0-fd04aed15670@pengutronix.de

---
Jonas Rebmann (2):
      dt-bindings: arm: fsl: Add Protonic PRT8ML
      arm64: dts: add Protonic PRT8ML board

 Documentation/devicetree/bindings/arm/fsl.yaml  |   1 +
 arch/arm64/boot/dts/freescale/Makefile          |   1 +
 arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dts | 504 ++++++++++++++++++++++++
 3 files changed, 506 insertions(+)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20250701-imx8mp-prt8ml-01be34684659

Best regards,
--  
Jonas Rebmann <jre@pengutronix.de>


