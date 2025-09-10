Return-Path: <netdev+bounces-221653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0795DB51711
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 14:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B554E802D
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 12:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DB031E0E3;
	Wed, 10 Sep 2025 12:35:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2521831A067
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507751; cv=none; b=ezrT0ibVxRgbv6SnFErDyDGaQVvsYCa+c4L1l5pnm1yqiV9VJ5SJTCyHEBBS3Gayc0NMRd9esb2ZtLy1rm7M/EZQeXRbtDHlHVGZtSZi+5Z24Kzj3PT/yIl1g++B+/LFiOOb9ufuPQwf3v7+zMJWCRhEjlc6olsNT8Kv/giOEO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507751; c=relaxed/simple;
	bh=TBA+/Wtrrdw+qQXA6PajB1ycZl0ryR1E4WZlHtktBNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PwttH8uj7VJYRf2QLaSkUluLX56PPyau4/gV5NrdK1N7bCxoAtLDn3tQ4Ftv0QM1AD4bxJ03TMyvmSTv6UWXGVboZQc9N5ShWDJsyqTQ+6DGscHy7CUzfC3Z/3MaEDwZV2/qBL0vS3LbjWO/Gr8VJW5ZR9tVpCQ0liSt4mhi+fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1uwK31-0002Rk-MB; Wed, 10 Sep 2025 14:35:39 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 10 Sep 2025 14:35:23 +0200
Subject: [PATCH 3/4] dt-bindings: arm: fsl: Add Protonic PRT8ML
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250910-imx8mp-prt8ml-v1-3-fd04aed15670@pengutronix.de>
References: <20250910-imx8mp-prt8ml-v1-0-fd04aed15670@pengutronix.de>
In-Reply-To: <20250910-imx8mp-prt8ml-v1-0-fd04aed15670@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=TBA+/Wtrrdw+qQXA6PajB1ycZl0ryR1E4WZlHtktBNs=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsg4WDAzZgdj1FKGF9tPXMne/vXnoojj9xhqGrYne3Iyt
 JhesGxP6ShlYRDjYpAVU2SJVZNTEDL2v25WaRcLM4eVCWQIAxenAEwkUJfhD8cbgfy9fy663uxN
 sspY8Fukxy5T4EfysuNa7wT+txT+nMTwh+fLvVW7lP9orTh+KHdeX8qdHdWhc9Z5y3qdWnT1wwy
 9rfwA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Add DT compatible string for Protonic PRT8ML board.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index ebafa6ecbcb6..ce3e53b4513a 100644
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
2.51.0.178.g2462961280


