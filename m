Return-Path: <netdev+bounces-233371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED12CC128AA
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26D3C4EF11E
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E6B2248B9;
	Tue, 28 Oct 2025 01:27:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875E51F3BAC;
	Tue, 28 Oct 2025 01:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761614875; cv=none; b=lQdN7rN6hZ5gwdMyWTQ/Ll1YEUsRYESoIpvdvJjf9shFXhIJ6fbgHFP1y1+9pUD39pRRgc5eWjPu612FSzSNCG7U5E7VHYY3yzvqCBxooJM956K790/rsqC5r6tlFNn9Gn72PR8PHdrWUen1c/fRvP7NgviFdVjJ79uhZkF+mVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761614875; c=relaxed/simple;
	bh=+xOOGvn43/VAMLY95I2MsreauEqB7OYAIu7MB39DSrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cs1ma0nUzF8FCLapQAUmjAYMxT+18ug5RGyAHDoLiLh3OlBjEW1k1giNrGzKhQeGSPWrv8+vXLQTDTQ4oQdV0bUy8N6d/8PC6K6wwMLbmHvAElKPryWkRyqXpakWvdV66NrX8EF5h4EFrI5u+OtHFXUD8Q1SzarVWq5pxAMdHFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vDYUy-0000000068J-2gMM;
	Tue, 28 Oct 2025 01:27:44 +0000
Date: Tue, 28 Oct 2025 01:27:39 +0000
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
Subject: Re: [PATCH net-next v3 10/12] dt-bindings: net: dsa: lantiq,gswip:
 add support for MaxLinear GSW1xx switches
Message-ID: <aQAcC3lj5G_uoXPd@makrotopia.org>
References: <cover.1761521845.git.daniel@makrotopia.org>
 <cover.1761521845.git.daniel@makrotopia.org>
 <f07c15befb17573ca50e507156892b067a25ee2c.1761521845.git.daniel@makrotopia.org>
 <f07c15befb17573ca50e507156892b067a25ee2c.1761521845.git.daniel@makrotopia.org>
 <20251028000959.3kiac5kwo5pcl4ft@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028000959.3kiac5kwo5pcl4ft@skbuf>

On Tue, Oct 28, 2025 at 02:09:59AM +0200, Vladimir Oltean wrote:
> On Sun, Oct 26, 2025 at 11:48:06PM +0000, Daniel Golle wrote:
> > Extend the Lantiq GSWIP device tree binding to also cover MaxLinear
> > GSW1xx switches which are based on the same hardware IP but connected
> > via MDIO instead of being memory-mapped.
> > 
> > Add compatible strings for MaxLinear GSW120, GSW125, GSW140, GSW141,
> > and GSW145 switches and adjust the schema to handle the different
> > connection methods with conditional properties.
> > 
> > Add MaxLinear GSW125 example showing MDIO-connected configuration.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> > v3:
> >  * add maxlinear,rx-inverted and maxlinear,tx-inverted properties
> > 
> > v2:
> >  * remove git conflict left-overs which somehow creeped in
> >  * indent example with 4 spaces instead of tabs
> > 
> >  .../bindings/net/dsa/lantiq,gswip.yaml        | 275 +++++++++++++-----
> >  1 file changed, 202 insertions(+), 73 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > index dd3858bad8ca..1148fdd0b6bc 100644
> > --- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > +++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > @@ -4,7 +4,12 @@
> >  $id: http://devicetree.org/schemas/net/dsa/lantiq,gswip.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  
> > -title: Lantiq GSWIP Ethernet switches
> > +title: Lantiq GSWIP and MaxLinear GSW1xx Ethernet switches
> > +
> > +description:
> > +  Lantiq GSWIP and MaxLinear GSW1xx switches share the same hardware IP.
> > +  Lantiq switches are embedded in SoCs and accessed via memory-mapped I/O,
> > +  while MaxLinear switches are standalone ICs connected via MDIO.
> >  
> >  $ref: dsa.yaml#
> >  
> > @@ -34,6 +39,108 @@ patternProperties:
> >              description:
> >                Configure the RMII reference clock to be a clock output
> >                rather than an input. Only applicable for RMII mode.
> > +          maxlinear,rx-inverted:
> > +            type: boolean
> > +            description:
> > +              Enable RX polarity inversion for SerDes port.
> > +          maxlinear,tx-inverted:
> > +            type: boolean
> > +            description:
> > +              Enable TX polarity inversion for SerDes port.
> 
> How urgently do you need these two properties? They are truly general,
> not vendor-specific, and while I wanted to add such support to the
> Synopsys XPCS, I started working on some generic variants.

Inverting the RX inversion is required for the MaxLinear GSW145 demo
board I got which got an MxL86111 PHY wired to the SGMII port of the
switch. That's why I had to implement at least that in order to be able
to test the SerDes port.

> There's some cleanup and consolidation to do. "st,pcie-tx-pol-inv" and
> "st,sata-tx-pol-inv" are defined in .txt bindings but not implemented.
> Then we have "st,px_rx_pol_inv" and "mediatek,pnswap" which would also
> need deprecating and converted to the new formats.

Sounds like a good plan, I'm all for it :)

> 
> Where I left things was that I haven't decided if there's any value in
> defining the polarity per SerDes protocol (like
> Documentation/devicetree/bindings/phy/transmit-amplitude.yaml) or if a
> global value is fine. I.e. if the polarity is inverted for SATA, it's
> normal for PCIe, or something like that. The existence of the independent
> "st,pcie-tx-pol-inv" and "st,sata-tx-pol-inv" properties would suggest
> yes, but the lack of an implementation casts some doubt on that.
> 
> Anyway, I do have some prototype patches that add something like this:
> 
>     phy: phy {
>       #phy-cells = <1>;
>       tx-p2p-microvolt = <915000>, <1100000>, <1200000>;
>       tx-p2p-microvolt-names = "2500base-x", "usb-hs", "usb-ss";
> 
>       /* RX polarity is inverted for usb-hs, normal for usb-ss */
>       rx-polarity = <PHY_POL_INVERT>, <PHY_POL_NORMAL>;
>       rx-polarity-names = "usb-hs", "usb-ss";
> 
>       /* TX polarity is normal for all modes */
>       tx-polarity = <PHY_POL_NORMAL>;
>       tx-polarity-names = "default";
>     };
> 
> and a new drivers/phy/phy-common-props.c file (yes, outside of netdev)
> with two exported API functions:
> 
> int phy_get_rx_polarity(struct fwnode_handle *fwnode, const char *mode_name);
> int phy_get_tx_polarity(struct fwnode_handle *fwnode, const char *mode_name);
> 
> If you can split this up from the rest of the MDIO discrete switch
> introduction series, I can accelerate work on these common properties in
> the following weeks.

I can break out the SGMII polarity dt-bindings and functional patch
and postpone it until generic properties to describe SerDes polarities
are introduced.

Also note that the SerDes PHY also got a bunch of other tunables which
can make sense but aren't required on the demo board:
 * RX LOS Detector Enable
 * RX LOS Filter Count
 * RX LOS Threshold Level in mV
 * RX LOS Sensitivity Level
 * TX Amplitude Control
 * TX Vboost Enable
 * TX Vboost Level (0.844 V, 1.008 V, 1.156 V)
 * TX Remote Receiver Detection Request Enable
 * TX Preemphasis
 * ...

Especially the voltage levels cry for being described in a generic
way...

