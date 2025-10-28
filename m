Return-Path: <netdev+bounces-233389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC7EC12A4C
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0E474E0663
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422711D5151;
	Tue, 28 Oct 2025 02:14:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFC62DF68;
	Tue, 28 Oct 2025 02:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761617697; cv=none; b=FWhT4rK7fivicgwX29GRmW5kBdkfQHPL4aa77JIAXNcA/qw7kwjyPw9INdA+hJVO2yHMDSXTRWS9onUBB8DNpWzch3fIJ0G/u5swmofT8kXl3rZigcmt2No3G0+mjxpoFmUSRhMERn1itjwNA4EQ6vixUy2me7VJPoWiJAK6Pw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761617697; c=relaxed/simple;
	bh=8GA2HWQ3CnTTZU4f0v/SuliTNBNdDaZ0tSnmxpynxRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVjRi2/fXIQvnWxN2s1dQ5pkolreFuBoPiZ9/bvifbRPSrmvSi0uCFLYEimwtq7Xr4TNGPbEh5bMaeKr4zlgPjw93h0wYSZSjJ6xLEU8IbT4Bjs287odqhrXpJ8tMIyzA6O6b4PJ+GmS95zU0zsSFNvIJcM3haO3aR4U9FP2vPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vDZEX-000000006K5-0QLG;
	Tue, 28 Oct 2025 02:14:49 +0000
Date: Tue, 28 Oct 2025 02:14:45 +0000
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
Subject: Re: [PATCH net-next v3 12/12] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Message-ID: <aQAnFXYZXIe4VA0Q@makrotopia.org>
References: <cover.1761521845.git.daniel@makrotopia.org>
 <cover.1761521845.git.daniel@makrotopia.org>
 <5055f997f3dea3c26d6a34f94ed06bceda020790.1761521845.git.daniel@makrotopia.org>
 <5055f997f3dea3c26d6a34f94ed06bceda020790.1761521845.git.daniel@makrotopia.org>
 <20251028012430.2khnl6hts2twyrz3@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028012430.2khnl6hts2twyrz3@skbuf>

On Tue, Oct 28, 2025 at 03:24:30AM +0200, Vladimir Oltean wrote:
> On Sun, Oct 26, 2025 at 11:49:10PM +0000, Daniel Golle wrote:
> > Add driver for the MaxLinear GSW1xx family of Ethernet switch ICs which
> > are based on the same IP as the Lantiq/Intel GSWIP found in the Lantiq VR9
> > and Intel GRX MIPS router SoCs. The main difference is that instead of
> > using memory-mapped I/O to communicate with the host CPU these ICs are
> > connected via MDIO (or SPI, which isn't supported by this driver).
> > Implement the regmap API to access the switch registers over MDIO to allow
> > reusing lantiq_gswip_common for all core functionality.
> > 
> > The GSW1xx also comes with a SerDes port capable of 1000Base-X, SGMII and
> > 2500Base-X, which can either be used to connect an external PHY or SFP
> > cage, or as the CPU port. Support for the SerDes interface is implemented
> > in this driver using the phylink_pcs interface.
> 
> I opened the GSW145 datasheet and it seems borderline in terms of what
> I'd suggest to implement via MFD, keeping the DSA driver to be just for
> the switch fabric, vs implementing everything in the DSA driver.
> 
> Just to know what to expect in the future. Are there higher-spec'd
> switches with an embedded CPU, waiting to be supported by Linux?

In terms of dedicated switches the short answer is "no".
The Lantiq/Intel/MaxLinear GSWIP family afaik ends with GSWIP 3.0 which
can be found in some of the PON SoCs build around the Intel Atom which
are marketed by MaxLinear. Supporting also those is on my agenda
once I get hold of the hardware. The switch IP found in those SoCs
generally is still just an improved and extended PCE, just with more
tables and more table entries to implement layer-3 features like PPPoE,
NAT and flow-offloading all within the switch-part of the SoC.

> Linux running outside, but also potentially inside?

No. The GSW1xx switches and the switch IP found inside those SoCs are
still basically programmable store-(modify-)and-forward ASICs rathern
than general purpose processors with offloading paths.

> Maybe you'll need full-fledged clock, pinmux, GPIO drivers, due to IPs
> reused in other parts? Interrupt controller support? The SGMII "PHY"
> block also seems distinct from the "PCS" block, more like a driver in
> drivers/phy/ would control.

I don't think we'll see those blocks in anything else than those
dedicated switch ICs.

Newer MaxLinear switches (with more than 1 Gbit/s TP ports) are
completely different animals, they do run an RTOS on a general purpose
CPU internally, and offer a complex API to be used by the host rather
than allowing raw access to the internal registers. They can even be
turned into a standalone web-managed switch, ie. the CPU is capable of
providing a HTTP server, SNMP, ...

It is, of course, possible that some parts of GSW1xx series may or may
not have been reused, but as the RTOS running on those MxL862xx chips is
proprietary and there is no documentation of the bare-metal hardware it
is impossible for me to tell. What I can tell for sure that there isn't
any external DRAM, so they won't ever run Linux for resource reasons.

> 
> > +
> > +static int gsw1xx_pcs_phy_xaui_write(struct gsw1xx_priv *priv, u16 addr,
> > +				     u16 data)
> > +{
> > +	int ret, val;
> > +
> > +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_D, data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_A, addr);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_C,
> > +			   GSW1XX_SGMII_PHY_WRITE |
> > +			   GSW1XX_SGMII_PHY_RESET_N);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return regmap_read_poll_timeout(priv->sgmii, GSW1XX_SGMII_PHY_C,
> > +					val, val & GSW1XX_SGMII_PHY_STATUS,
> > +					1000, 100000);
> > +}
> > +
> > +static int gsw1xx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> > +			     phy_interface_t interface,
> > +			     const unsigned long *advertising,
> > +			     bool permit_pause_to_mac)
> > +{
> > +	struct gsw1xx_priv *priv = pcs_to_gsw1xx(pcs);
> > +	bool sgmii_mac_mode = dsa_is_user_port(priv->gswip.ds,
> > +					       GSW1XX_SGMII_PORT);
> 
> In lack of the phy-mode = "revsgmii" that you also mention, can we just
> assume that any port with phy-mode = "sgmii" is in "MAC mode"?

That would result in SGMII generally not be useful for being used as
interface mode for the CPU port, because in that case the switch would
need to operate in "SGMII PHY mode". It is true, however, that in most
cases it is likely possible to just use 1000Base-X or 2500Base-X instead
of SGMII to connect the switch to the CPU.

> > [...]
> 
> Can you split up this function in multiple smaller logical blocks?
> The control flow with "reconf" and "skip_init_reset" is a bit difficult
> to follow. I can't say I understood what's going on. Ideally
> gsw1xx_pcs_config() fits in one-two screen.

I think breaking out the intial reset and flush into a seperate
function makes sense.

> 
> > +static int gsw1xx_probe(struct mdio_device *mdiodev)
> > +{
> > [...]
> > +	/* configure GPIO pin-mux for MMDIO in case of external PHY connected to
> 
> Can you explain that MMDIO stands for MDIO master interface? On first
> sight it looks like a typo.

Yes, MMDIO = Master MDIO (ie. to connect external PHYs to the switch in
this case, but also to access the built-in TP PHYs). As opposed to the
MDIO Slave module which is used to allow the CPU to access the switch
registers. I'll change the comment to make it more clear.

