Return-Path: <netdev+bounces-13108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 007C973A4A6
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 17:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF58C2819A6
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 15:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE581F92E;
	Thu, 22 Jun 2023 15:20:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41C1E526
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 15:20:34 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68A2193
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hxhr5L2A281Sz/6A9WtJTxt9oFFCE2ao7NMx3Ulfj4g=; b=IKYmNa6d0Eg97maDMDJqz2+9V/
	/TXfwLEAWAUuXMU3fY0XH07NJmKpCKYkYbtET9CICYhkVh6N6NB9u/VPus52IiPfuJ43f0CoRu6o3
	WsMSwCyMX7X51jOwjBP/74CN9jefWifiIQDlKyYDfAIIpWNQBboNc6Oa1YMAlCM1lZydNewG06VMJ
	7iSuA3swZvgjStE9E9krF9d53YgrFVnFd6gotRC4yyavRkVw0U+ExbOuDZB+Zi3yxZ4BizSqWapJO
	IPVaC2LgbpGwSm7TFTwUO8/Cy03nwjn1VY8sVEJ7phDKa/AfwiP5jv1Am5z61x6oY+J3nAGgWqWOA
	Z6kDjRsQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36840)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qCM6n-0004QN-Bq; Thu, 22 Jun 2023 16:20:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qCM6m-0000Y4-Ab; Thu, 22 Jun 2023 16:20:28 +0100
Date: Thu, 22 Jun 2023 16:20:28 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev <netdev@vger.kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: [PATCH v4 net-next 7/9] net: phy: Add phy_support_eee()
 indicating MAC support EEE
Message-ID: <ZJRmvIldnyYBbBYa@shell.armlinux.org.uk>
References: <20230618184119.4017149-1-andrew@lunn.ch>
 <20230618184119.4017149-8-andrew@lunn.ch>
 <6951e7fa-a922-c498-9bb9-eaae5f47faaf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6951e7fa-a922-c498-9bb9-eaae5f47faaf@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 19, 2023 at 04:21:09PM +0100, Florian Fainelli wrote:
> 
> 
> On 6/18/2023 7:41 PM, Andrew Lunn wrote:
> > In order for EEE to operate, both the MAC and the PHY need to support
> > it, similar to how pause works. Copy the pause concept and add the
> > call phy_support_eee() which the MAC makes after connecting the PHY to
> > indicate it supports EEE. phylib will then advertise EEE when auto-neg
> > is performed.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >   drivers/net/phy/phy_device.c | 18 ++++++++++++++++++
> >   include/linux/phy.h          |  3 ++-
> >   2 files changed, 20 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> > index 2cad9cc3f6b8..ae2ebe1df15c 100644
> > --- a/drivers/net/phy/phy_device.c
> > +++ b/drivers/net/phy/phy_device.c
> > @@ -2762,6 +2762,24 @@ void phy_advertise_supported(struct phy_device *phydev)
> >   }
> >   EXPORT_SYMBOL(phy_advertise_supported);
> > +/**
> > + * phy_support_eee - Enable support of EEE
> > + * @phydev: target phy_device struct
> > + *
> > + * Description: Called by the MAC to indicate is supports Energy
> 
> typo: is/it
> 
> > + * Efficient Ethernet. This should be called before phy_start() in
> > + * order that EEE is negotiated when the link comes up as part of
> > + * phy_start(). EEE is enabled by default when the hardware supports
> > + * it.
> > + */
> > +void phy_support_eee(struct phy_device *phydev)
> > +{
> > +	linkmode_copy(phydev->advertising_eee, phydev->supported_eee);
> > +	phydev->eee_cfg.tx_lpi_enabled = true;
> > +	phydev->eee_cfg.eee_enabled = true;
> > +}
> > +EXPORT_SYMBOL(phy_support_eee);
> 
> A bit worried that naming this function might be confusing driver authors
> that this is a function that reports whether EEE is supported, though I am
> not able to come up with better names.

Possibly phy_enable_eee_support() ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

