Return-Path: <netdev+bounces-25521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCBC7746F2
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412C82818B6
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4CF156FE;
	Tue,  8 Aug 2023 19:06:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519E1168BD
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 19:06:24 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC197DA3
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 11:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S0NDF8BYiBmMuicTIuqbq9E/8bfFVU7dprOXrD36Ljw=; b=p1u+KKFFFUf1sW5pUgPUN/3O4K
	DnLqTzLC6ihAPhuRbCT6oVKMy2gzWsYuQd4yQD/yCTnKNxB0Ot4G8SNxaM7Yt31LDX5WYbzfL7cVd
	Ys2VHES/YeWDzW9RtmWLU+bY3DTs4pqdO3GcYvjIBlJ6H03ks7xRTWtYwxdiJ2yQz8nDgIBPwHIcH
	uvje4CaR/ct61Fd5HRs670PmRtjNPv8YGyz2bijP1dP9a7O+VGZDW0NWSgFSU426NGncZ6w6sAVZ+
	1/glfYbz5xPPWavzRUL1Bhkk4PafJ6w/AdAWxSoK89I15jH/r2hVvDNQHPHOO2B5+a0gaYw8pgDXv
	XdtYU11g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39522)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qTNYQ-0008IP-05;
	Tue, 08 Aug 2023 15:19:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qTNYO-0008Al-Ry; Tue, 08 Aug 2023 15:19:20 +0100
Date: Tue, 8 Aug 2023 15:19:20 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk>
References: <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <20230808120652.fehnyzporzychfct@skbuf>
 <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <20230808120652.fehnyzporzychfct@skbuf>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <20230808123901.3jrqsx7pe357hwkh@skbuf>
 <ZNI7x9uMe6UP2Xhr@shell.armlinux.org.uk>
 <20230808135215.tqhw4mmfwp2c3zy2@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808135215.tqhw4mmfwp2c3zy2@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 08, 2023 at 04:52:15PM +0300, Vladimir Oltean wrote:
> On Tue, Aug 08, 2023 at 01:57:43PM +0100, Russell King (Oracle) wrote:
> > Thanks for the r-b.
> > 
> > At risk of delaying this patch through further discussion... so I'll
> > say now that we're going off into discussions about future changes.
> > 
> > I believe all DSA drivers that provide .phylink_get_caps fill in the
> > .mac_capabilities member, which leaves just a few drivers that do not,
> > which are:
> > 
> > $ git grep -l dsa_switch_ops.*= drivers/net/dsa/ | xargs grep -L '\.phylink_get_caps'
> > drivers/net/dsa/dsa_loop.c
> > drivers/net/dsa/mv88e6060.c
> > drivers/net/dsa/realtek/rtl8366rb.c
> > drivers/net/dsa/vitesse-vsc73xx-core.c
> > 
> > I've floated the idea to Linus W and Arinc about setting
> > .mac_capabilities in the non-phylink_get_caps path as well, suggesting:
> 
> Not sure what you mean by "in the non-phylink_get_caps path" (what is
> that other path). Don't you mean that we should implement phylink_get_caps()
> for these drivers, to have a unified code flow for everyone?

I meant this:

                /* For legacy drivers */
                if (mode != PHY_INTERFACE_MODE_NA) {
                        __set_bit(mode, dp->pl_config.supported_interfaces);
                } else {
                        __set_bit(PHY_INTERFACE_MODE_INTERNAL,
                                  dp->pl_config.supported_interfaces);
                        __set_bit(PHY_INTERFACE_MODE_GMII,
                                  dp->pl_config.supported_interfaces);
                }

but ultimately yes, having the DSA phylink_get_caps method mandatory
would be excellent, but I don't think we have sufficient information
to do that.

For example, what interface modes does the Vitesse DSA switch support?
What speeds? Does it support pause? Does it vary depending on port?

> > 
> > 	MAC_1000 | MAC_100 | MAC_10 | MAC_SYM_PAUSE | MAC_ASYM_PAUSE
> > 
> > support more than 1G speeds. I think the only exception to that may
> > be dsa_loop, but as I think that makes use of the old fixed-link
> > software emulated PHYs, I believe that would be limited to max. 1G
> > as well.
> 
> I don't believe that dsa_loop makes use of fixed-link at all. Its user
> ports use phy/gmii mode through the non-OF-based dsa_slave_phy_connect()
> to the ds->slave_mii_bus, and the CPU port goes through the non-OF code
> path ("else" block) here (because dsa_loop_bdinfo.c _is_ non-OF-based):

Sorry, I meant fixed-phy not fixed-link.

> 
> dsa_port_setup:
> 	case DSA_PORT_TYPE_CPU:
> 		if (dp->dn) {
> 			err = dsa_shared_port_link_register_of(dp);
> 			if (err)
> 				break;
> 			dsa_port_link_registered = true;
> 		} else {
> 			dev_warn(ds->dev,
> 				 "skipping link registration for CPU port %d\n",
> 				 dp->index);
> 		}

What made me believe that it uses the old fixed-phy stuff is:

static int __init dsa_loop_init(void)
...
        for (i = 0; i < NUM_FIXED_PHYS; i++)
                phydevs[i] = fixed_phy_register(PHY_POLL, &status, NULL);

These PHYs end up on the "fixed-0" virtual MDIO bus, which also has a
MDIO device created for the dsa-loop driver at address 31. Thus, in
dsa_loop_drv_probe():

	ps->bus = mdiodev->bus;

is the fixed-0 bus with these fixed-PHYs on, and dsa_loop_phy_read()
and dsa_loop_phy_write() access these fixed PHYs.

These fixed PHYs are clause-22 PHYs, which only support up to 1G
speeds. Therefore, it is my understanding that dsa-loop will only
support up to 1G speeds.

> > If we did set .mac_capabilities, then dsa_port_phylink_validate() would
> > always call phylink_generic_validate() for all DSA drivers, and at that
> > point, we don't need dsa_port_phylink_validate() anymore as it provides
> > nothing that isn't already done inside phylink.
> > 
> > Once dsa_port_phylink_validate() is gone, then I believe there are no
> > drivers populating the .validate method in phylink_mac_ops, which
> > then means there is the possibility to remove that method.
> 
> Assuming I understand correctly, I agree it would be beneficial for
> mv88e6060, rtl8366rb and vsc73xx to populate mac_capabilities and
> supported_interfaces.

... which we can only do if someone can furnish information on what
these support. Short of that, we would need something in the core
DSA code (like we're doing for the supported_interfaces) that would
allow them to continue working until .phylink_get_caps could be
reasonably implemented for them.

Providing a legacy .phylink_get_caps would also be a possibility.
Maybe something like this:

void legacy_dsa_phylink_get_caps(struct dsa_switch *ds, int port,
				 struct phylink_config *config)
{
	struct dsa_port *dp = dsa_to_port(ds, port);
	phy_interface_t mode;
	int err;

	err = of_get_phy_mode(dp->dn, &mode);
	if (!err) {
		__set_bit(mode, config->supported_interfaces);
	} else {
		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
			  config->supported_interfaces);
		__set_bit(PHY_INTERFACE_MODE_GMII,
			  config->supported_interfaces);
	}

	config->mac_capabilities = MAC_1000 | MAC_100 | MAC_10 |
				   MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
}

and then dsa_port_phylink_create() always calls phylink_get_caps:

-	if (ds->ops->phylink_get_caps) {
-		ds->ops->phylink_get_caps(ds, dp->index, &dp->pl_config);
-	} else {
-	...
-	}
+	ds->ops->phylink_get_caps(ds, dp->index, &dp->pl_config);

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

