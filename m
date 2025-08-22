Return-Path: <netdev+bounces-216172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139F3B32571
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 01:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED05E5C239F
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 23:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836342D77ED;
	Fri, 22 Aug 2025 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI7xDZ9F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4ED19E7E2
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755906000; cv=none; b=ZIzvuPLNDxvuWtKk3kP5Hz8zOVU0TMadi32XpKAzcoyXtiVMu2h7tqhDrE1+tX5Vonv8WuGvoknodv+p48zfmGcYOQnjLcQX7Iet+BU+9YJcZ8KrNLT8rfEClB15q6WbAQXHBzo6967cnjMjY5rZ7gQuLOLImq8TfkuMq2ZpQxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755906000; c=relaxed/simple;
	bh=oSYw0CCLIbx8JTGJyUNNIop35e33owDNtPxvOTvyzyw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VlC8bA8tvoJ8HiDKb326nY4qTCs7+czyuLjNehdE5odN14uyWrs3UcNFTwyWPsjSyyP3yriuOrR1jH6eOXQ8gRxUsqI0F7ZO7hw6NrY2MCVewVi04MCa+bXCbRhpJXAcKoV6Wo5xtaqLDyFvg+H6PLZcWsM7f3sl3fzlO0mT98w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI7xDZ9F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A07C4CEED;
	Fri, 22 Aug 2025 23:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755905999;
	bh=oSYw0CCLIbx8JTGJyUNNIop35e33owDNtPxvOTvyzyw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jI7xDZ9FcAp5ODht08wEVLNWLRbRg2h1QVqZkpq7om6ECjeO2xMszfwtlkz5CuIsq
	 CNnJ4Z4g3th8D6iGv+MJBnC4pphFLFVL+pC4E6H5R49iqwX1xMJC6/pN2nddi07gvr
	 c4Hk7EnMlvfVFBYTX8Nro7Dl0J7ryoEzaKdEwN8tQG5XveZXRg+py74jzb19XzudwD
	 079rdTT+Jdbc19HG9kV7II2OqfXD/FcdJAWOygRbbaJvFpo9VpPhjgkLp7aRYNeAYv
	 gM+9PshNzMDhItxKwACXCpyCyfjzkAbX33kgBcqKpih8WetkPTCYSycA+SAEuEtlXp
	 0YpAaBI2jx4zQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE19383BF69;
	Fri, 22 Aug 2025 23:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] tcp: user_mss and TCP_MAXSEG series
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175590600877.2032242.10124563349770509552.git-patchwork-notify@kernel.org>
Date: Fri, 22 Aug 2025 23:40:08 +0000
References: <20250821141901.18839-1-edumazet@google.com>
In-Reply-To: <20250821141901.18839-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, horms@kernel.org, kuniyu@google.com,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 Aug 2025 14:18:59 +0000 you wrote:
> Annotate data-races around tp->rx_opt.user_mss and make
> TCP_MAXSEG lockless.
> 
> Eric Dumazet (2):
>   tcp: annotate data-races around tp->rx_opt.user_mss
>   tcp: lockless TCP_MAXSEG option
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] tcp: annotate data-races around tp->rx_opt.user_mss
    https://git.kernel.org/netdev/net-next/c/d5ffba0f254d
  - [net-next,2/2] tcp: lockless TCP_MAXSEG option
    https://git.kernel.org/netdev/net-next/c/9217146fee49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



