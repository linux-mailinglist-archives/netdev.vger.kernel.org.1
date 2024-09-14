Return-Path: <netdev+bounces-128275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC38978D07
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 05:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6DD8B25C7F
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 03:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BAA28689;
	Sat, 14 Sep 2024 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C52iS0AW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2A025622;
	Sat, 14 Sep 2024 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726283436; cv=none; b=bxgian76oSSXjvBpHdAwok/kUrT+iSv8uGsXUD2v6BG6wFToHo7rLPjV1CvqwZYUmYv4kZNyCjCMDm0c1aw0KBstQVVnP0+yUkF1Vn3A8r8i/mL6fJWXyg1wY3LXcAnTojch7sWaxCVWehwuWk4Nn+3Xf4iAmda1f/h5OsHcuyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726283436; c=relaxed/simple;
	bh=Sdy2e+qHmazre0dUjOLj4xVHsL4E2phkUHBh8FfMcDA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KjWVsIznuNzDSSmHT8jOsfMhItcZ5cNjGDuPBGi2xGz0+ib11uYFvd5mtxfj5XL/SZ/OGpyNAa/7++J1aSR/UFRXV+HGDH1Cepsjwj6VuC+59LqUaG4zFCiBPp8k8FAfb+qQ5ys6H0IeNU6Hyp30IcacRyQODsz/jhBn+RTT3WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C52iS0AW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E101FC4CEC0;
	Sat, 14 Sep 2024 03:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726283435;
	bh=Sdy2e+qHmazre0dUjOLj4xVHsL4E2phkUHBh8FfMcDA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C52iS0AWy9yoX5CqzzNtdy6WPOW4NXYrwzaXBAcLBYLijtL+Iaf0zZGRrH2vv7u7T
	 jXOR8/l9pZJgZzLGCdmXHNK86kybySYaA+3NJH40Bf8oeGQwlZlnu+SshhG3CQQ9du
	 mkWTBZbQF3M3KHa74URtbxymiU59zFO2wHVlPvZbqDT/dazNoDuPQbTpxK2+Sn+Wge
	 Et/sqsWVSFUbj4anQwK8ZoVh+wzMvWiZFNXW7rJYQoy/Mw40hPUJJOHEqBo/ZTcy3o
	 jd/h+tGtOug4A3ryScu3HaQ6CzhKOXX9KCQ0SxHSsYWseKUyiEta6o5zW8UZSje9L2
	 LteEqqtY9dsig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D8F3806655;
	Sat, 14 Sep 2024 03:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ipv6: rpl_iptunnel: Fix memory leak in rpl_input
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172628343700.2438539.13770490860202118869.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 03:10:37 +0000
References: <20240911174557.11536-1-justin.iurman@uliege.be>
In-Reply-To: <20240911174557.11536-1-justin.iurman@uliege.be>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, aahringo@redhat.com, alex.aring@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Sep 2024 19:45:57 +0200 you wrote:
> Free the skb before returning from rpl_input when skb_cow_head() fails.
> Use a "drop" label and goto instructions.
> 
> Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> ---
>  net/ipv6/rpl_iptunnel.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net] net: ipv6: rpl_iptunnel: Fix memory leak in rpl_input
    https://git.kernel.org/netdev/net/c/2c84b0aa28b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



