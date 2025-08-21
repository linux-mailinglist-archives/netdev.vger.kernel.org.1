Return-Path: <netdev+bounces-215764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 677A1B302BF
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 21:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194061CE41A7
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 19:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7943C27AC4D;
	Thu, 21 Aug 2025 19:18:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0852FE56A;
	Thu, 21 Aug 2025 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755803929; cv=none; b=C1Jp8aCyNHY5OHSpSPualyyfRGWYY6lqNx942mnHxXxWW5vGmeXLJkx/8KN7AyLl6EVfzccchmPMV7wBTDA30u7YTkVlg7lCkRnn24sUE5LYivJBQ3S2rhDgKKoVeB50b+0NrLTILT1cxQNafLDKBOb8acHbhGuj3PmiPyM+EZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755803929; c=relaxed/simple;
	bh=dbuMZlgv4kPnPvJIMQukOYPjt/HO1WKuwLWhDZMMlH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GB5BmyO2CiIePISxXsnFLhuf3CvkFfzIybedBWZtwS3zzWx+h0ubMLCzKFAZ2yxTVzoPsoYs58KkdJqlho5Do3XKjNHiRuJ75AeX32MlQoi00D65NSU9B4Qnf5X3umXJq7h/5zwHSX9+FH+0J266dy4JPi790ytMaKAC9mr6DMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1upAo4-000000001O7-2KmP;
	Thu, 21 Aug 2025 19:18:40 +0000
Date: Thu, 21 Aug 2025 20:18:34 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "hauke@hauke-m.de" <hauke@hauke-m.de>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arkadis@mellanox.com" <arkadis@mellanox.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"john@phrozen.org" <john@phrozen.org>,
	"Stockmann, Lukas" <lukas.stockmann@siemens.com>,
	"yweng@maxlinear.com" <yweng@maxlinear.com>,
	"fchan@maxlinear.com" <fchan@maxlinear.com>,
	"lxu@maxlinear.com" <lxu@maxlinear.com>,
	"jpovazanec@maxlinear.com" <jpovazanec@maxlinear.com>,
	"Schirm, Andreas" <andreas.schirm@siemens.com>,
	"Christen, Peter" <peter.christen@siemens.com>,
	"ajayaraman@maxlinear.com" <ajayaraman@maxlinear.com>,
	"bxu@maxlinear.com" <bxu@maxlinear.com>,
	"lrosu@maxlinear.com" <lrosu@maxlinear.com>
Subject: Re: [PATCH RFC net-next 22/23] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Message-ID: <aKdxCpOEsX--ESpB@pidgin.makrotopia.org>
References: <aKDikYiU-88zC6RF@pidgin.makrotopia.org>
 <59f32c924cd8ebd02483dfd19c2788cf09d9ab75.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59f32c924cd8ebd02483dfd19c2788cf09d9ab75.camel@siemens.com>

On Thu, Aug 21, 2025 at 06:53:22PM +0000, Sverdlin, Alexander wrote:
> Hi Daniel,
> 
> On Sat, 2025-08-16 at 20:57 +0100, Daniel Golle wrote:
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
> ...
> 
> > --- /dev/null
> > +++ b/drivers/net/dsa/mxl-gsw1xx.c
> 
> ...
> 
> > static int gsw1xx_sgmii_pcs_config(struct phylink_pcs *pcs,
> > +				   unsigned int neg_mode,
> > +				   phy_interface_t interface,
> > +				   const unsigned long *advertising,
> > +				   bool permit_pause_to_mac)
> > +{
> > +	struct gsw1xx_priv *priv = sgmii_pcs_to_gsw1xx(pcs);
> > +	bool sgmii_mac_mode = dsa_is_user_port(priv->gswip.ds, GSW1XX_SGMII_PORT);
> > +	u16 txaneg, anegctl, val, nco_ctrl;
> > +	int ret;
> > +
> > +	/* Assert and deassert SGMII shell reset */
> > +	ret = regmap_set_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
> > +			      GSW1XX_RST_REQ_SGMII_SHELL);
> 
> Can this be moved into gsw1xx_probe() maybe?
> 
> The thing is, if the switch is bootstrapped in
> "Self-start Mode: Managed Switch Sub-Mode", SGMII will be already
> brought out of reset (by bootloader?) (GSWIP_CFG register), refer
> to "Table 12 Registers Configuration for Self-start Mode: Managed Switch Sub-Mode"
> in datasheet. And nobody would disable SGMII if it's unused otherwise.

What you say is true if the SGMII interface is used as the CPU port or
to connect a (1000M/100M/10M) PHY. However, it can also be used to connect
SFP modules, which can be hot-plugged. Or a 2500M/1000M/100M/10M PHY which
requires switching to 2500Base-X mode in case of a 2500M link on the UTP
interface comes up, but uses SGMII for all lower speeds.

We can probably do this similar to drivers/net/pcs/pcs-mtk-lynxi.c and
only do a full reconf including reset if there are major changes which
actually require that, but as the impact is minimal and the vendor
implementation also carries out a reset as the first thing when
configuring the SGMII interface, I'd just keep it like that for now.
Optimization can come later if actually required.

Another good thing would probably be to implement pcs_enable() and
pcs_disable() ops which put the whole SGMII port into a low-power state
(stopping clocks, maybe asserting reset as you suggest...) and bring it
back up. However, also this can be done after initial support has been
merged and verified to work in all cases (I only got the MxL8611x
evaluation board on which GSW145 is connected to MxL86111, so I can't
really do anything too fancy with the SGMII interface other than making
sure it works with that PHY with both, enabled and disabled SGMII in-band
negotiation).

> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = regmap_clear_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
> > +				GSW1XX_RST_REQ_SGMII_SHELL);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Hardware Bringup FSM Enable  */
> > +	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_HWBU_CTRL,
> > +			   GSW1XX_SGMII_PHY_HWBU_CTRL_EN_HWBU_FSM |
> > +			   GSW1XX_SGMII_PHY_HWBU_CTRL_HW_FSM_EN);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Configure SGMII PHY Receiver */
> > +	val = FIELD_PREP(GSW1XX_SGMII_PHY_RX0_CFG2_EQ,
> > +			 GSW1XX_SGMII_PHY_RX0_CFG2_EQ_DEF) |
> > +	      GSW1XX_SGMII_PHY_RX0_CFG2_LOS_EN |
> > +	      GSW1XX_SGMII_PHY_RX0_CFG2_TERM_EN |
> > +	      FIELD_PREP(GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT,
> > +			 GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT_DEF);
> > +
> > +	// if (!priv->dts.sgmii_rx_invert)
>         ^^
> There is still a room for some cleanup ;-)

Ooops... I forgot about that, it should become a vendor DT property.


