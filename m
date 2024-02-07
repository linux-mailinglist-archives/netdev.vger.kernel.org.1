Return-Path: <netdev+bounces-70023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A3784D5CB
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 23:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83DC21F231D2
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 22:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6EF944F;
	Wed,  7 Feb 2024 22:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="axozuhOb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF871CD2D
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 22:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707345129; cv=none; b=TP7GV7+KmntRC1dbDB6Vs5TY/0jY2M1KgM0zywy/IdjEkHaa0uYgsyLEnXDqRCbqHG7Hs0uCXCj+O9WPM8ZQCKoGNzBzEk08HUt6wm3K9JgvBe9litxnnftMYCo/lGYhKQgmJuI9OhSKb5rNui7ODxQTEzKeQ8npIAuGKmaU2pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707345129; c=relaxed/simple;
	bh=p9obJlh2ztOgU7C5iSK3Zc7CVtQ1sQT0Au/+5QPfbko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHDgqJ5H7SSmE6WWfow5Kpr2NhFXCs9Xc+6JyawlmubrY873ml+pgmuosnLXf0fwmjYzPDEOXS+8VZ51chl5OB5dUjmOBK5MemCA/ZWUzLM669hspEQ08wyhySfquGrpPqJR/TyTPWbSPgk6+L0QHHi02JoHY9vzTPCK/8sodHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=axozuhOb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yI6ChlyFs52ySiCSLYuCP8ihxXG/FqDl0oh/kf5rF74=; b=axozuhObEH0AgB1qsAigwsOBIL
	oGkmRpWt+POnSHdsUhIIB6RmQ0HUXet9bZbeyA7Spihe09nCtvwVTrUPggdV6TtWXuLANTMU8TPoo
	IWBABg0cikcXGTPUv2bpnRG/kHLIeEXpeHWR3KbGEWh53WhUDF7V2DEHUosmAvjMcNIo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rXqST-007G13-3D; Wed, 07 Feb 2024 23:31:57 +0100
Date: Wed, 7 Feb 2024 23:31:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] net: phy: realtek: use generic MDIO
 constants
Message-ID: <40337728-a364-4955-a782-6ce4e178a097@lunn.ch>
References: <31a83fd9-90ce-402a-84c7-d5c20540b730@gmail.com>
 <732a70d6-4191-4aae-8862-3716b062aa9e@gmail.com>
 <81779222-dab6-4e11-9fd2-6e447257c0d5@lunn.ch>
 <a4bea8c5-b7d7-41ed-9c10-47d087e7dff8@gmail.com>
 <de75885e-d996-4e23-9ef8-3917fe1160c4@gmail.com>
 <6c5d7946-0776-4129-89db-2602e1874615@gmail.com>
 <05f488ea-2fe5-48b6-b4bf-c6e6d5c69461@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05f488ea-2fe5-48b6-b4bf-c6e6d5c69461@gmail.com>

> >>>>> @@ -674,11 +666,11 @@ static int rtl822x_get_features(struct phy_device *phydev)
> >>>>>  		return val;
> >>>>>  
> >>>>>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> >>>>> -			 phydev->supported, val & RTL_SUPPORTS_2500FULL);
> >>>>> +			 phydev->supported, val & MDIO_PMA_SPEED_2_5G);
> >>>>>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> >>>>> -			 phydev->supported, val & RTL_SUPPORTS_5000FULL);
> >>>>> +			 phydev->supported, val & MDIO_PMA_SPEED_5G);
> >>>>>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> >>>>> -			 phydev->supported, val & RTL_SUPPORTS_10000FULL);
> >>>>> +			 phydev->supported, val & MDIO_SPEED_10G);
> >>>>
> >>>> Now that this only using generic constants, should it move into mdio.h
> >>>> as a shared helper? Is this a standard register defined in 802.3, just
> >>>> at a different address?
> >>>>
> >>> This is register 1.4 (PMA/PMD speed ability), mapped to a vendor-specific
> >>> register. There's very few users of this register, and nothing where such
> >>> a helper could be reused.
> >>>
> 
> When looking a little closer at creating a helper for it, I stumbled across
> the following. This register just states that the PHY can operate at a certain
> speed, it leaves open which mode(s) are supported at that speed.

O.K, yes, i agree. All it says is speed, nothing more.

But that also means this driver should not really be doing this. Is
there a full list of registers which are implemented? Is there a way
to implement genphy_c45_pma_read_abilities(), or at least the subset
needed for this device? That appears to be MDIO_MMD_PMAPMD:MDIO_PMA_NG_EXTABLE and
MDIO_MMD_PMAPMD:MDIO_PMA_EXTABLE?

	Andrew

