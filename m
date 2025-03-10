Return-Path: <netdev+bounces-173577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B80A599F8
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 16:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B566C1884DCC
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8AF22171C;
	Mon, 10 Mar 2025 15:28:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0D319004A;
	Mon, 10 Mar 2025 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620524; cv=none; b=nLcngebhk6ahXNdteZpFSs35ymAJNevOemiNJZEh+XyJB5a1SJxu469PeHRHFRms839lQnVhSBl/crdXl7ik8hsPvq9jMW4GVP8yayMaTM/nVfDDoYHLcmveg3AZUeaHA95yaXh7HiNfLHNtWFiG1FN0xQjupKWRkwi5Er0ksNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620524; c=relaxed/simple;
	bh=LEc2cr6VLcEmIpUbXsZc5EpuLp7yE1cqdlNds8NJqxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gt1Fetho2kVjKFLZSt5CbsvTR3EpuhWp0Eur7f6mOmtJmZCTDmeVAGKOWHqmmeFo4Gh5SMj4E8+K4vRuzqe/HEv7s6R+AiJhOJLno1GA0Y+epFf1oCMP+vo1uz+9SCZG0rHVCfNDM8/vM4IDRYKCMzc3SNSpSmZT4Vi/IHzrV9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1trf3H-000000002Wj-1UOW;
	Mon, 10 Mar 2025 15:28:23 +0000
Date: Mon, 10 Mar 2025 15:28:05 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"sander@svanheule.net" <sander@svanheule.net>,
	"markus.stockhausen@gmx.de" <markus.stockhausen@gmx.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v9] net: mdio: Add RTL9300 MDIO driver
Message-ID: <Z88FBR7m1olkTXxR@pidgin.makrotopia.org>
References: <20250309232536.19141-1-chris.packham@alliedtelesis.co.nz>
 <Z85A9_Li_4n9vcEG@pidgin.makrotopia.org>
 <b506b6e9-d5c3-4927-ab2d-e3a241513082@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b506b6e9-d5c3-4927-ab2d-e3a241513082@alliedtelesis.co.nz>

On Mon, Mar 10, 2025 at 02:07:26AM +0000, Chris Packham wrote:
> Hi Daniel,
> 
> On 10/03/2025 14:31, Daniel Golle wrote:
> > Hi Chris,
> >
> > On Mon, Mar 10, 2025 at 12:25:36PM +1300, Chris Packham wrote:
> >> Add a driver for the MDIO controller on the RTL9300 family of Ethernet
> >> switches with integrated SoC. There are 4 physical SMI interfaces on the
> >> RTL9300 however access is done using the switch ports. The driver takes
> >> the MDIO bus hierarchy from the DTS and uses this to configure the
> >> switch ports so they are associated with the correct PHY. This mapping
> >> is also used when dealing with software requests from phylib.
> >>
> >> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >> ---
> >> ...
> >> +static int rtl9300_mdio_read_c22(struct mii_bus *bus, int phy_id, int regnum)
> >> +{
> >> +	struct rtl9300_mdio_chan *chan = bus->priv;
> >> +	struct rtl9300_mdio_priv *priv;
> >> +	struct regmap *regmap;
> >> +	int port;
> >> +	u32 val;
> >> +	int err;
> >> +
> >> +	priv = chan->priv;
> >> +	regmap = priv->regmap;
> >> +
> >> +	port = rtl9300_mdio_phy_to_port(bus, phy_id);
> >> +	if (port < 0)
> >> +		return port;
> >> +
> >> +	mutex_lock(&priv->lock);
> >> +	err = rtl9300_mdio_wait_ready(priv);
> >> +	if (err)
> >> +		goto out_err;
> >> +
> >> +	err = regmap_write(regmap, SMI_ACCESS_PHY_CTRL_2, FIELD_PREP(PHY_CTRL_INDATA, port));
> >> +	if (err)
> >> +		goto out_err;
> >> +
> >> +	val = FIELD_PREP(PHY_CTRL_REG_ADDR, regnum) |
> >> +	      FIELD_PREP(PHY_CTRL_PARK_PAGE, 0x1f) |
> >> +	      FIELD_PREP(PHY_CTRL_MAIN_PAGE, 0xfff) |
> >> +	      PHY_CTRL_READ | PHY_CTRL_TYPE_C22 | PHY_CTRL_CMD;
> > Using "raw" access to the PHY and thereby bypassing the MDIO
> > controller's support for hardware-assisted page access is problematic.
> > The MDIO controller also polls all PHYs status in hardware and hence
> > be aware of the currently selected page. Using raw access to switch
> > the page of a PHY "behind the back" of the hardware polling mechanism
> > results in in occassional havoc on link status changes in case Linux'
> > reading the phy status overlaps with the hardware polling.
> > This is esp. when using RealTek's 2.5GBit/s PHYs which require using
> > paged access in their read_status() function.
> >
> > Markus Stockhausen (already in Cc) has implemented a nice solution to
> > this problem, including documentation, see
> > https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/realtek/files-6.6/drivers/net/ethernet/rtl838x_eth.c;h=4b79090696e341ed1e432a7ec5c0f7f92776f0e1;hb=HEAD#l1631
> 
> I read that code/comment a few times and I must admit I still don't 
> quite get it. Part of the problem might be that my hardware platform is 
> using C45 PHYs and that's what I've been testing with. The C22
> support
> is based on my reading of the datasheet and some of what I can glean 
> from openwrt (although I completely missed that comment when I read 
> through the driver the first time).

Yes, this issue exists only with Clause-22 access, Clause-45 doesn't
require any of that. Also note that OpenWrt has recently switched
implementation from a (not very upstream friendly) approach requiring
dedicated support for paged access to Markus' new implementation which
also added the comment.

> 
> > Including a similar mechanism in this driver for C22 read and write
> > operations would be my advise, so hardware-assisted access to the PHY
> > pages is always used, and hence the hardware polling mechanism is aware
> > of the currently selected page.
> 
> So far upstream Linux doesn't have generic paged PHY register functions. 
> It sounds like that'd be a prerequisite for this.

No, that's exactly what Markus has improved about the implementation
compared to the previous approach:
We simply intercept access to C22 register 0x1f. For write access the
to-be-selected page is stored in the priv struct of the MDIO bus, in a
0-initialized array for each MDIO bus address. C22 read access to
register 0x1f can read back that value, all without actually acessing the
hardware.
Any subsequent C22 read or write operation will then use the selected
page stored for that PHY in the memory associated with the MDIO bus.

In this way page selection is left to the MDIO controller which also
carries out polling in background (see SMI_POLL_CTRL), and clashes due
to congruent access by Linux and hardware polling don't occur.



