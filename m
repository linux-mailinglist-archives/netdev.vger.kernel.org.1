Return-Path: <netdev+bounces-27058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAC177A105
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 18:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98A21C20908
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 16:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626998470;
	Sat, 12 Aug 2023 16:28:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5371D79FC
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 16:28:15 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA121BEE;
	Sat, 12 Aug 2023 09:28:13 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A51C20002;
	Sat, 12 Aug 2023 16:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1691857692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=38WNKp1tIHZuWDWyB1VGwPuC9C9gEwniYXC3BCan83U=;
	b=btMVtgRqMyn/AKspRKynx1G2Dg6YT82EWik4KPC2lQZOo2oqPltopNdfNbwNV0UyqDhE57
	rr5W7V6PXFcb21pzwX6pidCTc59c5yFAQEzbd8HiPS7Qlt5c47y5gwn3qqmcymz1ZBFWLb
	gn4zfwmCj73tskoy7Zo0DZ7YEWXa1l7EMjaYIeF1/yHKlzXmNEbthAZb2fuGS4ne+9fhuP
	vRxUE52SRldB0IBCiLxjw2eC3p4o39sQD0Us2JJ8zo5aCkBeFtuqkoYz36g9U20Ew+zYxD
	DQuA9Serq/WreUiX/0ilFqR/G95g9WzbLkrtZKdjy+lnp/sBSEB27QOHtuPoAA==
Message-ID: <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
Date: Sat, 12 Aug 2023 19:28:02 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: document internal MDIO bus
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, Linus Walleij <linus.walleij@linaro.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Daniel Golle <daniel@makrotopia.org>, Landen Chao
 <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-3-arinc.unal@arinc9.com>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230812091708.34665-3-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I changed this to below. I will wait for reviews before submitting v2.

The realtek.yaml schema extends the mdio.yaml schema. The mdio.yaml schema
is also being referred to through dsa.yaml#/$defs/ethernet-ports now which
means we cannot disallow additional properties by 'unevaluatedProperties:
false' on the dsa.yaml schema.

On the realtek.yaml schema, refer to dsa.yaml#/properties/mdio instead to
point the human readers to the description on the dsa.yaml schema.

diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
index ec74a660beda..03ccedbc49dc 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
@@ -31,6 +31,24 @@ properties:
        (single device hanging off a CPU port) must not specify this property
      $ref: /schemas/types.yaml#/definitions/uint32-array
  
+  mdio:
+    description: The internal MDIO bus of the switch
+    $ref: /schemas/net/mdio.yaml#
+
+if:
+  required: [ mdio ]
+then:
+  patternProperties:
+    "^(ethernet-)?ports$":
+      patternProperties:
+        "^(ethernet-)?port@[0-9]+$":
+          if:
+            not:
+              required: [ ethernet ]
+          then:
+            required:
+              - phy-handle
+
  additionalProperties: true
  
  $defs:
diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
index cfd69c2604ea..f4b4fe0509a0 100644
--- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
@@ -96,7 +96,7 @@ properties:
        - '#interrupt-cells'
  
    mdio:
-    $ref: /schemas/net/mdio.yaml#
+    $ref: dsa.yaml#/properties/mdio
      unevaluatedProperties: false
  
      properties:

Arınç

