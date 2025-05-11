Return-Path: <netdev+bounces-189528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 291E3AB28EC
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 16:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52C13B18F9
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 14:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684C51DB154;
	Sun, 11 May 2025 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="Lr8RdLBi"
X-Original-To: netdev@vger.kernel.org
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6D3189905;
	Sun, 11 May 2025 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746973199; cv=none; b=R2x00fgGp67NjFg3FAwUqEJ1D6xSguCOyt4xqkmtbCF/yaSoUJE+gSyg4FteYOas2KQZbvTC7rBYBzp3hNs/NeY5dGgN444s5U906XF2xWjnl6RjA2tJJiztnSdq7FN3LV2tqA+TRwLqh4uIkyOuXf5p8wXTUkQna3ypnPzi/Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746973199; c=relaxed/simple;
	bh=XXRZGl+UctDtZHPpvMU4a58MBFSFBk2fvZ3jOpa1DHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQxdpl82yCsyIO7mPrXSXxIs6161O2ptJ9cRt3PZntn7kgmuyykpVo+rzz8RRHb5Jg96HZFsFLUKR8ZPkB7hVrur5MlQS+kHOvdWivPiVtP+V2GJNe/pKUbR2U76E6qcwvSQ6RCcL2D3cOP3YptU6+ByHF2VaIZyfHdA9g0OHj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=Lr8RdLBi; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout4.routing.net (Postfix) with ESMTP id C50D7100569;
	Sun, 11 May 2025 14:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1746973194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09L0bbi2Bma9JXQKFtRq2kpouHX/DXAgs6YhAdRHLGI=;
	b=Lr8RdLBiPGlG/BnV8gmWcbdfWQri+pExu7H/FH/LtvAzNGF8xHDHjcCxZRLrtra10Tc4rX
	3Mx/8G1XAvlHkRptC7u4QVSVg6OjE7VtDfWXhcAVEBJvD2kApbX8WmGBCYzDXMNEOXpkvX
	tgduPpVf1q6ricuXpSxBnUqSdbuE5Lk=
Received: from frank-u24.. (fttx-pool-194.15.84.99.bambit.de [194.15.84.99])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 90738100787;
	Sun, 11 May 2025 14:19:52 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v1 01/14] dt-bindings: net: mediatek,net: update for mt7988
Date: Sun, 11 May 2025 16:19:17 +0200
Message-ID: <20250511141942.10284-2-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511141942.10284-1-linux@fw-web.de>
References: <20250511141942.10284-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 43a9dc2b-8449-488e-bbf8-467610c50a98

From: Frank Wunderlich <frank-w@public-files.de>

Update binding for mt7988 which has 3 gmac and 2 reg items.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 Documentation/devicetree/bindings/net/mediatek,net.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index 9e02fd80af83..5d249da02c3a 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
@@ -28,7 +28,8 @@ properties:
       - ralink,rt5350-eth
 
   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   clocks:
     minItems: 2
@@ -381,8 +382,12 @@ allOf:
             - const: xgp2
             - const: xgp3
 
+        reg:
+          minItems: 2
+          maxItems: 2
+
 patternProperties:
-  "^mac@[0-1]$":
+  "^mac@[0-2]$":
     type: object
     unevaluatedProperties: false
     allOf:
-- 
2.43.0


