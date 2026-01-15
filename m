Return-Path: <netdev+bounces-250244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 714F2D25A0F
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACD44309BE74
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 16:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1733B8D72;
	Thu, 15 Jan 2026 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBo8grPF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF023B8D6F
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768493236; cv=none; b=Fskm9CtsZt4DObbmEOI18kf5/Uci4d8LUEFDfunKiwu2OTLfv3V6YO/PhEA4Cs/dRxJ+NtU4YhT2UNQyMpe3Dxd7iEtakf2I/RdUd8ovnea4NQhrTkIYBXB9qRpkxql2Da1hyQrvQBkeWvNuZvgDRewev1xNL+Fy3DqOIVODv9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768493236; c=relaxed/simple;
	bh=nBmoDHO2R0a4JYQRSShF47usB+o/lY7TK/w/u56HbK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7khjxm2LXYOGiRMGzD0bLDQj2xe1obT4iUPf8XRmcsPS43/+U3p0W3WFUfTrbz5oLXgp2j/u8cjJZkmQ46b9Y518mP5+rxV4KTvgXpsBdp/joESisUHfUYmyq2C5pmBw4IT+6tN+iusuxnkluTIvW6ZrnOcKaGXzd5gqFDEOjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBo8grPF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE72FC19421;
	Thu, 15 Jan 2026 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768493236;
	bh=nBmoDHO2R0a4JYQRSShF47usB+o/lY7TK/w/u56HbK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBo8grPFeuWXN1+PX9uXtzYbEtxmihakuI9+BMsBAiZqfC2RbIXx5m6CDuovFzrB0
	 8xEPFlRdcP9ilGZeo+bGqeEsAmBiTNpkCWuqmyzOH2tvc9wWsO+FyvfGsqEOP/Ic/5
	 FuaGugiAHBYM8LCvi6HjLXCqYKGUA2qtrjO0S8tllxDmp7TlskyiBz07LMWHKLFJiW
	 tkQCCvqz3jTbPRw9UDbdvfUdOVYn59ANuDsw0KKIvsveHrwRABCUFPWFh7sxtWSc48
	 OY9mxV8V6G5kAUwTsriAVmAT0zvT/MyLxOVHM+H3b2nXcvT9ye4zW6F/hrSzpDLHy3
	 pr5GM20cUIrAw==
Date: Thu, 15 Jan 2026 16:07:11 +0000
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next] net: ethernet: dnet: remove driver
Message-ID: <aWkQr4ra0uEw2KFE@horms.kernel.org>
References: <cef7c728-28ee-439f-b747-eb1c9394fe51@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cef7c728-28ee-439f-b747-eb1c9394fe51@gmail.com>

On Mon, Jan 12, 2026 at 09:11:04PM +0100, Heiner Kallweit wrote:
> This legacy platform driver was used with some Qong board. Support for this
> board was removed with e731f3146ff3 ("Merge tag 'armsoc-soc' of
> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc") in 2020.
> So remove this now orphaned driver.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - remove related config in arch/mips/configs/ip27_defconfig

Thanks,

It's nice to get rid of unused code.

I might have cited commit c93197b0041d ("ARM: imx: Remove i.MX31 board files").
But that notwithstanding this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

