Return-Path: <netdev+bounces-238874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF5AC60AD8
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 21:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76043AD150
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 20:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D5D22370A;
	Sat, 15 Nov 2025 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SwEcspr1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2619D219A8A;
	Sat, 15 Nov 2025 20:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763239017; cv=none; b=eAJSvOjEJ5ioXcafgQLfulIpoz1yTYc2u9P89C3st1JlnTfIlf8uv1pIb+DTdB73mAuf8LKhqrNEMjHcictLWBO01+IMw7GBspGliXn9GerlH5vZF275E2TDuLu4nmS+H8scO5OJlX4eUR83YhRO6YuyyjD9DdQNSTt/7w1o2sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763239017; c=relaxed/simple;
	bh=v18CVjKC5d773x8flfaLcDgBqoAJielhcHyW7LiqnIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxB8idalAwiDzkGI4XQU4iDFL60PzFfKZSIlz7+XZoVorI35unXoRsCUV6e9jmHetuhflypMIWep8bSDB0ALDFDCb4rTNKTEOsDPX9+wdWgoCc58zIO3LMfpPRinUMc6SlBjeGCD2njLiVN/g3cNgzQ5B5I4Bfn9xwzFw8z70yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SwEcspr1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ciSbI/w/Itpo1/nIDh+lpEP4Lis78IruFuj26WpJ1DM=; b=SwEcspr1qNcJZFWRIV6/lRppBH
	M2ThBSbVg4iUake5HFIfJkQqeW2FCAyqOmlljFRtkBRn6ahv5QuEeAUWZdRysAYamHKDF1hPCt0Hx
	lCH7D5qZpAoI4CILQ6AIc1X13xu8i2uqL6+Wa1Mde6JwPKvOkBUHQ/oFETEcDgUwA4nk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vKN0m-00E6u6-Df; Sat, 15 Nov 2025 21:36:44 +0100
Date: Sat, 15 Nov 2025 21:36:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: linux@armlinux.org.uk, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	eric@nelint.com, maxime.chevallier@bootlin.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phylink: add missing supported link modes for
 the fixed-link
Message-ID: <fc57fba2-26c2-4b8a-b0f5-1b3c4d1b9bef@lunn.ch>
References: <20251114052808.1129942-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114052808.1129942-1-wei.fang@nxp.com>

On Fri, Nov 14, 2025 at 01:28:08PM +0800, Wei Fang wrote:
> Pause, Asym_Pause and Autoneg bits are not set when pl->supported is
> initialized, so these link modes will not work for the fixed-link.
> 
> Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link configuration")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/phy/phylink.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 9d7799ea1c17..918244308215 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -637,6 +637,9 @@ static int phylink_validate(struct phylink *pl, unsigned long *supported,
>  
>  static void phylink_fill_fixedlink_supported(unsigned long *supported)
>  {
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, supported);

Do these make sense? There is no PHY, so there is no autoneg? So why
is autoneg in supported?

You can force pause at the MAC with ethtool:

ethtool -A|--pause devname [autoneg on|off] [rx on|off] [tx on|off]

with autoneg off, rx and tx are directly applied to the MAC. But to do
that, are these bits needed in supported?

Maybe you should explain what problem you are seeing?

	Andrew

