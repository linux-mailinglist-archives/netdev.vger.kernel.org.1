Return-Path: <netdev+bounces-201710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B2DAEABC4
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 02:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1DA4E09D5
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 00:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A63A4C9D;
	Fri, 27 Jun 2025 00:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJ6gaPot"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6067A2F30;
	Fri, 27 Jun 2025 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750984180; cv=none; b=EJJc9YBpLbZbeuPflTXBDTsunStKOh2/+u2R8U8xneRtjhi6uJ1y3ToKMKrUNktzgmTTIN81i53S76Oyc34xz43k3TTocayZplhReZL6o4XwEcoPAwTkqJYnorxuc2OpHGZE108MfSdL6pz6j3O4OVsWzv8aFPatAeR9EeNtqT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750984180; c=relaxed/simple;
	bh=kpOmWqyh2I+6Xk6RjUCcQG3I+QS1vPnHrnO7ToVIJMg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lUMDYluP++IAbrJOb9aWLlAOnFB2HJzazctOVaVmLA/CrhZhtXdxCNrsziYkmn+VGq07typBwgj7jfK6hnIiiZTdn81byA0SCaZQUxhaMR40CaDOA5MhUE+BeL28+7UOPEAhSMSrYrtenh+/NmM1zgUYhE6xLSIcn7Fplga3QqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJ6gaPot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB74DC4CEEB;
	Fri, 27 Jun 2025 00:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750984179;
	bh=kpOmWqyh2I+6Xk6RjUCcQG3I+QS1vPnHrnO7ToVIJMg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HJ6gaPotiKvqXsto+Bl+IhvIbp4l0/1MtfBq7yd+N2185yfTXuCq/s362lVHUNVcD
	 lPjSOY7tK32+QZUbAM1mB6qLr2v/JhV3WoKULD0olM0lc+hhn3RxvwkSHZFLgN9hft
	 g/Dg+Qs1aU5F17HC+X/Vd0E4lEi2V9xYLe3SnFi+/Is6qkpFDb2aYmwh4JxcvqL04f
	 uSpfyDxro1VHM9/qBWGINCWtlGDMb+RpN41GBha9BMRfOjk9DqXfm7WlyKbqzfTrbQ
	 2CB3MBhbGBZ/HDux91MFKed6TOsdA7RcTLxQ0rDo2jBBE0YW+4vw5hjQVBtuR0n1jg
	 AFj6oGTaR55Bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D163A40FCB;
	Fri, 27 Jun 2025 00:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ipv4: fib: Remove unnecessary encap_type
 check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175098420600.1382491.1629775321433934271.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 00:30:06 +0000
References: <20250625022059.3958215-1-yuehaibing@huawei.com>
In-Reply-To: <20250625022059.3958215-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Jun 2025 10:20:59 +0800 you wrote:
> lwtunnel_build_state() has check validity of encap_type,
> so no need to do this before call it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
> v2: Restore encap_type check in fib_encap_match()
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ipv4: fib: Remove unnecessary encap_type check
    https://git.kernel.org/netdev/net-next/c/77e12dba07d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



