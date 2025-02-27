Return-Path: <netdev+bounces-170369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2270AA48583
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999663A7CB6
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D591B3943;
	Thu, 27 Feb 2025 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2qay3Pcg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0CB1A9B5B
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 16:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674748; cv=none; b=maAdg/PZ+MRYS7+LW6qS4fegMQfNGAjzqv4MX+WiBeAM5UUeUwmju3jPnLeoRSZiWsNzyOLWi1IQfd90MDbyOB5yum7nNV2x5QtAh1jlJAQWyGWgB3bj/pTLlEUA0dihV1mIU41Inh9qplVwjPuIftxBXw8OED4rpKXA0lL5Kt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674748; c=relaxed/simple;
	bh=9vVE2pO6d5xKxhhTrDpsRmVrXeLiDyBr9cQHVp29GoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbk4tgTuCgwlBAWz62Pb56q4P/GoWwY5oGqENyZWMPHw7fnCZlaQF8R8ZZ+072XSO2eCPGmds1bDrQxnhf7btan71rWf95WCPaiDatWzYROSK3Jj7bClx9lDAUa0NGmtOboIXrvuwk2g/bLCX9bvgslNN+RccsIZAZkMuowIgek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2qay3Pcg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HrBR9b6H7tZXfdjF/q6TjeiUJ561S6ADrqTX1DVsg3w=; b=2qay3PcgwSNUno19N5QZc2XmvW
	WGLOEDlugD42oZkbLK0PGD+G/lakTcGwmlVVHeWWeHL0xoL+yuKRrSBibh5I4ZZ8KBFo+cI7LweAf
	YGUe+YgLSzaP1vRo+v6td3PYbW8/mEotEyqXHzxQOCV+ZEbfx12XlO6oQhqWK08Iv7bA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tnh0x-000elu-F6; Thu, 27 Feb 2025 17:45:35 +0100
Date: Thu, 27 Feb 2025 17:45:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC net-next 3/5] net: stmmac: simplify phylink_suspend()
 and phylink_resume() calls
Message-ID: <16e3f674-0267-47c1-8825-7f15a379332c@lunn.ch>
References: <Z8B4tVd4nLUKXdQ4@shell.armlinux.org.uk>
 <E1tnf1S-0056LC-6H@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tnf1S-0056LC-6H@rmk-PC.armlinux.org.uk>

> @@ -7927,13 +7925,9 @@ int stmmac_resume(struct device *dev)
>  	}
>  
>  	rtnl_lock();
> -	if (device_may_wakeup(priv->device) && priv->plat->pmt) {
> -		phylink_resume(priv->phylink);
> -	} else {
> -		phylink_resume(priv->phylink);
> -		if (device_may_wakeup(priv->device))
> -			phylink_speed_up(priv->phylink);
> -	}
> +	phylink_resume(priv->phylink);
> +	if (device_may_wakeup(priv->device) && !priv->plat->pmt)
> +		phylink_speed_up(priv->phylink);
>  	rtnl_unlock();
>  
>  	rtnl_lock();

Unrelated to this patch, but unlock() followed by lock()? Seems like
some more code which could be cleaned up?

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

