Return-Path: <netdev+bounces-244777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23700CBE9D1
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 16:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B9F03096D34
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C1F346761;
	Mon, 15 Dec 2025 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptW39etb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E42C345CDC
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765809974; cv=none; b=kkhzB7+TVN9zq8C8alZRsq7hz9EzQaJoK4JMcFSkVScnwOxITFem0VwbEMqQ126f2VEITz9qb9NSNxcAv+yimv0mrKa9Ff/q1CERgS9CDU2J8nxkPO2PXpqpNO9WHWsPIXJoV6A13NYFYP335FRoIguXxOrqvwinERN3NiAVcW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765809974; c=relaxed/simple;
	bh=cpkThU/iDZPNl2WUb1A/xyooDs7xq9cIb/W7GIlL8sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/drxyW6GSHi6uUi1Nv5P+92tDxv4vUjdq/VpGc8xZJafNsW/uxSmKdrTpUV/ZRQkGnDXK8g4e2RjB0IQJHAUWZjsCMS+ai/w+oWiE8D4YJ16hSajyb4SAYv+yriAhj4SJ+y0ZCkEvfmGN6Jg7KWSErlPNsoWS9tKrj0Rl0bKB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptW39etb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55485C4CEF5;
	Mon, 15 Dec 2025 14:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765809973;
	bh=cpkThU/iDZPNl2WUb1A/xyooDs7xq9cIb/W7GIlL8sQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ptW39etb4Uuv1LtxqrQslKQtHnJxPnOP1UnEkYmEnX0hY7kk82Ys2eE7NR2A6ThVV
	 M4qgVjqpDVW93I1mu+OQymetOY7nFSZB+l6EsTcfMFOb5bBioRudMbNasjvrxiWc0r
	 JZm5W6grM7wYJtenI3g/lj2m0SXPEqs175n89mN60lR/KtiDMqC3Uf6B5YiiD6ZWxt
	 L0LRJoRnxnLONbxt8E9xOcJ4dS7gHaRFMQxz3ySHiSwOn/N2D8TKe24uHO7/iZSHbp
	 xzNu62b3pWR6D1DPIA6d5kQ8NMLyNzFGfOuHjEy1RW/8A9hKRF7vSuSzrQAYCfRExN
	 r11yI2aWCMASw==
Date: Mon, 15 Dec 2025 14:46:09 +0000
From: Simon Horman <horms@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: netdev@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>,
	Ian MacDonald <ian@netstatz.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jay Vosburgh <jv@jvosburgh.net>
Subject: Re: [PATCH net-next v2 0/5] net: thunderbolt: Various improvements
Message-ID: <aUAfMYxit0aC_BZa@horms.kernel.org>
References: <20251215121109.4042218-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215121109.4042218-1-mika.westerberg@linux.intel.com>

On Mon, Dec 15, 2025 at 01:11:04PM +0100, Mika Westerberg wrote:
> Hi all,
> 
> This series improves the Thunderbolt networking driver so that it should
> work with the bonding driver. I added also possibility of channing MTU
> which is sometimes needed, and was part of the original driver.
> 
> The discussion that started this patch series can be read below:
> 
>   https://lore.kernel.org/netdev/CAFJzfF9N4Hak23sc-zh0jMobbkjK7rg4odhic1DQ1cC+=MoQoA@mail.gmail.com/
> 
> The previous version of the series can be seen here:
> 
>   v1: https://lore.kernel.org/netdev/20251127131521.2580237-1-mika.westerberg@linux.intel.com/

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

