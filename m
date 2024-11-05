Return-Path: <netdev+bounces-142094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD399BD76F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25CC1B21D6F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 21:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD830215C68;
	Tue,  5 Nov 2024 21:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Op8vJOlo"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132E81D9A48
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 21:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730840828; cv=none; b=QdXc5YShC5+m62p3CaapyawnFfFkvJgz2pVSCB9gRMslqkT6OaWIJYZTofQ46XtMFYbiy8IJ2E4+tGFuIFtGNZ1DgGzSnDF7fEQGOM8fRmkx8Mv0fPA3U9/tp5dZeWo9XFazd7fwdtUKjpiizkSpPiJYCG3SD3JBt+6J76Q8ItQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730840828; c=relaxed/simple;
	bh=TJzk4F76g4LwZ3I9ALBWjxagp05Gyn66gsgAWCo8kLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNoMjtlo7J93QBJp5eXWlO8yG/e5tOvwtOxG1lTqijO5ZSGxB3s4tIHoG+wz7FCJekvhdbISjUeIL5rx/UEukaCCYdGYmHk9TXUWoA3VEAtHdudz5G4GiRGTpVISPcQ5E/bc13A+qR//6s7NzouaBzNj0qguOZF5HkMmsKLvdDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Op8vJOlo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RijrwSR996jc8zmkXUnW0yxsceb4awN7BsqNEiuedsc=; b=Op8vJOloiZnKstWUxcBR+7p7SB
	k52V+ldeS0VaTOhRJQpWshz2Bon6/o3AFOGP0S02tF9+Cmeux6QY96R+d1AryZivrKrqckbEP45sI
	C2fznfiR641VN9+IdHq6HiYjO5RhFr4+MyEcZhgF9eIaGJ+0Fn87mUpaanzCPzTmV9QA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t8QlK-00CFrk-Sh; Tue, 05 Nov 2024 22:06:54 +0100
Date: Tue, 5 Nov 2024 22:06:54 +0100
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
Message-ID: <5cd6ccf1-8641-4bd5-9199-b250115b844c@lunn.ch>
References: <4677d3c4-60e2-4094-81a8-adae42ca46bb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4677d3c4-60e2-4094-81a8-adae42ca46bb@gmail.com>

On Mon, Nov 04, 2024 at 11:07:20PM +0100, Heiner Kallweit wrote:
> Vendor driver r8125 doesn't advertise 2.5G EEE on RTL8125A, and r8126
> doesn't advertise 5G EEE. Likely there are compatibility issues,
> therefore do the same in r8169.
> With this change we don't have to disable 2.5G EEE advertisement in
> rtl8125a_config_eee_phy() any longer.
> Note: We don't remove the potentially problematic modes from the
> supported modes, so users can re-enable advertisement of these modes
> if they work fine in their setup.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c       |  7 +++++++
>  drivers/net/ethernet/realtek/r8169_phy_config.c | 16 ++++------------
>  2 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index e83c4841b..4f37d25e0 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -5318,6 +5318,13 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
>  		phy_support_eee(tp->phydev);
>  	phy_support_asym_pause(tp->phydev);
>  
> +	/* mimic behavior of r8125/r8126 vendor drivers */
> +	if (tp->mac_version == RTL_GIGA_MAC_VER_61)
> +		linkmode_clear_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +				   tp->phydev->advertising_eee);
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> +			   tp->phydev->advertising_eee);

Hi Heiner

phy_device.c has:

/**
 * phy_remove_link_mode - Remove a supported link mode
 * @phydev: phy_device structure to remove link mode from
 * @link_mode: Link mode to be removed
 *
 * Description: Some MACs don't support all link modes which the PHY
 * does.  e.g. a 1G MAC often does not support 1000Half. Add a helper
 * to remove a link mode.
 */
void phy_remove_link_mode(struct phy_device *phydev, u32 link_mode)
{
        linkmode_clear_bit(link_mode, phydev->supported);
        phy_advertise_supported(phydev);
}
EXPORT_SYMBOL(phy_remove_link_mode);

Maybe we need a phy_remove_eee_link_mode()? That could also remove it
from supported? At minimum, it would stop MAC drivers poking around
the insides of phylib.

	Andrew

