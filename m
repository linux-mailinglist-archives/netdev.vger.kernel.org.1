Return-Path: <netdev+bounces-45543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4D87DE0E4
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 13:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48995281381
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 12:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A169125C0;
	Wed,  1 Nov 2023 12:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d40CEUi4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D9A1848;
	Wed,  1 Nov 2023 12:36:24 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A6CE4;
	Wed,  1 Nov 2023 05:36:20 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c4fe37f166so91987191fa.1;
        Wed, 01 Nov 2023 05:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698842179; x=1699446979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bAjxWab9FuMrPYW8KTN90/drF/opLkjSX2ZaRRk1GLQ=;
        b=d40CEUi4z/DjtLoFJwr0ohhvWdiq6eHdlVIFoaguxR5iwOspnFBgUyptUROcQVqObc
         a48ibU8zV3Lv6RciNCCNXQu4prKmBI450P+E8XktPaIgwdSLqNvJlbsSEA1zcLp5wtLU
         QIUMuBxypk8t/MZtf7OwWM6yeyPjHtdFjDY4xPjuEYzckdBfLC6kagQgrUmkTviZZGh1
         p5AefA4hR4/ww6klJ1opIYTCAJNn2AV7I2cHZgbVOKHlGLC/DL4KsmSNwmdxWO1HSMwi
         0EafUn9ygvDUcaizdDVdD24HvhtjI6BcrRmFdiFyLHJ2ihMDMbIky9ICa3KYYBwZA8kc
         aRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698842179; x=1699446979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAjxWab9FuMrPYW8KTN90/drF/opLkjSX2ZaRRk1GLQ=;
        b=mp4Tzj/kV7g3/Y3kVvztdA33h35YTZmXy0eYvkpq1F98Zs9Jjhxb5t08qovh5lt7qG
         CaRUgpVO6spmjoInEeD1gWQdqFLEDCRa3T7qcRhoCqMdYSjVwGNcKWXUIIuPI7b6PrlQ
         Hfm3W0pujh5ndtwno9aLJ8FtI6eGo161nM3YVtGPPJTvXJNOI4bkXaraNPZgWtdlySNs
         CLI7ceWN1kwiALlkufZfoKmnPZusfAtaBM8SVRU50+VoK74uc7HC0qpBaRfgWHWtdbw/
         WyURcqlGe0P7bUBos8sHBQgETQPfwyabrY4iWP0pboAhPnYoSeU2LIsifbVu1MUgefpU
         5KFQ==
X-Gm-Message-State: AOJu0Yw31A1zHb9zfV1UVMZBLon48eS6gktthEE2kfqjpHfTv1vQgLQF
	ODZwxfkTjhKDG0Al/v28ReQ=
X-Google-Smtp-Source: AGHT+IHcY01/ejAyOcNJcwI0+naqu1Pvlh0ir6PtwLt3lmbU9x6nqmFq55OR+6r4J9inCcFgqvw2sA==
X-Received: by 2002:a2e:2c11:0:b0:2c5:6df:8b2c with SMTP id s17-20020a2e2c11000000b002c506df8b2cmr12290289ljs.45.1698842178449;
        Wed, 01 Nov 2023 05:36:18 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id r6-20020a05600c458600b00405959bbf4fsm1449832wmo.19.2023.11.01.05.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 05:36:17 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v2 2/2] dt-bindings: Document bindings for Marvell Aquantia PHY
Date: Wed,  1 Nov 2023 13:36:08 +0100
Message-Id: <20231101123608.11157-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101123608.11157-1-ansuelsmth@gmail.com>
References: <20231101123608.11157-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document bindings for Marvell Aquantia PHY.

The Marvell Aquantia PHY require a firmware to work correctly and there
at least 3 way to load this firmware.

Describe all the different way and document the binding "firmware-name"
to load the PHY firmware from userspace.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Add DT patch

 .../bindings/net/marvell,aquantia.yaml        | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/marvell,aquantia.yaml

diff --git a/Documentation/devicetree/bindings/net/marvell,aquantia.yaml b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
new file mode 100644
index 000000000000..f2248a81fbe7
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/marvell,aquantia.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/marvell,aquantia.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Aquantia Ethernet PHY
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: |
+  Marvell Aquantia Ethernet PHY require a firmware to be loaded to actually
+  work.
+
+  This can be done and is implemented by OEM in 3 different way:
+    - Attached SPI directly to the PHY with the firmware. The PHY will
+      self load the firmware in the presence of this configuration.
+    - Dedicated partition on system NAND with firmware in it. NVMEM
+      subsystem will be used and the declared NVMEM cell will load
+      the firmware to the PHY using the PHY mailbox interface.
+    - Manually provided firmware using the sysfs interface. Firmware is
+      loaded using the PHY mailbox.
+
+  If declared, nvmem will always take priority over fs provided firmware.
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - ethernet-phy-id03a1.b445
+          - ethernet-phy-id03a1.b460
+          - ethernet-phy-id03a1.b4a2
+          - ethernet-phy-id03a1.b4d0
+          - ethernet-phy-id03a1.b4e0
+          - ethernet-phy-id03a1.b5c2
+          - ethernet-phy-id03a1.b4b0
+          - ethernet-phy-id03a1.b662
+          - ethernet-phy-id03a1.b712
+          - ethernet-phy-id31c3.1c12
+      - const: ethernet-phy-ieee802.3-c45
+
+  reg:
+    maxItems: 1
+
+  firmware-name:
+    description: specify the name of PHY firmware to load
+
+  nvmem-cells:
+    description: phandle to the firmware nvmem cell
+    maxItems: 1
+
+  nvmem-cell-names:
+    const: firmware
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@0 {
+            /*  Only needed to make DT lint tools work. Do not copy/paste
+             *  into real DTS files.
+             */
+            compatible = "ethernet-phy-id31c3.1c12",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <0>;
+            firmware-name = "AQR-G4_v5.4.C-AQR_CIG_WF-1945_0x8_ID44776_VER1630.cld";
+        };
+
+        ethernet-phy@1 {
+            /*  Only needed to make DT lint tools work. Do not copy/paste
+             *  into real DTS files.
+             */
+            compatible = "ethernet-phy-id31c3.1c12",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <0>;
+            nvmem-cells = <&aqr_fw>;
+            nvmem-cell-names = "firmware";
+        };
+    };
+
+    flash {
+        compatible = "jedec,spi-nor";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partitions {
+            compatible = "fixed-partitions";
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            /* ... */
+
+            partition@650000 {
+                compatible = "nvmem-cells";
+                label = "0:ethphyfw";
+                reg = <0x650000 0x80000>;
+                read-only;
+                #address-cells = <1>;
+                #size-cells = <1>;
+
+                aqr_fw: aqr_fw@0 {
+                    reg = <0x0 0x5f42a>;
+                };
+            };
+
+            /* ... */
+
+        };
+    };
-- 
2.40.1


