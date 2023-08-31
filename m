Return-Path: <netdev+bounces-31487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5258278E578
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 06:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06EB4281292
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 04:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EDD139B;
	Thu, 31 Aug 2023 04:40:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42431360
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 04:40:48 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07D1E8
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 21:40:46 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qbZTS-0003zJ-7a; Thu, 31 Aug 2023 06:40:06 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qbZTQ-0004mf-Il; Thu, 31 Aug 2023 06:40:04 +0200
Date: Thu, 31 Aug 2023 06:40:04 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
	davem@davemloft.net, Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <20230831044004.GA17603@pengutronix.de>
References: <20230830101813.GG31399@pengutronix.de>
 <20230830125224.1012459f@wsk>
 <20230830105941.GH31399@pengutronix.de>
 <20230830135151.683303db@wsk>
 <20230830121738.GJ31399@pengutronix.de>
 <ZO83htinyfAp4mWw@shell.armlinux.org.uk>
 <20230830130649.GK31399@pengutronix.de>
 <ZO9Ejx9G8laNRasu@shell.armlinux.org.uk>
 <20230830142650.GL31399@pengutronix.de>
 <20230830183818.1f42919b@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230830183818.1f42919b@wsk>
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

Hi Lukasz,

On Wed, Aug 30, 2023 at 06:38:18PM +0200, Lukasz Majewski wrote:
> Hi Oleksij,
 
> The implementation as you suggested seems to work :-)
> 
> The ksz_get_phy_flags() - where the MICREL_NO_EEE is set is executed
> before ksz9477_config_init().
> 
> And then the eee_broken_modes are taken into account.
> 
> # ethtool --show-eee lan1
> EEE Settings for lan1:
>         EEE status: disabled
>         Tx LPI: 0 (us)
>         Supported EEE link modes:  100baseT/Full 
>                                    1000baseT/Full 
>         Advertised EEE link modes:  Not reported
>         Link partner advertised EEE link modes:  Not reported
> 
> I will prepare tomorrow a proper patch.

can you please by the way remove this line:
https://elixir.bootlin.com/linux/v6.5/source/drivers/net/phy/micrel.c#L1803

it is obsolet by eee_broken_modes.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

