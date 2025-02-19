Return-Path: <netdev+bounces-167594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED557A3AFB8
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADAAA3A8D45
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E1B188596;
	Wed, 19 Feb 2025 02:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2fMobe5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C95E186294
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 02:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739932808; cv=none; b=KKvWKYFkzaLedZ63f9LRA1K+yat8N3QhudDHSBQ6GarBigAFYs+Cf+IAPCMJUXpSbcxYo+Kv/HKsUSXzMOArCdLaLiMDKAgUlX99BzyzqMBwhWn8/JwWHngRbZ7Thyz1k2YAdafs+F567Ak2jtnou23CxjHwvPGJly7bdhppArg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739932808; c=relaxed/simple;
	bh=KssP//fAl3taOIUK5nLfcx9SJ4D7yzJ23oqMX6V68Tc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lSR0kJUQYe2Nfn3DJMOOeaTUvGN661AfhqczzpM+RVWzhhmMUFF0TIjSEsM8ypcWNRGPFQee/+I6IvPpWuoE4nPI5nb3GwRB+Wnrl598/nyRiMLBoRmZb/h8hyf3srVOcjZYw8NXicZdavab8XBVZjnu55GQN6h4lRegCi6zzuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2fMobe5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A700C4CEE2;
	Wed, 19 Feb 2025 02:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739932808;
	bh=KssP//fAl3taOIUK5nLfcx9SJ4D7yzJ23oqMX6V68Tc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C2fMobe5vIQ33Fhcr8SmiI5MP+vN5xoDTKt6D7mfhvRJrvMhbXGNvGO/F1JvUItd3
	 uPofmZtMWrzU0GnOdMtMhDISpDXm+4n2N/9VgM9m560ZSbj2c7cmvJNdCvcoo9xXtd
	 uhUrwChWHQ74LifQYgurQgUyvFLHjyX07ETefiTFGtBSld15UCMsXSJ3NMXeFElxSR
	 6daeR6JYGvmPe5Hfd3G5Db0hJ37YK6dzhMGqvOr+9O1PGTgbSB0WNOOp6G0mIOClXV
	 8B4zkjQWlUyT0hU4Ch4FyOUVo4B7HoJ5BJheh/jFRCKjkxzmRcLUmuFKLbDG4HCbSV
	 ALLGEsbgz1F6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE6F8380AAE9;
	Wed, 19 Feb 2025 02:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/7] net: deduplicate cookie logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173993283823.110799.3553317360149288778.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 02:40:38 +0000
References: <20250214222720.3205500-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20250214222720.3205500-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org,
 willemb@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Feb 2025 17:26:57 -0500 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Reuse standard sk, ip and ipv6 cookie init handlers where possible.
> 
> Avoid repeated open coding of the same logic.
> Harmonize feature sets across protocols.
> Make IPv4 and IPv6 logic more alike.
> Simplify adding future new fields with a single init point.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/7] tcp: only initialize sockcm tsflags field
    https://git.kernel.org/netdev/net-next/c/aaf6532d119d
  - [net-next,v3,2/7] net: initialize mark in sockcm_init
    https://git.kernel.org/netdev/net-next/c/6ad861519a69
  - [net-next,v3,3/7] ipv4: initialize inet socket cookies with sockcm_init
    https://git.kernel.org/netdev/net-next/c/94788792f379
  - [net-next,v3,4/7] ipv4: remove get_rttos
    https://git.kernel.org/netdev/net-next/c/9329b58395e5
  - [net-next,v3,5/7] icmp: reflect tos through ip cookie rather than updating inet_sk
    https://git.kernel.org/netdev/net-next/c/e8485911050a
  - [net-next,v3,6/7] ipv6: replace ipcm6_init calls with ipcm6_init_sk
    https://git.kernel.org/netdev/net-next/c/096208592b09
  - [net-next,v3,7/7] ipv6: initialize inet socket cookies with sockcm_init
    https://git.kernel.org/netdev/net-next/c/5cd2f78886dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



