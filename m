Return-Path: <netdev+bounces-120774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8C195A945
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 03:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7BA1F22EE2
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 01:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1476FC7;
	Thu, 22 Aug 2024 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSyvIRSZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3380C15A8;
	Thu, 22 Aug 2024 01:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724288432; cv=none; b=GbcJb8KSlRFb9u4q3roV7U6oUhM9hQhQKmM3JXKUR6Xm9YH2wH2rzdteaDbJnZHdDpLO1oYhFxQ6JB99YmOtRYc5f7Vyb+URoFfPJOgkwjvyBdIlLhWSASrBUWgXUVDBrHrsRsW0MW8fyHurIQGvsdEm4AqxZh8hg0JvXgz8xlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724288432; c=relaxed/simple;
	bh=ko1Gt2R3hp5jRp7FVaneBoHdEBiZ+I6juZQq4g8HoDQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JsX2xjZZ93aqSQoQJUmh8T51doJ69Fcz7mqkyAJxp2ZnZpJrbV2LYzaNjp3HCstQzAWjjIt6zRyg6bo0JLqZMsuVkhKWYLRWwiILMEOxmr8/EcQ9EC4ra86vJktwTYcfkXAzP0t+XJ9ZyiV5Kp/CNqMWoQudEluxV5e6HryH0W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSyvIRSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1753C32782;
	Thu, 22 Aug 2024 01:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724288430;
	bh=ko1Gt2R3hp5jRp7FVaneBoHdEBiZ+I6juZQq4g8HoDQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kSyvIRSZ66B0YbETC4qLlHCRHUp5pX/4llBRPz/qY+48RC0uP+2/E8zgO0bqEBjIL
	 y8EkpVH0Gt+fLvJZrjtPKJSyeE0bswZAwqAlEtilszSroYLiakMPjWHnAogWgjwCfU
	 WkGHhbq9K2Wvv3eVlhrhao47yn5JlEDEoaOGiSEKNEp6Kr9FsKM3FA5KBwxg3eQJ4s
	 Q5MwG4Bd/UTdmhBHexsDUCvpaiwsngMInYEt9X3prvtbm6k0Tro3p8PZouwQiFaV0T
	 Vo5ga4UCaaWy3aP5MZ5t2TgedX79lz219u5asLmhTa/EAyBTYVyx/5AvhUDEn3WGDw
	 n2H8gefmYh2sA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D2E3804CAB;
	Thu, 22 Aug 2024 01:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] net: xilinx: axienet: Add statistics support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172428843028.1875438.3178062453740587499.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 01:00:30 +0000
References: <20240820175343.760389-1-sean.anderson@linux.dev>
In-Reply-To: <20240820175343.760389-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: andrew@lunn.ch, radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
 michal.simek@amd.com, linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Aug 2024 13:53:40 -0400 you wrote:
> Add support for hardware statistics counters (if they are enabled) in
> the AXI Ethernet driver. Unfortunately, the implementation is
> complicated a bit since the hardware might only support 32-bit counters.
> 
> Changes in v4:
> - Reduce hw_last_counter to u32 to ensure we use (wrapping) 32-bit
>   arithmetic.
> - Implement get_ethtool_stats for nonstandard statistics
> - Rebase onto net-next/main
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] net: xilinx: axienet: Report RxRject as rx_dropped
    https://git.kernel.org/netdev/net-next/c/d70e3788da1d
  - [net-next,v4,2/2] net: xilinx: axienet: Add statistics support
    https://git.kernel.org/netdev/net-next/c/76abb5d675c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



