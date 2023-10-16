Return-Path: <netdev+bounces-41309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9842D7CA8B5
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 14:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BF21B20AB3
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 12:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C59A2770A;
	Mon, 16 Oct 2023 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFD81CA9A;
	Mon, 16 Oct 2023 12:59:34 +0000 (UTC)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405BAAB;
	Mon, 16 Oct 2023 05:59:33 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1e9bb3a0bfeso2482707fac.3;
        Mon, 16 Oct 2023 05:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697461172; x=1698065972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5qotJcOY/78cW/Hq8ly2JZYukLGnIIJLqd88Irrixs=;
        b=i6cRYJxmSHhfm12r/H+j9ZJZIikXacSIirHZx3plmBek/EK5zvlBkckcTSNEVRIHva
         N3h6jxYRLMBJaUojAqKyxEJFON3g+XqRUCdjQsMZM+RYo6MOhmk/F/LLiiilSYo4EZa6
         TtNcDRMTX6TAUPSu9Gank3g7v6JtqubpEKI0J1dRwzC/FOuI2Zr4WVTu45cNqqh5RSdZ
         A/N5s5jOtGmpBkOpEzN2E+xILliJ9DaAAjWSUyl3MvQFf1K5/uhFbeZ4bjRfb06zG/ec
         +5SMI0Z7F+1HUGAWdafGdbHJa2EsctmyZPAXC/FwFj6TUXR35SXMORvUqxqruVUUNt/+
         Kd9A==
X-Gm-Message-State: AOJu0YwEu8jl18kiU1QZE46kk9Q5AN5g9qsdiP1JjnRA3TnSBnf26fyN
	kz3PLv48TcLtTDMud3wnGQ==
X-Google-Smtp-Source: AGHT+IEf7behtCPf6kQIdc79YQsrkjp7NVEEN3y26qF/FI1LSb60UvAR/VwMDiXcoiEg1g9CuCZFlw==
X-Received: by 2002:a05:6870:128f:b0:1ea:69f6:fe13 with SMTP id 15-20020a056870128f00b001ea69f6fe13mr724547oal.44.1697461172185;
        Mon, 16 Oct 2023 05:59:32 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s6-20020a05687087c600b001dd17c5356dsm985623oam.11.2023.10.16.05.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 05:59:31 -0700 (PDT)
Received: (nullmailer pid 2593748 invoked by uid 1000);
	Mon, 16 Oct 2023 12:59:29 -0000
Date: Mon, 16 Oct 2023 07:59:29 -0500
From: Rob Herring <robh@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Christian Marangi <ansuelsmth@gmail.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/6] dt-bindings: marvell: Rewrite MV88E6xxx
 in schema
Message-ID: <20231016125929.GB2578576-robh@kernel.org>
References: <20231016-marvell-88e6152-wan-led-v3-0-38cd449dfb15@linaro.org>
 <20231016-marvell-88e6152-wan-led-v3-0-38cd449dfb15@linaro.org>
 <20231016-marvell-88e6152-wan-led-v3-1-38cd449dfb15@linaro.org>
 <20231016-marvell-88e6152-wan-led-v3-1-38cd449dfb15@linaro.org>
 <20231016110858.ljvjssqujuesu7kd@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016110858.ljvjssqujuesu7kd@skbuf>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 02:08:58PM +0300, Vladimir Oltean wrote:
> On Mon, Oct 16, 2023 at 11:12:54AM +0200, Linus Walleij wrote:
> > This is an attempt to rewrite the Marvell MV88E6xxx switch bindings
> > in YAML schema.
> > 
> > The current text binding says:
> >   WARNING: This binding is currently unstable. Do not program it into a
> >   FLASH never to be changed again. Once this binding is stable, this
> >   warning will be removed.
> > 
> > Well that never happened before we switched to YAML markup,
> > we can't have it like this, what about fixing the mess?
> 
> Removing that remark seems in order.
> 
> > 
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  .../bindings/net/dsa/marvell,mv88e6xxx.yaml        | 243 +++++++++++++++++++++
> >  .../devicetree/bindings/net/dsa/marvell.txt        | 109 ---------
> >  MAINTAINERS                                        |   2 +-
> >  3 files changed, 244 insertions(+), 110 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
> > new file mode 100644
> > index 000000000000..954db04147f8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
> > @@ -0,0 +1,243 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Marvell MV88E6xxx DSA switch family
> > +
> > +maintainers:
> > +  - Andrew Lunn <andrew@lunn.ch>
> > +
> > +description:
> > +  The Marvell MV88E6xxx switch series has been produced and sold
> > +  by Marvell since at least 2010. The switch has a few compatibles which
> > +  just indicate the base address of the switch, then operating systems
> > +  can investigate switch ID registers to find out which actual version
> > +  of the switch it is dealing with.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - marvell,mv88e6085
> > +          - marvell,mv88e6190
> > +          - marvell,mv88e6250
> > +    description: |
> > +      marvell,mv88e6085: This switch uses base address 0x10.
> > +        This switch and its siblings will be autodetected from
> > +        ID registers found in the switch, so only "marvell,mv88e6085" should be
> > +        specified. This includes the following list of MV88Exxxx switches:
> > +        6085, 6095, 6097, 6123, 6131, 6141, 6161, 6165, 6171, 6172, 6175, 6176,
> > +        6185, 6240, 6320, 6321, 6341, 6350, 6351, 6352
> > +      marvell,mv88e6190: This switch uses base address 0x00.
> > +        This switch and its siblings will be autodetected from
> > +        ID registers found in the switch, so only "marvell,mv88e6190" should be
> > +        specified. This includes the following list of MV88Exxxx switches:
> > +        6190, 6190X, 6191, 6290, 6361, 6390, 6390X
> > +      marvell,mv88e6250: This switch uses base address 0x08 or 0x18.
> > +        This switch and its siblings will be autodetected from
> > +        ID registers found in the switch, so only "marvell,mv88e6250" should be
> > +        specified. This includes the following list of MV88Exxxx switches:
> > +        6220, 6250
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  eeprom-length:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: Set to the length of an EEPROM connected to the switch. Must be
> > +      set if the switch can not detect the presence and/or size of a connected
> > +      EEPROM, otherwise optional.
> > +
> > +  reset-gpios:
> > +    description:
> > +      GPIO to be used to reset the whole device
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    description: The switch provides an external interrupt line, but it is
> > +      not always used by target systems.
> > +    maxItems: 1
> > +
> > +  interrupt-controller:
> > +    description: The switch has an internal interrupt controller used by
> > +      the different sub-blocks.
> > +
> > +  '#interrupt-cells':
> > +    description: The internal interrupt controller only supports triggering
> > +      on active high level interrupts so the second cell must alway be set to
> > +      IRQ_TYPE_LEVEL_HIGH.
> > +    const: 2
> > +
> > +  mdio:
> > +    $ref: /schemas/net/mdio.yaml#
> > +    unevaluatedProperties: false
> > +    description: Marvell MV88E6xxx switches have an varying combination of
> > +    internal and external MDIO buses, in some cases a combined bus that
> > +    can be used both internally and externally. This node is for the
> > +    primary bus, used internally and sometimes also externally.
> > +
> > +  mdio-external:
> > +    $ref: /schemas/net/mdio.yaml#
> > +    unevaluatedProperties: false
> > +    description: Marvell MV88E6xxx switches that have a separate external
> > +      MDIO bus use this port to access external components on the MDIO bus.
> > +
> > +    properties:
> > +      compatible:
> > +        const: marvell,mv88e6xxx-mdio-external
> > +
> > +    required:
> > +      - compatible
> > +
> > +$ref: dsa.yaml#
> > +
> > +patternProperties:
> > +  "^(ethernet-)?ports$":
> > +    type: object
> > +    patternProperties:
> > +      "^(ethernet-)?port@[0-9]+$":
> > +        type: object
> > +        description: Ethernet switch ports
> > +
> > +        $ref: dsa-port.yaml#
> > +
> > +        unevaluatedProperties: false
> > +
> > +oneOf:
> > +  - required:
> > +      - ports
> > +  - required:
> > +      - ethernet-ports
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    mdio {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        switch0: switch@0 {
> 
> ethernet-switch is preferred
> 
> > +            compatible = "marvell,mv88e6085";
> > +            reg = <0>;
> > +            reset-gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
> > +            interrupt-parent = <&gpio0>;
> 
> I don't see interrupt-parent as an accepted property in the schema.
> Should interrupts-extended also be accepted?

Both are implicitly accepted since 'interrupts' is.

Rob

