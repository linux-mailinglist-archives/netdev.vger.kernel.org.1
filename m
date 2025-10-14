Return-Path: <netdev+bounces-229237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E1ABD9AA9
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27285581E18
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67304314A97;
	Tue, 14 Oct 2025 13:09:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE46314B6D
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447389; cv=none; b=RpmbVrwIMCs+JgDPWi+4MSAsyaIJI/9fLlbkkkdVG/mkqbS9ThUgaftnAZ38JjBe5iV6X+VsIohVWNG4HUkW63zFERloVZU3Pbg2aAX/zjCmlA6f1GUK00x7GSNeed80Lcpr2e+CCFdVm2Eq/vsmYGZZ4IV28f2177YN3O3X6Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447389; c=relaxed/simple;
	bh=es09yTqH3vjY+MucOzbeZ0YoUvTIbmtEWDEy+H56jXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cf9aG+oGlFdnWdcgOU3Clw5ZoZDtlc3WUAwiGfaAKQXWK0P8MmM1BQTlMf4PrF0GYLn/Ndl8VamH+npwNvDKfGb67WLUb0xsEvyz0/lnLNqTq1aP+/OuWpQ2lAANSZe3VU+6goZGV7F50NZL+v6G6hfeW/yFPwFpqIQYabRCWAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1v8emV-0007EX-AC; Tue, 14 Oct 2025 15:09:35 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Tue, 14 Oct 2025 15:09:31 +0200
Subject: [PATCH v4 1/2] dt-bindings: arm: fsl: Add Protonic PRT8ML
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-imx8mp-prt8ml-v4-1-88fed69b1af2@pengutronix.de>
References: <20251014-imx8mp-prt8ml-v4-0-88fed69b1af2@pengutronix.de>
In-Reply-To: <20251014-imx8mp-prt8ml-v4-0-88fed69b1af2@pengutronix.de>
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
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.15-dev-7abec
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=es09yTqH3vjY+MucOzbeZ0YoUvTIbmtEWDEy+H56jXU=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsh459378dOXh5m/dkXd/7b3oNapBfFaU93ebn2ScXSNT
 N3S/APlhh2lLAxiXAyyYoossWpyCkLG/tfNKu1iYeawMoEMYeDiFICJzLdm+CtRumBjxzrDqtZP
 pz1UPJ/XVFqE20979Sj3YhFz1Fqu9xYM/6sWsO/6054jNO3hYbcv+lNW9EoeVNfab2D1SeWmxVz
 Ps4wA
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


