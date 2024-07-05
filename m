Return-Path: <netdev+bounces-109547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E409928BFD
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 17:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED9A28258D
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7D716CD13;
	Fri,  5 Jul 2024 15:53:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C722B9B9
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720194792; cv=none; b=HFBh/KzK7KudP6hBJrxWcC+AhLckV/NfnwZPrG1c9CK86GkMWGl5ASBNCY4ghMcREXHBOcfTBQnVWtmSV8sweiUPGyQYDmouEsUDSB+90Y9TjhZYcw84zdC+LzK4iX37vKaEn3ppGNS1uWzOKLYrbZHqX2Rr/yEvIxbIi6XX+jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720194792; c=relaxed/simple;
	bh=Js1jHHcbW9bl2iGDt0WGXDTwBcDTsvtF99F1XVhBwc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbajvD8IhJXkfO/M9t/c0X0s8slfizQCpccIiAesbSV717A7uy78FIVuq6B5Bm/fcjBQfbxOT1Fyhf9ayL66KWf6S0wul2ZNUPX807iTMyLl2dsGq0wQSAelLglMxMbRnTBQzqD1dvFLOTNsHLFMow1VRSlTErohDWhvEu2OS9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sPlEo-0005qz-V1; Fri, 05 Jul 2024 17:52:42 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sPlEm-007MEv-17; Fri, 05 Jul 2024 17:52:40 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sPlEl-00GTcu-30;
	Fri, 05 Jul 2024 17:52:39 +0200
Date: Fri, 5 Jul 2024 17:52:39 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Arun.Ramadoss@microchip.com
Cc: andrew@lunn.ch, davem@davemloft.net, hkallweit1@gmail.com,
	Yuiko.Oshino@microchip.com, linux@armlinux.org.uk,
	Woojung.Huh@microchip.com, pabeni@redhat.com, edumazet@google.com,
	f.fainelli@gmail.com, kuba@kernel.org, michal.kubiak@intel.com,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	florian.fainelli@broadcom.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/1] net: phy: microchip: lan937x: add
 support for 100BaseTX PHY
Message-ID: <ZogWx59tzuH7t4PG@pengutronix.de>
References: <20240705085550.86678-1-o.rempel@pengutronix.de>
 <457179162ca6fd067b22b3b7733c60c2a17129a5.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <457179162ca6fd067b22b3b7733c60c2a17129a5.camel@microchip.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Jul 05, 2024 at 03:15:36PM +0000, Arun.Ramadoss@microchip.com wrote:
> Hi Oleksij,
> On Fri, 2024-07-05 at 10:55 +0200, Oleksij Rempel wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> > 
> > Add support of 100BaseTX PHY build in to LAN9371 and LAN9372
> > switches.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> > ---
> > changes v2:
> > - move LAN937X_TX code from microchip_t1.c to microchip.c
> > - add Reviewed-by tags
> > ---
> >  drivers/net/phy/microchip.c | 75
> > +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 75 insertions(+)
> > 
> > diff --git a/drivers/net/phy/microchip.c
> > b/drivers/net/phy/microchip.c
> > index 0b88635f4fbca..b46d5d43e2585 100644
> > --- a/drivers/net/phy/microchip.c
> > +++ b/drivers/net/phy/microchip.c
> > @@ -12,6 +12,12 @@
> >  #include <linux/of.h>
> >  #include <dt-bindings/net/microchip-lan78xx.h>
> > 
> > +#define PHY_ID_LAN937X_TX                      0x0007c190
> 
> 0x0007c190 -> 0x0007C190

Why? 

I wrote a python script to gather stats in the drivers/net/phy:

Uppercase hex digits count:
E: 83
F: 216
C: 130
A: 148
B: 65
D: 74

Lowercase hex digits count:
b: 218
a: 337
d: 190
e: 238
f: 2560
c: 368

Sum of uppercase A-F: 716
Sum of lowercase a-f: 3911

> > +#define LAN937X_MODE_CTRL_STATUS_REG           0x11
> > +#define LAN937X_AUTOMDIX_EN                    BIT(7)
> > +#define LAN937X_MDI_MODE                       BIT(6)
> > +
> >  #define DRIVER_AUTHOR  "WOOJUNG HUH <woojung.huh@microchip.com>"
> >  #define DRIVER_DESC    "Microchip LAN88XX PHY driver"
> 
> nitpick:
> It can be updated to include "Microchip LAN88XX/LAN937X TX PHY driver"

ack

> > @@ -373,6 +379,66 @@ static void lan88xx_link_change_notify(struct
> > phy_device *phydev)
> >         }
> >  }
> > 
> 
> Adding function description will be good.

ack

> > +static int lan937x_tx_config_mdix(struct phy_device *phydev, u8
> > ctrl)
> > +{
> > +       u16 val;
> > +
> > +       switch (ctrl) {
> > +       case ETH_TP_MDI:
> > +               val = 0;
> > +               break;
> > +       case ETH_TP_MDI_X:
> > +               val = LAN937X_MDI_MODE;
> > +               break;
> > +       case ETH_TP_MDI_AUTO:
> > +               val = LAN937X_AUTOMDIX_EN;
> > +               break;
> > +       default:
> > +               return 0;
> > +       }
> > +
> > +       return phy_modify(phydev, LAN937X_MODE_CTRL_STATUS_REG,
> > +                         LAN937X_AUTOMDIX_EN | LAN937X_MDI_MODE,
> > val);
> > +}
> > +
> > +static int lan937x_tx_config_aneg(struct phy_device *phydev)
> > +{
> > +       int ret;
> > +
> > +       ret = genphy_config_aneg(phydev);
> > +       if (ret)
> 
> Is this if( ret < 0) ?

ack

> > +               return ret;
> > +
> > +       return lan937x_tx_config_mdix(phydev, phydev->mdix_ctrl);
> 
> why we need to pass argument phydev->mdix_ctrl, since already phydev is
> passed.

good point.

> Also IMO, this two function can be combined together if
> lan937x_tx_config_mdix is not used by other functions. 

I disagree here.

> > +{
> > +       PHY_ID_MATCH_MODEL(PHY_ID_LAN937X_TX),
> > +       .name           = "Microchip LAN937x TX",
> > +       .suspend        = genphy_suspend,
> > +       .resume         = genphy_resume,
> > +       .config_aneg    = lan937x_tx_config_aneg,
> > +       .read_status    = lan937x_tx_read_status,
> 
> Do we need to add genphy_suspend/resume, .features?

From PHY driver perspective - yes, otherwise to suspend or resume will be
called.
From internal PHY perspective - i do not know. Will the MAC disable PHY
automatically?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

