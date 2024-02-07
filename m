Return-Path: <netdev+bounces-69990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3C084D2FA
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 21:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916F128EFA9
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224F21272A8;
	Wed,  7 Feb 2024 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HAdpCPi0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AB78563F
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337710; cv=none; b=FVBOnIoG+vWNf8YDhyQYX2Wun9Vxp1qJ8wUhAJs0q9GvE5zl81ZuQXqf2DEVN+gXEmnqJKINB45zOKwLnJzrjPHjuaDMWQWoE5AvJ3nvv5lc4E21BLTfaOeEoURxpF5qS8lVQrR5MO5unhFGigwSvxC+q1FJ2R6l21WytLSUc24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337710; c=relaxed/simple;
	bh=UuONzK3ffQnhi6/ylHW6m3G2O7+Y5zxB5ca0/YNGMB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVbVhkcg7kgqs2085Ab3eKxpEXp7vlxvRj6zxwT/MJzkcUdz+pkkylK/yewnmOIs+WWns+bV7rG0ckR+Z6MolbRo/066zpBgOXwiLmreVzkv46JQL5RLaijLzNqeMt3tB98G7bYVrFAA920MkhYhxOmLuwViyW8f2JIer5PHsu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HAdpCPi0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=brIZwLGvpiUBpavuUP2urzyvZURWUwfnZ3fp+nbxJps=; b=HA
	dpCPi06HkPzCTdmCgQcg9BOM/N9mtmz2jwdZXEzS9KgERviKKTTOS+CZ5X4CoaQVzK4eKBVRsK6PF
	nQid8ExfspDXzAgg3cPzcIdt2BA+VMSIepiTX/aPIW3bwajNhglP3e2Wq0DCf4LCy41ufgk6PMJVl
	ZuPsKsnzbMtb5Zk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rXoWh-007Fao-Dn; Wed, 07 Feb 2024 21:28:11 +0100
Date: Wed, 7 Feb 2024 21:28:11 +0100
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
Message-ID: <4be28ade-366e-4433-afd3-07a1cf3ffec2@lunn.ch>
References: <31a83fd9-90ce-402a-84c7-d5c20540b730@gmail.com>
 <732a70d6-4191-4aae-8862-3716b062aa9e@gmail.com>
 <81779222-dab6-4e11-9fd2-6e447257c0d5@lunn.ch>
 <a4bea8c5-b7d7-41ed-9c10-47d087e7dff8@gmail.com>
 <de75885e-d996-4e23-9ef8-3917fe1160c4@gmail.com>
 <6c5d7946-0776-4129-89db-2602e1874615@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c5d7946-0776-4129-89db-2602e1874615@gmail.com>

On Wed, Feb 07, 2024 at 08:51:29PM +0100, Heiner Kallweit wrote:
> Hi Andrew,
> 
> On 04.02.2024 17:35, Heiner Kallweit wrote:
> > On 04.02.2024 17:26, Heiner Kallweit wrote:
> >> On 04.02.2024 17:00, Andrew Lunn wrote:
> >>> On Sun, Feb 04, 2024 at 03:17:53PM +0100, Heiner Kallweit wrote:
> >>>> From: Marek Behún <kabel@kernel.org>
> >>>>
> >>>> Drop the ad-hoc MDIO constants used in the driver and use generic
> >>>> constants instead.
> >>>>
> >>>> Signed-off-by: Marek Behún <kabel@kernel.org>
> >>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >>>> ---
> >>>>  drivers/net/phy/realtek.c | 30 +++++++++++++-----------------
> >>>>  1 file changed, 13 insertions(+), 17 deletions(-)
> >>>>
> >>>> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> >>>> index 894172a3e..ffc13c495 100644
> >>>> --- a/drivers/net/phy/realtek.c
> >>>> +++ b/drivers/net/phy/realtek.c
> >>>> @@ -57,14 +57,6 @@
> >>>>  #define RTL8366RB_POWER_SAVE			0x15
> >>>>  #define RTL8366RB_POWER_SAVE_ON			BIT(12)
> >>>>  
> >>>> -#define RTL_SUPPORTS_5000FULL			BIT(14)
> >>>> -#define RTL_SUPPORTS_2500FULL			BIT(13)
> >>>> -#define RTL_SUPPORTS_10000FULL			BIT(0)
> >>>> -#define RTL_ADV_2500FULL			BIT(7)
> >>>> -#define RTL_LPADV_10000FULL			BIT(11)
> >>>> -#define RTL_LPADV_5000FULL			BIT(6)
> >>>> -#define RTL_LPADV_2500FULL			BIT(5)
> >>>> -
> >>>>  #define RTL9000A_GINMR				0x14
> >>>>  #define RTL9000A_GINMR_LINK_STATUS		BIT(4)
> >>>>  
> >>>> @@ -674,11 +666,11 @@ static int rtl822x_get_features(struct phy_device *phydev)
> >>>>  		return val;
> >>>>  
> >>>>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> >>>> -			 phydev->supported, val & RTL_SUPPORTS_2500FULL);
> >>>> +			 phydev->supported, val & MDIO_PMA_SPEED_2_5G);
> >>>>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> >>>> -			 phydev->supported, val & RTL_SUPPORTS_5000FULL);
> >>>> +			 phydev->supported, val & MDIO_PMA_SPEED_5G);
> >>>>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> >>>> -			 phydev->supported, val & RTL_SUPPORTS_10000FULL);
> >>>> +			 phydev->supported, val & MDIO_SPEED_10G);
> >>>
> >>> Now that this only using generic constants, should it move into mdio.h
> >>> as a shared helper? Is this a standard register defined in 802.3, just
> >>> at a different address?
> >>>
> >> This is register 1.4 (PMA/PMD speed ability), mapped to a vendor-specific
> >> register. There's very few users of this register, and nothing where such
> >> a helper could be reused.

Nothing at the moment. If ixgbe ever gets converted to phylib, or at
least converted to link modes, it could use it. But i think it should
be in mdio.h. That is where people will look for such a helper, and
might overlook it here. We want to encourage such helpers and there
use.

> >>> Is this mii_10gbt_stat_mod_linkmode_lpa_t() ?
> >>>
> >> Indeed, it is. Thanks for the hint. I'd prefer to submit the patch making use
> >> of this helper as a follow-up patch. Then it's obvious that the helper is
> >> the same as the replaced code.
> >>
> Is it fine with you to do this in a follow-up patch?
> The series is marked "under review", so Jakub seems to wait for an outcome
> of our discussion.

Converting to use the standard helps can be a follow-up patch. And
moving the helper into mdio.h as well.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


