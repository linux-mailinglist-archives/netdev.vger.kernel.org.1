Return-Path: <netdev+bounces-31541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5143278EA47
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 12:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA721C20A04
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 10:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246598462;
	Thu, 31 Aug 2023 10:37:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E2A63CC
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 10:37:34 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6D5CF3
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 03:37:32 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qbf31-0002Kq-EB; Thu, 31 Aug 2023 12:37:11 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qbf2z-00067y-Fd; Thu, 31 Aug 2023 12:37:09 +0200
Date: Thu, 31 Aug 2023 12:37:09 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Lukasz Majewski <lukma@denx.de>, Tristram.Ha@microchip.com,
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
	davem@davemloft.net, Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Michael Walle <michael@walle.cc>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: phy: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <20230831103709.GC17603@pengutronix.de>
References: <20230831072527.537839-1-lukma@denx.de>
 <ZPBrMMPiWubgFEZ0@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZPBrMMPiWubgFEZ0@shell.armlinux.org.uk>
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

On Thu, Aug 31, 2023 at 11:28:00AM +0100, Russell King (Oracle) wrote:
> On Thu, Aug 31, 2023 at 09:25:27AM +0200, Lukasz Majewski wrote:
> > diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
> > index 8bef1ab62bba..eed474fc7308 100644
> > --- a/include/linux/micrel_phy.h
> > +++ b/include/linux/micrel_phy.h
> > @@ -44,6 +44,7 @@
> >  #define MICREL_PHY_50MHZ_CLK	0x00000001
> >  #define MICREL_PHY_FXEN		0x00000002
> >  #define MICREL_KSZ8_P1_ERRATA	0x00000003
> > +#define MICREL_NO_EEE	0x00000004
> 
> Erm... Maybe someone should clarify this... we have in the code the
> following tests for these "flags":
> 
> 	/* Support legacy board-file configuration */
> 	if (phydev->dev_flags & MICREL_PHY_50MHZ_CLK) {
> 	        priv->rmii_ref_clk_sel = true;
> 	        priv->rmii_ref_clk_sel_val = true;
> 	}
> 
> 	/* Skip auto-negotiation in fiber mode */
> 	if (phydev->dev_flags & MICREL_PHY_FXEN) {
> 	        phydev->speed = SPEED_100;
> 	        return 0;
> 	}
> 
> 	if (phydev->dev_flags & MICREL_KSZ8_P1_ERRATA)
> 		return -EOPNOTSUPP;
> 
> 	/* According to KSZ9477 Errata DS80000754C (Module 4) all EEE modes
> 	 * in this switch shall be regarded as broken.
> 	 */
> 	if (phydev->dev_flags & MICREL_NO_EEE)
> 	        phydev->eee_broken_modes = -1;
> 
> Is it intentional that setting MICREL_PHY_50MHZ_CLK on its own also
> activates the MICREL_KSZ8_P1_ERRATA and vice versa? Is it intentional
> that setting MICREL_PHY_FXEN also activates MICREL_KSZ8_P1_ERRATA and
> vice versa?
> 
> To me, this looks horribly broken, and this patch just perpetuates the
> brokenness (but at least 0x4 doesn't overlap with the other flags.)
> 
> If it is intentional, then MICREL_KSZ8_P1_ERRATA should be defined to
> make it explicit - in other words, as
> (MICREL_PHY_FXEN|MICREL_PHY_50MHZ_CLK). If not, all these flags should
> be defined using (1 << n) or BIT() to make it explicit that they're a
> bit, and not just a hex number that gets incremented when the next flag
> is added.

Indeed, it is broken. I'll send a fix for this one.
MICREL_KSZ8_P1_ERRATA should be BIT(3)
and MICREL_NO_EEE BIT(4)

Thx!

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

