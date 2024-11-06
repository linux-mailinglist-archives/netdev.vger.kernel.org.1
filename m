Return-Path: <netdev+bounces-142434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B829BF182
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 16:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB1D283104
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 15:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F762036E1;
	Wed,  6 Nov 2024 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wWgwk5CK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00632202F94
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730906543; cv=none; b=ot/mA6KPu/YxKr0ydS7ePtIzPHbo3u9ywKmR41x0a9Op3ugyC1ebZp06Q2gConzdNgic3gKXaqc7lXVoZYXIcWjxzcTGak0ViZ81foOHgPbrpJC2ls4X0o58HmWFiArOpTwk/6z3KAmlAi+RbENpMYH537HiNmlOVi7SlhZqz8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730906543; c=relaxed/simple;
	bh=BVptabtPgyu0QPBlOwcKfYx+PtCwBwAre909cVOPiQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYujAIfMdI4TWYG9Piz3o+TQHPOqeEjRI7VOA7hcewPTBnYzmWWX54Tyi5DAA201c6vnglZO96LkGDqpngq+hSqKJKwUALZDuRcg8UDel/3d84OAVweODgoSVQDcc9MtI1Xpfbkdvg4gq1j3p5pjfOPWbr+luLYfNbYhxr0Uv28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wWgwk5CK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QEQLUGbScObvEeEnxxnctE1Qseoomn5lk7YdxkB4zec=; b=wWgwk5CKT6R+8H5BTjObcxkrAI
	kUOQRvrV9aYwQXqapvh2Wwhwnjf0XT3NcjZwv1azrmDz/Y/6LpoaNmLguOadO6vQKuYqIUFbjJRWR
	0YPeMZDoUf396Q45jCUgwF6gMXUrm3X6e+lSFjJWrItc/spX8sZ9ReKouC2Df1jmrrHw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t8hrB-00CLsQ-5y; Wed, 06 Nov 2024 16:22:05 +0100
Date: Wed, 6 Nov 2024 16:22:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: copy vendor driver 2.5G/5G EEE
 advertisement constraints
Message-ID: <5f5a45ff-dff8-4a04-9028-88b189862fcb@lunn.ch>
References: <4677d3c4-60e2-4094-81a8-adae42ca46bb@gmail.com>
 <5cd6ccf1-8641-4bd5-9199-b250115b844c@lunn.ch>
 <3a27097f-f7d0-4cb2-8e43-9e53327dcd7a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a27097f-f7d0-4cb2-8e43-9e53327dcd7a@gmail.com>

On Wed, Nov 06, 2024 at 02:28:54PM +0100, Heiner Kallweit wrote:
> On 05.11.2024 22:06, Andrew Lunn wrote:
> > On Mon, Nov 04, 2024 at 11:07:20PM +0100, Heiner Kallweit wrote:
> >> Vendor driver r8125 doesn't advertise 2.5G EEE on RTL8125A, and r8126
> >> doesn't advertise 5G EEE. Likely there are compatibility issues,
> >> therefore do the same in r8169.
> >> With this change we don't have to disable 2.5G EEE advertisement in
> >> rtl8125a_config_eee_phy() any longer.
> >> Note: We don't remove the potentially problematic modes from the
> >> supported modes, so users can re-enable advertisement of these modes
> >> if they work fine in their setup.
> >>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> ---
> >>  drivers/net/ethernet/realtek/r8169_main.c       |  7 +++++++
> >>  drivers/net/ethernet/realtek/r8169_phy_config.c | 16 ++++------------
> >>  2 files changed, 11 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> >> index e83c4841b..4f37d25e0 100644
> >> --- a/drivers/net/ethernet/realtek/r8169_main.c
> >> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> >> @@ -5318,6 +5318,13 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
> >>  		phy_support_eee(tp->phydev);
> >>  	phy_support_asym_pause(tp->phydev);
> >>  
> >> +	/* mimic behavior of r8125/r8126 vendor drivers */
> >> +	if (tp->mac_version == RTL_GIGA_MAC_VER_61)
> >> +		linkmode_clear_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> >> +				   tp->phydev->advertising_eee);
> >> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> >> +			   tp->phydev->advertising_eee);
> > 
> > Hi Heiner
> > 
> > phy_device.c has:
> > 
> > /**
> >  * phy_remove_link_mode - Remove a supported link mode
> >  * @phydev: phy_device structure to remove link mode from
> >  * @link_mode: Link mode to be removed
> >  *
> >  * Description: Some MACs don't support all link modes which the PHY
> >  * does.  e.g. a 1G MAC often does not support 1000Half. Add a helper
> >  * to remove a link mode.
> >  */
> > void phy_remove_link_mode(struct phy_device *phydev, u32 link_mode)
> > {
> >         linkmode_clear_bit(link_mode, phydev->supported);
> >         phy_advertise_supported(phydev);
> > }
> > EXPORT_SYMBOL(phy_remove_link_mode);
> > 
> > Maybe we need a phy_remove_eee_link_mode()? That could also remove it
> > from supported? At minimum, it would stop MAC drivers poking around
> > the insides of phylib.
> > 
> After checking eee_broken_modes in more detail:
> In general it does what I need, it prevents broken EEE modes from being
> advertised. Some challenges:
> 
> - eee_broken_modes currently represents eee_cap1 register bits.
>   So it's not possible to flag 2.5G or 5G EEE as broken.
>   - We would have to change eee_broken_modes to a linkmode bitmap.
> 
> - eee_broken_modes can be populated via DT only.
>   of_set_phy_eee_broken() would have to be changed to operate on
>   fwnodes. Then I may be able to "inject" the broken modes in my
>   case as swnode's.
>   Not the easiest solution, but maybe the cleanest. Feedback welcome.

I probably would not go as far as adding swnode support for something
so simple. Just add phy_remove_eee_link_mode() or maybe
phy_set_eee_broken() as i suggested to set bits in
phydev->eee_broken_modes.

And converting it to a linkmode bitmap is probably needed in the long
term anyway. the change does not look too invasive, eee_broken_mode is
not used in many places.

I say go for it.

	Andrew

