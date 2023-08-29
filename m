Return-Path: <netdev+bounces-31221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D2378C390
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 13:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7451E1C209D5
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 11:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21873154B8;
	Tue, 29 Aug 2023 11:47:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F1414F66
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 11:47:50 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F948132
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 04:47:49 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qaxC9-0005k9-Ke; Tue, 29 Aug 2023 13:47:41 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qaxC7-000743-Uk; Tue, 29 Aug 2023 13:47:39 +0200
Date: Tue, 29 Aug 2023 13:47:39 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com,
	Oleksij Rempel <linux@rempel-privat.de>,
	Arun Ramadoss <arun.ramadoss@microchip.com>, f.fainelli@gmail.com,
	andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, Woojung.Huh@microchip.com, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <20230829114739.GC31399@pengutronix.de>
References: <20230824154827.166274-1-lukma@denx.de>
 <20230824154827.166274-2-lukma@denx.de>
 <BYAPR11MB35583A648E4E44944A0172A0ECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20230825103911.682b3d70@wsk>
 <862e5225-2d8e-8b8f-fc6d-c9b48ac74bfc@gmail.com>
 <BYAPR11MB3558A24A05D30BA93408851EECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20230826104910.voaw3ndvs52yoy2v@skbuf>
 <20230829103533.7966f332@wsk>
 <20230829101851.435pxwwse2mo5fwi@skbuf>
 <20230829132429.529283be@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829132429.529283be@wsk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Lukasz,

On Tue, Aug 29, 2023 at 01:24:29PM +0200, Lukasz Majewski wrote:
> Hi Vladimir,
> 
> > Hi Lukasz,
> > 
> > On Tue, Aug 29, 2023 at 10:35:33AM +0200, Lukasz Majewski wrote:
> > > Hi Vladimir,
> > >   
> > > > On Fri, Aug 25, 2023 at 06:48:41PM +0000,
> > > > Tristram.Ha@microchip.com wrote:  
> > > > > > > IMHO adding functions to MMD modification would facilitate
> > > > > > > further development (for example LED setup).    
> > > > > > 
> > > > > > We already have some KSZ9477 specific initialization done in
> > > > > > the Micrel PHY driver under drivers/net/phy/micrel.c, can we
> > > > > > converge on the PHY driver which has a reasonable amount of
> > > > > > infrastructure for dealing with workarounds, indirect or
> > > > > > direct MMD accesses etc.?    
> > > > > 
> > > > > Actually the internal PHY used in the KSZ9897/KSZ9477/KSZ9893
> > > > > switches are special and only used inside those switches.
> > > > > Putting all the switch related code in Micrel PHY driver does
> > > > > not really help.  When the switch is reset all those PHY
> > > > > registers need to be set again, but the PHY driver only
> > > > > executes those code during PHY initialization.  I do not know
> > > > > if there is a good way to tell the PHY to re-initialize again.
> > > > >   
> > > > 
> > > > Suppose there was a method to tell the PHY driver to re-initialize
> > > > itself. What would be the key points in which the DSA switch
> > > > driver would need to trigger that method? Where is the switch
> > > > reset at runtime?  
> > > 
> > > Tristam has explained why adding the internal switch PHY errata to
> > > generic PHY code is not optimal.  
> > 
> > Yes, and I didn't understand that explanation, so I asked a
> > clarification question.
> 
> Ok. Let's wait for Tristram's answer.
> 
> > 
> > > If adding MMD generic code is a problem - then I'm fine with just
> > > clearing proper bits with just two indirect writes in the
> > > drivers/net/dsa/microchip/ksz9477.c
> > > 
> > > I would also prefer to keep the separate ksz9477_errata() function,
> > > so we could add other errata code there.
> > > 
> > > Just informative - without this patch the KSZ9477-EVB board's
> > > network is useless when the other peer has EEE enabled by default
> > > (like almost all non managed ETH switches).  
> > 
> > No, adding direct PHY MMD access code to the ksz9477 switch driver is
> > not even the biggest problem - even though, IIUC, the "workaround" to
> > disable EEE advertisement could be moved to ksz9477_get_features() in
> > drivers/net/phy/micrel.c, where phydev->supported_eee could be
> > cleared.
> 
> To be even more interesting (after looking into the PHY micrel.c code):
> https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/micrel.c#L1804
> 
> The errata from this patch is already present.
> 
> The issue is that ksz9477_config_init() (drivers/net/phy/micrel.c) is
> executed AFTER generic phy_probe():
> https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/phy_device.c#L3256
> in which the EEE advertisement registers are read.
> 
> Hence, those registers needs to be cleared earlier - as I do in
> ksz9477_setup() in drivers/net/dsa/microchip/ksz9477.
> 
> Here the precedence matters ...
> > 
> > The biggest problem that I see is that Oleksij Rempel has "just" added
> > EEE support to the KSZ9477 earlier this year, with an ack from Arun
> > Ramadoss: 69d3b36ca045 ("net: dsa: microchip: enable EEE support").
> > I'm not understanding why the erratum wasn't a discussion topic then.
> 
> +1

As this erratum states:  "this feature _can_ cause link drops".
For example I was indeed able to have EEE relates issue between this
switch and a link partner with AR8035 PHY. Following patch addressing
this issue:
https://lore.kernel.org/all/20230327142202.3754446-8-o.rempel@pengutronix.de/
So, in this case KSZ9477 was not the bad side.

Since this erratum do not describe exact cause of this issue or specific
link partners where this functionality is not working, I would prefer to
give the user the freedom of choice.

The same issue we have with Pause Frame support. It is not always a good
choice, but user has freedom to configure it.

Today I wont to create a test setup with different EEE capable link
partners on one side and KSZ9477 on other side and let it run some days.
Just to make sure.

Beside, are you able to reproduce this issue?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

