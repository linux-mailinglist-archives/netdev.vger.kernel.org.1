Return-Path: <netdev+bounces-132294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8466D9912E5
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61191C22598
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FE414B061;
	Fri,  4 Oct 2024 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIgn04Cl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050C7231C9B
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084031; cv=none; b=bmLpp1H+5NH6H+DCbtLn3buHE7uoPRG3IyxVP0qbDNLuDnTsKITusNm6F++sfNTXg/c0AORkfqyOmQASWWwInu6dryAcKOoizXxwHV+KqNEfUwyDflDAI3E+lJPRq5sWQwzLrw1RCMAo8cPvChrfapcsqTePLM+kbrIKL3GuciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084031; c=relaxed/simple;
	bh=6YYGwa2I6BiaJpu643LAGs9pcWzqMSzBi5rTbGYZKLE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OqzxErUniZ3BZjH7NmayNgCODC62QapG0UJK4EMnhF19aUUJgGqRVHFm0CfR+nrYJm9BQe00H0b6mHZ52JLLL62b81GjJXcAKahGwfjR5IiybdHTIxsrmyyj+FtWT37Xwf63nNsN5FMjhafv2ZbWuN+dPeTDz+MWOEuXkC3B5iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIgn04Cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A78C4CEC6;
	Fri,  4 Oct 2024 23:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728084030;
	bh=6YYGwa2I6BiaJpu643LAGs9pcWzqMSzBi5rTbGYZKLE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gIgn04ClTLPbqvJi9/97KEVaz0LNk04WzZDVT8rJ6fPmXBw/YRMBy6A85PRY4eqd3
	 ZT8E6cJmCVq60ucwgFuij5FMoauBzACCebl/c2rhUNXYChW+F6cfVud7lnf+lA1ndG
	 L/p201Y16U6jaRB/rGiVYMM1t6/a++ztTDeEzNy7IEnW7eZGWlxIc2Qq0xaXUJJo5R
	 Gpyj4vPoSO2EpPVleXvT3P0Nal+TqWcGQ9pOiNhrsHX+2CUBlL+Ak+q28Jo/CvOZBt
	 J8k5a0bR/DI5SW4anWZAdDyS8rbnvwTA2pDpLTrmnmeUhjGGhJlYM0op3cAGWB3gav
	 z950pT/0i4xEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE00439F76FF;
	Fri,  4 Oct 2024 23:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] tcp: add fast path in timer handlers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172808403451.2772330.8977227840437535743.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 23:20:34 +0000
References: <20241002173042.917928-1-edumazet@google.com>
In-Reply-To: <20241002173042.917928-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Oct 2024 17:30:39 +0000 you wrote:
> As mentioned in Netconf 2024:
> 
> TCP retransmit and delack timers are not stopped from
> inet_csk_clear_xmit_timer() because we do not define
> INET_CSK_CLEAR_TIMERS.
> 
> Enabling INET_CSK_CLEAR_TIMERS leads to lower performance,
> mainly because del_timer() and mod_timer() happen from
> different cpus quite often.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] tcp: annotate data-races around icsk->icsk_pending
    https://git.kernel.org/netdev/net-next/c/5a9071a760a6
  - [net-next,2/3] tcp: add a fast path in tcp_write_timer()
    https://git.kernel.org/netdev/net-next/c/3b7842930162
  - [net-next,3/3] tcp: add a fast path in tcp_delack_timer()
    https://git.kernel.org/netdev/net-next/c/81df4fa94ee8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



