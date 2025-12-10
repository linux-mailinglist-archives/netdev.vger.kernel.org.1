Return-Path: <netdev+bounces-244283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0414CB3D37
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 20:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B25E9300F5A1
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 19:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F471322B70;
	Wed, 10 Dec 2025 19:05:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAAF221540;
	Wed, 10 Dec 2025 19:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765393551; cv=none; b=fZgMnY0FbiJhNoPr4nmVAndQmAwraFzFpe+X6BNwCSGo6QzdlE7B+Ua3Oh2zoKOzY6yM/J6kZg16+tFt/RFQRoHhoF6NNBl4bY3sx7UAlqPZlVj3ci4FCHp30F98lHlc/V+MUuh2hsXJ8J0pVk2HKkXTftl0Iawlu1yQ1Z/KEBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765393551; c=relaxed/simple;
	bh=KDEoCCT9zD0xJYow6wdIftf1Mh3RLXNQ3swoQ7pMTPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWsLAH8tIVrC1FXsACVJHV+IZugyNSQcMaILzKZbo02sLZmj+1sp+6p+ZEHFhBj93imutGSf2+cH6sfZQYgoBbeTAi46jKHiNGn2xCK6oaF9G6DNO2bczfoeJRIPUTkf1uedK5duKBDhPZ9Dcy1fID1774ypMCaWx30SBPs27tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vTPVN-000000006DG-3tJi;
	Wed, 10 Dec 2025 19:05:42 +0000
Date: Wed, 10 Dec 2025 19:05:38 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next 3/3] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <aTnEgjso87YRDlmr@makrotopia.org>
References: <cover.1764717476.git.daniel@makrotopia.org>
 <d92766bc84e409e6fafdc5e3505573662dc19d08.1764717476.git.daniel@makrotopia.org>
 <c6525467-2229-4941-803d-1be5efb431c3@lunn.ch>
 <aTmPjw83jFQXgWQt@makrotopia.org>
 <d5ea5bee-40c5-43f5-9238-ced5ca1904b7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5ea5bee-40c5-43f5-9238-ced5ca1904b7@lunn.ch>

On Wed, Dec 10, 2025 at 07:56:13PM +0100, Andrew Lunn wrote:
> > Imho it would be nice to introduce unlock __mdiodev_c45_* helpers in
> > include/linux/mdio.h, ie.
> > 
> > static inline int __mdiodev_c45_read(struct mdio_device *mdiodev, int devad,
> > 				     u16 regnum)
> > {
> > 	return __mdiobus_c45_read(mdiodev->bus, mdiodev->addr, devad, regnum);
> > }
> > 
> > static inline int __mdiodev_c45_write(struct mdio_device *mdiodev, u32 devad,
> > 				      u16 regnum, u16 val)
> > {
> > 	return __mdiobus_c45_write(mdiodev->bus, mdiodev->addr, devad, regnum,
> > 				   val);
> > }
> 
> https://elixir.bootlin.com/linux/v6.18/source/drivers/net/phy/mdio_bus.c#L531

That's __mdiobus_c45_*, but having __mdiodev_c45_* would be nice as
well, see above.

> > > > +	if (result < 0) {
> > > > +		ret = result;
> > > > +		goto out;
> > > > +	}
> > > 
> > > If i'm reading mxl862xx_send_cmd() correct, result is the value of a
> > > register. It seems unlikely this is a Linux error code?
> > 
> > Only someone with insights into the use of error codes by the uC
> > firmware can really answer that. However, as also Russell pointed out,
> > the whole use of s16 here with negative values being interpreted as
> > errors is fishy here, because in the end this is also used to read
> > registers from external MDIO connected PHYs which may return arbitrary
> > 16-bit values...
> > Someone in MaxLinear will need to clarify here.
> 
> It looks wrong, and since different architectures use different error
> code values, it is hard to get right. I would suggest you just return
> EPROTO or EIO and add a netdev_err() to print the value of result.

Ack, makes sense.

> > > > +#define MXL862XX_API_WRITE(dev, cmd, data) \
> > > > +	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), false)
> > > > +#define MXL862XX_API_READ(dev, cmd, data) \
> > > > +	mxl862xx_api_wrap(dev, cmd, &(data), sizeof((data)), true)
> > > 
> > > > +/* PHY access via firmware relay */
> > > > +static int mxl862xx_phy_read_mmd(struct mxl862xx_priv *priv, int port,
> > > > +				 int devadd, int reg)
> > > > +{
> > > > +	struct mdio_relay_data param = {
> > > > +		.phy = port,
> > > > +		.mmd = devadd,
> > > > +		.reg = reg & 0xffff,
> > > > +	};
> > > > +	int ret;
> > > > +
> > > > +	ret = MXL862XX_API_READ(priv, INT_GPHY_READ, param);
> > > 
> > > That looks a bit ugly, using a macro as a function name. I would
> > > suggest tiny functions rather than macros. The compiler should do the
> > > right thing.
> > 
> > The thing is that the macro way allows to use MXL862XX_API_* on
> > arbitrary types, such as the packed structs. Using a function would
> > require the type of the parameter to be defined, which would result
> > in a lot of code duplication in this case.
> 
> How many different invocations of these macros are there? For MDIO you
> need two. How many more are there? 

A lot, 80+ in total in the more-or-less complete driver, using 30+
different __packed structs as parameters.

https://github.com/dangowrt/linux/blob/mxl862xx-for-upstream/drivers/net/dsa/mxl862xx/mxl862xx.c

https://github.com/dangowrt/linux/blob/mxl862xx-for-upstream/drivers/net/dsa/mxl862xx/mxl862xx-api.h

