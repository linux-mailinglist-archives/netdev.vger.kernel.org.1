Return-Path: <netdev+bounces-249620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 022A9D1BA61
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 00:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B4C83027DA4
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 23:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5E932B9A2;
	Tue, 13 Jan 2026 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXcLE4x5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A73A2BEC2E;
	Tue, 13 Jan 2026 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768345549; cv=none; b=SR8L4vW3OfBnSFhtpE+HhZiq1+Xc7BNuHKhzsQDynGY8/P14paZZXnLBqQnNWebIEG6lnfeJMV6X5Glh6WUodwJaoqBaJkfO1HqkH6zjzkLI4xujCY7WXdfrkJ22A2SaJcqfDaZmSoWkv/l8VO/+t7qiv8xfUeCRxQS5YR/FKdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768345549; c=relaxed/simple;
	bh=IJN756o4Hydndhp9CKXhoTUF5hOw+Vbm+VDNTzDl1GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xh1HBi4WJK6JGDPINCYBZc9mLlaCByj/RD5lX+AXsYg8/FFS0KHgoBJmbRN0JpudZj4jEKVNXO1dhzvd1YZEoibGTJ8+r6wDbE4JVWsYAdB7OXiWMgmEZN1SGOjHUfgGZKSKuB4AolmSSIdsXYaCiexOdIMQq7TJRzUQkyXjAEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXcLE4x5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB187C116C6;
	Tue, 13 Jan 2026 23:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768345548;
	bh=IJN756o4Hydndhp9CKXhoTUF5hOw+Vbm+VDNTzDl1GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OXcLE4x5YWgmvDUm6kW7kyxq5gD2BV6JRuhpyPOikmsin313xPcF/5BYyYMUaHhUi
	 1OgfXoFpynaeSESgkvwEWiRf6P1Z5PzumubW6pyxCc9h0X3ib8QCNi2SUX1qJAf8hy
	 +wUtFzpkML7tSfwaNJRqblFQeGPOeNgPFo9GI42rFOJ2TdoaMdWmcBD6JmFudSVBf6
	 WpM4m2PN6Os5lEkLoMk5gIrSeStSV3bMlf6D/ML0wIoayNG+jdO8gkKnF4nUmcn/ip
	 dhRt/++PIRdISmtO8XEIvSpDkEDVnK/paQBfhSd4VL41rkJL6nLyQdia58nlX9E309
	 eIeo/CfKLHuTA==
Date: Tue, 13 Jan 2026 17:05:48 -0600
From: Rob Herring <robh@kernel.org>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: net: micrel: Convert to DT schema
Message-ID: <20260113230548.GA392296-robh@kernel.org>
References: <20260108125208.29940-1-eichest@gmail.com>
 <20260108125208.29940-2-eichest@gmail.com>
 <20260108184845.GA758009-robh@kernel.org>
 <aWC6e9N0rJt1JHsw@eichest-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWC6e9N0rJt1JHsw@eichest-laptop>

On Fri, Jan 09, 2026 at 09:21:15AM +0100, Stefan Eichenberger wrote:
> On Thu, Jan 08, 2026 at 12:48:45PM -0600, Rob Herring wrote:
> > On Thu, Jan 08, 2026 at 01:51:27PM +0100, Stefan Eichenberger wrote:
> > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > 
> > > Convert the devicetree bindings for the Micrel PHYs and switches to DT
> > > schema.
> > > 
> > > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > ---
> > >  .../devicetree/bindings/net/micrel.txt        |  57 --------
> > >  .../devicetree/bindings/net/micrel.yaml       | 133 ++++++++++++++++++
> > >  2 files changed, 133 insertions(+), 57 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/net/micrel.txt
> > >  create mode 100644 Documentation/devicetree/bindings/net/micrel.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/net/micrel.txt b/Documentation/devicetree/bindings/net/micrel.txt
> > > deleted file mode 100644
> > > index 01622ce58112..000000000000
> > > --- a/Documentation/devicetree/bindings/net/micrel.txt
> > > +++ /dev/null
> > > @@ -1,57 +0,0 @@
> > > -Micrel PHY properties.
> > > -
> > > -These properties cover the base properties Micrel PHYs.
> > > -
> > > -Optional properties:
> > > -
> > > - - micrel,led-mode : LED mode value to set for PHYs with configurable LEDs.
> > > -
> > > -	Configure the LED mode with single value. The list of PHYs and the
> > > -	bits that are currently supported:
> > > -
> > > -	KSZ8001: register 0x1e, bits 15..14
> > > -	KSZ8041: register 0x1e, bits 15..14
> > > -	KSZ8021: register 0x1f, bits 5..4
> > > -	KSZ8031: register 0x1f, bits 5..4
> > > -	KSZ8051: register 0x1f, bits 5..4
> > > -	KSZ8081: register 0x1f, bits 5..4
> > > -	KSZ8091: register 0x1f, bits 5..4
> > > -	LAN8814: register EP5.0, bit 6
> > > -
> > > -	See the respective PHY datasheet for the mode values.
> > > -
> > > - - micrel,rmii-reference-clock-select-25-mhz: RMII Reference Clock Select
> > > -						bit selects 25 MHz mode
> > > -
> > > -	Setting the RMII Reference Clock Select bit enables 25 MHz rather
> > > -	than 50 MHz clock mode.
> > > -
> > > -	Note that this option is only needed for certain PHY revisions with a
> > > -	non-standard, inverted function of this configuration bit.
> > > -	Specifically, a clock reference ("rmii-ref" below) is always needed to
> > > -	actually select a mode.
> > > -
> > > - - clocks, clock-names: contains clocks according to the common clock bindings.
> > > -
> > > -	supported clocks:
> > > -	- KSZ8021, KSZ8031, KSZ8081, KSZ8091: "rmii-ref": The RMII reference
> > > -	  input clock. Used to determine the XI input clock.
> > > -
> > > - - micrel,fiber-mode: If present the PHY is configured to operate in fiber mode
> > > -
> > > -	Some PHYs, such as the KSZ8041FTL variant, support fiber mode, enabled
> > > -	by the FXEN boot strapping pin. It can't be determined from the PHY
> > > -	registers whether the PHY is in fiber mode, so this boolean device tree
> > > -	property can be used to describe it.
> > > -
> > > -	In fiber mode, auto-negotiation is disabled and the PHY can only work in
> > > -	100base-fx (full and half duplex) modes.
> > > -
> > > - - coma-mode-gpios: If present the given gpio will be deasserted when the
> > > -		    PHY is probed.
> > > -
> > > -	Some PHYs have a COMA mode input pin which puts the PHY into
> > > -	isolate and power-down mode. On some boards this input is connected
> > > -	to a GPIO of the SoC.
> > > -
> > > -	Supported on the LAN8814.
> > > diff --git a/Documentation/devicetree/bindings/net/micrel.yaml b/Documentation/devicetree/bindings/net/micrel.yaml
> > > new file mode 100644
> > > index 000000000000..52d1b187e1d3
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/net/micrel.yaml
> > > @@ -0,0 +1,133 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/net/micrel.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Micrel KSZ series PHYs and switches
> > > +
> > > +maintainers:
> > > +  - Andrew Lunn <andrew@lunn.ch>
> > > +  - Stefan Eichenberger <eichest@gmail.com>
> > > +
> > > +description:
> > > +  The Micrel KSZ series contains different network phys and switches.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - ethernet-phy-id000e.7237  # KSZ8873MLL
> > > +      - ethernet-phy-id0022.1430  # KSZ886X
> > > +      - ethernet-phy-id0022.1435  # KSZ8863
> > > +      - ethernet-phy-id0022.1510  # KSZ8041
> > > +      - ethernet-phy-id0022.1537  # KSZ8041RNLI
> > > +      - ethernet-phy-id0022.1550  # KSZ8051
> > > +      - ethernet-phy-id0022.1555  # KSZ8021
> > > +      - ethernet-phy-id0022.1556  # KSZ8031
> > > +      - ethernet-phy-id0022.1560  # KSZ8081, KSZ8091
> > > +      - ethernet-phy-id0022.1570  # KSZ8061
> > > +      - ethernet-phy-id0022.161a  # KSZ8001
> > > +      - ethernet-phy-id0022.1720  # KS8737
> > > +
> > > +  micrel,fiber-mode:
> > > +    type: boolean
> > > +    description: |
> > > +      If present the PHY is configured to operate in fiber mode.
> > > +
> > > +      The KSZ8041FTL variant supports fiber mode, enabled by the FXEN
> > > +      boot strapping pin. It can't be determined from the PHY registers
> > > +      whether the PHY is in fiber mode, so this boolean device tree
> > > +      property can be used to describe it.
> > > +
> > > +      In fiber mode, auto-negotiation is disabled and the PHY can only
> > > +      work in 100base-fx (full and half duplex) modes.
> > > +
> > > +  micrel,led-mode:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: |
> > > +      LED mode value to set for PHYs with configurable LEDs.
> > > +
> > > +      Configure the LED mode with single value. The list of PHYs and the
> > > +      bits that are currently supported:
> > > +
> > > +      KSZ8001: register 0x1e, bits 15..14
> > > +      KSZ8041: register 0x1e, bits 15..14
> > > +      KSZ8021: register 0x1f, bits 5..4
> > > +      KSZ8031: register 0x1f, bits 5..4
> > > +      KSZ8051: register 0x1f, bits 5..4
> > > +      KSZ8081: register 0x1f, bits 5..4
> > > +      KSZ8091: register 0x1f, bits 5..4
> > > +
> > > +      See the respective PHY datasheet for the mode values.
> > > +    minimum: 0
> > > +    maximum: 3
> > > +
> > > +allOf:
> > > +  - $ref: ethernet-phy.yaml#
> > > +  - if:
> > > +      not:
> > > +        properties:
> > > +          compatible:
> > > +            contains:
> > > +              const: ethernet-phy-id0022.1510
> > > +    then:
> > > +      properties:
> > > +        micrel,fiber-mode: false
> > > +  - if:
> > > +      not:
> > > +        properties:
> > > +          compatible:
> > > +            contains:
> > > +              enum:
> > > +                - ethernet-phy-id0022.1510
> > > +                - ethernet-phy-id0022.1555
> > > +                - ethernet-phy-id0022.1556
> > > +                - ethernet-phy-id0022.1550
> > > +                - ethernet-phy-id0022.1560
> > > +                - ethernet-phy-id0022.161a
> > > +    then:
> > > +      properties:
> > > +        micrel,led-mode: false
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - ethernet-phy-id0022.1555
> > > +              - ethernet-phy-id0022.1556
> > > +              - ethernet-phy-id0022.1560
> > > +    then:
> > > +      properties:
> > > +        clocks:
> > > +          maxItems: 1
> > 
> > This has no effect because ethernet-phy.yaml already defines this.
> 
> Thanks for the info. That means I would only set the clock-names and
> remove maxItems. I will fix that in the next version.
> 
> > > +        clock-names:
> > > +          const: rmii-ref
> > > +          description:
> > > +            The RMII reference input clock. Used to determine the XI input
> > > +            clock.
> > > +        micrel,rmii-reference-clock-select-25-mhz:
> > > +          type: boolean
> > > +          description: |
> > > +            RMII Reference Clock Select bit selects 25 MHz mode
> > > +
> > > +            Setting the RMII Reference Clock Select bit enables 25 MHz rather
> > > +            than 50 MHz clock mode.
> > 
> > These should be defined at the top-level. Then use the if/then schema to 
> > disallow the properties.
> 
> The problem with this approach is, that because it has clock in its
> name, the DT schema valdiator will complain:
> devicetree/bindings/net/micrel.yaml: properties:micrel,rmii-reference-clock-select-25-mhz: 'anyOf' conditional failed, one must be fixed:
>         'maxItems' is a required property
>                 hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
>         'type' is not one of ['maxItems', 'description', 'deprecated']
>                 hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
>         Additional properties are not allowed ('type' was unexpected)
>                 hint: Arrays must be described with a combination of minItems/maxItems/items
>         'type' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
>         hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
>         from schema $id: http://devicetree.org/meta-schemas/cell.yaml
> 
> I couldn't find another way to define that Boolean type at top level. Is
> there an option to make the validator happy?

Ah, because it collides with the standard -mhz unit suffix...

Using '$ref: /schemas/types.yaml#/definitions/flag' instead of 'type: 
boolean' might happen to work. If not, just leave it as-is.

Rob

