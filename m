Return-Path: <netdev+bounces-180472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA33DA81665
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 22:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20D8D3A9DDC
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E27246335;
	Tue,  8 Apr 2025 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqU0Me33"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFBA245012
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744142881; cv=none; b=Qb9OTN3Og0E/eB/BKGFJdI9+HQLRXToDGof7mVcDMn6L2OGld+fOCIzC7aDH3Bq0/tlxr/sNu+PtEYd4w1obac+MEvW9esJOD/O8YnPIhak9CF4HLoGPzGoPV1dYAU4iJAbBKBu4UCEJfYQjhu/qaIOeghJpSrRORP2BrhgPcvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744142881; c=relaxed/simple;
	bh=SxlXicYG9Todb1aDurDgFSUvWnxkDG0WTyH6LH3gEHo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TGFiM3WY37838WKtybJuOa3BMUDeNumKY8rJEOvVBPGfMpUAUIgo/zoS28ApAsfgdapowivmSTXnm4cyLXwZNRrqOf9CkYBOOvWZpDDwKBe7uYFabCn6q2qGGi545EeomcMeLHUl/pcYP9Zd37P9BcasPFy38A6FLlXwQIY1IA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqU0Me33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2EBC4CEEA;
	Tue,  8 Apr 2025 20:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744142881;
	bh=SxlXicYG9Todb1aDurDgFSUvWnxkDG0WTyH6LH3gEHo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DqU0Me33Z85MWShq0P5AAeW5/9VMj7XluRXZJLis8vDGxR2yy66JHHFx99lP1utkF
	 pg+jt3TpdPE0rGc/c4GLtEYVw9+8/3xz4fc9wHtOwOA7OrPfBUH3O0vguPQ/5W86oo
	 ab1MnFId6jxUNH8doc3Oky68YM8+75iljzMoa4QQ7b0EN8AL+rhhETqPAvaMBHlbjv
	 gsVHkQtx7tldhhOIp1Io3dyuf5+ws3anTzYyax7cILPctcLFIh6ymjOss8US3u5XrS
	 Uzo1DgziFU5O3IW8wzpuGDhCEwt5lDrCKzj4tZxbD/nBNu757zsaZENC0vFyO1JncG
	 2gouKZHKOdmBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCED38111D4;
	Tue,  8 Apr 2025 20:08:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] net: ena: Support persistent per-NAPI config.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174414291850.2113367.11961686627141164174.git-patchwork-notify@kernel.org>
Date: Tue, 08 Apr 2025 20:08:38 +0000
References: <20250407164802.25184-1-kuniyu@amazon.com>
In-Reply-To: <20250407164802.25184-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: shayagr@amazon.com, akiyano@amazon.com, darinzon@amazon.com,
 saeedb@amazon.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jdamato@fastly.com,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 7 Apr 2025 09:47:59 -0700 you wrote:
> Let's pass the queue index to netif_napi_add_config() to preserve
> per-NAPI config.
> 
> Test:
> 
> Set 100 to defer-hard-irqs (default is 0) and check the value after
> link down & up.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] net: ena: Support persistent per-NAPI config.
    https://git.kernel.org/netdev/net-next/c/0f681b0ecd19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



