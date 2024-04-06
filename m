Return-Path: <netdev+bounces-85398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7798289A949
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 08:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179671F229AE
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 06:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9A52B9C0;
	Sat,  6 Apr 2024 06:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+JVExva"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4996C2B9AA
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 06:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712383832; cv=none; b=BwA3ohX4mmx9MATjscKnxaDTKpeaCwClIfsIcjcMB38xqP88xZPY6z1Wn6MmJH9ZYfboGAiOW7Hok3Hb9JuOag7sXcdgkqJAW7c090ALxW1N2mwzwDo2WqndcchAJODE07JvcKgplJc6BJHlTRPOCQParqC8Nqg6QnQy37tauu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712383832; c=relaxed/simple;
	bh=38BMngGGR6b4WNh62yatXz/ZFcm8pOAiVdKlyqPdWUE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kFyOeS164mt/snGTO+sg3gBWKiNLEH+a7xV2/5xYYv3gCcdrsvWzR6WSfQLY4khw8tV8ZVu0v7Mghy9iLiMMYRa2KSssVZZhn6734FBnXOMtvmRrIBrexEf4XT4RNdDQ+9TNNj4WVEqdaEtCQN3toxk1K4Ow1d4n5ZEGS6gyi+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+JVExva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E03D8C43394;
	Sat,  6 Apr 2024 06:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712383831;
	bh=38BMngGGR6b4WNh62yatXz/ZFcm8pOAiVdKlyqPdWUE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H+JVExvazQ10Z2P99CDjLTCr/auCX6nSMpoWLcKioOX1pBePirmT/MBTRbBOx+f5g
	 rrzG4EnTSdQdjI5LlIEB3KmA1I4AORe/6qBPgWg4/O3VGa399j266Nw8iywu4MN9IC
	 CfO/KjsBul5SWA7s0dJoH8aLnrhQbZtNo5vyRWhpP9+2HM+2hXD0D2WHdnwliUbXPm
	 8wykIk1bYAt5+SnCQNzj3GQ4JD5EEsvwiUQ0UclpexvQPLCOm+RS/Erwdzdctuyrky
	 qPJ8K+GNyVPeRgwRLZ2v5CDwmX7rMGeM78mapXFljA0PaF1pwnW1QHlVR0PE6p1fAW
	 zyCxnhrd/kSoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0275D8A106;
	Sat,  6 Apr 2024 06:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: annotate data-races around tp->window_clamp
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171238383184.24936.16674036552041310979.git-patchwork-notify@kernel.org>
Date: Sat, 06 Apr 2024 06:10:31 +0000
References: <20240404114231.2195171-1-edumazet@google.com>
In-Reply-To: <20240404114231.2195171-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Apr 2024 11:42:31 +0000 you wrote:
> tp->window_clamp can be read locklessly, add READ_ONCE()
> and WRITE_ONCE() annotations.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/syncookies.c |  3 ++-
>  net/ipv4/tcp.c        |  8 ++++----
>  net/ipv4/tcp_input.c  | 17 ++++++++++-------
>  net/ipv4/tcp_output.c | 18 ++++++++++--------
>  net/ipv6/syncookies.c |  2 +-
>  net/mptcp/protocol.c  |  2 +-
>  net/mptcp/sockopt.c   |  2 +-
>  7 files changed, 29 insertions(+), 23 deletions(-)

Here is the summary with links:
  - [net-next] tcp: annotate data-races around tp->window_clamp
    https://git.kernel.org/netdev/net-next/c/f410cbea9f3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



