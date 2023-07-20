Return-Path: <netdev+bounces-19468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD48475ACA4
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 13:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59DB1C2135C
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 11:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B313E1773C;
	Thu, 20 Jul 2023 11:15:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7350A5C
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 11:15:17 +0000 (UTC)
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543DE2690;
	Thu, 20 Jul 2023 04:15:15 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 4A21824E0DF;
	Thu, 20 Jul 2023 19:15:12 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 20 Jul
 2023 19:15:12 +0800
Received: from starfive-sdk.starfivetech.com (171.223.208.138) by
 EXMBX062.cuchost.com (172.16.6.62) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Thu, 20 Jul 2023 19:15:10 +0800
From: Samin Guo <samin.guo@starfivetech.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, Peter Geis <pgwipeout@gmail.com>, Frank
	<Frank.Sae@motor-comm.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, Conor Dooley
	<conor@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"Russell King" <linux@armlinux.org.uk>, Samin Guo
	<samin.guo@starfivetech.com>, "Yanhong Wang" <yanhong.wang@starfivetech.com>
Subject: [PATCH v5 1/2] dt-bindings: net: motorcomm: Add pad driver strength cfg
Date: Thu, 20 Jul 2023 19:15:08 +0800
Message-ID: <20230720111509.21843-2-samin.guo@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230720111509.21843-1-samin.guo@starfivetech.com>
References: <20230720111509.21843-1-samin.guo@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The motorcomm phy (YT8531) supports the ability to adjust the drive
strength of the rx_clk/rx_data.

The YT8531 RGMII LDO voltage supports 1.8V/3.3V, and the
LDO voltage can be configured with hardware pull-up resistors to match
the SOC voltage (usually 1.8V). The software can read the registers
0xA001 obtain the current LDO voltage value.

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: Samin Guo <samin.guo@starfivetech.com>
---
 .../bindings/net/motorcomm,yt8xxx.yaml        | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
index 157e3bbcaf6f..605be74f8556 100644
--- a/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
+++ b/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
@@ -52,6 +52,40 @@ properties:
       for a timer.
     type: boolean
 
+  motorcomm,rx-clk-drv-microamp:
+    description: |
+      drive strength of rx_clk rgmii pad.
+      The YT8531 RGMII LDO voltage supports 1.8V/3.3V, and the LDO voltage can
+      be configured with hardware pull-up resistors to match the SOC voltage
+      (usually 1.8V).
+      The software can read the registers to obtain the LDO voltage and configure
+      the legal drive strength(curren).
+      =====================================================
+      | voltage |        curren Available (uA)            |
+      |   1.8v  | 1200 2100 2700 2910 3110 3600 3970 4350 |
+      |   3.3v  | 3070 4080 4370 4680 5020 5450 5740 6140 |
+      =====================================================
+    enum: [ 1200, 2100, 2700, 2910, 3070, 3110, 3600, 3970,
+            4080, 4350, 4370, 4680, 5020, 5450, 5740, 6140 ]
+    default: 2910
+
+  motorcomm,rx-data-drv-microamp:
+    description: |
+      drive strength of rx_data/rx_ctl rgmii pad.
+      The YT8531 RGMII LDO voltage supports 1.8V/3.3V, and the LDO voltage can
+      be configured with hardware pull-up resistors to match the SOC voltage
+      (usually 1.8V).
+      The software can read the registers to obtain the LDO voltage and configure
+      the legal drive strength(curren).
+      =====================================================
+      | voltage |        curren Available (uA)            |
+      |   1.8v  | 1200 2100 2700 2910 3110 3600 3970 4350 |
+      |   3.3v  | 3070 4080 4370 4680 5020 5450 5740 6140 |
+      =====================================================
+    enum: [ 1200, 2100, 2700, 2910, 3070, 3110, 3600, 3970,
+            4080, 4350, 4370, 4680, 5020, 5450, 5740, 6140 ]
+    default: 2910
+
   motorcomm,tx-clk-adj-enabled:
     description: |
       This configuration is mainly to adapt to VF2 with JH7110 SoC.
-- 
2.17.1


