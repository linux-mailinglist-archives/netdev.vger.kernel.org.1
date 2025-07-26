Return-Path: <netdev+bounces-210277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18521B12925
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 08:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371695670DC
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 06:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63F220110B;
	Sat, 26 Jul 2025 06:22:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180A328682
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 06:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753510926; cv=none; b=T9SCL8vOCQQysfGAUNraGZFN1p/idTCPjxj5jhx6/K8Oe68AlCDNCn53kL7Pj39lQj2xFIxTgCMuymL1ljrEoS0fE+sJvChrccXAuiIZfRuC2Xm7I9IkqdbfhmJyfjW+9ChYyMR/3g5OB1XZAa+O8Mn8Yy9wK+17Amk1TnK0xmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753510926; c=relaxed/simple;
	bh=N4bjEMZEHQLw2NSc13zRiraVV7AOOO5DLl86UoFcTUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QN5C4syQTXrY5We50Y6IRre+wp7cAduv4oce289ueMb3dV5sSqXn4C5WnS2WKqM9Yp0yCWc3oqgSJpb3ifaxNbPvo7Qcwfn8i0Gg2hhm1bwBBnm6XUpeSYlD8DoSpTleIGFZP7iglqr0wm475qwyCYfI+l6x+D+UuMkwnzvTOL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ufYI2-0001Cj-Mx; Sat, 26 Jul 2025 08:21:50 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ufYI0-00ALQh-1p;
	Sat, 26 Jul 2025 08:21:48 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ufYI0-007BER-1P;
	Sat, 26 Jul 2025 08:21:48 +0200
Date: Sat, 26 Jul 2025 08:21:48 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, andrew@lunn.ch,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] net: phy: micrel: Replace hardcoded
 pages with defines
Message-ID: <aIRz_EvHUWSNAUVH@pengutronix.de>
References: <20250724200826.2662658-1-horatiu.vultur@microchip.com>
 <20250724200826.2662658-4-horatiu.vultur@microchip.com>
 <aIKbaS8ASndR7Xe_@shell.armlinux.org.uk>
 <20250725064839.psuzyuxfmyvudfka@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250725064839.psuzyuxfmyvudfka@DEN-DL-M31836.microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Jul 25, 2025 at 08:48:39AM +0200, Horatiu Vultur wrote:
> The 07/24/2025 21:45, Russell King (Oracle) wrote:
> > 
> > On Thu, Jul 24, 2025 at 10:08:25PM +0200, Horatiu Vultur wrote:
> > > diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> > > index b04c471c11a4a..d20f028106b7d 100644
> > > --- a/drivers/net/phy/micrel.c
> > > +++ b/drivers/net/phy/micrel.c
> > > @@ -2788,6 +2788,13 @@ static int ksz886x_cable_test_get_status(struct phy_device *phydev,
> > >       return ret;
> e >  }
> > >
> > > +#define LAN_EXT_PAGE_0                                       0
> > > +#define LAN_EXT_PAGE_1                                       1
> > > +#define LAN_EXT_PAGE_2                                       2
> > > +#define LAN_EXT_PAGE_4                                       4
> > > +#define LAN_EXT_PAGE_5                                       5
> > > +#define LAN_EXT_PAGE_31                                      31
> 
> Hi Russell,
> 
> > 
> > I don't see the point of this change. This is almost as bad as:
> > 
> > #define ZERO 0
> > #define ONE 1
> > #define TWO 2
> > #define THREE 3
> > ...
> > #define ONE_HUNDRED_AND_FIFTY_FIVE 155
> > etc
> > 
> > It doesn't give us any new information, and just adds extra clutter,
> > making the code less readable.
> > 
> > The point of using register definitions is to describe the purpose
> > of the number, giving the number a meaning, not to just hide the
> > number because we don't want to see such things in C code.
> > 
> > I'm sorry if you were asked to do this in v1, but I think if you
> > were asked to do it, it would've been assuming that the definitions
> > could be more meaningful.
> 
> You are right, I have been ask to change this in version 1:
> https://lkml.org/lkml/2025/7/23/672
> 
> I have mentioned it that the extended pages don't have any meaningfull
> names also in the register description document. But Oleksij says he
> will be fine with xxxx_EXT_PAGE_0, so maybe I have missunderstood Oleksij

Hi,

I requested these defines because it's much easier to search for a specific
define than for a raw number - especially when debugging or comparing with
datasheets. Even if the names are generic, it helps track down usage when
documentation becomes available or evolves.

To improve the situation, I reviewed the LAN8814 documentation and observed how
the existing driver and patches (for LAN8842) use these extended pages.
Based on that, I suggest following names:

Documented Extended Pages:

These are described in the LAN8814 documentation:

/**
 * LAN8814_PAGE_COMMON_REGS - Selects Extended Page 4.
 *
 * This page contains device-common registers that affect the entire chip.
 * It includes controls for chip-level resets, strap status, GPIO,
 * QSGMII, the shared 1588 PTP block, and the PVT monitor.
 */
#define LAN8814_PAGE_COMMON_REGS 4

/**
 * LAN8814_PAGE_PORT_REGS - Selects Extended Page 5.
 *
 * This page contains port-specific registers that must be accessed
 * on a per-port basis. It includes controls for port LEDs, QSGMII PCS,
 * rate adaptation FIFOs, and the per-port 1588 TSU block.
 */
#define LAN8814_PAGE_PORT_REGS 5

Undocumented Pages (based on driver and patch analysis):

These pages are not officially documented, but their use is visible in the
driver and LAN8842 patch:

/**
 * LAN8814_PAGE_AFE_PMA - Selects Extended Page 1.
 *
 * This page appears to control the Analog Front-End (AFE) and Physical
 * Medium Attachment (PMA) layers. It is used to access registers like
 * LAN8814_PD_CONTROLS and LAN8814_LINK_QUALITY.
 */
#define LAN8814_PAGE_AFE_PMA 1

/**
 * LAN8814_PAGE_PCS_DIGITAL - Selects Extended Page 2.
 *
 * This page seems dedicated to the Physical Coding Sublayer (PCS) and other
 * digital logic. It is used for MDI-X alignment (LAN8814_ALIGN_SWAP) and EEE
 * state (LAN8814_EEE_STATE) in the LAN8814, and is repurposed for statistics
 * and self-test counters in the LAN8842.
 */
#define LAN8814_PAGE_PCS_DIGITAL 2

/**
 * LAN8814_PAGE_SYSTEM_CTRL - Selects Extended Page 31.
 *
 * This page appears to hold fundamental system or global controls. In the
 * driver, it is used by the related LAN8804 to access the
 * LAN8814_CLOCK_MANAGEMENT register.
 */
#define LAN8814_PAGE_SYSTEM_CTRL 31

While these names are not official, they still give useful hints and make the
code more readable. I doubt the LAN8842 has an identical layout, but it looks
similar enough to reuse these patterns for now.

Are there any plans to make the LAN8842 register documentation public? That
would help clarify this further and improve upstream support.

Best regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

