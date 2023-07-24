Return-Path: <netdev+bounces-20413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A9C75F58E
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 13:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6DE1C20B29
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 11:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B474563C0;
	Mon, 24 Jul 2023 11:57:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8274569E
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 11:57:59 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627531B1;
	Mon, 24 Jul 2023 04:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=soyMhpZcIJrJxMhkmZ1JJAZp/WUFHI/6qg/v9ZpPSVg=; b=mC+HME3GwTW1U5etzIqgvfxOeV
	gjzzOioQ+PdwJpFMOpJooPKDRWlKOFwnXA/hWiT/72Vr77mZ1ohBi5CfhUXcS5KtRbLNQwdhtTs3v
	46KHvxrcsamzBwsNMrXj1p8ExUkiwnZdi2EBdRJ/fUGYGWI9aAQi/AiGF3S/r4g0rGywk3rh2H4MP
	zAOmR+p/a4Hr5B0y5fzCIN1C9dd+xJszobTx7nIea+LwB7QkhsEpv6vK5veQd6xDWHLO5JMI6EiC3
	PGBhLx/vsbL9YkUovPzstlvYreK+3PtY+0XIX1DO60TucGOsP4Cdj0fwTTTDUcILbec8r9we0y7dV
	j4/Uvtww==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44102)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qNuCJ-0008Qe-2B;
	Mon, 24 Jul 2023 12:57:55 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qNuCJ-0000m9-F8; Mon, 24 Jul 2023 12:57:55 +0100
Date: Mon, 24 Jul 2023 12:57:55 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Revanth Kumar Uppala <ruppala@nvidia.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 3/4] net: phy: aquantia: Poll for TX ready at PHY system
 side
Message-ID: <ZL5nQxCyj8x+5lWk@shell.armlinux.org.uk>
References: <20230628124326.55732-1-ruppala@nvidia.com>
 <20230628124326.55732-3-ruppala@nvidia.com>
 <ZJw2u6BIShe2ZGsw@shell.armlinux.org.uk>
 <BL3PR12MB64504E3A40CD6D8EAB7FF0C8C302A@BL3PR12MB6450.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL3PR12MB64504E3A40CD6D8EAB7FF0C8C302A@BL3PR12MB6450.namprd12.prod.outlook.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 11:29:33AM +0000, Revanth Kumar Uppala wrote:
> > -----Original Message-----
> > From: Russell King <linux@armlinux.org.uk>
> > Sent: Wednesday, June 28, 2023 7:04 PM
> > To: Revanth Kumar Uppala <ruppala@nvidia.com>
> > Cc: andrew@lunn.ch; hkallweit1@gmail.com; netdev@vger.kernel.org; linux-
> > tegra@vger.kernel.org
> > Subject: Re: [PATCH 3/4] net: phy: aquantia: Poll for TX ready at PHY system side
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, Jun 28, 2023 at 06:13:25PM +0530, Revanth Kumar Uppala wrote:
> > > +     /* Lane bring-up failures are seen during interface up, as interface
> > > +      * speed settings are configured while the PHY is still initializing.
> > > +      * To resolve this, poll until PHY system side interface gets ready
> > > +      * and the interface speed settings are configured.
> > > +      */
> > > +     ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_PHYXS,
> > MDIO_PHYXS_VEND_IF_STATUS,
> > > +                                     val, (val & MDIO_PHYXS_VEND_IF_STATUS_TX_READY),
> > > +                                     20000, 2000000, false);
> > 
> > What does this actually mean when the condition succeeds? Does it mean that
> > the system interface is now fully configured (but may or may not have link)?
> Yes, your understanding is correct.
> It means that the system interface is now fully configured and has the link.

As you indicate that it also indicates that the system interface has
link, then you leave me no option but to NAK this patch, sorry. The
reason is:

> > ... If it doesn't succeed because the system
> > interface doesn't have link, then that would be very bad, because _this_ function
> > needs to return so the MAC side can then be configured to gain link with the PHY
> > with the appropriate link parameters.

Essentially, if the PHY changes its host interface because the media
side has changed, we *need* the read_status() function to succeed, tell
us that the link is up, and what the parameters are for the media side
link _and_ the host side interface.

At this point, if the PHY has changed its host-side interface, then the
link with the host MAC will be _down_ because the MAC driver is not yet
aware of the new parameters for the link. read_status() has to succeed
and report the new parameters to the MAC so that the MAC (or phylink)
can reconfigure the MAC and PCS for the PHY's new operating mode.

Sorry, but NAK.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

