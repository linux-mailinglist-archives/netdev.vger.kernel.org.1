Return-Path: <netdev+bounces-83474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BB68926A2
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 23:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850DE1C21131
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 22:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6E813CF8F;
	Fri, 29 Mar 2024 22:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkHeGooj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D8139FD6
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711750231; cv=none; b=IrPn0B+QLyAdUaZCopfw/si6ejfpkPIazGHmyyQHQJzSju4WNu0Nz8Xf9BHWa1jrU0rYeYdOMQKlYm5RlqfF/6GsWVrcARzEFep6b7LEFHdzpFp3ADam7+P/tc7zhBBvIWqIjYgPIw6/CBtrVvg9lslrHBt07oIQEy9oSeSHzYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711750231; c=relaxed/simple;
	bh=7L28Ihlv5klCNAmpmHkrFLMVHnx1wXWwionH0DX562E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JU/O/wSEVIJFg7x/FGT3zP76RgbC6Qw83tqSabVwHg3rGdS6uhViS7u6iHtqhSlLyNOUFqM5r3lirrkwu4heGBCtUl8Zbxy+gw/hOw2i4icxTk8Kkk8i/GDJy2xMvT2FUGr3nZwPYcrswjVdzCPzod/HSWH3HY7mw3kkGFMgL1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkHeGooj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C5EBC43390;
	Fri, 29 Mar 2024 22:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711750230;
	bh=7L28Ihlv5klCNAmpmHkrFLMVHnx1wXWwionH0DX562E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PkHeGoojHg6DOekuh963+cYCXhycfhEbrFDOnqbu4CD+E5eHviEXeHM5QQBcrn3N5
	 VB+UW31YW9D6UfC0AuDsV8uHNirTG7y8azein1uAFcNmd0MFJIvxcSZRR8QwPywnkh
	 Pp2juwx5Mg3sGxA76UHGqjExffnXXZ+cU/Ul3XMnvDc2n2fMTyVzJWm1JJN04zfV0q
	 QStv/CBbWvSmm7LOiX9rfTFWEkA+2eaKR5Pw9yBlRKKPUHqu0VrN+NHwADQkjkwp3i
	 rGdpiR3VkwFO6d5LpEcWjZhew63l+YViLVZ5M/s/DSVez6ZmX5m4FD6MLF3b14x+J1
	 dH9Ry6o24EELA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B865D2D0EE;
	Fri, 29 Mar 2024 22:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] udp: small changes on receive path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171175023049.13425.17170361907257369970.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 22:10:30 +0000
References: <20240328144032.1864988-1-edumazet@google.com>
In-Reply-To: <20240328144032.1864988-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Mar 2024 14:40:28 +0000 you wrote:
> This series is based on an observation I made in UDP receive path.
> 
> The sock_def_readable() costs are pretty high, especially when
> epoll is used to generate EPOLLIN events.
> 
> First patch annotates races on sk->sk_rcvbuf reads.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] udp: annotate data-race in __udp_enqueue_schedule_skb()
    https://git.kernel.org/netdev/net-next/c/605579699513
  - [net-next,2/4] udp: relax atomic operation on sk->sk_rmem_alloc
    https://git.kernel.org/netdev/net-next/c/6a1f12dd85a8
  - [net-next,3/4] udp: avoid calling sock_def_readable() if possible
    https://git.kernel.org/netdev/net-next/c/612b1c0dec5b
  - [net-next,4/4] net: add sk_wake_async_rcu() helper
    https://git.kernel.org/netdev/net-next/c/1abe267f173e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



