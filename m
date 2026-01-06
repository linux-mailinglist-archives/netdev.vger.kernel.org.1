Return-Path: <netdev+bounces-247382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C0BCF90FD
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 16:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F38B30111AC
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 15:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFA0345731;
	Tue,  6 Jan 2026 15:22:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2E729BD9A
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712954; cv=none; b=Q4AqPLCV5kyXmIJTbTCsAWoC9xBlkwe6X5rB86PDlvHjcDtGlrUirTOfL/dPGllhW8zHeIib6SDiZUpVtF1KHHxq5ipmX8BQdRd4L/9viDQavBgxGfU71qlb6jNAJVNRMmsb7/zYEKxBbbfX+ejb/JG0oQoFNN2SP9yhic8dNjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712954; c=relaxed/simple;
	bh=lnB1SuFK24iyU1ErIXFxzV0xHOtmPu6m7i52mplXliY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ML8pGfd5Qtdv6de2KLQsuuhGRD41SgLSZQ/th1aOPJvO+/v3wiPNyCnqh3IOuzkoudKWyHcu8CYNsU/NE1d9j+L9lEbyI8/3H/uuIs7RYB7iSByh1sHc7rfoiMT/kBWt53eiPcRwszoKkqpPfghKWKEJsDXriPzv7B7jRoAzuH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vd8t3-0004tk-TA; Tue, 06 Jan 2026 16:22:21 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vd8t3-009Mm0-0u;
	Tue, 06 Jan 2026 16:22:21 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vd8t3-00ELDF-0T;
	Tue, 06 Jan 2026 16:22:21 +0100
Date: Tue, 6 Jan 2026 16:22:21 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Woojung Huh <woojung.huh@microchip.com>,
	"maintainer:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <UNGLinuxDriver@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
	"open list:MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER" <netdev@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev,
	shawnguo@kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: net: dsa: microchip: Make pinctrl
 'reset' optional
Message-ID: <20260106152221.pfhnfndzox4kjqaz@pengutronix.de>
References: <20260106143620.126212-1-Frank.Li@nxp.com>
 <20260106150245.exhf5soqdjv7nkb7@pengutronix.de>
 <aV0nA521iLnxYTVu@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV0nA521iLnxYTVu@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On 26-01-06, Frank Li wrote:
> On Tue, Jan 06, 2026 at 04:02:45PM +0100, Marco Felsch wrote:
> > Hi Frank,
> >
> > thanks for fixing this.
> >
> > On 26-01-06, Frank Li wrote:
> > > Commit e469b87e0fb0d ("dt-bindings: net: dsa: microchip: Add strap
> > > description to set SPI mode") required both 'default' and 'reset' pinctrl
> > > states for all compatible devices. However, this requirement should be only
> > > applicable to KSZ8463.
> > >
> > > Make the 'reset' pinctrl state optional for all other Microchip DSA
> > > devices while keeping it mandatory for KSZ8463.
> > >
> > > Fix below CHECK_DTBS warnings:
> > >   arch/arm64/boot/dts/freescale/imx8mp-skov-basic.dtb: switch@5f (microchip,ksz9893): pinctrl-names: ['default'] is too short
> > > 	from schema $id: http://devicetree.org/schemas/net/dsa/microchip,ksz.yaml#
> > >
> >
> > Fixes tag?
> 
> This one is only fix warning, some maintainer wants add fixes tags only for
> user visualable issue.
> 
> If maintainer want, it can be added when apply, commit hash already in
> commit message.
> 
> >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > > index a8c8009414ae0..8d4a3a9a33fcc 100644
> > > --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > > +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > > @@ -40,6 +40,7 @@ properties:
> > >        - const: reset
> > >          description:
> > >            Used during reset for strap configuration.
> > > +    minItems: 1
> >
> > Does this mean that all others can now either specify 'reset' or
> > 'default'? If yes, this seems wrong.
> 
> No,  It allow that
> 	 case 1: "default"
> 	 case 2: "default", "reset".
> 
> Don't allow 'reset' only.

Ah okay, so it takes the list element-pos. into account, fingers
crossed, that no one is going to change the order :-)

Thanks for the info, with that:

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

> 
> Frank
> 
> >
> > Regards,
> >   Marco
> >
> > >
> > >    reset-gpios:
> > >      description:
> > > @@ -153,6 +154,8 @@ allOf:
> > >              const: microchip,ksz8463
> > >      then:
> > >        properties:
> > > +        pinctrl-names:
> > > +          minItems: 2
> > >          straps-rxd-gpios:
> > >            description:
> > >              RXD0 and RXD1 pins, used to select SPI as bus interface.
> > > --
> > > 2.34.1
> > >
> > >
> >
> > --
> > #gernperDu
> > #CallMeByMyFirstName
> >
> > Pengutronix e.K.                           |                             |
> > Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
> > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

