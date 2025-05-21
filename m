Return-Path: <netdev+bounces-192107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F97ABE8EF
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 03:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7F53B8CEC
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 01:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AC4189905;
	Wed, 21 May 2025 01:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYwC9mLh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F288D17A2EF
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 01:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747790418; cv=none; b=Hun7MpyqYQ1tUF6IV32Zr3QgCOI4AM0mth6v33wWJCkbNxzXNbqMxmKbIBmg/TbpoCjKGvJ3CTh+91eo6RqMHqS11PGj1d91uYfpZIYuKsD8b+W/fuLvCRVXoZOrfm1Xa1VWom4cSzYkTtNPARPD1ddx4AK4hPbue/Q+vJJl9vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747790418; c=relaxed/simple;
	bh=1FUCFQzIiU5dEqs0GiPV5fpiBRnSU8WoxcajJdy5hk8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XYbFAcO8gmwVWq7kncmf5PtM8kpmAJKgmnuoN371e1+jt3tR45xLqd69JF7gSIplt3rjyqqEd5zG8cu1msWYTV7yw9l2jISAkuRduZC4I4KN5kTsNDZYtJHSWEJAbNXu8vFgW2xsPnje0yLEFUQZrle3bx0iMl++NCuHbF2JROA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYwC9mLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7057DC4CEE9;
	Wed, 21 May 2025 01:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747790417;
	bh=1FUCFQzIiU5dEqs0GiPV5fpiBRnSU8WoxcajJdy5hk8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nYwC9mLhDlQDVbsnuSx3mhbJwcLPy/rSDZdgpFIl5KTpxBcj017PnQmCw3PDTX7hf
	 qGMDug02ziG0fa1RtPAi4P1zJ27jOZ0zrDWdrA0sL/eGrE5XmTYNnUyn8FplpPIy8Y
	 AcM79AUQi22KidigA64C5Jw2kripVTii+pZjN8HTcm6e9vLCCAYgutn40ShcK3OFqc
	 tLePKS07OpstsUstM2ZPnZlLzpgZLRQl8EdVIP7QPni2doT7oZGGY4poQlEdF5Zijl
	 PA6/kKC4v83xU4hMMDWU8i+6+vQ97gpdGF1bXfa5ZR/UBQkEJejEHadbTBZA3GMtUy
	 yiYemZ9K5m8Pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B90380AAD0;
	Wed, 21 May 2025 01:20:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: let lockdep compare instance locks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174779045324.1526198.12733134685673125499.git-patchwork-notify@kernel.org>
Date: Wed, 21 May 2025 01:20:53 +0000
References: <20250517200810.466531-1-kuba@kernel.org>
In-Reply-To: <20250517200810.466531-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 kuniyu@amazon.com, sdf@fomichev.me

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 17 May 2025 13:08:10 -0700 you wrote:
> AFAIU always returning -1 from lockdep's compare function
> basically disables checking of dependencies between given
> locks. Try to be a little more precise about what guarantees
> that instance locks won't deadlock.
> 
> Right now we only nest them under protection of rtnl_lock.
> Mostly in unregister_netdevice_many() and dev_close_many().
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: let lockdep compare instance locks
    https://git.kernel.org/netdev/net-next/c/4c2bd7913f52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



