Return-Path: <netdev+bounces-95538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EF78C28AE
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 18:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA6A1F23228
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 16:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1817A174EC3;
	Fri, 10 May 2024 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i0d056CB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154B5446BD;
	Fri, 10 May 2024 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715358141; cv=none; b=gOTJNGjJnavmxX9uRZ0N/WeyDJVS9dyJ9EpxJAKzhA9xTJkQvcN+niuJz4ocUlXQsfeW6cqi3l50f1uUpKIkGppXsv5qF5ITvDdGSCoXZns5D1hufXFM9oD+T1XXsh58KefjEuMZYOrhXRwW/d25czbmb0xdxQ66VJ9Yk7XfwQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715358141; c=relaxed/simple;
	bh=f5Lyl73/buxOPCrNGhmeGwJJGuEKE+nFnd9kTzyxINg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gu2fNfHlwcJxcmLwigU/XTEVj6hJS1VYj5gZtDcCiw/D5SEdFL5dziN6D2LAO3PT8LB3eTVB2PBR1JYjaJMEGtDDQSKinOW2/gtptvYKLc8JmZSw3P73DOzbpjM8nwa7MkXkt3hSBLhgikshBGc8krkyNUO+NiG9BvxQz/yiNH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=i0d056CB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=jteZ0Puod1sISdOydEueJECfJg+J6qXBz+kx/rQs/VY=; b=i0
	d056CBXtLAnuBEGPK3M2nRjkWiCBcubeqSymv+R03oAd2lBoif2/NnxOGH0XbGDpgKDKNCaBcKJnG
	RO9MkWAdG5HP+5fNWXcRneBsNoWVn3OrRzP8+bMAB4IYEpY66FmHUGkutW9vwPb16cMHR2h1jFWRG
	c+n+Sy75kioeUFs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s5T0J-00F9SY-It; Fri, 10 May 2024 18:21:51 +0200
Date: Fri, 10 May 2024 18:21:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: arnd@arndb.de, davem@davemloft.net, edumazet@google.com,
	gerg@linux-m68k.org, glaubitz@physik.fu-berlin.de, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	nico@fluxnic.net, pabeni@redhat.com
Subject: Re: [PATCH v3] net: smc91x: Fix m68k kernel compilation for ColdFire
 CPU
Message-ID: <d9b4b726-7c31-4fbb-936e-e4ee505a66a1@lunn.ch>
References: <20240509213743.175221-3-thorsten.blum@toblux.com>
 <20240510113054.186648-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240510113054.186648-2-thorsten.blum@toblux.com>

On Fri, May 10, 2024 at 01:30:55PM +0200, Thorsten Blum wrote:
> Compiling the m68k kernel with support for the ColdFire CPU family fails
> with the following error:
> 
> In file included from drivers/net/ethernet/smsc/smc91x.c:80:
> drivers/net/ethernet/smsc/smc91x.c: In function ‘smc_reset’:
> drivers/net/ethernet/smsc/smc91x.h:160:40: error: implicit declaration of function ‘_swapw’; did you mean ‘swap’? [-Werror=implicit-function-declaration]
>   160 | #define SMC_outw(lp, v, a, r)   writew(_swapw(v), (a) + (r))
>       |                                        ^~~~~~
> drivers/net/ethernet/smsc/smc91x.h:904:25: note: in expansion of macro ‘SMC_outw’
>   904 |                         SMC_outw(lp, x, ioaddr, BANK_SELECT);           \
>       |                         ^~~~~~~~
> drivers/net/ethernet/smsc/smc91x.c:250:9: note: in expansion of macro ‘SMC_SELECT_BANK’
>   250 |         SMC_SELECT_BANK(lp, 2);
>       |         ^~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> 
> The function _swapw() was removed in commit d97cf70af097 ("m68k: use
> asm-generic/io.h for non-MMU io access functions"), but is still used in
> drivers/net/ethernet/smsc/smc91x.h.
> 
> Use ioread16be() and iowrite16be() to resolve the error.
> 
> Fixes: d97cf70af097 ("m68k: use asm-generic/io.h for non-MMU io access functions")
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
> Changes in v2:
> - Use ioread16be() and iowrite16be() directly instead of re-adding
>   _swapw() as suggested by Arnd Bergmann and Andrew Lunn
> 
> Changes in v3:
> - Add Fixes: tag

This is for net.

Cc: <stable@vger.kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

