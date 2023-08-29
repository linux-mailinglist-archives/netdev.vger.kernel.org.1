Return-Path: <netdev+bounces-31285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F60378C7CF
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 16:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D007E1C209E0
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 14:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506C915AC9;
	Tue, 29 Aug 2023 14:42:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE19156CC
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 14:42:31 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EA51B1
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 07:42:21 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qazv2-00055u-JZ; Tue, 29 Aug 2023 16:42:12 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qazuz-0007w2-Bn; Tue, 29 Aug 2023 16:42:09 +0200
Date: Tue, 29 Aug 2023 16:42:09 +0200
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
Message-ID: <20230829144209.GD31399@pengutronix.de>
References: <BYAPR11MB35583A648E4E44944A0172A0ECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20230825103911.682b3d70@wsk>
 <862e5225-2d8e-8b8f-fc6d-c9b48ac74bfc@gmail.com>
 <BYAPR11MB3558A24A05D30BA93408851EECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20230826104910.voaw3ndvs52yoy2v@skbuf>
 <20230829103533.7966f332@wsk>
 <20230829101851.435pxwwse2mo5fwi@skbuf>
 <20230829132429.529283be@wsk>
 <20230829114739.GC31399@pengutronix.de>
 <20230829143829.68410966@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829143829.68410966@wsk>
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

On Tue, Aug 29, 2023 at 02:38:29PM +0200, Lukasz Majewski wrote:
> Hi Oleksij,

...

> Hence, I would prefer to apply the Errata and then somebody, who would
> like to enable EEE can try if it works for him.

ok.

> IMHO, code to fix erratas shall be added unconditionally, without any
> "freedom of choic

This claim is not consistent with the patch. To make it without ability
to enable EEE, you will need to clear all eee_supported bits.
If this HW is really so broken, then it is the we how it should be
fixed.

> > Beside, are you able to reproduce this issue?
> 
> Yes, I can reproduce the issue. I do use two Microchip's development
> boards (KSZ9477-EVB [1]) connected together to test HSR as well as
> communication with HOST PC.

I use KSZ9477-EVB as well.

> The network on this board without this patch is not usable (continually
> I do encounter link up/downs).

My test setup runs currently about two hours. It had 4 link drops on LAN3 and
none on other ports. Swapping cables connected to LAN2 and LAN3 still let the
LAN3 sometimes drop the connection. So far, for example LAN2 works stable and
this is probably the reason why I have not seen this issue before.
After disabling EEE on LAN3 I start getting drops on LAN2.

> Please be also aware, that this errata fix is (implicitly I think)
> already present in the kernel:
> https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/micrel.c#L1804
> 
> However, the execution order of PHY/DSA functions with newest mainline
> makes it not working any more (I've described it in details in the
> earlier mail to Vladimir).

Ok, since it was already not advertised by default, I have nothing against
having default policy to not advertise EEE for this switch.

On other hand, since this functionality is not listed as supported by the
KSZ9477 datasheet (No word about IEEE 802.3az Energy Efficient Ethernet (EEE))
compared to KSZ8565R datasheet (where EEE support is listed) and it is
confirmed to work not stable enough, then it should be disabled properly.
The phydev->supported_eee should be cleared. See ksz9477_get_features().


Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

