Return-Path: <netdev+bounces-40549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5F67C7A62
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 01:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877761C2107B
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565A62B5D8;
	Thu, 12 Oct 2023 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKWW41YQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F062B5C0;
	Thu, 12 Oct 2023 23:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176C8C433CA;
	Thu, 12 Oct 2023 23:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697153185;
	bh=qNqWoA/ZDLB/uXCHNS8ySDtf00nZP74HHvVGjttkErQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HKWW41YQy8EqNpNGM+UUKpc+RgJDT9JWw0QCWmqprmhVz5h0QulhwY8JfidW38YWT
	 kreoZcDSL4oFttV2dRMx+v2DuddjZI0/yB/HA2uHlh98EADBUMpH726kyIFwKlvg4x
	 8CJJIb4M1nW0ldfOVGb3I4FZGqr8rxTYWeAizA+4jmaUHuz2CR34yKnN216yLYNO9t
	 Q7yNlM3mwpsje2zZ76/9y5RtJ3YPg6h6oU9IImpklyO1+j1SkUf27tsOCg0D3I3V9j
	 N85228TKgf371oxZ1kXdwAYp8u65FWKwZgXKAWOz/sxsLS4WwyMeuCy+hoGBd4fDD1
	 wm7fzxeKRwjbA==
Received: (nullmailer pid 2140553 invoked by uid 1000);
	Thu, 12 Oct 2023 23:26:23 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Eric Dumazet <edumazet@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Gregory Clement <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Paolo Abeni <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20231013-marvell-88e6152-wan-led-v1-2-0712ba99857c@linaro.org>
References: <20231013-marvell-88e6152-wan-led-v1-0-0712ba99857c@linaro.org>
 <20231013-marvell-88e6152-wan-led-v1-2-0712ba99857c@linaro.org>
Message-Id: <169715318309.2140513.13293051505659071749.robh@kernel.org>
Subject: Re: [PATCH 2/3] RFC: dt-bindings: marvell: Rewrite in schema
Date: Thu, 12 Oct 2023 18:26:23 -0500


On Fri, 13 Oct 2023 00:35:15 +0200, Linus Walleij wrote:
> This is an attempt to rewrite the Marvell MV88E6xxx switch bindings
> in YAML schema.
> 
> The current text binding says:
>   WARNING: This binding is currently unstable. Do not program it into a
>   FLASH never to be changed again. Once this binding is stable, this
>   warning will be removed.
> 
> Well that never happened before we switched to YAML markup,
> we can't have it like this, what about fixing the mess?
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/net/dsa/marvell,mv88e6xxx.yaml        | 249 +++++++++++++++++++++
>  .../devicetree/bindings/net/dsa/marvell.txt        | 109 ---------
>  MAINTAINERS                                        |   2 +-
>  3 files changed, 250 insertions(+), 110 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.example.dtb: switch@0: mdio-external: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.example.dtb: switch@0: Unevaluated properties are not allowed ('mdio-external' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231013-marvell-88e6152-wan-led-v1-2-0712ba99857c@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


