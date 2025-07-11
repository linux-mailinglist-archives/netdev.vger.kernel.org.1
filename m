Return-Path: <netdev+bounces-206010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CDFB010D3
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 03:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B761B4A5875
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1B713B590;
	Fri, 11 Jul 2025 01:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rp55xN+W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5782CA55
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752197391; cv=none; b=YxVJ1PXvKmkrLRPJL7sE5KSz8skiXhN+Abju+WRPqG3XH1UPB/a0ltkcmCeoFwBCiZHqpYARxCLnR67q/+vIcIz+1NOpMLvCpsjXv6MA8K7BzqxsP54wdG/m2LUjT3uszx5frrXhf6FTcSNYyX9CiQmxd7kQtIcr/oSxli2FBPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752197391; c=relaxed/simple;
	bh=2nzT97FE6P9CM8vHxa58wCMJAO1jnzz9zpLJsq7k5ks=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G0ObN76QZqMeAVs2bUhAGK8IzmLTGHgqKjPnBUfaghpJnve2LWin8Jdof5BC6s+QhCv4+Hx8s7aiyGyPmyIheCWbjG7M9pK2nIFWpIo9xYjRaqi/3VXnC5djYqiMO62786Sclk15g13leAqyws8dwQYj+jhZlWLHBi11zwYRFwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rp55xN+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBB3C4CEF7;
	Fri, 11 Jul 2025 01:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752197389;
	bh=2nzT97FE6P9CM8vHxa58wCMJAO1jnzz9zpLJsq7k5ks=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rp55xN+WDKhN7C+1QYtmF00CHXGD3xwyObgzrsYYhjgejAgxSjHZSqzpi+t1epLns
	 pfo+PnO8HuMc11g7+jFd74Gz9ls60nZ9eOujvIgb8GKMGmnUOt2ttCz6IDvRASBRQU
	 mOmktT5F4k8j3BtHf1Jzwa+q8lSd148M//LMYB/myl1NJ78UQu29JiD+T7sSWgEmLY
	 7/0urDVpoWSea58wFnyYGMIS9rjKZvx1UU29xD90pXHzKqPJxBTJ0JOC4/7EnSPt8f
	 STfGQpIhZn7cm5AidsKgr68Mvu3bBmtKH8NDwIypyAHpp/G8ZARSvtfAa/h0pRiOlS
	 HcaQa+7MxUPlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B09383B266;
	Fri, 11 Jul 2025 01:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] gre: Fix default IPv6 multicast route creation.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175219741174.1728628.33955596202938885.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 01:30:11 +0000
References: <cover.1752070620.git.gnault@redhat.com>
In-Reply-To: <cover.1752070620.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, ling@moedove.com, gary@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 9 Jul 2025 16:30:04 +0200 you wrote:
> When fixing IPv6 link-local address generation on GRE devices with
> commit 3e6a0243ff00 ("gre: Fix again IPv6 link-local address
> generation."), I accidentally broke the default IPv6 multicast route
> creation on these GRE devices.
> 
> Fix that in patch 1, making the GRE specific code yet a bit closer to
> the generic code used by most other network interface types.
> 
> [...]

Here is the summary with links:
  - [net,1/2] gre: Fix IPv6 multicast route creation.
    https://git.kernel.org/netdev/net/c/4e914ef063de
  - [net,2/2] selftests: Add IPv6 multicast route generation tests for GRE devices.
    https://git.kernel.org/netdev/net/c/4d61a8a73343

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



