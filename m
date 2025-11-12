Return-Path: <netdev+bounces-238123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C27C5462D
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 21:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B81F34344C
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 20:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99116280329;
	Wed, 12 Nov 2025 20:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GqehtCo0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B508419F137;
	Wed, 12 Nov 2025 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978409; cv=none; b=cNUyFrl0nT7eCP5aXIV0C0BxvYMuuFmpFCQGuyUYtSZLTNgBoOZG9TqK1YjJerPOIJIkX2SJzf7V7J3Oe8RsifbWSAlj2L5EwX4st+f8KPmuLCjuvOpQiD1Yxhch4VcX/o4fRLfHIlETBHlzM9Vtc5MgDtGRt+62aTryYDmUdvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978409; c=relaxed/simple;
	bh=jKookoDhnVybNYrtm2DQ1GPIqnubMpj/CdSHLOtCdHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rowhEvnOpQxZtZd0mKiB16SIOWGeW/juyytVFwFBsZEAb4CMt+SIVbNiOqvkTtSee7AVEjzh4QrDwHKq5/JTQ4hPLtZ3O/z2+WnDHzbX0HtGgI4SLXRoe1a7J+6p1DaAcSDYzuUWuCGi1Yau/OC6Knt2SKVksDPOVQsQ/8c7hWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GqehtCo0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4vxYXcF2Pj0hRrrKxi4gDBrIQdytgM6fvDVm0un7Y3E=; b=GqehtCo02TKWsD53JUWrfBT+hp
	m7qITRl/Kxu7S8YdH0uELYUt5I+7EcXhf77vFlLdffkBB7UKcoy3bZXGsWqbGWSW9Slk/gmFdHvMX
	QwG6xSVqaKfABi9lUhkJHKmw/bGzpIhx0yui/OfMXBWl4M+JF28sFBGssfWph9y5cu6I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vJHDO-00DmiF-38; Wed, 12 Nov 2025 21:13:14 +0100
Date: Wed, 12 Nov 2025 21:13:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, eric@nelint.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] net: fec: remove useless conditional
 preprocessor directives
Message-ID: <28badd8f-8c76-4e88-bcb2-49ed5026c1af@lunn.ch>
References: <20251111100057.2660101-1-wei.fang@nxp.com>
 <20251111100057.2660101-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111100057.2660101-2-wei.fang@nxp.com>

On Tue, Nov 11, 2025 at 06:00:53PM +0800, Wei Fang wrote:
> The conditional preprocessor directive "#if !defined(CONFIG_M5272)" was
> added due to build errors on MCF5272 platform, see commit d13919301d9a
> ("net: fec: Fix build for MCF5272"). The compilation error was caused by
> some register macros not being defined on the MCF5272 platform. However,
> this preprocessor directive is not needed in some parts of the driver.
> First, removing it will not cause compilation errors. Second, these parts
> will check quirks, which do not exist on the MCF7527 platform. Therefore,
> we can safely delete these useless preprocessor directives.

> @@ -2515,9 +2513,7 @@ static int fec_enet_mii_probe(struct net_device *ndev)
>  		phy_set_max_speed(phy_dev, 1000);
>  		phy_remove_link_mode(phy_dev,
>  				     ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
> -#if !defined(CONFIG_M5272)
>  		phy_support_sym_pause(phy_dev);
> -#endif
>  	}

I think the explanation could be better.

I assume the M5272 only supported Fast Ethernet, so fep->quirks &
FEC_QUIRK_HAS_GBIT was never true?

>  	else
>  		phy_set_max_speed(phy_dev, 100);
> @@ -4400,11 +4396,9 @@ fec_probe(struct platform_device *pdev)
>  	fep->num_rx_queues = num_rx_qs;
>  	fep->num_tx_queues = num_tx_qs;
>  
> -#if !defined(CONFIG_M5272)
>  	/* default enable pause frame auto negotiation */
>  	if (fep->quirks & FEC_QUIRK_HAS_GBIT)
>  		fep->pause_flag |= FEC_PAUSE_FLAG_AUTONEG;
> -#endif

Same here?

Maybe the commit message should actually say that M5272 only supported
Fast Ethernet, so these conditions cannot be true, and so the #ifdef
guard can be removed.

    Andrew

---
pw-bot: cr

