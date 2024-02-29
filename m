Return-Path: <netdev+bounces-76109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE6A86C5A1
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 10:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5020B1C21F44
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 09:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ADB60BBA;
	Thu, 29 Feb 2024 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RM3TI4p9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8536089F
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199629; cv=none; b=q7ZsUCSpXaXr3Q/BFaSrygooF5DfKA5HiTRPk/tqa2hsx1Z87iD0+hQR90eg7RgyCKuBbqa0U0qL9sVSE4mo+wUTZ4+j1U15Omix3IVFCrN3NdACkr7gxYg6MAEU8o2duQgzn4GQNHZLkBmn/QlH9a4nQdytOtb6nR9gfrU3K0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199629; c=relaxed/simple;
	bh=NoowTqn55XF5VA94x0Jkp6PPEqCL6tdRBD3wXchh8N8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qw8hyS+HWrnjsCeMqjjqcbeSMyHfGhGKR0/xo8AlbbD4JtoQtqvFTsOaN7y1CuRmVt74qWLRyV14WJoJkakWd0w7/5Ul1L/iU1mGdabVuQ8H1tOPbUp4FXirTj/8IFLWHB7wZ/Eki3RdtLwco3V8OhkWdpsjP089GXO7B2S27sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RM3TI4p9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13EDBC43390;
	Thu, 29 Feb 2024 09:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709199629;
	bh=NoowTqn55XF5VA94x0Jkp6PPEqCL6tdRBD3wXchh8N8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RM3TI4p9EMLzb5JBUchINyVdqFm599wdLSxbKx58t/jbDvir4a4SLYjodLLwlW+yV
	 5AElqa8Mz6ZVn5vc9trkVwZbyPdOISTGjPTg6KLxhZRNS2LZo8UHjA00YJN75L/sv0
	 20Wk0cbJsvbsLdQVsGpWAKPTmZkln93priD5xuAkRvbVH/RpazsAwrAE6+LoOfORlG
	 H5qTsqF0MVf404mPrDNGeg6z4uP8bREWBGSQKNXgAnjXAWkiBAU2OTzfn43qVTW+zM
	 eBCT5JwI44FuSS7maLgEy4UaYV9o9lGl3wWKR4GV86MqBYXXVQbmqpsotXt6RX98hs
	 45ITSCjTRj65Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF542C3274B;
	Thu, 29 Feb 2024 09:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv4: raw: remove useless input parameter in
 do_raw_set/getsockopt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170919962897.2436.3451341015068474866.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 09:40:28 +0000
References: <20240228072505.640550-1-shaozhengchao@huawei.com>
In-Reply-To: <20240228072505.640550-1-shaozhengchao@huawei.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 weiyongjun1@huawei.com, yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 28 Feb 2024 15:25:05 +0800 you wrote:
> The input parameter 'level' in do_raw_set/getsockopt() is not used.
> Therefore, remove it.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  net/ipv4/raw.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] ipv4: raw: remove useless input parameter in do_raw_set/getsockopt
    https://git.kernel.org/netdev/net-next/c/8b2b1e62cdb9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



