Return-Path: <netdev+bounces-141317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82419BA773
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 19:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6E11F213EF
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 18:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704341411E0;
	Sun,  3 Nov 2024 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7CJ+g6D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9BEF4F1
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730659220; cv=none; b=N/AWc1E5hdd6+wC5CEriQq+3WAcUUDq8QK3vaunECSDVsQx5w8Ycf2yV6NnRWWy2ik5wGcmHfu3zU0uCPskMPx9+oLcl8nW8aRHjp/o0kiqBW3Vd9ZcgLgiQuid43z5dv/BghDqj0Jb2YOz5z45wGaN2KIC45T4KZy66l7hqbSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730659220; c=relaxed/simple;
	bh=r5bBA75ah/CJeVvGl/rzULBM6+fhFadfQCdHZJ4czNA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aSQD3tSvyqKul6COk6Gu5l3x7sADpwl8MHw6uvA0nTUkvvXc55t+DnyZ2sVhK3QlK25P7RJBNLNKB0j52YQSATFihNH0dZVgJvKLqH15cfVWNLkOFV8zC6unsgfo7brhIns3ShoTTD45TnLT0Hl43B9Z4W1eAKZnjd2ee2UMrkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7CJ+g6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD4CC4CECD;
	Sun,  3 Nov 2024 18:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730659219;
	bh=r5bBA75ah/CJeVvGl/rzULBM6+fhFadfQCdHZJ4czNA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s7CJ+g6DdRHIG+hQDX1TEIFS2F+bvStRAlVHQ+Ls+ZNXQZ0QIuHDLiSCYGaAbMGZW
	 eATOJIxFIdRjQQIJVmlkbaeyCL11WnkbGO8V029old43rk6g4mewsAGxB0z88HM8qc
	 N+uJeOXmgogICKb/upOfrftCxTsgwOd+N/pe61tD0CPuC/4SevbRqcpViOhH+6f/dB
	 jSnsImx4KT9yPLYc8e+kLhorigP6KXAHD6sIGBSbLjlN1XFOkMcja2UjqYmYeh3ICU
	 U/bUfw32YtLl6ulOgzyrh8c0uvAOyQXTjOVdKONpMs3I0FTgxiE7epRd0zS+mGtjhB
	 tzjuA0HY8ECuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D4A38363C3;
	Sun,  3 Nov 2024 18:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] Add noinline_for_tracing and apply it to tcp_drop_reason
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173065922825.3229475.14917431772969917056.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 18:40:28 +0000
References: <20241024093742.87681-1-laoar.shao@gmail.com>
In-Reply-To: <20241024093742.87681-1-laoar.shao@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Oct 2024 17:37:40 +0800 you wrote:
> This patchset introduces a new compiler annotation, noinline_for_tracing,
> designed to prevent specific functions from being inlined to facilitate
> tracing. In Patch #2, this annotation is applied to the tcp_drop_reason().
> 
> Yafang Shao (2):
>   compiler_types: Add noinline_for_tracing annotation
>   net: tcp: Add noinline_for_tracing annotation for tcp_drop_reason()
> 
> [...]

Here is the summary with links:
  - [1/2] compiler_types: Add noinline_for_tracing annotation
    https://git.kernel.org/netdev/net-next/c/a8f80673ca0d
  - [2/2] net: tcp: Add noinline_for_tracing annotation for tcp_drop_reason()
    https://git.kernel.org/netdev/net-next/c/dbd5e2e79ed8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



