Return-Path: <netdev+bounces-41038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D91D7C9654
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 22:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24355281D2A
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 20:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80683262BD;
	Sat, 14 Oct 2023 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j1ijFjZu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF362374F
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 20:51:42 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EC9DE
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 13:51:40 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50308217223so3839959e87.3
        for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 13:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697316698; x=1697921498; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83tifkcL7STtWqxT7Toe1m2iOWJK+NJCvD/bs0pj7pU=;
        b=j1ijFjZuWa7QSevQlo1UNJE+HKtRD/d/rV3z56eHi6J7AnTobWDxl+P7YVkvRspxjG
         eXCQg/XErekoeFbFcUUL7GIg9XjazhEkCwdwCgbVP/SJaGzzXDPEQSd5+nhAnnbVPCIQ
         wZi2aJS9LQdIpVUmniUHihIrVmAqomzEwwaKPkfbOHWPZDwSuS94qIBQmuyqQO6Z8C2C
         CuVbRLIww0VgdDoG4lhVZeFACi4QKb1T5BVQG18abkXROKWcQRZeRajOM7SldOsl0S4r
         0ZDPVJ4uoIh06s1Kzau9b8/ESjfHhcBtkitm2nzbinGrL9Oc4lTfBibNHn5Xd4dQQ/8j
         OPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697316698; x=1697921498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83tifkcL7STtWqxT7Toe1m2iOWJK+NJCvD/bs0pj7pU=;
        b=ArTO4IPLbN3o+PxIuxkmK9nmjLLjjXdBnAW8jef6ZXcO96rHa/zjTuCX3kkhj0RYAr
         u3876DUDw7yFCgtW5RjJd30U27vmYWEmBN27AENMXESW5ISXrEfOt2ah8KVUAzRD2P+s
         bNm9N9bfYkq+zM5WTG8uBxJmpkqqdjHmmo7U32EwrKKjHHb+2ggykRcFVdXet9lD2KZ2
         aPw3LuwMpPLoAB3N1FlejXgrRS5LfpHQlCKp1K/LcbvBk0eurlT4HQNCQ91crrFlK3TW
         XNIt9yd6k8okN5IlS45/7wWiYVGITVxcswXJVb2VMeOu5ALtvSP/Nhvgp63uJGX49hPp
         tnnw==
X-Gm-Message-State: AOJu0YzfkL13yZh++ndIuw37b30XFw+obPyffAj5DUlr0bA4cUwAWGLV
	fqd2ts5ijbEJoMNPpPlnBH/Nkg==
X-Google-Smtp-Source: AGHT+IHFr/VAVKK4SuDqlJGBmO5soHuX301jwXaHnqV1V+ZBJoGsixdCBVKtlESDOjoGWehemW8ulQ==
X-Received: by 2002:a05:6512:1153:b0:4fb:7559:aea3 with SMTP id m19-20020a056512115300b004fb7559aea3mr30227904lfg.39.1697316698352;
        Sat, 14 Oct 2023 13:51:38 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id o17-20020ac24e91000000b004ff96c09b47sm49926lfr.260.2023.10.14.13.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 13:51:37 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 14 Oct 2023 22:51:33 +0200
Subject: [PATCH net-next v2 2/5] dt-bindings: marvell: Add Marvell
 MV88E6060 DSA schema
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231014-marvell-88e6152-wan-led-v2-2-7fca08b68849@linaro.org>
References: <20231014-marvell-88e6152-wan-led-v2-0-7fca08b68849@linaro.org>
In-Reply-To: <20231014-marvell-88e6152-wan-led-v2-0-7fca08b68849@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The Marvell MV88E6060 is one of the oldest DSA switches from
Marvell, and it has DT bindings used in the wild. Let's define
them properly.

It is different enough from the rest of the MV88E6xxx switches
that it deserves its own binding.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/net/dsa/marvell,mv88e6060.yaml        | 106 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 107 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6060.yaml b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6060.yaml
new file mode 100644
index 000000000000..74e546a8472c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6060.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6060.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell MV88E6060 DSA switch
+
+maintainers:
+  - Andrew Lunn <andrew@lunn.ch>
+
+description:
+  The Marvell MV88E6060 switch has been produced and sold by Marvell
+  since at least 2010. The switch has one pin ADDR4 that controls the
+  MDIO address of the switch to be 0x10 or 0x00, and on the MDIO bus
+  connected to the switch, the PHY:s inside the switch appear as
+  independent devices on address 0x00-0x04 or 0x10-0x14, so in difference
+  from many other DSA switches this switch does not have an internal
+  MDIO bus for the PHY devices.
+
+properties:
+  compatible:
+    const: marvell,mv88e6060
+    description:
+      The MV88E6060 is the oldest Marvell DSA switch product, and
+      as such a bit limited in features compared to later hardware.
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      GPIO to be used to reset the whole device
+    maxItems: 1
+
+$ref: dsa.yaml#
+
+patternProperties:
+  "^(ethernet-)?ports$":
+    type: object
+    patternProperties:
+      "^(ethernet-)?port@[0-9]+$":
+        type: object
+        description: Ethernet switch ports
+
+        $ref: dsa-port.yaml#
+
+        unevaluatedProperties: false
+
+oneOf:
+  - required:
+      - ports
+  - required:
+      - ethernet-ports
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        switch@16 {
+            compatible = "marvell,mv88e6060";
+            reg = <16>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    label = "lan1";
+                };
+                port@1 {
+                    reg = <1>;
+                    label = "lan2";
+                };
+                port@2 {
+                    reg = <2>;
+                    label = "lan3";
+                };
+                port@3 {
+                    reg = <3>;
+                    label = "lan4";
+                };
+                port@5 {
+                    reg = <5>;
+                    phy-mode = "rgmii-id";
+                    ethernet = <&ethc>;
+                    label = "cpu";
+                    fixed-link {
+                        speed = <100>;
+                        full-duplex;
+                    };
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 1b4475254d27..4c933a2a56ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12625,6 +12625,7 @@ MARVELL 88E6XXX ETHERNET SWITCH FABRIC DRIVER
 M:	Andrew Lunn <andrew@lunn.ch>
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/dsa/marvell,mv88e6060.yaml
 F:	Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
 F:	Documentation/networking/devlink/mv88e6xxx.rst
 F:	drivers/net/dsa/mv88e6xxx/

-- 
2.34.1


