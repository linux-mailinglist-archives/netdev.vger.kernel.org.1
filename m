Return-Path: <netdev+bounces-215837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 583EEB30984
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 00:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A23718987EB
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 22:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B9D34DCC9;
	Thu, 21 Aug 2025 22:38:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B17E3128BB;
	Thu, 21 Aug 2025 22:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755815888; cv=none; b=jaQDNHXjs8uPWr3MrS37NicpER6eKGxdaNKKJgUA2tYHE9HqpSWTam2VNWtccxcqKKV8pxdqNpAPMfqk3Hl2nqJeV0yi6gnlEbphLNEKtC9Y5/0Ffb0GdOPMWs0ru3BLRQqOwrCskWKhET3WUvz4SRNT/5E6SvEScHxWefYWvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755815888; c=relaxed/simple;
	bh=JAKV+m3cuPzOrPOamBpGHs3U2qVTmhaXqceomooRw/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WD/zBfoXhay2nfDSFTTxg3iTcSJ2WpMI4TlvjJN6LVxu4Vnh+Lgd0ieu0/q1gRz1EuZNahmymUBjQPlcW2yGqouQLK1OWsCf1qRY5aeGe5UYMGqoKP6OMoIxbKN0hbI2eO0wmNuoUdwtmrtayIgfxYfyTA7QjBnZihk5nWDhHA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1upDuw-000000002Qe-2Vi3;
	Thu, 21 Aug 2025 22:37:58 +0000
Date: Thu, 21 Aug 2025 23:37:53 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "olteanv@gmail.com" <olteanv@gmail.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"Christen, Peter" <peter.christen@siemens.com>,
	"lxu@maxlinear.com" <lxu@maxlinear.com>,
	"john@phrozen.org" <john@phrozen.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"yweng@maxlinear.com" <yweng@maxlinear.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"bxu@maxlinear.com" <bxu@maxlinear.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"fchan@maxlinear.com" <fchan@maxlinear.com>,
	"ajayaraman@maxlinear.com" <ajayaraman@maxlinear.com>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>,
	"arkadis@mellanox.com" <arkadis@mellanox.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>,
	"jpovazanec@maxlinear.com" <jpovazanec@maxlinear.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Stockmann, Lukas" <lukas.stockmann@siemens.com>,
	"lrosu@maxlinear.com" <lrosu@maxlinear.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"Schirm, Andreas" <andreas.schirm@siemens.com>
Subject: Re: [PATCH RFC net-next 22/23] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Message-ID: <aKefwdv1DJeYz1WU@pidgin.makrotopia.org>
References: <aKDikYiU-88zC6RF@pidgin.makrotopia.org>
 <59f32c924cd8ebd02483dfd19c2788cf09d9ab75.camel@siemens.com>
 <aKdxCpOEsX--ESpB@pidgin.makrotopia.org>
 <a4048989adc1724a8aff80f954b9dfeac2bfa9b4.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4048989adc1724a8aff80f954b9dfeac2bfa9b4.camel@siemens.com>

On Thu, Aug 21, 2025 at 08:13:24PM +0000, Sverdlin, Alexander wrote:
> Hello Daniel,
> 
> On Thu, 2025-08-21 at 20:18 +0100, Daniel Golle wrote:
> > > > Add driver for the MaxLinear GSW1xx family of Ethernet switch ICs which
> > > > are based on the same IP as the Lantiq/Intel GSWIP found in the Lantiq VR9
> > > > and Intel GRX MIPS router SoCs. The main difference is that instead of
> > > > using memory-mapped I/O to communicate with the host CPU these ICs are
> > > > connected via MDIO (or SPI, which isn't supported by this driver).
> > > > Implement the regmap API to access the switch registers over MDIO to allow
> > > > reusing lantiq_gswip_common for all core functionality.
> > > > 
> > > > The GSW1xx also comes with a SerDes port capable of 1000Base-X, SGMII and
> > > > 2500Base-X, which can either be used to connect an external PHY or SFP
> > > > cage, or as the CPU port. Support for the SerDes interface is implemented
> > > > in this driver using the phylink_pcs interface.
> > > 
> > > ...
> > > 
> > > > --- /dev/null
> > > > +++ b/drivers/net/dsa/mxl-gsw1xx.c
> > > 
> > > ...
> > > 
> > > > static int gsw1xx_sgmii_pcs_config(struct phylink_pcs *pcs,
> > > > +				   unsigned int neg_mode,
> > > > +				   phy_interface_t interface,
> > > > +				   const unsigned long *advertising,
> > > > +				   bool permit_pause_to_mac)
> > > > +{
> > > > +	struct gsw1xx_priv *priv = sgmii_pcs_to_gsw1xx(pcs);
> > > > +	bool sgmii_mac_mode = dsa_is_user_port(priv->gswip.ds, GSW1XX_SGMII_PORT);
> > > > +	u16 txaneg, anegctl, val, nco_ctrl;
> > > > +	int ret;
> > > > +
> > > > +	/* Assert and deassert SGMII shell reset */
> > > > +	ret = regmap_set_bits(priv->shell, GSW1XX_SHELL_RST_REQ,
> > > > +			      GSW1XX_RST_REQ_SGMII_SHELL);
> > > 
> > > Can this be moved into gsw1xx_probe() maybe?
> > > 
> > > The thing is, if the switch is bootstrapped in
> > > "Self-start Mode: Managed Switch Sub-Mode", SGMII will be already
> > > brought out of reset (by bootloader?) (GSWIP_CFG register), refer
> > > to "Table 12 Registers Configuration for Self-start Mode: Managed Switch Sub-Mode"
> > > in datasheet. And nobody would disable SGMII if it's unused otherwise.
> > 
> > What you say is true if the SGMII interface is used as the CPU port or
> > to connect a (1000M/100M/10M) PHY. However, it can also be used to connect
> > SFP modules, which can be hot-plugged. Or a 2500M/1000M/100M/10M PHY which
> > requires switching to 2500Base-X mode in case of a 2500M link on the UTP
> > interface comes up, but uses SGMII for all lower speeds.
> 
> I'm actually concerned about use-cases where SGMII is unused.
> In "Self-start Mode" SGMII block is being brought up and driver will never disable it.
> I'm not proposing to move the de-assertion of the reset, but either
> the assertion can be done unconditionally somewhere around probe
> or struct dsa_switch_ops::setup callback or the assertion can remain
> here and be duplicated somewhere around init.

Lets assert the SGMII in the probe() function and let .pcs_enable() and
.pcs_disable() handle deassertion and assertion at runtime. That's easy
and obvious, and makes sure the SGMII reset is always asserted if the
SGMII unit isn't used. We can later optmize more and also stop clocks
or do whatever MaxLinear folks are telling us would be good to further
reduce power consumption and potentially also EM noise.

> 
> > We can probably do this similar to drivers/net/pcs/pcs-mtk-lynxi.c and
> > only do a full reconf including reset if there are major changes which
> > actually require that, but as the impact is minimal and the vendor
> > implementation also carries out a reset as the first thing when
> > configuring the SGMII interface, I'd just keep it like that for now.
> > Optimization can come later if actually required.
> 
> Sure, it goes a bit beyond basic support as it's a power consumption
> optimization, but I thought I'll bring this up now as the re-spin will happen
> anyway and if you agree on moving the reset assertion, then later patching
> will not be required.

Convinced me ;)


