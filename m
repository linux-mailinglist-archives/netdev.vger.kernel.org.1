Return-Path: <netdev+bounces-28581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD1477FE48
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D09282057
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 19:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B691ADCC;
	Thu, 17 Aug 2023 19:00:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B321619896
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 19:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 730F3C433AD;
	Thu, 17 Aug 2023 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692298825;
	bh=qd4n0CwObW1GrqqS6S0NdzYHkRtYwMp0AzwZh9N0zUk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uTtT3J8iHn4N3ryK2YjrGYDup6UhY+ygOsPpAwbuGhorF6oymWn+PvV9MkoxSMtiJ
	 M9GWaOCmriH83ApDpBBxIXA0DY/woG3SB6am/54jQ4bzd3g71czPjimcBrLrwYeJ8Q
	 zfo8mJibKhvVbl/bkEjkif/uEqP+gpAo5BBXir/iD9xC+0IHVid9P8kHTuYYzLaPli
	 lDzth//n4agU1+rirbUe6dYmplrAWWqoAA2mEJgFJvg7SlBptGdFHFwRMd30vnR2j9
	 3hjcC2Ex3pHaSfQB1/zdTLOcs8IgF/Fi88ix1zRmvFxbXEerm2eHN3AL0qh/8Q/wEC
	 QpVjBRzXxQ81g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 550B5E26D3C;
	Thu, 17 Aug 2023 19:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] sock: Fix misuse of sk_under_memory_pressure()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169229882534.13479.15705873404005032657.git-patchwork-notify@kernel.org>
Date: Thu, 17 Aug 2023 19:00:25 +0000
References: <20230816091226.1542-1-wuyun.abel@bytedance.com>
In-Reply-To: <20230816091226.1542-1-wuyun.abel@bytedance.com>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: shakeelb@google.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kuniyu@amazon.com, ast@kernel.org,
 martin.lau@kernel.org, leitao@debian.org, alexander@mihalicyn.com,
 dhowells@redhat.com, kernelxing@tencent.com, glommer@parallels.com,
 kamezawa.hiroyu@jp.fujtsu.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Aug 2023 17:12:22 +0800 you wrote:
> The status of global socket memory pressure is updated when:
> 
>   a) __sk_mem_raise_allocated():
> 
> 	enter: sk_memory_allocated(sk) >  sysctl_mem[1]
> 	leave: sk_memory_allocated(sk) <= sysctl_mem[0]
> 
> [...]

Here is the summary with links:
  - [net] sock: Fix misuse of sk_under_memory_pressure()
    https://git.kernel.org/netdev/net/c/2d0c88e84e48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



