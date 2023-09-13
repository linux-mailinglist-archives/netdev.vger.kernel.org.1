Return-Path: <netdev+bounces-33543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A81579E6E9
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 13:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5380D28256B
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA541EA66;
	Wed, 13 Sep 2023 11:35:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1FB1E519
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 11:35:32 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44621FC0;
	Wed, 13 Sep 2023 04:35:31 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 235F224000E;
	Wed, 13 Sep 2023 11:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1694604930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WbMwXGk6o+lbYJAjbVb82tnFj2aYuAgarBbBqqRuBPc=;
	b=Z2GShICU3ihvCutupOM5tgMDhIm2mE3jZBu65j1kClIXb2kYp4zA/1kLyRZzGnS+y8zwpF
	i86FO0SJS5yz1RmHw7lK4RftC4V8Zq87sTEDaeW6ujIFLUgkEcgSneHohDugmA/6dXn9M7
	l6ri9KtfyFJDfNZa5xmZdwMi4UJUcKqCk4itn8lqSf4uXjh/hLbvGajBUtR+3uqm8KgPyE
	P0CTMnaxoU9OeECX6sFWp7QiheE76FXBve+lU0I1gknHwXcQtOK6Ujz0RJT34oRYMgMcUy
	ootEQlkXZFAYcTtHnxCsV1YuntvZx6uKdcTZYTyUsvrhINyUHJiJQGJmuJjvIw==
Message-ID: <137fd54d-7d2d-4d0b-a50b-cca69875a814@arinc9.com>
Date: Wed, 13 Sep 2023 14:35:11 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: document internal MDIO bus
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
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
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <0cee0928-74c9-4048-8cd8-70bfbfafd9b2@arinc9.com>
 <20230827121235.zog4c3ehu2cyd3jy@skbuf>
 <676d1a2b-6ffa-4aff-8bed-a749c373f5b3@arinc9.com>
 <87325ce9-595a-4dda-a6a1-b5927d25719b@arinc9.com>
 <20230911225126.rk23g3u3bzo3agby@skbuf>
 <036c0763-f1b2-49ff-bc82-1ff16eec27ab@arinc9.com>
 <20230912193450.h5s6miubag46z623@skbuf>
 <6cec079e-991e-4222-a76d-d6156de0daca@arinc9.com>
 <20230913074231.5azwxqjuv2wp5nik@skbuf>
 <89c9b84c-574c-4071-9524-9207597a3f0a@arinc9.com>
 <20230913110404.co7earmnbzf6hhoe@skbuf>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230913110404.co7earmnbzf6hhoe@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 13.09.2023 14:04, Vladimir Oltean wrote:
> I don't think they're for switch ports only. Any driver which uses
> phylink_fwnode_phy_connect() or its derivatives gets subject to the same
> bindings. But putting the sub-schema in ethernet-controller.yaml makes
> sense, just maybe not naming it "phylink-switch".

Got it. Should we disallow managed altogether when fixed-link is also
defined, or just with in-band-status value?

Currently:

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 9f6a5ccbcefe..3b5946a4be34 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -284,6 +284,21 @@ allOf:
              controllers that have configurable TX internal delays. If this
              property is present then the MAC applies the TX delay.
  
+$defs:
+  phylink:
+    description: phylink bindings for ethernet controllers
+    allOf:
+      - anyOf:
+          - required: [ fixed-link ]
+          - required: [ phy-handle ]
+          - required: [ managed ]
+
+      - if:
+          required: [ fixed-link ]
+        then:
+          properties:
+            managed: false
+
  additionalProperties: true
  
  ...

Arınç

