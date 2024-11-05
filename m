Return-Path: <netdev+bounces-141854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7010C9BC8B4
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30AE7281C5F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E7F1D172B;
	Tue,  5 Nov 2024 09:10:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A071CFED4
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797809; cv=none; b=ClyNkOi36CoCq5Lq6+AiwYZQZaqgl0fp52ldBWwXmqv156mkY4n+eWb/WZ+e0n4fShfC/CMx82sXCdyuSYMS2CfZs9N1PyuLnwlpzn8yxUZ555pR2bT7Ez7nF0q7BbkC/pi4BTbOGoPbDx7g9Fay+w3Lt3rCAZss6ifOxLQMYd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797809; c=relaxed/simple;
	bh=mv2/SEFrlPC3p6OnzI+7NQhDPVvHM/AyOdIW9TzUXwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eveCEjF7by5ltR/odINRfzzKz4bmWAbFYRNxeqXhSEaLKGxNgU+rUjoBESoI95+GuD0f2vLUfPpEDuCs7E7rfqDfBUkXE+pXAOp6AO8rB6Sa5WwqGxTNlYM6IKxrovSZfQviN/kmNctQcsGxNhXFpCu6TTVLoX2Hgrfa5GqmvqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t8FZL-0003oN-Rq; Tue, 05 Nov 2024 10:09:47 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t8FZK-0027YU-1L;
	Tue, 05 Nov 2024 10:09:46 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t8FZK-002ofl-15;
	Tue, 05 Nov 2024 10:09:46 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org,
	Marek Vasut <marex@denx.de>
Subject: [PATCH net-next v3 2/6] dt-bindings: net: dsa: ksz: add mdio-parent-bus property for internal MDIO
Date: Tue,  5 Nov 2024 10:09:40 +0100
Message-Id: <20241105090944.671379-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241105090944.671379-1-o.rempel@pengutronix.de>
References: <20241105090944.671379-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Introduce `mdio-parent-bus` property in the ksz DSA bindings to
reference the parent MDIO bus when the internal MDIO bus is attached to
it, bypassing the main management interface.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml       | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index a4e463819d4d7..121a4bbd147be 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -84,6 +84,15 @@ properties:
   mdio:
     $ref: /schemas/net/mdio.yaml#
     unevaluatedProperties: false
+    properties:
+      mdio-parent-bus:
+        $ref: /schemas/types.yaml#/definitions/phandle
+        description:
+          Phandle pointing to the MDIO bus controller connected to the
+          secondary MDIO interface. This property should be used when
+          the internal MDIO bus is accessed via a secondary MDIO
+          interface rather than the primary management interface.
+
     patternProperties:
       "^ethernet-phy@[0-9a-f]$":
         type: object
-- 
2.39.5


