Return-Path: <netdev+bounces-250759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EBFD391E5
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 01:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4B94300ACC7
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 00:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BFF450FE;
	Sun, 18 Jan 2026 00:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkDnCAIL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210E92BB13;
	Sun, 18 Jan 2026 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768696386; cv=none; b=FyPhmJ7vyM2dwyOCA6LEMW0tQA5BfxNdMAyZa2fi0OTEczaT+Iz6UXjWdKQ1XrH6MzQPhxy3dNwQKvwg58frucMwOLsY2m2RnD7FBK+6ERl3p/kjS8j0suqca4X63QHUrtADjPkcqW1yxLDM5B3eavn1Mx3Wf9V+ZAQvEV33/xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768696386; c=relaxed/simple;
	bh=9qYSCGBlbg9UIS1cuIDLcrI/IRjqlqjgCkiZkoOotfc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjbJw2o/gw/RrB4c3qfCnn2nzJKnpFOcaVOWc96pU7w0s3zfcKacfjbr+lMtZapnoyESY5x5/H0C/xJOYcA2w1A1SsiUbGmP2UpJnge3kfNoMcm5IL0qnLmYexsbIoPWJ5s8BpxIsnaic6W4ZoL1ERu6omw0Uev5huHEIjn+xx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkDnCAIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A162C4CEF7;
	Sun, 18 Jan 2026 00:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768696385;
	bh=9qYSCGBlbg9UIS1cuIDLcrI/IRjqlqjgCkiZkoOotfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tkDnCAIL03x/ftLC7pNt4qYFCVJJahYptKbsPzuIZos/Hj4fdRd2FfRlZMON0umKF
	 lI1AihUX9dOeUpbEu4hM2l6ExrlQO3wzWAMG9ZSRD8g4GDp1FpJAT7nzrG+cxbgI1F
	 MwN+Hm3asj8ocuHpqP9dOXCEO3GwrvnqkLe7sntAxM8IAJ61dkmrALLQQz2OMkOtp5
	 ih9tKkpEfP3wop4Nfpoo+hC5WomB64Ez4w+mPEt6yZza1ewr6No/wWEG0m8g/1jNFX
	 IppkaXOh/8Eb276ilagTwF29PVI+etoKzGolnJBZtkcFVqRZurN/e2ZCKQtaaG0+dU
	 dZljXXZ3YOQ4w==
Date: Sat, 17 Jan 2026 16:33:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net/tcp_sigpool: Enable compile-testing
Message-ID: <20260117163304.20caae7c@kernel.org>
In-Reply-To: <e4822cf4aa03fed067f5df7cd4f3496828abc638.1768487199.git.geert+renesas@glider.be>
References: <e4822cf4aa03fed067f5df7cd4f3496828abc638.1768487199.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 15:27:26 +0100 Geert Uytterhoeven wrote:
> Since commit 37a183d3b7cdb873 ("tcp: Convert tcp-md5 to use MD5 library
> instead of crypto_ahash"), TCP_SIGPOOL is only selected by TCP_AO.
> However, the latter depends on 64BIT, so tcp_sigpool can no longer be
> built on 32-bit platforms at all.
> 
> Improve compile coverage on 32-bit by allowing the user to enable
> TCP_SIGPOOL when compile-testing.  Add a dependency on CRYPTO, which is
> always fulfilled when selected by TCP_AO.

I don't see why we'd care. I understand COMPILE_TEST when the symbol
is narrowed down to a very unusual platform. But this is doing the
opposite, it's _adding_ a very unusual platform on which, as you say,
this code cannot be used today. If this code regresses and someone
wants to start using it on 32b they'll have to fix it.

Please LMK if I'm misunderstanding or there's another argument (not
mentioned in the commit message).
-- 
pw-bot: cr

