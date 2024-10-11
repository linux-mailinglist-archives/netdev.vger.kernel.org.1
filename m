Return-Path: <netdev+bounces-134630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6FA99A8C9
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967321F2142F
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 16:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41AE194A6F;
	Fri, 11 Oct 2024 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQBnhj2q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9098B5381E
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728663623; cv=none; b=rlNqrDnsyTnlLjkvkHcGn5Zwv4sreYGzvZTjSYzFFBRQ8s8afVA2jm5yrAQb0dlPdetNrf9IGM/Kn/Y/FQy6nzHopCSSW6L1cDuoYPmnEPzgRFAU1KygbhMiU5qF5MLV86cP3fnu6KoxtmotepimJ29W+tdN5+rxAnU5viot4JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728663623; c=relaxed/simple;
	bh=mlFbrEOI1sWXzo/T40Mu7V+gzY/cAo7lpcrNEjn1t0s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IrZ6w/BmYizlCTQTAUSCIbkvhC2PwNbLOYhRCnhBcqu4qjcKzNeWuxbT37DXBaJlEXkPZdShY/EhsLN2QLVjgNFd+BSBSOCcAQGKBs1GHVlRRJnFY6TO++iyfC6nVIvxTVPrsQkVs6K1/yGHHabfXqp3UH/y2BhFTHrscQyfcqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQBnhj2q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A691C4CEC3;
	Fri, 11 Oct 2024 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728663623;
	bh=mlFbrEOI1sWXzo/T40Mu7V+gzY/cAo7lpcrNEjn1t0s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MQBnhj2qRyZcO5EQe34LKYnw+O8pcb5MBuALYZL4KDhDrZK/j9NAiSwUIE5LOYtxU
	 rOTdQ1dqcWQ7l37o4Vu6IrY2Z+g6OdhZvMY8NajUGIxnvJoPhQSyQpu6jIjAO7DO2v
	 jCizE5erWVWtuZA+8HCVInXumHimZ6Gl+k/YILpnY9I5N51G2xQZSvt542swcLtA8T
	 fNswPmQg0dPix1k8Z5tnww1XenlU4L/lxZ42PkX4r5rtbyGq2jgFudZvZu/qjM+G9J
	 +rR5mBQtYE87Z00COqaFZnduPIJNFpTyixoj72F2FAE3X0ObPvkf6LquQZ5DcElUYA
	 B+thPZ2kbJ5Qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB011380DBC0;
	Fri, 11 Oct 2024 16:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] tcp: move sysctl_tcp_l3mdev_accept to
 netns_ipv4_read_rx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172866362777.2871296.1184945994794038542.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 16:20:27 +0000
References: <20241010034100.320832-1-edumazet@google.com>
In-Reply-To: <20241010034100.320832-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, dsahern@kernel.org,
 weiwan@google.com, lixiaoyan@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Oct 2024 03:41:00 +0000 you wrote:
> sysctl_tcp_l3mdev_accept is read from TCP receive fast path from
> tcp_v6_early_demux(),
>  __inet6_lookup_established,
>   inet_request_bound_dev_if().
> 
> Move it to netns_ipv4_read_rx.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] tcp: move sysctl_tcp_l3mdev_accept to netns_ipv4_read_rx
    https://git.kernel.org/netdev/net-next/c/d677aebd663d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



