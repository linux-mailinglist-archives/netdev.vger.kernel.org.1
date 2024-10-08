Return-Path: <netdev+bounces-132918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1D7993B96
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 02:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4610928445D
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71552538A;
	Tue,  8 Oct 2024 00:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NC1QX3BL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7318C1E
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 00:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728346226; cv=none; b=SGKGivYnevHHUEt5kOb+MNK4exm5UfhlqtWC5rVZvlKK9Hq86MidNP0J1WFXcmVIsrrnJ8V5/bfOEuTz9WCeUqFFHT6t0SHqM5AbTcgDvwTPh6eII2LnX8pc5GDfqca6inKi1ZX6QJQFi/3SKkOMFKqTHFzdYpZNch2Rc8zR6PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728346226; c=relaxed/simple;
	bh=31Lx1aFVDXJ1LIUOAoupESYQh1A3KEuRzuv3tsHUsjU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C5osXIs9jrc7f50/kkcX+V/ZtbmJknR7Y6/20fb6DX+977v4MGRNA/6zpyyGJR9vP4bF3jJodZizY3ZNJvoinMSgYr2N7eaeKOZ75KtvJoP7j0dAyoifw+2rydlyrny1K81UNn/k2Bpi1q2lmUdX7CxPiFzKzq/w2yrgkwqHDOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NC1QX3BL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAF7C4CEC6;
	Tue,  8 Oct 2024 00:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728346226;
	bh=31Lx1aFVDXJ1LIUOAoupESYQh1A3KEuRzuv3tsHUsjU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NC1QX3BL28MGTIaZtPPs/lVm7VhcREgcjbhIUG4hUUNXeC3eII/VM6sw3mm+ZgBTi
	 FSknTsU7E2AB893tM/NwT8514p06Qp0+AGyeVBgSZv5dii+P/xb1J5JG+rcmO28kFU
	 RThiirGz5eKB/xQcghErOlxO9J8t7MC8p9igvTvaATWqippO67ziBsbbkc8e3w6wHt
	 905x7DWPCYObysz5h9CMwNLdNTGuflGMfShk5YN0XcFi9QcgdVS8QoBcFsS93+nJFW
	 nJ3a2WXQzzrua5bHOyb65ShxJAoJdMITlXJQnIVu1dFajTbMEKriXyv8gvgthAbc2P
	 1MSlCbq5LmhBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D7B3803262;
	Tue,  8 Oct 2024 00:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] ipv4: preliminary work for per-netns RTNL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172834623005.25280.1180068090156317294.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 00:10:30 +0000
References: <20241004134720.579244-1-edumazet@google.com>
In-Reply-To: <20241004134720.579244-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, kuniyu@amazon.com, alexandre.ferrieux@orange.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Oct 2024 13:47:16 +0000 you wrote:
> Inspired by 9b8ca04854fd ("ipv4: avoid quadratic behavior in
> FIB insertion of common address") and per-netns RTNL conversion
> started by Kuniyuki this week.
> 
> ip_fib_check_default() can use RCU instead of a shared spinlock.
> 
> fib_info_lock can be removed, RTNL is already used.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] ipv4: remove fib_devindex_hashfn()
    https://git.kernel.org/netdev/net-next/c/8a0f62fdeb9e
  - [net-next,2/4] ipv4: use rcu in ip_fib_check_default()
    https://git.kernel.org/netdev/net-next/c/fc38b28365e5
  - [net-next,3/4] ipv4: remove fib_info_lock
    https://git.kernel.org/netdev/net-next/c/143ca845ec0c
  - [net-next,4/4] ipv4: remove fib_info_devhash[]
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



