Return-Path: <netdev+bounces-31296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2D078CA56
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 19:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C601C20A00
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 17:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C2C17FFB;
	Tue, 29 Aug 2023 17:12:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A7E14F6D
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 17:12:17 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2A3AD
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:12:16 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qb2G7-0006Hf-RH; Tue, 29 Aug 2023 19:12:07 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qb2G5-0007PG-Gy; Tue, 29 Aug 2023 19:12:05 +0200
Date: Tue, 29 Aug 2023 19:12:05 +0200
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
Message-ID: <20230829171205.GE31399@pengutronix.de>
References: <862e5225-2d8e-8b8f-fc6d-c9b48ac74bfc@gmail.com>
 <BYAPR11MB3558A24A05D30BA93408851EECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20230826104910.voaw3ndvs52yoy2v@skbuf>
 <20230829103533.7966f332@wsk>
 <20230829101851.435pxwwse2mo5fwi@skbuf>
 <20230829132429.529283be@wsk>
 <20230829114739.GC31399@pengutronix.de>
 <20230829143829.68410966@wsk>
 <20230829144209.GD31399@pengutronix.de>
 <20230829172913.518210b0@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829172913.518210b0@wsk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 29, 2023 at 05:29:13PM +0200, Lukasz Majewski wrote:
> Hi Oleksij,
> > On other hand, since this functionality is not listed as supported by
> > the KSZ9477 datasheet (No word about IEEE 802.3az Energy Efficient
> > Ethernet (EEE)) compared to KSZ8565R datasheet (where EEE support is
> > listed) and it is confirmed to work not stable enough, then it should
> > be disabled properly.
> 
> I've described this problem in more details here:
> https://lore.kernel.org/lkml/20230829132429.529283be@wsk/
> 
> -------->8---------
> The issue is that ksz9477_config_init() (drivers/net/phy/micrel.c) is
> executed AFTER generic phy_probe():
> https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/phy_device.c#L3256
> in which the EEE advertisement registers are read.
> 
> Hence, those registers needs to be cleared earlier - as I do in
> ksz9477_setup() in drivers/net/dsa/microchip/ksz9477.
> 
> Here the precedence matters ...
> ----------8<-------------
> 
> > The phydev->supported_eee should be cleared.
> > See ksz9477_get_features().
> > 
> 
> Removing the linkmod_and() from ksz9477_get_features():
> https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/micrel.c#L1408
> 
> doesn't help.

Yes, removing linkmod_and() will not should not help. I said, "The
phydev->supported_eee should be cleared."

For example like this:
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1400,6 +1400,7 @@ static int ksz9131_config_aneg(struct phy_device *phydev)
 
 static int ksz9477_get_features(struct phy_device *phydev)
 {
+       __ETHTOOL_DECLARE_LINK_MODE_MASK(zero) = { 0, };
        int ret;
 
        ret = genphy_read_abilities(phydev);
@@ -1413,7 +1414,7 @@ static int ksz9477_get_features(struct phy_device *phydev)
         * KSZ8563R should have 100BaseTX/Full only.
         */
        linkmode_and(phydev->supported_eee, phydev->supported,
-                    PHY_EEE_CAP1_FEATURES);
+                    zero);
 
        return 0;
 }

You will need to clear it only on KSZ9477 variants with this bug.
This change is tested and it works on my KSZ9477-EVB.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

