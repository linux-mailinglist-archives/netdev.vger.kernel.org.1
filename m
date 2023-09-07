Return-Path: <netdev+bounces-32450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFA87979EB
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 19:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89D81C20B25
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C69613ADC;
	Thu,  7 Sep 2023 17:25:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBF9134A3
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 17:25:47 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4471EE6F
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 10:25:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qeB1H-0004gl-2t; Thu, 07 Sep 2023 11:09:47 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1qeB1F-004c5o-Ag; Thu, 07 Sep 2023 11:09:45 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1qeB1F-00A0Vy-00;
	Thu, 07 Sep 2023 11:09:45 +0200
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
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: [RFC net-next v3 1/2] dt-bindings: net: dsa: microchip: Update ksz device tree bindings for drive strength
Date: Thu,  7 Sep 2023 11:09:42 +0200
Message-Id: <20230907090943.2385053-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230907090943.2385053-1-o.rempel@pengutronix.de>
References: <20230907090943.2385053-1-o.rempel@pengutronix.de>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extend device tree bindings to support drive strength configuration for the
ksz* switches. Introduced properties:
- microchip,hi-drive-strength-microamp: Controls the drive strength for
  high-speed interfaces like GMII/RGMII and more.
- microchip,lo-drive-strength-microamp: Governs the drive strength for
  low-speed interfaces such as LEDs, PME_N, and others.
- microchip,io-drive-strength-microamp: Controls the drive strength for
  for undocumented Pads on KSZ88xx variants.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../bindings/net/dsa/microchip,ksz.yaml       | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index e51be1ac03623..f2b6a66a9d22d 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -49,6 +49,26 @@ properties:
       Set if the output SYNCLKO clock should be disabled. Do not mix with
       microchip,synclko-125.
 
+  microchip,io-drive-strength-microamp:
+    description:
+      IO Pad Drive Strength
+    enum: [8000, 16000]
+    default: 16000
+
+  microchip,hi-drive-strength-microamp:
+    description:
+      High Speed Drive Strength. Controls drive strength of GMII / RGMII /
+      MII / RMII (except TX_CLK/REFCLKI, COL and CRS) and CLKO_25_125 lines.
+    enum: [2000, 4000, 8000, 12000, 16000, 20000, 24000, 28000]
+    default: 24000
+
+  microchip,lo-drive-strength-microamp:
+    description:
+      Low Speed Drive Strength. Controls drive strength of TX_CLK / REFCLKI,
+      COL, CRS, LEDs, PME_N, NTRP_N, SDO and SDI/SDA/MDIO lines.
+    enum: [2000, 4000, 8000, 12000, 16000, 20000, 24000, 28000]
+    default: 8000
+
 required:
   - compatible
   - reg
-- 
2.39.2


