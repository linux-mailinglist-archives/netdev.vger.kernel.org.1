Return-Path: <netdev+bounces-221655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADFAB51715
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 14:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F28E4E74E9
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 12:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E92A320384;
	Wed, 10 Sep 2025 12:35:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E28E31DD9E
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507753; cv=none; b=qrbwHrJjOShFAR/8gXuLDvoz2mhMUhDNW8qG4+296ho+ddXXuNIum7GvLu4Zx1QuxuWqGMRPThD43S44Ni3H2xxXZqHRWTrl2oGNAtScJ3MkKkOBWcGNu1NnYzcaogYZjNaaWgiIyYrWm0uFzuC2tdDC3BqwP9O+6//fozj/oFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507753; c=relaxed/simple;
	bh=cRnw/rMFKF5mNaHDp3VQz3lG8dTPu1HRaGTl0p0YzSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j9yg210+GjKG1T3zsGB0n00/2xzvmz6kdNU+XjMhLQxZZkDoq/XemZ3HQKzlYEHYTDIA89NVRa5iZZe3VqkOarvYZ9GMYc552JhA5e51xyzykkvNjRHwqIba/QaQ73s3MLq+Lj1cgGu13Gj+M3G3yM2Kr1Hkg6SfA5RFxkFi6v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1uwK31-0002Rk-Jq; Wed, 10 Sep 2025 14:35:39 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 10 Sep 2025 14:35:22 +0200
Subject: [PATCH 2/4] ASoC: dt-bindings: asahi-kasei,ak4458: Reference
 common DAI properties
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-imx8mp-prt8ml-v1-2-fd04aed15670@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=926; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=cRnw/rMFKF5mNaHDp3VQz3lG8dTPu1HRaGTl0p0YzSc=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsg4WDDzwZwXTCt9pM9wuIm3Mq1R0Xhkxr73R+7NZ1/kd
 VcFpN6U7ShlYRDjYpAVU2SJVZNTEDL2v25WaRcLM4eVCWQIAxenAExE5jMjw5yD+ofcGv/Jvlnw
 8/w5Ta7Hhp+a1I7O6soz+uRz44l37HOGv5LqL1/57c36PjlH8fM6oY1VW+eu/NxZn/xhWfC8CEW
 9aEYA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Reference the dai-common.yaml schema to allow '#sound-dai-cells' and
"sound-name-prefix' to be used.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml
index 4477f84b7acc..1fdbeecc5eff 100644
--- a/Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml
+++ b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml
@@ -15,6 +15,9 @@ properties:
       - asahi-kasei,ak4458
       - asahi-kasei,ak4497
 
+  "#sound-dai-cells":
+    const: 0
+
   reg:
     maxItems: 1
 
@@ -46,6 +49,7 @@ required:
   - reg
 
 allOf:
+  - $ref: dai-common.yaml#
   - if:
       properties:
         compatible:

-- 
2.51.0.178.g2462961280


