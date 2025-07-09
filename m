Return-Path: <netdev+bounces-205272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C583AFDFD4
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E83582BE6
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 06:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB33E26B2DA;
	Wed,  9 Jul 2025 06:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N1V6uSds"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BCF1E7C27;
	Wed,  9 Jul 2025 06:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752041546; cv=none; b=UKDRZHU9tPmlWTWQ1VogFk/JygT6qAMjt769mGb1uXIdqxdUTZeOl624did26vrAxM90YysL3jeJJPCxDs8KbAfY8BnEwuz1Y31H453LMZ8X9ggoBi53ZYx+fUNv+E9jPhymBNhbulWdNoZazC8Flxjc+BeCw5tDOOpQUFPY4Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752041546; c=relaxed/simple;
	bh=b6fHflmKbdoQM8mgBF82jn0LzwgDIvXGI4ngEOI9Kho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RrkYAehLCrFCtVyHziVwBzX6B3pkV6kwKafcuxNVH24AvwMbaaCX+NtKldr9EkqmCZP2c1bIkmOXHmGTP3Gq850oTlymFWB7Gb4G2c5Ev3GZ9BWf+kabKGkNOK24TR/hZnoHhJ4qPvSxBErvbuyCpy4yxrrcQlN3jr1mqyjVQNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N1V6uSds; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B1A661FCF0;
	Wed,  9 Jul 2025 06:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752041541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KsS1Bbbca9XQYHQZD5JFcdb0dmQjAJZfp72T1bNefM=;
	b=N1V6uSdsMSier0lYnfeBmwUGUxNP++lSOFVGh8ovo3TyUfJyrOMJWiFxiVxH8vJSJq1Trv
	3sDyDQTjtNBBg2Jlyi77dJpiaOZrpzE5v/tGuXhA+Kyc7MXwqdtz9Ff0WtMhaKm4/PAPsn
	zDwoY2Bt6stQZTDWS2YNg+Hui7CeGr0UxeNJH1k5oB49ADbef7NZfWNRRgD8c4e8DXWC9U
	Rw7z24mcaiQp35pHC7rEZFfgNTWE01B6/5nkd0AIihjMpgcnmIsurJ+5a6AcLUhDPBVOnT
	+xFv01g+7556/0rl/xHhBOwct960Rk6hXKlam+YPtJxLzC/EaHP+0p0Gy9hqkQ==
Date: Wed, 9 Jul 2025 08:12:17 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: <Tristram.Ha@microchip.com>
Cc: <Woojung.Huh@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <marex@denx.de>, <UNGLinuxDriver@microchip.com>,
 <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 6/6 v2] net: dsa: microchip: Setup fiber ports
 for KSZ8463
Message-ID: <20250709081217.368e1f7d@fedora>
In-Reply-To: <DM3PR11MB8736DE8A01523BD67AF73766EC4EA@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250708031648.6703-1-Tristram.Ha@microchip.com>
	<20250708031648.6703-7-Tristram.Ha@microchip.com>
	<20250708122237.08f4dd7c@device-24.home>
	<DM3PR11MB8736DE8A01523BD67AF73766EC4EA@DM3PR11MB8736.namprd11.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefieektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopefvrhhishhtrhgrmhdrjfgrsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohephghoohhjuhhnghdrjfhuhhesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopeholhhtvggrnhhvsehgmhgri
 hhlrdgtohhmpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvth
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Tristram

On Tue, 8 Jul 2025 19:45:44 +0000
<Tristram.Ha@microchip.com> wrote:

> > Hi Tristram,
> > 
> > On Mon, 7 Jul 2025 20:16:48 -0700
> > <Tristram.Ha@microchip.com> wrote:
> >   
> > > From: Tristram Ha <tristram.ha@microchip.com>
> > >
> > > The fiber ports in KSZ8463 cannot be detected internally, so it requires
> > > specifying that condition in the device tree.  Like the one used in
> > > Micrel PHY the port link can only be read and there is no write to the
> > > PHY.  The driver programs registers to operate fiber ports correctly.
> > >
> > > The PTP function of the switch is also turned off as it may interfere the
> > > normal operation of the MAC.
> > >
> > > Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> > > ---
> > >  drivers/net/dsa/microchip/ksz8.c       | 26 ++++++++++++++++++++++++++
> > >  drivers/net/dsa/microchip/ksz_common.c |  3 +++
> > >  2 files changed, 29 insertions(+)
> > >
> > > diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
> > > index 904db68e11f3..1207879ef80c 100644
> > > --- a/drivers/net/dsa/microchip/ksz8.c
> > > +++ b/drivers/net/dsa/microchip/ksz8.c
> > > @@ -1715,6 +1715,7 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
> > >       const u32 *masks;
> > >       const u16 *regs;
> > >       u8 remote;
> > > +     u8 fiber_ports = 0;
> > >       int i;
> > >
> > >       masks = dev->info->masks;
> > > @@ -1745,6 +1746,31 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
> > >               else
> > >                       ksz_port_cfg(dev, i, regs[P_STP_CTRL],
> > >                                    PORT_FORCE_FLOW_CTRL, false);
> > > +             if (p->fiber)
> > > +                     fiber_ports |= (1 << i);
> > > +     }
> > > +     if (ksz_is_ksz8463(dev)) {
> > > +             /* Setup fiber ports. */  
> > 
> > What does fiber port mean ? Is it 100BaseFX ? As this configuration is
> > done only for the CPU port (it seems), looks like this mode is planned
> > to be used as the MAC to MAC mode on the DSA conduit. So, instead of
> > using this property maybe you should implement that as handling the
> > "100base-x" phy-mode ?
> >   
> > > +             if (fiber_ports) {
> > > +                     regmap_update_bits(ksz_regmap_16(dev),
> > > +                                        reg16(dev, KSZ8463_REG_CFG_CTRL),
> > > +                                        fiber_ports << PORT_COPPER_MODE_S,
> > > +                                        0);
> > > +                     regmap_update_bits(ksz_regmap_16(dev),
> > > +                                        reg16(dev, KSZ8463_REG_DSP_CTRL_6),
> > > +                                        COPPER_RECEIVE_ADJUSTMENT, 0);
> > > +             }
> > > +
> > > +             /* Turn off PTP function as the switch's proprietary way of
> > > +              * handling timestamp is not supported in current Linux PTP
> > > +              * stack implementation.
> > > +              */
> > > +             regmap_update_bits(ksz_regmap_16(dev),
> > > +                                reg16(dev, KSZ8463_PTP_MSG_CONF1),
> > > +                                PTP_ENABLE, 0);
> > > +             regmap_update_bits(ksz_regmap_16(dev),
> > > +                                reg16(dev, KSZ8463_PTP_CLK_CTRL),
> > > +                                PTP_CLK_ENABLE, 0);
> > >       }
> > >  }
> > >
> > > diff --git a/drivers/net/dsa/microchip/ksz_common.c  
> > b/drivers/net/dsa/microchip/ksz_common.c  
> > > index c08e6578a0df..b3153b45ced9 100644
> > > --- a/drivers/net/dsa/microchip/ksz_common.c
> > > +++ b/drivers/net/dsa/microchip/ksz_common.c
> > > @@ -5441,6 +5441,9 @@ int ksz_switch_register(struct ksz_device *dev)
> > >                                               &dev->ports[port_num].interface);
> > >
> > >                               ksz_parse_rgmii_delay(dev, port_num, port);
> > > +                             dev->ports[port_num].fiber =
> > > +                                     of_property_read_bool(port,
> > > +                                                           "micrel,fiber-mode");  
> > 
> > Shouldn't this be described in the binding ?
> >   
> > >                       }
> > >                       of_node_put(ports);
> > >               }  
> 
> The "micrel,fiber-mode" is described in Documentation/devicetree/
> bindings/net/micrel.txt.

Yes but that's for PHYs right ? Yours is under the DSA "ports"
node.

> 
> Some old KSZ88XX switches have option of using fiber in a port running
> 100base-fx.  Typically they have a register indicating that configuration
> and the driver just treats the port as having a PHY and reads the link
> status and speed as normal except there is no write to those PHY related
> registers.  KSZ8463 does not have that option so the driver needs to be
> told.

That's what I understood from your comments indeed, what thew me off
guard is that all ports's fiber mode is configured in the
config_cpu_port() callback.

I'd like to one day be able to deprecate these
micrel,fiber-mode/ti,fiber-mode properties in favor of the ports API
that's being worked on, but I guess we can roll with it for now.

Maxime



