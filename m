Return-Path: <netdev+bounces-233331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BC5C12142
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 00:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10781421709
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 23:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC88032D0F9;
	Mon, 27 Oct 2025 23:41:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60CA39ACF;
	Mon, 27 Oct 2025 23:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761608486; cv=none; b=JPaneRDXYx+RKSkbHJPY05y64km6eidg4A+FgDfYjdF00WNF5UVrEuSuSp0qRJ+0t7QDPonAKqNQVi9yWr6aMRrO8bMmT1XQzc1vLwAZI/bcsLWi2H4RSG1m+nujKh+/6KuY+uAkemlx9wQ4eahIoVvJTf2jBrmEB0HEUlFj6K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761608486; c=relaxed/simple;
	bh=32fYWnaIMPU9AkYqGR9xgWgNQ7QLYLvhQjbl9a1CEps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rALs5pvlFJP04uj0Vc/slH6005g3B6EGx7PYa7gYQx91fypiORb4bvSz73Ugfip5RTE1tEXhYonriHXK1n105eWO/kH4M0S4tgd9BA2fgztP5OnQZPBp3ec1W42PDA27qbH6b4YMmZ90nZj6LgB3YFA3Br676q0GvtyvC+bTKbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vDWpt-000000005gg-3ylV;
	Mon, 27 Oct 2025 23:41:14 +0000
Date: Mon, 27 Oct 2025 23:41:10 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v3 06/12] dt-bindings: net: dsa: lantiq,gswip:
 add support for MII delay properties
Message-ID: <aQADFttLJeUXRyRF@makrotopia.org>
References: <cover.1761521845.git.daniel@makrotopia.org>
 <cover.1761521845.git.daniel@makrotopia.org>
 <e7a4dadf49c506ff71124166b7ca3009e30d64d8.1761521845.git.daniel@makrotopia.org>
 <e7a4dadf49c506ff71124166b7ca3009e30d64d8.1761521845.git.daniel@makrotopia.org>
 <20251027230439.7zsi3k6da3rohrfo@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027230439.7zsi3k6da3rohrfo@skbuf>

On Tue, Oct 28, 2025 at 01:04:39AM +0200, Vladimir Oltean wrote:
> On Sun, Oct 26, 2025 at 11:45:19PM +0000, Daniel Golle wrote:
> > Add support for standard tx-internal-delay-ps and rx-internal-delay-ps
> > properties on port nodes to allow fine-tuning of RGMII clock delays.
> > 
> > The GSWIP switch hardware supports delay values in 500 picosecond
> > increments from 0 to 3500 picoseconds, with a default of 2000
> > picoseconds for both TX and RX delays.
> > 
> > This corresponds to the driver changes that allow adjusting MII delays
> > using Device Tree properties instead of relying solely on the PHY
> > interface mode.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> > v3:
> >  * redefine ports node so properties are defined actually apply
> >  * RGMII port with 2ps delay is 'rgmii-id' mode
> > 
> >  .../bindings/net/dsa/lantiq,gswip.yaml        | 29 +++++++++++++++++--
> >  1 file changed, 26 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > index f3154b19af78..b0227b80716c 100644
> > --- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > +++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > @@ -6,8 +6,29 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  
> >  title: Lantiq GSWIP Ethernet switches
> >  
> > -allOf:
> > -  - $ref: dsa.yaml#/$defs/ethernet-ports
> > +$ref: dsa.yaml#
> > +
> > +patternProperties:
> > +  "^(ethernet-)?ports$":
> > +    type: object
> > +    patternProperties:
> > +      "^(ethernet-)?port@[0-6]$":
> > +        $ref: dsa-port.yaml#
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          tx-internal-delay-ps:
> > +            enum: [0, 500, 1000, 1500, 2000, 2500, 3000, 3500]
> > +            default: 2000
> 
> No. This is confusing and wrong. I looked at the driver implementation
> code, wanting to note that it has the potential of being a breaking
> change for device trees without the "tx-internal-delay-ps" and
> "rx-internal-delay-ps" properties.
> 
> But then I saw that the driver implementation is subtly different.
> "tx-internal-delay-ps" defaults to 2000 only if "rx-internal-delay-ps" is set, and
> "rx-internal-delay-ps" defaults to 2000 only if "tx-internal-delay-ps" is set.
> 
> So when implemented in this way, it won't cause the regressions I was
> concerned about, but it is misrepresented in the schema.
> 
> Why overcomplicate this and just not set a default? Modify the RX clock
> skew if set, and the TX clock skew if set.

The problem is that before adding support for both *-internal-delay-ps
properties the internal delays would be set exclusively based on the
interface mode -- and are inverted logic:

```
         switch (state->interface) {
         case PHY_INTERFACE_MODE_RGMII_ID:
                 gswip_mii_mask_pcdu(priv, GSWIP_MII_PCDU_TXDLY_MASK |
                                           GSWIP_MII_PCDU_RXDLY_MASK, 0, port);
                 break;
         case PHY_INTERFACE_MODE_RGMII_RXID:
                 gswip_mii_mask_pcdu(priv, GSWIP_MII_PCDU_RXDLY_MASK, 0, port);
                 break;
         case PHY_INTERFACE_MODE_RGMII_TXID:
                 gswip_mii_mask_pcdu(priv, GSWIP_MII_PCDU_TXDLY_MASK, 0, port);
                 break;
         default:
                 break;
         }
```

As you can see the delays are set to 0 in case of the interface mode
being RGMII_ID (and the same for RGMII_RXID and RGMII_TXID
respectively).

This is probably the result of the delays being initialized to 2000ps by
default, and if the **PHY connected to the switch port** is set to take
care of the clk/data delay then the switch port RGMII interface doesn't
have to do it.

From my understanding this is a bit awkward as "internal delay" usually
means the delay is taken care of by the PHY rather than by discrete
parts of the board design. Here, however, it is *never* part of the
board design and always handled by either the switch RGMII interface
(MAC side) or the connected PHY.

So in order to not break existing board device trees expecting this
behavior I've decided to only fall-back to adjust the delay based on the
interface mode in case both properties are missing.

Please correct me if that's the wrong thing to do or if my understanding
is flawed in any way.

