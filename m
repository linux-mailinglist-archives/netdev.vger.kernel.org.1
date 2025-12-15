Return-Path: <netdev+bounces-244778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D4DCBE9AC
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 16:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20E7830253F3
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8180D346FC4;
	Mon, 15 Dec 2025 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="So3y0NSe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A274346FC3;
	Mon, 15 Dec 2025 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765810001; cv=none; b=EGrTutsmUOEtrUeDU7Vyn+bO7koJQfNSJ9QHTeBC7KXDd7ui0uRjFef/L50QlkCH20sf4obxL1WBrfL+CxBk5aw0tZkwE8Ytu1JThhn1SPazah9Qt/A2zMaZYUHKauSAXDulZnXcBg7ZXv4DGw+ULXPYC6VVarFg8936LXPtO/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765810001; c=relaxed/simple;
	bh=9owYTMV4BIdjEIFVsMwY/OJT1Ieh/JcXdMXGrAXASe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luhNcAVj6w09sXnqFbwRvJ6bOzqycaG+bkDohk+M6mG7T11rUC09WhUbAT6NxVHMowqbRELdtluLrYyCRUmJL7KQm+FYOkW0lu6j2OV//ztMdo7bBCWexY4pi1eQY0oCNNatp25LuAzxR1KgVZJiyLyDMMiZazI5uKeKBynSXeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=So3y0NSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E99C4CEF5;
	Mon, 15 Dec 2025 14:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765810001;
	bh=9owYTMV4BIdjEIFVsMwY/OJT1Ieh/JcXdMXGrAXASe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=So3y0NSegHHnFdghVIWOADnUZkbrTE9dw3Vw7OeoUNPSuiXzOOky+4Mh/BkeECr0w
	 bno4HFcrzTa+Y6f12OhjATSfvOxPuEs8QPyT5zBDmfOutiLrawdmo/ULddaOy91jCD
	 z3BSn/E1Aiyn9WMCLYfwnJupvWwJCsdNS7nwp0n/rn0K/S8+pkRSxKIy5i9intKPjp
	 y1QAXkWYCnh64cH3mtBmSRYPgAEMUlbgFZ697xS6szRAQ/Z1psEwcaAlBi0It4Dghu
	 WPNQKVSogTpfYBZR5e+x2S4EP4G1+GJiP8VWntrydronHAuDztlU3ipUeS9mkxzZJ6
	 ghpH8qNYoxe6Q==
Date: Mon, 15 Dec 2025 14:46:35 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, Frank.Sae@motor-comm.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, salil.mehta@huawei.com,
	shiyongbang@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/6] Support PHY LED for hibmcge driver
Message-ID: <aUAfS9EtzHqqZztu@horms.kernel.org>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215125705.1567527-1-shaojijie@huawei.com>

On Mon, Dec 15, 2025 at 08:56:59PM +0800, Jijie Shao wrote:
> Support PHY LED for hibmcge driver
> 
> Jijie Shao (6):
>   net: phy: change of_phy_leds() to fwnode_phy_leds()
>   net: phy: add support to set default rules
>   net: hibmcge: create a software node for phy_led
>   net: hibmcge: support get phy_leds_reg from spec register
>   net: hibmcge: support get phy device from apci
>   net: phy: motorcomm: fix duplex setting error for phy leds

...

## Form letter - net-next-closed

net-next is currently closed for new drivers, features, code refactoring and
optimizations. We are currently accepting bug fixes only.

net-next was closed when the merge window for v6.19 began. And due to a
combination of the travel commitments of the maintainers, and the holiday
season, net-next will not re-open until after 2nd January.

Please repost when net-next reopens.

RFC patches sent for review only are welcome at any time.

Thanks for your understanding.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

-- 
pw-bot: defer

