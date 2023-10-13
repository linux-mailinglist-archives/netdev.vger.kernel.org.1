Return-Path: <netdev+bounces-40711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB707C85F8
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 14:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519621F21125
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 12:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3600C1119F;
	Fri, 13 Oct 2023 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Sl/UoMzL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2147D279;
	Fri, 13 Oct 2023 12:43:19 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC1B91;
	Fri, 13 Oct 2023 05:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fPquRdX+fyaXxcACERQp1ldJLvmp6A1Oj12yYYIMkoM=; b=Sl/UoMzLoDOWtNKjOlu/f0ns0S
	/BHqoWpqfH9f1sEuGuvowgltG3yVND2t4/0s7/JgQtRJdXHA2t5Tu88q0nKQqKpX+SF2ILZY4tg9f
	dFDROcdQ1FoqHvxHAcnyKTWmcONwhdycPJoyTNHJdGgT7DcMVVc+XUYs7fzg0QnEn1kU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qrHVU-0025g3-A6; Fri, 13 Oct 2023 14:43:08 +0200
Date: Fri, 13 Oct 2023 14:43:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] RFC: dt-bindings: marvell: Rewrite in schema
Message-ID: <d971d7c1-c6b5-44a4-81cf-4f634e760e87@lunn.ch>
References: <20231013-marvell-88e6152-wan-led-v1-0-0712ba99857c@linaro.org>
 <20231013-marvell-88e6152-wan-led-v1-2-0712ba99857c@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013-marvell-88e6152-wan-led-v1-2-0712ba99857c@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - marvell,mv88e6060

The 6060 is a separate driver. Its not part of mv88e6xxx. So it should
have a binding document of its own.

> +  '#interrupt-cells':
> +    description: The internal interrupt controller only supports triggering
> +      on IRQ_TYPE_LEVEL_HIGH
> +      # FIXME: what is this? this should be one cell should it not?
> +      # the Linux mv88e6xxx driver does not implement .irq_set_type in its irq_chip
> +      # so at least in that implementation the type is flat out ignored.
> +    const: 2

This interrupt controller is for the embedded PHYs. Its is hard wired
active high.

> +  mdio-external:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +    description: Marvell MV88E6xxx switches have an external mdio bus to
> +      access switch ports.

This is used to access external PHYs attached to the ports, not the
ports themselves.

> +
> +  mdio1:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +    description: Older version of mdio-external
> +    deprecated: true
> +    properties:
> +      compatible:
> +        const: marvell,mv88e6xxx-mdio-external

The driver only looks at the compatible. It does not care what the
node is called. So you are going to need to change the driver if you
want this in the schema.

     Andrew

