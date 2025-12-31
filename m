Return-Path: <netdev+bounces-246421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A032ACEBC22
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 11:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A71E30080D4
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9F1230BCB;
	Wed, 31 Dec 2025 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="wWTpfti6"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC437081E;
	Wed, 31 Dec 2025 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767176234; cv=none; b=E43v+97vzSHM3bLp5m7x1Y7uAUPaRvoVUx9qQXows1lRF2yyGDjOukaCOPOwYCfRp3D1/GXjeQiy5d7AIZsln4sHiup40hb41JrlsV/0RelWwH1cSe1NbZ+ehVih7D41mmQW44dcRsZF/h28ZpP7AR1ExERD3NZVHmIoD8JcnBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767176234; c=relaxed/simple;
	bh=MskCS9p2/ccJXIeZRORkl0HLsqxkzQGi25wwN6yxaw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6HoixkCh1BtZMi+FUNLK0rkHnhcm6JWOtgvgQ0OSmIHmBGzrYr8SE8AOgjJsWM55+dN9mzBQXiXrHENDoT7HsFORtVH886DW6gfWiYsmgTvkscO4+nIoVHlSMhJjda/wSDw/ikWHrEAMpNRIANk8dyo7XKHrIxVKAX5tjv1PLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=wWTpfti6; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NokiJ30dAYhFuWf402Gvxr+vg7uTSyM7JUF7HNSZfvg=; b=wWTpfti6mzF0tW9v/fIXcVpTN9
	6NHaAFVRO3LJtYJIGGbsyokEC2iA9YOSz84V7m/pCzNNW0U+qMr2WpHtYZEtMJiYnhaGKBiNsRQEI
	4tMeY0U/FfBnjcv6BVkFrc9qkQj4lezziF2vp86bSNXMiV16G4C7rsdghZEbi8eRP4K0PteS/FJw/
	7+fe7QdhutXVnIO1/LT0PrnObGwZzyDFj9qfomJ5Gy5FBKHjOy2hkOum2vQ97csvyxA5jglPWOsBt
	woNUVqZF5jvGwrnzMXadZidMu/mP2GHxytIkQoFlq/9Byrd0F03DjHI6fU39+ZOKGTms1wYQV52mh
	llcA1GBw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vatGE-00Cl9C-0S; Wed, 31 Dec 2025 10:16:58 +0000
Date: Wed, 31 Dec 2025 02:16:53 -0800
From: Breno Leitao <leitao@debian.org>
To: yk@y-koj.net
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: netdevsim: fix inconsistent carrier
 state after link/unlink
Message-ID: <4xxshlplnoulncmfkinnuzvwx7bbnukkwds7go75cese4scrws@6xlfsy35t7gg>
References: <cover.1767108538.git.yk@y-koj.net>
 <c1a057c1586b1ec11875b3014cdf6196ffb2c62b.1767108538.git.yk@y-koj.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1a057c1586b1ec11875b3014cdf6196ffb2c62b.1767108538.git.yk@y-koj.net>
X-Debian-User: leitao

Hello Yohei,

On Wed, Dec 31, 2025 at 01:03:29AM +0900, yk@y-koj.net wrote:
> From: Yohei Kojima <yk@y-koj.net>
> 
> This patch fixes the edge case behavior on ifup/ifdown and
> linking/unlinking two netdevsim interfaces:
> 
> 1. unlink two interfaces netdevsim1 and netdevsim2
> 2. ifdown netdevsim1
> 3. ifup netdevsim1
> 4. link two interfaces netdevsim1 and netdevsim2

> 5. (Now two interfaces are linked in terms of netdevsim peer, but
>     carrier state of the two interfaces remains DOWN.)

That seems a real issue, in fact. The carriers are only getting up when
opening the device, not when linking. Thus, this patch makes sense to
me.

> This inconsistent behavior is caused by the current implementation,
> which only cares about the "link, then ifup" order, not "ifup, then
> link" order. This patch fixes the inconsistency by calling
> netif_carrier_on() when two netdevsim interfaces are linked.
> 
> This patch fixes buggy behavior on NetworkManager-based systems which
> causes the netdevsim test to fail with the following error:
> 
>   # timeout set to 600
>   # selftests: drivers/net/netdevsim: peer.sh
>   # 2025/12/25 00:54:03 socat[9115] W address is opened in read-write mode but only supports read-only
>   # 2025/12/25 00:56:17 socat[9115] W connect(7, AF=2 192.168.1.1:1234, 16): Connection timed out
>   # 2025/12/25 00:56:17 socat[9115] E TCP:192.168.1.1:1234: Connection timed out
>   # expected 3 bytes, got 0
>   # 2025/12/25 00:56:17 socat[9109] W exiting on signal 15
>   not ok 13 selftests: drivers/net/netdevsim: peer.sh # exit=1
> 
> This patch also solves timeout on TCP Fast Open (TFO) test in
> NetworkManager-based systems because it also depends on netdevsim's
> carrier consistency.
> 
> Fixes: 1a8fed52f7be ("netdevsim: set the carrier when the device goes up")
> Signed-off-by: Yohei Kojima <yk@y-koj.net>

Reviewed-by: Breno Leitao <leitao@debian.org>

Thanks for the fix!

