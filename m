Return-Path: <netdev+bounces-221652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A781B5170F
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 14:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235971C81FC1
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 12:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E43331DDAE;
	Wed, 10 Sep 2025 12:35:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF7C31C56B
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507751; cv=none; b=YFDZmBZpRXX/HU8eIlLXnPcO4uJKBNUMnaJclfAp6iNMjdN6URAFRgZ2RBQlx6lVbtzBDM6O54qg4CMzuPc/eHHpVPbmopACJbFXiKckMgTrdtNB0Q62XIlud6xtAqkV209JEIimJxeuEyXchwMjRxiAHKCVPs/Bn1Kv3xpI2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507751; c=relaxed/simple;
	bh=XQ4gxJpcOh8Z0XnCFiM0h78lv72v3EN1lEY0NA2CNOk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=frK2PbUyly0gsCYOpJMG+EI1GXnOHN063h4Ro/Nb6ub+5maCRFpV8zWNcgIqiPe8DeTkAYktNR0iQmjHB7dSmF66X/Fr0iCBwNEqtlNad5dhN99ctsLWTDPLQyfiysJYQzWdQ7LJw+Yd1/1sdJ/QMOf15bhPHKt+2G/CbPt1zAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1uwK31-0002Rk-F5; Wed, 10 Sep 2025 14:35:39 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Subject: [PATCH 0/4] Mainline Protonic PRT8ML board
Date: Wed, 10 Sep 2025 14:35:20 +0200
Message-Id: <20250910-imx8mp-prt8ml-v1-0-fd04aed15670@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIhwwWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwND3czcCovcAt2CohKL3BxdA8OkVGMTMwsTM1NLJaCegqLUtMwKsHn
 RsbW1AJ6ooaxfAAAA
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
 Lucas Stach <l.stach@pengutronix.de>, David Jander <david@protonic.nl>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
X-Mailer: b4 0.15-dev-7abec
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=XQ4gxJpcOh8Z0XnCFiM0h78lv72v3EN1lEY0NA2CNOk=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsg4WDCDL8Hr5A2hDRmHDvOt+uZSkM79a1l3xeQ5bLL+U
 UfC/qnu7ShlYRDjYpAVU2SJVZNTEDL2v25WaRcLM4eVCWQIAxenAEzkXSYjw8QP7grLBI71V7VG
 Okp6t/Mwbz7jdcVTyfw915kiloaNAgz/tI9Y7gljr4q19ZI7/+nAvhq/u505q9pSn6yuLdkZuju
 SBwA=
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
Jonas Rebmann (3):
      dt-bindings: net: dsa: nxp,sja1105: Add reset-gpios property
      ASoC: dt-bindings: asahi-kasei,ak4458: Reference common DAI properties
      dt-bindings: arm: fsl: Add Protonic PRT8ML

Lucas Stach (1):
      arm64: dts: add Protonic PRT8ML board

 Documentation/devicetree/bindings/arm/fsl.yaml     |   1 +
 .../devicetree/bindings/net/dsa/nxp,sja1105.yaml   |   5 +
 .../bindings/sound/asahi-kasei,ak4458.yaml         |   4 +
 arch/arm64/boot/dts/freescale/Makefile             |   1 +
 arch/arm64/boot/dts/freescale/imx8mp-prt8ml.dts    | 409 +++++++++++++++++++++
 5 files changed, 420 insertions(+)
---
base-commit: d34bbb45b57c90a5c1bcac5f327df79ddfbfe957
change-id: 20250701-imx8mp-prt8ml-01be34684659

Best regards,
--  
Jonas Rebmann <jre@pengutronix.de>


