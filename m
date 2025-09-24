Return-Path: <netdev+bounces-225889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54417B98E82
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D59197AA88C
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13ED286D49;
	Wed, 24 Sep 2025 08:34:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4228B286887
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758702889; cv=none; b=WmeLMvHtsAp7GPo5Z4vXBmtwu+m5H2ImTW8mPTybxI5NfPMUbbQBmlHKtLm6veo2XJslbkYxDHntbA03uBD8/s14Bn2ScBrnvnbBQEPQMnoB+TYmLEtG+7941aR1oRAWqLhD0LcfGpz/0HBal7KcZrRuxv1fwctP/9ybBONyAu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758702889; c=relaxed/simple;
	bh=es09yTqH3vjY+MucOzbeZ0YoUvTIbmtEWDEy+H56jXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L7HjsogIILlnB7zTIOUwv06CdMDNIhTHd+XT8y+MhalHflcU0fXLUCHqr/sMu6sdQRul2u2Lv8A9B68GU9I6XV5FBSRKk6Pufw9noAQzcwX3bUzFNyuPcLXeqeJm/SoMac7JpxuFYf+rzgQSJsGmSFGhqGF3nNDCby6QWoUltBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1v1KxR-0006Aj-Ck; Wed, 24 Sep 2025 10:34:37 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 24 Sep 2025 10:34:13 +0200
Subject: [PATCH v3 2/3] dt-bindings: arm: fsl: Add Protonic PRT8ML
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250924-imx8mp-prt8ml-v3-2-f498d7f71a94@pengutronix.de>
References: <20250924-imx8mp-prt8ml-v3-0-f498d7f71a94@pengutronix.de>
In-Reply-To: <20250924-imx8mp-prt8ml-v3-0-f498d7f71a94@pengutronix.de>
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
 linux-arm-kernel@lists.infradead.org, Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.15-dev-7abec
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=es09yTqH3vjY+MucOzbeZ0YoUvTIbmtEWDEy+H56jXU=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsi4vFbG69XkDMl93vnyK//IRwo7BsvzFbXIBmTlqD1Qm
 v1a55tURykLgxgXg6yYIkusmpyCkLH/dbNKu1iYOaxMIEMYuDgFYCIXbjIyfGqvy2BY2yJw0CEm
 7lfPO/me3BtH+L9u8YsoTxaKLmJvY2T4xaP/12nxkvuPhTb/ea6caWhR1Xcl76fri5t+nmF6S4J
 5AQ==
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Add DT compatible string for Protonic PRT8ML board.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 00cdf490b062..b135f6360733 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1106,6 +1106,7 @@ properties:
               - gateworks,imx8mp-gw75xx-2x # i.MX8MP Gateworks Board
               - gateworks,imx8mp-gw82xx-2x # i.MX8MP Gateworks Board
               - gocontroll,moduline-display # GOcontroll Moduline Display controller
+              - prt,prt8ml             # Protonic PRT8ML
               - skov,imx8mp-skov-basic # SKOV i.MX8MP baseboard without frontplate
               - skov,imx8mp-skov-revb-hdmi # SKOV i.MX8MP climate control without panel
               - skov,imx8mp-skov-revb-lt6 # SKOV i.MX8MP climate control with 7” panel

-- 
2.51.0.297.gca2559c1d6


