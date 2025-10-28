Return-Path: <netdev+bounces-233394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84932C12AAD
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77AA74FFE55
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BD0263C91;
	Tue, 28 Oct 2025 02:30:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77547268C73;
	Tue, 28 Oct 2025 02:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761618649; cv=none; b=WgLcjBK9L2hiyl3AhWELJwFTcgZ5JUOGVuut191dMrKS9IFwZJtJNGQDMI9IdOxb34Ua0MxgLsPsmu6yxnKozbQgWQsmAmPFfliq3EWJthulxmRpYZvrTSKUbjlkPDexW7KLEO1j8tNs1GPQt7lLVA4K6cQtZ1yTd8eBRyl4kRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761618649; c=relaxed/simple;
	bh=xu6yXI4+7ybUrFbd9+AD4NTlqekVd8a78X/5OlIsvUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCHyNzb6+qkh7hyF3AyKISVVEvQo0q/41t1hRj/vdXlf3ADmmQb8Zxs+zg1PKlmoCBa3z4pYffy2NHMC75zn8tJljig6Gvem/NVWicU44jWgqj0w57kOhsHWYjIraxCWsMRo/QfqFUDHkxXWi0NGK8ky3KQuWepbe1BbANAmLRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vDZTq-000000006N2-1xQR;
	Tue, 28 Oct 2025 02:30:38 +0000
Date: Tue, 28 Oct 2025 02:30:34 +0000
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
Message-ID: <aQAqynybLOnzvUDn@makrotopia.org>
References: <cover.1761521845.git.daniel@makrotopia.org>
 <cover.1761521845.git.daniel@makrotopia.org>
 <e7a4dadf49c506ff71124166b7ca3009e30d64d8.1761521845.git.daniel@makrotopia.org>
 <e7a4dadf49c506ff71124166b7ca3009e30d64d8.1761521845.git.daniel@makrotopia.org>
 <20251027230439.7zsi3k6da3rohrfo@skbuf>
 <aQADFttLJeUXRyRF@makrotopia.org>
 <20251028013944.lmjboagptxl4dob7@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028013944.lmjboagptxl4dob7@skbuf>

On Tue, Oct 28, 2025 at 03:39:44AM +0200, Vladimir Oltean wrote:
> On Mon, Oct 27, 2025 at 11:41:10PM +0000, Daniel Golle wrote:
> > On Tue, Oct 28, 2025 at 01:04:39AM +0200, Vladimir Oltean wrote:
> > > On Sun, Oct 26, 2025 at 11:45:19PM +0000, Daniel Golle wrote:
> > > > Add support for standard tx-internal-delay-ps and rx-internal-delay-ps
> > > > properties on port nodes to allow fine-tuning of RGMII clock delays.
> > > > 
> > > > The GSWIP switch hardware supports delay values in 500 picosecond
> > > > increments from 0 to 3500 picoseconds, with a default of 2000
> > > > picoseconds for both TX and RX delays.
> > > > 
> > > > This corresponds to the driver changes that allow adjusting MII delays
> > > > using Device Tree properties instead of relying solely on the PHY
> > > > interface mode.
> > > > 
> > > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > > ---
> > > > v3:
> > > >  * redefine ports node so properties are defined actually apply
> > > >  * RGMII port with 2ps delay is 'rgmii-id' mode
> > > > 
> > > >  .../bindings/net/dsa/lantiq,gswip.yaml        | 29 +++++++++++++++++--
> > > >  1 file changed, 26 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > > > index f3154b19af78..b0227b80716c 100644
> > > > --- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > > > +++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > > > @@ -6,8 +6,29 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> > > >  
> > > >  title: Lantiq GSWIP Ethernet switches
> > > >  
> > > > -allOf:
> > > > -  - $ref: dsa.yaml#/$defs/ethernet-ports
> > > > +$ref: dsa.yaml#
> > > > +
> > > > +patternProperties:
> > > > +  "^(ethernet-)?ports$":
> > > > +    type: object
> > > > +    patternProperties:
> > > > +      "^(ethernet-)?port@[0-6]$":
> > > > +        $ref: dsa-port.yaml#
> > > > +        unevaluatedProperties: false
> > > > +
> > > > +        properties:
> > > > +          tx-internal-delay-ps:
> > > > +            enum: [0, 500, 1000, 1500, 2000, 2500, 3000, 3500]
> > > > +            default: 2000
> > > 
> > > No. This is confusing and wrong. I looked at the driver implementation
> > > code, wanting to note that it has the potential of being a breaking
> > > change for device trees without the "tx-internal-delay-ps" and
> > > "rx-internal-delay-ps" properties.
> > > 
> > > But then I saw that the driver implementation is subtly different.
> > > "tx-internal-delay-ps" defaults to 2000 only if "rx-internal-delay-ps" is set, and
> > > "rx-internal-delay-ps" defaults to 2000 only if "tx-internal-delay-ps" is set.
> > > 
> > > So when implemented in this way, it won't cause the regressions I was
> > > concerned about, but it is misrepresented in the schema.
> > > 
> > > Why overcomplicate this and just not set a default? Modify the RX clock
> > > skew if set, and the TX clock skew if set.
> > 
> > The problem is that before adding support for both *-internal-delay-ps
> > properties the internal delays would be set exclusively based on the
> > interface mode -- and are inverted logic:
> > 
> > ```
> >          switch (state->interface) {
> >          case PHY_INTERFACE_MODE_RGMII_ID:
> >                  gswip_mii_mask_pcdu(priv, GSWIP_MII_PCDU_TXDLY_MASK |
> >                                            GSWIP_MII_PCDU_RXDLY_MASK, 0, port);
> >                  break;
> >          case PHY_INTERFACE_MODE_RGMII_RXID:
> >                  gswip_mii_mask_pcdu(priv, GSWIP_MII_PCDU_RXDLY_MASK, 0, port);
> >                  break;
> >          case PHY_INTERFACE_MODE_RGMII_TXID:
> >                  gswip_mii_mask_pcdu(priv, GSWIP_MII_PCDU_TXDLY_MASK, 0, port);
> >                  break;
> >          default:
> >                  break;
> >          }
> > ```
> > 
> > As you can see the delays are set to 0 in case of the interface mode
> > being RGMII_ID (and the same for RGMII_RXID and RGMII_TXID
> > respectively).
> > 
> > This is probably the result of the delays being initialized to 2000ps by
> > default, and if the **PHY connected to the switch port** is set to take
> > care of the clk/data delay then the switch port RGMII interface doesn't
> > have to do it.
> > 
> > From my understanding this is a bit awkward as "internal delay" usually
> > means the delay is taken care of by the PHY rather than by discrete
> > parts of the board design. Here, however, it is *never* part of the
> > board design and always handled by either the switch RGMII interface
> > (MAC side) or the connected PHY.
> > 
> > So in order to not break existing board device trees expecting this
> > behavior I've decided to only fall-back to adjust the delay based on the
> > interface mode in case both properties are missing.
> > 
> > Please correct me if that's the wrong thing to do or if my understanding
> > is flawed in any way.
> 
> Ok, I missed the fact that there's RGMII delay handling outside of
> gswip_mii_delay_setup() too (a bit bizarre).
> 
> So "why overcomplicate this" has a good reason. You have legacy to
> maintain for xrx200, xrx300, xrx330 - essentially the same situation as
> documented in sja1105_parse_rgmii_delays(). But no legacy for the newly
> introduced switches though?  I don't see why you'd opt them into this
> behaviour of applying MAC delays based on phy-mode.

The answer here is also simple: because it would make the common part
of the driver to draw an artificial line between older in-SoC switches
and newer standalone chips, though the RGMII interface itself is
exactly the same and hence part of the lantiq_gswip_common library
module. I know that this reason alone doesn't fly with DT maintainers,
which is why I thought that allowing a modern (ie. using the
{rx,tx}-internal-delay-ps properties) way to set clk vs. data delays
for both new and old hardware would be the best.

Do you think doing an opt-out of the new hardware from this behavior
is worth persuing? (it would obviously make both the bindings as well
as the driver itself more complex in order to achieve that)

> 
> Also, the point still stands that your documented default delay value
> is incorrect. What happens in lack of one property depends on the
> presence of the other, and on the phy-mode. I think deleting the
> default value from the schema is much better than having wrong
> documentation for it.

To me that sounds like a good compromise. The defaults are correct, but
only if at least one of the two properties are present or if the reset
value if kept in case of PHY_INTERFACE_MODE_RGMII (which doesn't zero
either of the delays).

I could also harmonize the situation in the driver by always starting
with the default values selected in the legacy way (ie. based on the
interface mode) and allow overriding that using the modern properties.
Does that sound better than the current behavior?

