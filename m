Return-Path: <netdev+bounces-169866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F063A460FF
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 14:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3BE169CB6
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 13:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C637618785D;
	Wed, 26 Feb 2025 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Sf7PASKb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02476101FF;
	Wed, 26 Feb 2025 13:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576792; cv=none; b=A5eS3u0jXD8Ba2C7nbQKBHy5Y8C1xADaHnn5YD85qpyy0ETOjV92YkrQRMVEUa8QP9we/Z0Kh0uQUhyX7GJJtubRnbWYHcoNQqSQyxWlS5VqosyqLMY8ccTiMw8yb48ZfNTHqWfi4aO9blztsCuwHmepI9ejvp1c0hX1i3TZWtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576792; c=relaxed/simple;
	bh=kpc/Y3mRgi+fArynnY7CdE255PDg5V3f7b+lCMVeKgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZabI6lDZt6S014DUmOZJ3VCyOmBzCe8inkgcermr90cHqWB4kjEnJW/RwcUqn80+o+SHyroB2lvQUwkpMhuPDJzfDqeHJ8RAhor1IhtTeKAk1MOxL1M6l9I4nglyJRDYdhbotz8f+LpbFohddBUnrcbg8t55cgo7RXrw3wKxGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Sf7PASKb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=tm7hO41JOQlTWPC9THQAbEe0/tlBt69JLz+IlowK45s=; b=Sf
	7PASKbSARFMMzrBB16abt6ui8Mz+VjlV/9TgFn5nQ1/ot9dLG9/IiBhRy5tNn/0KlqJI5eAepClnp
	Ng+aVxSzmSK4iFHL4U0LW6d83GKunPs6JIsR1TNWKk8teFU99kFRf75MZ+Zu1e0AIqsAToa0d4UCu
	TnLTqsRbvcmPaZY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tnHWm-000Ggy-NL; Wed, 26 Feb 2025 14:32:44 +0100
Date: Wed, 26 Feb 2025 14:32:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH net-next v2 3/3] net: phy: mediatek: add driver for
 built-in 2.5G ethernet PHY on MT7988
Message-ID: <73080f10-5077-4165-9fe8-e2ccca497feb@lunn.ch>
References: <20250219083910.2255981-1-SkyLake.Huang@mediatek.com>
 <20250219083910.2255981-4-SkyLake.Huang@mediatek.com>
 <Z7WleP9v6Igx2MjC@shell.armlinux.org.uk>
 <5fae9c69a09320b0b24f25a178137bd0256a72d8.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fae9c69a09320b0b24f25a178137bd0256a72d8.camel@mediatek.com>

On Wed, Feb 26, 2025 at 06:48:34AM +0000, SkyLake Huang (黃啟澤) wrote:
> On Wed, 2025-02-19 at 09:33 +0000, Russell King (Oracle) wrote:
> > 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> > 
> > 
> > On Wed, Feb 19, 2025 at 04:39:10PM +0800, Sky Huang wrote:
> > > +static int mt798x_2p5ge_phy_config_init(struct phy_device *phydev)
> > > +{
> > > +     struct pinctrl *pinctrl;
> > > +     int ret;
> > > +
> > > +     /* Check if PHY interface type is compatible */
> > > +     if (phydev->interface != PHY_INTERFACE_MODE_INTERNAL)
> > > +             return -ENODEV;
> > > +
> > > +     ret = mt798x_2p5ge_phy_load_fw(phydev);
> > > +     if (ret < 0)
> > > +             return ret;
> > 
> > Firmware should not be loaded in the .config_init method. The above
> > call will block while holding the RTNL which will prevent all other
> > network configuration until the firmware has been loaded or the load
> > fails.
> > 
> > Thanks.
> > 
> > --
> > RMK's Patch system:
> > https://urldefense.com/v3/__https://www.armlinux.org.uk/developer/patches/__;!!CTRNKA9wMg0ARbw!iV-1ViPFsUV-lLj7aIycan8nery6sQO3t6mkpdlb_GW8hswhxc4ejJozxqkU3s2WzxSizs4kfdC77yr7HGGRIuU$
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> Hi Russell,
> mt798x_p5ge_phy_load_fw() will only load firmware once after driver is
> probed through priv->fw_loaded. And actually, firmware loading
> procedure only takes about 11ms. This was discussed earlier in:
> https://patchwork.kernel.org/project/linux-mediatek/patch/20240520113456.21675-6-SkyLake.Huang@mediatek.com/#25856462
> https://patchwork.kernel.org/project/linux-mediatek/patch/20240520113456.21675-6-SkyLake.Huang@mediatek.com/#25857174

Ideally, all PHY drivers should look like each other. That makes
maintenance simpler. Currently, air_en8811h.c, aquantia_main.c, and
qt2025.rs load firmware in there probe function. Is there a good
reason this driver needs to be different?

       Andrew

