Return-Path: <netdev+bounces-232738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006FFC087E6
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 03:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADAC33BA866
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 01:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A341920FAAB;
	Sat, 25 Oct 2025 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3K2qR2x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E82F20CCE4
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761354633; cv=none; b=a2wqigRbv/Ka/TpNMiuGZf/rzsddOAbxQpkwrVacO1OtpP9ipM0S1rDt2bIQt+iW8vxOoOxtEkU9SzTqnKXhSNEhrybEDDU9sF0Wf34ZUz1dyJif5aMBo/JJcBg0gNS/gBdBPE9YHzuiR/zWZBH+K1srzjvUlEmiRvsoJRbuyLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761354633; c=relaxed/simple;
	bh=PAXHIvo6r6jeEeG93sabn8tZFxG1xAWkfzKA7U2GC3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C6FSMUSkvY2+F+hRuy0NzV3qQxMo1C3NUcvVsjgEX67vb0sm9NEA2z05emyDR80hC0fY4gUG7BCNzuwS/0s3Lso8Qhp3hSyeGmdLbuRLSC7qZPGJsJKY94OcZntJs0F6MNHL5R0xLJNBRl6Jo1Wx9toxptEw9Qi4cRNi3uOO6g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3K2qR2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3AAC4CEF1;
	Sat, 25 Oct 2025 01:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761354633;
	bh=PAXHIvo6r6jeEeG93sabn8tZFxG1xAWkfzKA7U2GC3c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u3K2qR2xFnYrH7jYWKLyaVgimf/1KV3Q30WoswCSOgX7KKC5RoreQtkOpEts/coba
	 O2SzC3JqcvXhv7xj2vggCYGWJPpGZSrBSTAkmTpg67aCscjnYyyvaF8eU38RVbsztJ
	 5LE9NZUTnQ4W7cCuxRbD7iSpVgT6bj42xC6uNI029JgyGczvlwBs0i3czJzBIos0c4
	 kgt20LbGAGg0j+qNpGBEk5dJKmBD9Yb83KHs6bDugrfUKoJXHGbOH0lUc+/M7W93AU
	 z5RAcCwjy+H09zdMtk4wXu4bekJS/AE3cGRld+WVdNleCH4h684MDufStIrAby0dtm
	 ys3BUP9ZDxNYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC7A380AA59;
	Sat, 25 Oct 2025 01:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/5] neighbour: Convert RTM_GETNEIGHTBL and
 RTM_SETNEIGHTBL to RCU.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176135461275.4113798.10349813341332406170.git-patchwork-notify@kernel.org>
Date: Sat, 25 Oct 2025 01:10:12 +0000
References: <20251022054004.2514876-1-kuniyu@google.com>
In-Reply-To: <20251022054004.2514876-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Oct 2025 05:39:44 +0000 you wrote:
> Patch 1 & 2 are prep for RCU conversion for RTM_GETNEIGHTBL.
> 
> Patch 3 & 4 converts RTM_GETNEIGHTBL and RTM_SETNEIGHTBL to RCU.
> 
> Patch 5 converts the neighbour table rwlock to the plain spinlock.
> 
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/5] neighbour: Use RCU list helpers for neigh_parms.list writers.
    https://git.kernel.org/netdev/net-next/c/06d6322280d9
  - [v1,net-next,2/5] neighbour: Annotate access to neigh_parms fields.
    https://git.kernel.org/netdev/net-next/c/35d7c7087033
  - [v1,net-next,3/5] neighbour: Convert RTM_GETNEIGHTBL to RCU.
    https://git.kernel.org/netdev/net-next/c/4ae34be50064
  - [v1,net-next,4/5] neighbour: Convert RTM_SETNEIGHTBL to RCU.
    https://git.kernel.org/netdev/net-next/c/55a6046b48a8
  - [v1,net-next,5/5] neighbour: Convert rwlock of struct neigh_table to spinlock.
    https://git.kernel.org/netdev/net-next/c/3064d0fe02af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



