Return-Path: <netdev+bounces-34415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26677A41C6
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 09:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294081C20DE7
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 07:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C440748E;
	Mon, 18 Sep 2023 07:09:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450027469;
	Mon, 18 Sep 2023 07:09:06 +0000 (UTC)
Received: from core.lopingdog.com (core.lopingdog.com [162.55.228.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5563711A;
	Mon, 18 Sep 2023 00:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lopingdog.com;
	s=mail; t=1695020335;
	bh=i/qzEeo8fc//u5Bc1P6x2eVPi43Lvo5cbbQc5SwjBEs=;
	h=Date:From:To:Subject:From;
	b=XmF6He8xvOu8dvzWON+arINRODBSa6t6KE7srG2357M2cFSfN/9CS+R2zZ2gm5VE6
	 AHD6pf1q2PD5hMg9if8+ItTwicMoqqffUHlnMsmJkWGO/sP2a0nhFuqBSpM8qBKFTD
	 CnSVp60n+4kptVxOYjXSQC/J9DNY0b78kIAx9SM1CMcmxosdHJJ9LD9f8rI6iTVlB2
	 tp8RHbVNLfdJUJagNXZIU7nknjj3bUCurvRQJHkmdMOhCn/GVGbRRsw0toBu5sIWGi
	 dRCST4NTy5e2gHGM9XZNjbM2iw/Qwo4J4VEWbgmCONDMFNokrAEdV4cbiTJRNMAlOH
	 EKsyMz+fRDjDA==
Received: from authenticated-user (core.lopingdog.com [162.55.228.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by core.lopingdog.com (Postfix) with ESMTPSA id 270594405E6;
	Mon, 18 Sep 2023 01:58:54 -0500 (CDT)
Date: Mon, 18 Sep 2023 01:58:52 -0500
From: Jay Monkman <jtm@lopingdog.com>
To: devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Arndt Schuebel <Arndt.Schuebel@onsemi.com>
Subject: [PATCH 1/4] dt-bindings: net: Add bindings for onsemi NCN26000 PHY
Message-ID: <ZQf1LMnICzEnt9XK@lopingdog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Add devicetree bindings for onsemi's NCN26000 10BASE-T1S PHY.

Signed-off-by: Jay Monkman <jtm@lopingdog.com>
---
 .../bindings/net/onnn,ncn26000.yaml           | 177 ++++++++++++++++++
 1 file changed, 177 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/onnn,ncn26000.yaml

diff --git a/Documentation/devicetree/bindings/net/onnn,ncn26000.yaml b/Documentation/devicetree/bindings/net/onnn,ncn26000.yaml
new file mode 100644
index 000000000000..b0b1e1ea86f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/onnn,ncn26000.yaml
@@ -0,0 +1,177 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/onnn,ncn26000.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: onsemi NCN26000 10BASE-T1S Ethernet PHY
+
+maintainers:
+  - Jay Monkman <jtm@lopingdog.com>
+
+description: |
+  Bindings for onsemi NCN26000 10BASE-T1S ethernet PHY.
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+properties:
+  description: |
+    Sets the transmitter amplitude gain. If not specified,
+    gain is set to 1.0V (1v0)
+  tx-gain:
+    enum:
+      - 1v1
+      - 1v0
+      - 0v9
+      - 0v8
+
+  tx-slew:
+    description: |
+      Sets the slew rate of the TX line driver output. Defaults
+      to slow if not set.
+    enum:
+      - fast
+      - slow
+
+  dig-slew:
+    description: |
+      Sets the slew rate of the digital output pins. Defaults
+      to slow if not set.
+    enum:
+      - fast
+      - slow
+
+  cmc-comp:
+    description: |
+      Sets the common mode choke resistance (CMC compensation).
+      Defaults to 0-0.5 ohm (0p25) if not set.
+    enum:
+      - 0p25
+      - 1p38
+      - 3p00
+      - 3p37
+
+  plca-precedence:
+    description: |
+      Enables PLCA precedence mode. Defaults to off if not
+      set.
+    type: boolean
+
+  eni-mode:
+    description: |
+      Enables Enhanced Noise Immunity mode. Defaults to off if
+      not set.
+    enum:
+      - force-on
+      - force-off
+      - auto
+
+  tx-pkt-loop:
+    description: |
+      Enables packet loopback mode. Defaults to off is not set.
+    type: boolean
+
+  unjab-tmr-disable:
+    description: |
+      Disables the Unjab Timer. When disabled, device transmission
+      will be stopped due to a jabber error and only restarted on
+      device reset. If not set, this defaults to enabled.
+    type: boolean
+
+  col-disable:
+    description: |
+      Disables collision masking. Defaults to enabled if not set.
+    type: boolean
+
+  no-rx-delay:
+    description: |
+      Disables the RX internal path delay. Defaults to enabled if
+      not set.
+    type: boolean
+
+  dio0-fn:
+    description: |
+      Selects the DIO0 pin output function. Defaults to disabled if
+      not set.
+    enum:
+      - sfd-tx
+      - sfd-rx
+      - sfd-rxtx
+      - led-link
+      - led-plca
+      - led-tx
+      - led-rx
+      - led-rxtx
+      - clk25m
+
+  dio0-pullup:
+    description: |
+      Enables the DIO0 pin pullup. Defaults to no pull up if not
+      set.
+    type: boolean
+
+  dio0-active-high:
+    description: |
+      Sets DIO0 pin output state. Defaults to low if not set
+    type: boolean
+
+  dio0-slew:
+    description: |
+      Sets the slew rate of the DIO0 pin. Defaults to slow if not set.
+    enum:
+      - fast
+      - slow
+
+  dio1-fn:
+    description: |
+      Selects the DIO1 pin output function. Defaults to disabled if
+      not set.
+    enum:
+      - sfd-tx
+      - sfd-rx
+      - sfd-rxtx
+      - led-link
+      - led-plca
+      - led-tx
+      - led-rx
+      - led-rxtx
+      - clk25m
+
+  dio1-pullup:
+    description: |
+      Enables the DIO1 pin pullup. Defaults to no pull up if not
+      set.
+    type: boolean
+
+  dio1-active-high:
+    description: |
+      Sets DIO1 pin output state. Defaults to low if not set
+    type: boolean
+
+  dio1-slew:
+    description: |
+      Sets the slew rate of the DIO1 pin. Defaults to slow if not set.
+    enum:
+      - fast
+      - slow
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ephy0: ethernet-phy@0 {
+        compatible = "ethernet-phy-ieee802.3-c22";
+        reg = <0>;
+        dio0-fn = "gpio";
+        dio0-slew = "slow";
+        dio1-fn = "gpio";
+        dio1-slew = "slow";
+        eni-enable;
+        device_type = "ethernet-phy";
+      };
+    };
-- 
2.40.1


