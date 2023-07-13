Return-Path: <netdev+bounces-17532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C638E751E95
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 12:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82624280E07
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0781078C;
	Thu, 13 Jul 2023 10:14:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400CF100BF
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 10:14:32 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DE31724
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 03:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ky9/hMiNUPtOH1F0y78DWeK8XQvZNu7GiyGd7lx/p0Q=; b=pCdpkrWZmiOxMONSKcXZ/jlT8i
	tIlhjF46d3CcWI/UUWQGMDy7zzfmCg0gurWQD4J1UXt9xASeWO0qL8Ec6BtFOXqgtutyprbdx2GeT
	d8E+vOXdwqE6hhuygO3nXYeD53RltdF6jJuT55SfkKEPLeNOxOwLIT8+1hHuWHbaufO0ZlmemFQqU
	Ojm+88rlk8ACogbBQhAZPdRmuqrIvM/+nyLhB0ZcxhNlL4+KIg3rkOKWC2akNzEfoODaCG1zHd2AY
	XyccR+1BHTJ7x8jkm/xX7JZkVaGErNvANdeKtsHlKdqbmb48ecC6Mu4geIu8TO7XdhEgLVZGjxoSb
	f6epSl4A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49932)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qJtL6-0006S5-31;
	Thu, 13 Jul 2023 11:14:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qJtL5-000645-4X; Thu, 13 Jul 2023 11:14:23 +0100
Date: Thu, 13 Jul 2023 11:14:23 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	hkallweit1@gmail.com, francesco.dolcini@toradex.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 4/4] net: phy: marvell-88q2xxx: add driver
 for the Marvell 88Q2110 PHY
Message-ID: <ZK/Of27YzREq+Z9V@shell.armlinux.org.uk>
References: <20230710205900.52894-1-eichest@gmail.com>
 <20230710205900.52894-5-eichest@gmail.com>
 <2de0a6e1-0946-4d4f-8e57-1406a437b94e@lunn.ch>
 <ZK/G9FMPSabQCGNk@eichest-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK/G9FMPSabQCGNk@eichest-laptop>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 11:42:12AM +0200, Stefan Eichenberger wrote:
> Hi Andrew,
> 
> Thanks a lot for the review and all the hints, I have one short question
> below.
> 
> > > +static int mv88q2xxx_read_link(struct phy_device *phydev)
> > > +{
> > > +	u16 ret1, ret2;
> > > +
> > > +	/* The 88Q2XXX PHYs do not have the PMA/PMD status register available,
> > > +	 * therefore we need to read the link status from the vendor specific
> > > +	 * registers.
> > > +	 */
> > > +	if (phydev->speed == SPEED_1000) {
> > > +		/* Read twice to clear the latched status */
> > > +		ret1 = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_1000BT1_STAT);
> > > +		ret1 = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_1000BT1_STAT);
> > 
> > This is generally wrong. See for example genphy_update_link() and
> > genphy_c45_read_link().
> 
> Would something like this look fine to you? The issue is that I mix
> realtime data with latched data because the local and remote rx status
> is only available in realtime from what I can find in the datasheet.
> This would be for gbit, I split that up compared to the last version:

I've never really understood this kind of reaction from people. A bit
of example code gets suggested, and then the code gets sort of used
as a half-hearted template...

> static int mv88q2xxx_read_link_gbit(struct phy_device *phydev)
> {
> 	int ret1, ret2;
> 
> 	/* The link state is latched low so that momentary link drops can be
> 	 * detected. Do not double-read the status in polling mode to detect
> 	 * such short link drops except the link was already down. In case we
> 	 * are not polling, we always read the realtime status.
> 	 */
> 	if (!phy_polling_mode(phydev) || !phydev->link) {
> 		ret1 = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_PCS_1000BT1_STAT);
> 		if (ret1 < 0)
> 			return ret1;

Both genphy_update_link() and genphy_c45_read_link() check here whether
the link is up, and if it is, it bypasses the second read (because
there's no point re-reading it.) I've no idea why you dropped that
optimisation.

MDIO accesses aren't the cheapest thing...

> With this we will detect link loss in polling mode and read the realtime
> status in non-polling mode. Compared to genphy_c45_read_link we will not
> immediately return "link up" in non polling mode but always do the
> second read to get the realtime link status.

Why do you think that's better? "Link" only latches low, and the
entire point of that behaviour is so that management software can
detect when the link has failed at some point since it last read
the link status.

There is only any point in re-reading the status register if on the
first read it reports that the link has failed, and only then if we
already knew that the link has failed.

If we're using interrupt mode, then we need the current link status
but that's only because of the way phylib has been written.

> If we are only interested in the link status we could also skip the
> remote and local receiver check. However, as I understand the software
> initialization guide it could be that the receivers are not ready in
> that moment.

With copper PHYs, link up status means that the link is ready to pass
data. Is this not the case with T1 PHYs?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

