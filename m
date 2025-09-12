Return-Path: <netdev+bounces-222369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3608B53FF5
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 03:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853DA5685AF
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 01:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538D118D636;
	Fri, 12 Sep 2025 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMah5sQj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4EC18A6CF
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757641207; cv=none; b=qfn/MVk4B40eVjIgpMrx2FHNOe+/DkmWqf3s/ggb9WGDZuuPGSruPtOuhke67rol79ErpyISIXP7lTpwZjHu2SD5zfHp2/IZaTEbHxHcgI3P2BLQ1hz6eMWPn6p6H5exCi0cPCIKdQMXjn4kdQPd2vWvzKcLR6AI4PvCT69sRMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757641207; c=relaxed/simple;
	bh=ckd6H9JDvUAV7Wh2V0pq2soutdDYS9WnGlXbOVgfXPc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yn6S8T/EWgwfZbTx4G/KPQ1U0jJ+178oBQ8D4dhhr0saQJvKviNF2aBkfr92rctDj360+XZzkevXW4+VVC3KRRL459OhO3qiAfyiEw70iW35Tl7jX3zY5+63m0DHYi8kWrEEwp7m4fzh45bfvK3ZvAX+amATGSvCQal/Bss6S2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMah5sQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EB0C4CEF1;
	Fri, 12 Sep 2025 01:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757641206;
	bh=ckd6H9JDvUAV7Wh2V0pq2soutdDYS9WnGlXbOVgfXPc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SMah5sQjUdIL7wb9RIcO1+6xYPsAZQwuBUxtJQvF1ed8atmSb/Lmg6E1uMiy0/7SM
	 xb3EUNlIYAvTUbR86cQsEL1NSINGLa+WlWTzGSBEceYoDQAQJmLsdQE1DCGRwpwixh
	 CPPjdz8/tXbypxqr8pcC/Uchny8emU6dzkH99fkC6u5E50GF54/gUg2uBAxbkLMJDE
	 sGIx7M5/EXSnO/XRPysyJvqzywAoFg6CpmlLWFmm3p7gfATndeiDDjzJYF5b9svZZh
	 y0HcF12Ayphxcc33Iw0UISRx0w2gKaOGKgJ+FcfsmGrqTvDZMXO6xSNR362Vs22E/6
	 Mu6jDlIv3EDdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 840F8383BF69;
	Fri, 12 Sep 2025 01:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: Use NAPI_* in test_bit when stopping napi
 kthread
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175764120924.2369958.13903342123293251981.git-patchwork-notify@kernel.org>
Date: Fri, 12 Sep 2025 01:40:09 +0000
References: <20250910203716.1016546-1-skhawaja@google.com>
In-Reply-To: <20250910203716.1016546-1-skhawaja@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, willemb@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Sep 2025 20:37:16 +0000 you wrote:
> napi_stop_kthread waits for the NAPI_STATE_SCHED_THREADED to be unset
> before stopping the kthread. But it uses test_bit with the
> NAPIF_STATE_SCHED_THREADED and that might stop the kthread early before
> the flag is unset.
> 
> Use the NAPI_* variant of the NAPI state bits in test_bit instead.
> 
> [...]

Here is the summary with links:
  - [net] net: Use NAPI_* in test_bit when stopping napi kthread
    https://git.kernel.org/netdev/net/c/247981eecd3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



