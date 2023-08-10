Return-Path: <netdev+bounces-26435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F280B777BF0
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C7A1C20EEB
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3617820C8C;
	Thu, 10 Aug 2023 15:16:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAC51E1A2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 15:16:22 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891A590
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:16:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c1f6f3884so149484466b.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691680580; x=1692285380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E9BIJuejqLYsX23Cp7aFaqFKYfYh+8C8r5AvwFvd5Wk=;
        b=sKtx61CMPHndzYdk7VjV7dzUQqSWwr5lHgk8sd4JxF9r5tdffUT4loEwBhMRMUqdOh
         MFKxwI/Mt9gy5us2Zgcnu8Fq1GrxTwFSqg67GGaOUPcofMDIUUfHo7m4mpgh7QtD3QHr
         MTQ1ZgQnSNA5tz8WerTDLzec5EGfIpPOexa106FwQ4V7teojwC/IrrpsVwQZgzZGSd71
         AXotozRnAEq8zWuyGL48mH8Of68mQbkHVGCL/ImcJ2OKwpgh81jmdGUPr5O/gKjQiZl+
         1LGZDcm3kTyMmcYr6yBfgtk5v5s2CRW4tN33bXvUsyYrCNQ8hz4xxlraN7d/mLpPrBD2
         WHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691680580; x=1692285380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9BIJuejqLYsX23Cp7aFaqFKYfYh+8C8r5AvwFvd5Wk=;
        b=UV2NZDHa8+p2DDQF+6PDaYiROqUNsk6wVTi2jTI1RYzwPdWqCAzeC4puEHsgcCO+YM
         1txl4BAmwzc/Iv4O9dbGcmY8nOg1E5TMY51BESiEOE4t4M5YH82c6MgvbHuGymFwB7Zu
         OifJ40tna+LBEpEwQqaoZEpcFbu8gQJijUUrB5YSGOILRcB2haL92hdzLWJ8zcXKl1o4
         sqjcAxkzrREMsTkjg/0DRcpQHgLEOyH0BcWLZlyaYMxlQ8u3MC8Br3F+TZvgiaKA38bF
         bIR3Q2jzK1aDAJyLzHOcY8AJRDEKer53vcrzMlFk1XogStjsAleaoI6yBw/0gAej+9t2
         CkiQ==
X-Gm-Message-State: AOJu0YykTwiHJ0K2oI5RbdVstbMQ0f2Vlv9kGUfoz4KTygZTtJaoojeB
	d/oVYibz0yv0oTyF7Z5JYsU=
X-Google-Smtp-Source: AGHT+IGaYAuv/uN02d/TyhnmTx4Um4lCYrB7MozIpIUP9MhVoVkr0p6WyXED6Oyj1tf4xq4L1p/BFw==
X-Received: by 2002:a17:907:77c5:b0:994:1eb4:6898 with SMTP id kz5-20020a17090777c500b009941eb46898mr2474629ejc.9.1691680579707;
        Thu, 10 Aug 2023 08:16:19 -0700 (PDT)
Received: from skbuf ([188.27.184.201])
        by smtp.gmail.com with ESMTPSA id a18-20020a17090640d200b00993a9a951fasm1082140ejk.11.2023.08.10.08.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 08:16:19 -0700 (PDT)
Date: Thu, 10 Aug 2023 18:16:17 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Message-ID: <20230810151617.wv5xt5idbfu7wkyn@skbuf>
References: <20230808120652.fehnyzporzychfct@skbuf>
 <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
 <20230808120652.fehnyzporzychfct@skbuf>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <ZNI1WA3mGMl93ib8@shell.armlinux.org.uk>
 <20230808123901.3jrqsx7pe357hwkh@skbuf>
 <ZNI7x9uMe6UP2Xhr@shell.armlinux.org.uk>
 <20230808135215.tqhw4mmfwp2c3zy2@skbuf>
 <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNJO6JQm2g+hv/EX@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Russell,

On Tue, Aug 08, 2023 at 03:19:20PM +0100, Russell King (Oracle) wrote:
> On Tue, Aug 08, 2023 at 04:52:15PM +0300, Vladimir Oltean wrote:
> > On Tue, Aug 08, 2023 at 01:57:43PM +0100, Russell King (Oracle) wrote:
> > > Thanks for the r-b.
> > > 
> > > At risk of delaying this patch through further discussion... so I'll
> > > say now that we're going off into discussions about future changes.
> > > 
> > > I believe all DSA drivers that provide .phylink_get_caps fill in the
> > > .mac_capabilities member, which leaves just a few drivers that do not,
> > > which are:
> > > 
> > > $ git grep -l dsa_switch_ops.*= drivers/net/dsa/ | xargs grep -L '\.phylink_get_caps'
> > > drivers/net/dsa/dsa_loop.c
> > > drivers/net/dsa/mv88e6060.c
> > > drivers/net/dsa/realtek/rtl8366rb.c
> > > drivers/net/dsa/vitesse-vsc73xx-core.c
> > > 
> > > I've floated the idea to Linus W and Arinc about setting
> > > .mac_capabilities in the non-phylink_get_caps path as well, suggesting:
> > 
> > Not sure what you mean by "in the non-phylink_get_caps path" (what is
> > that other path). Don't you mean that we should implement phylink_get_caps()
> > for these drivers, to have a unified code flow for everyone?
> 
> I meant this:
> 
>                 /* For legacy drivers */
>                 if (mode != PHY_INTERFACE_MODE_NA) {
>                         __set_bit(mode, dp->pl_config.supported_interfaces);
>                 } else {
>                         __set_bit(PHY_INTERFACE_MODE_INTERNAL,
>                                   dp->pl_config.supported_interfaces);
>                         __set_bit(PHY_INTERFACE_MODE_GMII,
>                                   dp->pl_config.supported_interfaces);
>                 }

Ah, ok, you'd like a built-in assumption of the mac_capabilities in
dsa_port_phylink_create().

> but ultimately yes, having the DSA phylink_get_caps method mandatory
> would be excellent, but I don't think we have sufficient information
> to do that.
> 
> For example, what interface modes does the Vitesse DSA switch support?
> What speeds? Does it support pause? Does it vary depending on port?

I only have a VSC7395 datasheet which was shared with me by Linus (and
that link is no longer functional).

This switch supports MII/REV-MII/GMII/RGMII on MAC 6, and MACs 0-4 are
connected to internal PHYs (yes, there is no port 5, also see the
comment in vsc73xx_probe()).

Based on vsc73xx_init_port() and vsc73xx_adjust_enable_port(), I guess
all ports support flow control, and thus, PHYs should advertise it.

I don't have a datasheet for the other switches supported by the driver:

 * Vitesse VSC7385 SparX-G5 5+1-port Integrated Gigabit Ethernet Switch
 * Vitesse VSC7388 SparX-G8 8-port Integrated Gigabit Ethernet Switch
 * Vitesse VSC7395 SparX-G5e 5+1-port Integrated Gigabit Ethernet Switch
 * Vitesse VSC7398 SparX-G8e 8-port Integrated Gigabit Ethernet Switch

but based on the common treatment in vsc73xx_init_port(), I'd say that
on all models, port 6 (CPU_PORT) is the xMII port and all the others are
internal PHY ports, and all support the same configuration. So a
phylink_get_caps() implementation could probably also do one of two
things, based on "if (port == CPU_PORT)".

> > > 	MAC_1000 | MAC_100 | MAC_10 | MAC_SYM_PAUSE | MAC_ASYM_PAUSE
> > > 
> > > support more than 1G speeds. I think the only exception to that may
> > > be dsa_loop, but as I think that makes use of the old fixed-link
> > > software emulated PHYs, I believe that would be limited to max. 1G
> > > as well.
> > 
> > I don't believe that dsa_loop makes use of fixed-link at all. Its user
> > ports use phy/gmii mode through the non-OF-based dsa_slave_phy_connect()
> > to the ds->slave_mii_bus, and the CPU port goes through the non-OF code
> > path ("else" block) here (because dsa_loop_bdinfo.c _is_ non-OF-based):
> 
> Sorry, I meant fixed-phy not fixed-link.
> 
> > 
> > dsa_port_setup:
> > 	case DSA_PORT_TYPE_CPU:
> > 		if (dp->dn) {
> > 			err = dsa_shared_port_link_register_of(dp);
> > 			if (err)
> > 				break;
> > 			dsa_port_link_registered = true;
> > 		} else {
> > 			dev_warn(ds->dev,
> > 				 "skipping link registration for CPU port %d\n",
> > 				 dp->index);
> > 		}
> 
> What made me believe that it uses the old fixed-phy stuff is:
> 
> static int __init dsa_loop_init(void)
> ...
>         for (i = 0; i < NUM_FIXED_PHYS; i++)
>                 phydevs[i] = fixed_phy_register(PHY_POLL, &status, NULL);
> 
> These PHYs end up on the "fixed-0" virtual MDIO bus, which also has a
> MDIO device created for the dsa-loop driver at address 31. Thus, in
> dsa_loop_drv_probe():
> 
> 	ps->bus = mdiodev->bus;
> 
> is the fixed-0 bus with these fixed-PHYs on, and dsa_loop_phy_read()
> and dsa_loop_phy_write() access these fixed PHYs.
> 
> These fixed PHYs are clause-22 PHYs, which only support up to 1G
> speeds. Therefore, it is my understanding that dsa-loop will only
> support up to 1G speeds.

Clear now. Yes, this is correct.

> > > If we did set .mac_capabilities, then dsa_port_phylink_validate() would
> > > always call phylink_generic_validate() for all DSA drivers, and at that
> > > point, we don't need dsa_port_phylink_validate() anymore as it provides
> > > nothing that isn't already done inside phylink.
> > > 
> > > Once dsa_port_phylink_validate() is gone, then I believe there are no
> > > drivers populating the .validate method in phylink_mac_ops, which
> > > then means there is the possibility to remove that method.
> > 
> > Assuming I understand correctly, I agree it would be beneficial for
> > mv88e6060, rtl8366rb and vsc73xx to populate mac_capabilities and
> > supported_interfaces.
> 
> ... which we can only do if someone can furnish information on what
> these support. Short of that, we would need something in the core
> DSA code (like we're doing for the supported_interfaces) that would
> allow them to continue working until .phylink_get_caps could be
> reasonably implemented for them.
> 
> Providing a legacy .phylink_get_caps would also be a possibility.
> Maybe something like this:
> 
> void legacy_dsa_phylink_get_caps(struct dsa_switch *ds, int port,
> 				 struct phylink_config *config)
> {
> 	struct dsa_port *dp = dsa_to_port(ds, port);
> 	phy_interface_t mode;
> 	int err;
> 
> 	err = of_get_phy_mode(dp->dn, &mode);
> 	if (!err) {
> 		__set_bit(mode, config->supported_interfaces);
> 	} else {
> 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> 			  config->supported_interfaces);
> 		__set_bit(PHY_INTERFACE_MODE_GMII,
> 			  config->supported_interfaces);
> 	}
> 
> 	config->mac_capabilities = MAC_1000 | MAC_100 | MAC_10 |
> 				   MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
> }
> 
> and then dsa_port_phylink_create() always calls phylink_get_caps:
> 
> -	if (ds->ops->phylink_get_caps) {
> -		ds->ops->phylink_get_caps(ds, dp->index, &dp->pl_config);
> -	} else {
> -	...
> -	}
> +	ds->ops->phylink_get_caps(ds, dp->index, &dp->pl_config);

That could be an option, but I think the volume of switches is low
enough that we could just consider converting them all.

I see you've sent a mv88e6060 patch, I'll go review that now.

