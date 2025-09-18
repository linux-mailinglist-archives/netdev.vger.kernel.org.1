Return-Path: <netdev+bounces-224421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 388ACB848DE
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1921C8380A
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89D62D0C68;
	Thu, 18 Sep 2025 12:20:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B06F1A9F93
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198017; cv=none; b=PU8TFb8GAt9VA9fm0FmCz+y5yrMK9W1fyq834Ep2A0OGLkhdU0duhkghkoLnp4enci4Rqgc8uYsvOHbWOfAJeyJaYtE8AuoKczY3LVy/qlJNkI0fzHA3iDjHuS0aTQ4TRCMa3M3IPSy8ok8s7uzjdqnrsXn7KBID5bq8kYZrAR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198017; c=relaxed/simple;
	bh=FsXTDizrH/4gfOwdWNseCJsGuPazREdG9eV/96rDM88=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UbktS/cLlCujo2ifMC0YwKLKMgH8Rym1aBRutChfq0yCY+G6pyikX84fZRThlfk4x2R0sfvE6/ngdMJFNizyH7ENY8VSlqm+UO1fme1p9BFPlCCZQJJfulWRe4OEEvy8QoWmMYyTiJtBa/p/j/cR/hddLRMWQPPe2RwYGiSPE4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1uzDc7-0006mw-9i; Thu, 18 Sep 2025 14:19:51 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Subject: [PATCH v2 0/3] Mainline Protonic PRT8ML board
Date: Thu, 18 Sep 2025 14:19:43 +0200
Message-Id: <20250918-imx8mp-prt8ml-v2-0-3d84b4fe53de@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN/4y2gC/13Myw6CMBCF4Vchs7ZmiuW68j0MC7QDTCKlabHBk
 L67FXcu/5OcbwdPjslDm+3gKLDnxaTITxk8pt6MJFinhhzzAiuUguetnq2wbq3np0B5p4sqa1U
 WDaSPdTTwdni3LvXEfl3c++CD/K4/qZH4JwUpUAwaVU9aFmWFV0tmfK1uMbydNUEXY/wAhrRJo
 a8AAAA=
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
 linux-arm-kernel@lists.infradead.org, Jonas Rebmann <jre@pengutronix.de>, 
 David Jander <david@protonic.nl>, Lucas Stach <l.stach@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
X-Mailer: b4 0.15-dev-7abec
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=FsXTDizrH/4gfOwdWNseCJsGuPazREdG9eV/96rDM88=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsg4/ePJl6u3r7nvYpst9cU93nbZa5ffJtw/uvyt7Nh36
 BY3X3AK6ihlYRDjYpAVU2SJVZNTEDL2v25WaRcLM4eVCWQIAxenAEwk5Tsjw/r7Lp/mLmf7tWZP
 ZMrkzXf8ZI6bZe1b+Pi6Bktm3uaipbwM/0zyi2/dZIx5e6Xqa+Oi4tdTiyqde4LFl2t/z2DWO66
 3lhkA
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
Jonas Rebmann (3):
      dt-bindings: net: dsa: nxp,sja1105: Add reset-gpios property
      dt-bindings: arm: fsl: Add Protonic PRT8ML
      arm64: dts: add Protonic PRT8ML board

 Documentation/devicetree/bindings/arm/fsl.yaml     |   1 +
 .../devicetree/bindings/net/dsa/nxp,sja1105.yaml   |   9 +
 arch/arm64/boot/dts/freescale/Makefile             |   1 +
 arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dts    | 500 +++++++++++++++++++++
 4 files changed, 511 insertions(+)
---
base-commit: ea21fa34164c9ea0a2a5b8714c7e36f54c7fb46e
change-id: 20250701-imx8mp-prt8ml-01be34684659

Best regards,
--  
Jonas Rebmann <jre@pengutronix.de>


