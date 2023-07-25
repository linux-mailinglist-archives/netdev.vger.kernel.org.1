Return-Path: <netdev+bounces-20809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6AD761112
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 12:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811FE1C20DAB
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5597012B98;
	Tue, 25 Jul 2023 10:39:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4964C1549C
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:39:11 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829851736
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GiWSjr2y+UimwEjrUCr+h1aqI4K3pWRmJHTSqlXrZvo=; b=sjl+Jz8faU7IjatbS6Z79XjFWZ
	R09DgKdBaRJcvJwB1a/N0Q5lK2y+CrahPFP0l3VY2qHCG3UwfzeihPKMEbvzn+1G5U0EaO2n9S17x
	CwBlP8pR9fhuvq1Np+UsA10HQiAezz/fXyV6IjvxPkmTF6rx26nZ/ndrznmACANZCtEhPNUsq7bk6
	tymnGUpwtelsuSnKlUOW4D1HhQvEr4xnOAT7JI8P691gKOu60gkQOR2Np3UQe9+1R4Ts19qZl3eWc
	79jlQpDEXgXVneNcPwpg+DAKS06jd2Vm1Le9Be+q1ehPfIkvsYkLPGa1G7Zfn1zmjzFMwtQV2rzOj
	xX9722jQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50708)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qOFRT-0001uI-1F;
	Tue, 25 Jul 2023 11:38:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qOFRN-0001kT-Rm; Tue, 25 Jul 2023 11:38:53 +0100
Date: Tue, 25 Jul 2023 11:38:53 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
	Jose.Abreu@synopsys.com, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 6/7] net: txgbe: support copper NIC with
 external PHY
Message-ID: <ZL+mPVLjh2qxdlRY@shell.armlinux.org.uk>
References: <20230724102341.10401-1-jiawenwu@trustnetic.com>
 <20230724102341.10401-7-jiawenwu@trustnetic.com>
 <ZL5VyBb9cUTq/y3Y@shell.armlinux.org.uk>
 <03d201d9bea1$8dc4d740$a94e85c0$@trustnetic.com>
 <ZL+Bpxn8O3PRMv0p@shell.armlinux.org.uk>
 <03f201d9bedf$730b38c0$5921aa40$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03f201d9bedf$730b38c0$5921aa40$@trustnetic.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 06:04:49PM +0800, Jiawen Wu wrote:
> On Tuesday, July 25, 2023 4:03 PM, Russell King (Oracle) wrote:
> > On Tue, Jul 25, 2023 at 10:41:46AM +0800, Jiawen Wu wrote:
> > > On Monday, July 24, 2023 6:43 PM, Russell King (Oracle) wrote:
> > > > On Mon, Jul 24, 2023 at 06:23:40PM +0800, Jiawen Wu wrote:
> > > > > @@ -22,6 +25,9 @@ static int txgbe_get_link_ksettings(struct net_device *netdev,
> > > > >  {
> > > > >  	struct txgbe *txgbe = netdev_to_txgbe(netdev);
> > > > >
> > > > > +	if (txgbe->wx->media_type == sp_media_copper)
> > > > > +		return phy_ethtool_get_link_ksettings(netdev, cmd);
> > > >
> > > > Why? If a PHY is attached via phylink, then phylink will automatically
> > > > forward the call below to phylib.
> > >
> > > No, there is no phylink implemented for sp_media_copper.
> > >
> > > > > +
> > > > >  	return phylink_ethtool_ksettings_get(txgbe->phylink, cmd);
> > > >
> > > > If you implement it correctly, you also don't need two entirely
> > > > separate paths to configure the MAC/PCS for the results of the PHY's
> > > > negotiation, because phylink gives you a _generic_ set of interfaces
> > > > between whatever is downstream from the MAC and the MAC.
> > >
> > > For sp_media_copper, only mii bus is registered for attaching PHY.
> > > Most MAC/PCS configuration is done in firmware, so it is not necessary
> > > to implement phylink as sp_media_fiber.
> > 
> > If you do implement phylink for copper, then you don't need all these
> > conditionals and the additional adjust_link implementation. In other
> > words, you can re-use a lot of the code you've already added.
> > 
> > You don't have to provide a PCS to phylink provided you don't tell
> > phylink that it's "in-band".
> 
> Do I need to create a separate software node? That would seem to
> break more code of fiber initialization flow. I could try, but I'd like to
> keep the two flows separate.

You don't need any of the swnodes to be registered, so
txgbe_swnodes_register() can be skipped. You also don't need
txgbe_mdio_pcs_init() as you said firmware will look after that.

You will need txgbe_phylink_init() to select phy_mode depending on
whether your configuration is for SFP or not, so something like:

	if (txgbe->wx->media_type == sp_media_copper) {
		phy_mode = PHY_INTERFACE_MODE_XAUI;
		fwnode = NULL;
	} else {
		phy_mode = PHY_INTERFACE_MODE_10GBASER;
		fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_PHYLINK]);
	}

	__set_bit(phy_mode, config->supported_interfaces);
	phylink = phylink_create(config, fwnode, phy_mode, &txgbe_mac_ops);

You can then use phylink_connect_phy() to add the phydev to phylink.

You'll probably need to make txgbe_phylink_mac_select() check whether
txgbe->xpcs is non-NULL to prevent a NULL pointer dereference as I
don't believe you have the XPCS in this setup - or alternatively:

	if (interface == PHY_INTERFACE_MODE_10GBASER)
		return &txgbe->xpcs->pcs;

	return NULL;

and that should be about all that would be required. phylink will
then forward all the appropriate calls onto phylib for you, take care
of reading the phy's status, and calling the mac_link_up/mac_link_down
functions as the PHY status indicates the link changes state.

Phylink will call mac_prepare()/mac_config()/mac_finish() when the
netdev is opened, and will also limit the PHY's advertisement
according to the capabilities supplied in mac_capabilities, so you
shouldn't need to remove unsupported link modes from the PHY.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

