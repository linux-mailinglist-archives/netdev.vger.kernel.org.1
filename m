Return-Path: <netdev+bounces-233184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69037C0DE16
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 14:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D373B55F8
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 13:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED53C248881;
	Mon, 27 Oct 2025 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nxnmg1W5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529FA2472A4;
	Mon, 27 Oct 2025 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570327; cv=none; b=JfcmFCjdV5JwZD7AroBGZa+GonbpIBr5H+OkeoA4uRjj8Oqet4v7HK/jUugVkaT/2Xg+4dwfB3qADHRxdgVqsq7TatPUQ6NJx3DUQehKxD7uAHrZSDGjxRROewJ8JLI+4Rg0od4abUrHyZNxhlV5ZyeuAEjH5Z2TfR2LZeqBbN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570327; c=relaxed/simple;
	bh=839TfhD20YSqqudkpHJzMhqGHXtXzKSSSBLgn4ksVsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXxXJOFknSaUPrT1Mv50DAjiGMTq3eW906WzgJ+l+W9kCckh17vk8qt+ogYCfL39XuEZA6gSoU4kl4YiT6F+huGi/cf3U9Iyp4mZi5MQ823pmiqYot+gszEzZNPjc9y/Cr0pg9YsDHfeYr19ScwDTfX3FzSjlwkDSaUlxHq52Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nxnmg1W5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ncp/PVaBA/Q9U0SIqwEEOoFT7L5ChKq9+lSgFL39a+c=; b=nxnmg1W5k1LWT2WsVzfgD4yPeh
	IGsDt3RI2gcp73LUnZEQBZXZLyfqtjKcwPAn6bAYga7ZCy2Z5klEHtl/F728i9H4NdNCNH9zaH55O
	e1mOWdcmH7WQ/lYxhV6y4pe0YubZNWKuZGjCoscatzjAO8tDGcyP9hl9Fk21Cy1HQZng=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDMuS-00CC5r-PB; Mon, 27 Oct 2025 14:05:16 +0100
Date: Mon, 27 Oct 2025 14:05:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy:  micrel: lan8842 erratas
Message-ID: <4eefecbe-fa8f-41de-aeae-4d261cce5c1f@lunn.ch>
References: <20251027124026.64232-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027124026.64232-1-horatiu.vultur@microchip.com>

On Mon, Oct 27, 2025 at 01:40:26PM +0100, Horatiu Vultur wrote:
> Add two erratas for lan8842. The errata document can be found here [1].
> This is fixing the module 2 ("Analog front-end not optimized for
> PHY-side shorted center taps") and module 7 ("1000BASE-T PMA EEE TX wake
> timer is non-compliant")

Hi Horatiu

Could this be split into two patches, since there are two erratas?

I notice there is no Fixes: tag. So you don't think these are worth
back porting?

	Andrew

