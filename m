Return-Path: <netdev+bounces-129552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09899846A7
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 15:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0C91C229F2
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 13:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB5B1A7074;
	Tue, 24 Sep 2024 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJTRJiK2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5492E1A7063;
	Tue, 24 Sep 2024 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727184074; cv=none; b=LO9Q9acqaMKRk7vqnclgUFDdGjR4lzVqQjsQicG3pxPOgeub9/oNixn39KehwkcloqoBsIe5vC9WEMe3IVnYKM7i9AuS5aR4jTu5xH6XD9HOyPsU8Q6naA8LKdKUwvLiTOT32LdVUPheuuxWjP1K99KV4t2BP00Cqa4KsHT8WkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727184074; c=relaxed/simple;
	bh=HIgbNKlAg3/uEnoKTvuGqqCOsEeXLEcwJ/goJOQTiV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItJCTmIxHMhBBkYrQESQ81q4jnDPD1kLh/TSDqMYW29rmVJw4ZGIpxcSdxLk1YzHtcuIHPXO28gLY7M8D7BsHRu075Ujri/vomuQXmTMYDpO6lfzoyFCOah7j1FHc/GcZLLzzzoOLsaR/cXbenaQ7xvVvyekTxB6K0/4868lUm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJTRJiK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B7CC4CEC7;
	Tue, 24 Sep 2024 13:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727184073;
	bh=HIgbNKlAg3/uEnoKTvuGqqCOsEeXLEcwJ/goJOQTiV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lJTRJiK2ZdxEvoSqCqNjX6jRxuHsw6j1Vw9IAMfPcW7kNFaDiDW8LSzWuvHZtgNT3
	 MfozzTqUKhqAwsLCZ3OQGcJQIkagtvUpyt204pK+D9sJER2Gmd8T3/fnZD683dYj18
	 +zomZtEGWEQIt+ISWK3R1bsg8ngYkoUWtuDIjhbCng5NXsWZMhuEPOK/TSoP7iNwZ3
	 zvV0uGc+e14CwzBAOoKAcilfY0EG4+vfx6BGdt/pho5cwrYzJByattdbDiLl2WbZM9
	 wah9enhMSnmjbAOQa42LV8nngIS1DFICPwE2k1RSeZJ9OFMVhXjGfUX4d0w0TO9bbT
	 qEA/SUZ5WvRvg==
Date: Tue, 24 Sep 2024 14:21:09 +0100
From: Simon Horman <horms@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: Make OA_TC6 config symbol invisible
Message-ID: <20240924132109.GK4029621@kernel.org>
References: <9ebc58517c35a3afc4b19c3844da74984c561268.1727173168.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ebc58517c35a3afc4b19c3844da74984c561268.1727173168.git.geert+renesas@glider.be>

On Tue, Sep 24, 2024 at 12:20:32PM +0200, Geert Uytterhoeven wrote:
> There is no need to ask the user about enabling OPEN Alliance TC6
> 10BASE-T1x MAC-PHY support, as all drivers that use this library select
> the OA_TC6 symbol.  Hence make the symbol invisible, unless when
> compile-testing.
> 
> Fixes: aa58bec064ab1622 ("net: ethernet: oa_tc6: implement register write operation")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/net/ethernet/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Geert,

I'm not really convinced this is a fix rather than an enhancement for
net-next.  So my suggestion would be to repost, targeted at net-next, and
without a Fixes tag.

	Subject: [PATCH net-next] ...

In that scenario, if you wish to refer to the commit that introduced this
problem, then you can use the following in the commit message instead
of the Fixes tag. Unlike the fixes tag, I believe it can be line-wrapped.

commit aa58bec064a ("net: ethernet: oa_tc6: implement register write operation")

As it happens, net-next is currently closed for the v6.12 merge window. And
non-RFC patches for net-next should be posted after it re-opens. Which is
scheduled for after the release of v6.12-rc1.

Sorry for all the process nits :^)

-- 
pw-bot: defer

