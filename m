Return-Path: <netdev+bounces-44355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABDE7D7A31
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 03:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17C9DB212E7
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165D75666;
	Thu, 26 Oct 2023 01:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kb4D0/RQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C5A5388
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 01:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 599EFC433CA;
	Thu, 26 Oct 2023 01:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698283826;
	bh=Jaj6SzbA7OeMxIlJZJtKTt4GNXc6XevdlnvP/btosDM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kb4D0/RQaaKhGSjHjrqYYa4GVbEHoSfSj8KEbjKzox6mfxG1liZafwnjK+eSyitb3
	 bVZT82Exe37WwuLn4A9lquYnKinn3xA87NI1PjxHko52TB65SvDt0rEokQNRsKW8pl
	 BHcbqThRVML2X8HxXGrA1sNTzSmhRJD1gbeAWjM3V9HIuSPR6w4SL/Y2xK+MiHcVbk
	 apMx1FlVX40FFW8Sack6TpWj4LXZbR8oYKUzT9UkMXywGLWPG2kHGbYws5D4NycLdt
	 tm2K6EMDDeAQQWdlIVE7ZbLGvsQxquSDWVv99xiQ+lFwbG3x95gUoMHRcTTtkogaLZ
	 le3G1JeYX29gQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41900E11F55;
	Thu, 26 Oct 2023 01:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] net: ipv6/addrconf: ensure that temporary
 addresses' preferred lifetimes are in the valid range
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169828382626.14693.5307000504345152936.git-patchwork-notify@kernel.org>
Date: Thu, 26 Oct 2023 01:30:26 +0000
References: <20231024212312.299370-1-alexhenrie24@gmail.com>
In-Reply-To: <20231024212312.299370-1-alexhenrie24@gmail.com>
To: Alex Henrie <alexhenrie24@gmail.com>
Cc: netdev@vger.kernel.org, jbohac@suse.cz, benoit.boissinot@ens-lyon.org,
 davem@davemloft.net, hideaki.yoshifuji@miraclelinux.com, dsahern@kernel.org,
 pabeni@redhat.com, kuba@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Oct 2023 15:23:06 -0600 you wrote:
> No changes from v2, but there are only four patches now because the
> first patch has already been applied.
> 
> https://lore.kernel.org/all/20230829054623.104293-1-alexhenrie24@gmail.com/
> 
> Alex Henrie (4):
>   net: ipv6/addrconf: clamp preferred_lft to the maximum allowed
>   net: ipv6/addrconf: clamp preferred_lft to the minimum required
>   Documentation: networking: explain what happens if temp_valid_lft is
>     too small
>   Documentation: networking: explain what happens if temp_prefered_lft
>     is too small or too large
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] net: ipv6/addrconf: clamp preferred_lft to the maximum allowed
    https://git.kernel.org/netdev/net-next/c/bfbf81b31093
  - [net-next,v2,2/4] net: ipv6/addrconf: clamp preferred_lft to the minimum required
    https://git.kernel.org/netdev/net-next/c/629df6701c8a
  - [net-next,v2,3/4] Documentation: networking: explain what happens if temp_valid_lft is too small
    https://git.kernel.org/netdev/net-next/c/433d6c8048cb
  - [net-next,v2,4/4] Documentation: networking: explain what happens if temp_prefered_lft is too small or too large
    https://git.kernel.org/netdev/net-next/c/ec575f885e3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



