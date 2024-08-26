Return-Path: <netdev+bounces-121765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8220395E69F
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 04:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F65281259
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 02:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E809F4C96;
	Mon, 26 Aug 2024 02:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qGS7TIZG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50890BA2E;
	Mon, 26 Aug 2024 02:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724638442; cv=none; b=iq2FHGNaET4vLJ16NIr0JxmCvHZ/F0GRrfRlvhehrJaI3+URODynsmTAfEw60oakhLoeEIL+GrXfOgTdyoIpcFclxZvM0m8fA6OgGD0Wg2O2Neg59k9mk7pASkC7a+5tGltzq60gMuPeG5Lxr3a4vuSST06lLQBru9Hin/vlqqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724638442; c=relaxed/simple;
	bh=+ooGWtTv7b2+iFp7NtkTXFiD7wZ4t4YywkwvKSbc77M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJfVoc4IcGuIcnKmqBKEfsu9BfRJwwGzhOzQjN9cZOhJ/s04/8s2tRniYL2Ajp1mlkQ5v0OgNJ/w/tVtjJosMro5IjfvV9SunWyg4MFX85xlTO49ulo2mP+he/xCrTtwZsFLhAhcZqZpf//7xQ/JHMPEwmRfn+KwHemeMB0ssIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qGS7TIZG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=bbzXLQWsHbFbpDJz4vTlB9LZJEiiPprBS7HlkZTzSQg=; b=qG
	S7TIZGirRaG4QBOpf+NpYDuK9s8Rx3QV5uek4sfQ2MKMb/om16RF6yYs7RXpGiuVq+8BB68w5kfGF
	MR/mxn52S3LfbdN6JAgq3LFsLBpsuaGUYSjpQF4BadMBEbNwhppFoAhocVPxj0sBaf0b7ZwXPBGlY
	Z/Gh0D5txroRPVg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1siPEv-005fLQ-FQ; Mon, 26 Aug 2024 04:13:53 +0200
Date: Mon, 26 Aug 2024 04:13:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?UGF3ZcWC?= Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: vitesse: implement MDI-X
 configuration in vsc73xx
Message-ID: <9d937969-85e1-4490-836b-ec8f34cbd9ed@lunn.ch>
References: <20240822145336.409867-1-paweldembicki@gmail.com>
 <3abe172b-cbad-4879-9dbf-9257e736ec6a@lunn.ch>
 <CAJN1KkzYOYKuFqo4Ew0sURwNTso0op3MWWpGmmgoqRP_sHeXxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJN1KkzYOYKuFqo4Ew0sURwNTso0op3MWWpGmmgoqRP_sHeXxg@mail.gmail.com>

On Fri, Aug 23, 2024 at 10:46:44AM +0200, Paweł Dembicki wrote:
> czw., 22 sie 2024 o 17:58 Andrew Lunn <andrew@lunn.ch> napisał(a):
> >
> > > +static int vsc73xx_mdix_set(struct phy_device *phydev, u8 mdix)
> > > +{
> > > +     int ret;
> > > +     u16 val;
> > > +
> > > +     val = phy_read(phydev, MII_VSC73XX_PHY_BYPASS_CTRL);
> > > +
> > > +     switch (mdix) {
> > > +     case ETH_TP_MDI:
> > > +             val |= MII_VSC73XX_PBC_FOR_SPD_AUTO_MDIX_DIS |
> > > +                    MII_VSC73XX_PBC_PAIR_SWAP_DIS |
> > > +                    MII_VSC73XX_PBC_POL_INV_DIS;
> > > +             break;
> > > +     case ETH_TP_MDI_X:
> > > +             /* When MDI-X auto configuration is disabled, is possible
> > > +              * to force only MDI mode. Let's use autoconfig for forced
> > > +              * MDIX mode.
> > > +              */
> > > +     default:
> > > +             val &= ~(MII_VSC73XX_PBC_FOR_SPD_AUTO_MDIX_DIS |
> >
> > This could be a little bit more readable if rather than default: you
> > used case ETH_TP_MDI_AUTO: . Then after this code, add a real default:
> > which returns -EINVAL,
> >
> 
> How should I handle ETH_TP_MDI_INVALID? Should I do it like in
> marvell.c or rockchip.c, or leave it as the default?

ETH_TP_MDI_INVALID generally means there is no support for controlling
MDI. But you are adding support. The most useful default is
ETH_TP_MDI_AUTO. So i would do that here. I would also set
phydev->mdio_ctrl to whatever the hardware defaults to in .probe, or
.config_init

	Andrew

