Return-Path: <netdev+bounces-70424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B55A684EF46
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 04:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7230E282EA3
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 03:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3F0FC1F;
	Fri,  9 Feb 2024 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owzg2Kyx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE274C89
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448269; cv=none; b=Rx8XFlSG2WCsntr5zWpqC1u+jItXH/oOO/OrBama63PjYkSUdQ98SoOz7cfqG+Ofo+m7dmozXQ4YtppaUCLpyOFLejZnKjasYW4BcttDx3GGjfi9vBNJQeJlAb9Gbff1eXvOySR3YEAWZejaUG8BX12Va//rcAViHTeF5xO1/r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448269; c=relaxed/simple;
	bh=lT0I80QY3rs6zZ7HcW4gmXsd4KHsOPj25IWYh4LuWy8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aayAtLxyizmn/3al2hcbnBXF7/F9hJlx7yzGpBUgRfCGWeQVq+WW4BOgc+hNBLCjALcjOEVSIAZyjlBa7l1eAR5sPKhDisaxWKEtF/R0CzAw75Z3qtUGpJL4GaCwqRR4d0gErE6pkSdxITHnCZJNhJY220Z5+9sZIz0c313nYq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owzg2Kyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DA74C4166D;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707448268;
	bh=lT0I80QY3rs6zZ7HcW4gmXsd4KHsOPj25IWYh4LuWy8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=owzg2KyxvWqdwii12ziuQlkMqnES/AG9O6/F5eL6j0O8lkL/cIce3tYXcScFRVFKF
	 wECia00yXqj9JfY+r70YTi0GmXZvQ9bMwP3c8YWMsfLrbMhI5zwVXf4CJ+/j+X8RmB
	 BQSOQ0PvBBxK6SUq1u5jy2snCCV7rCxfdIWlWH1PHFePdyop9eJkoquf7AttCU5vky
	 glL7d63nouy7stEaPJhj8mWhD90zV35rQsZAEhVonohn2Knuotp+OP2rLArCqpk6E2
	 849PTU6NQ/XzUPmMUobwpzSdUnTy0WZvn18hSs5kQuFaR8N64e0f3T7NP67S8lNPzj
	 s7u7Pz/36wJdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 689F9D8C978;
	Fri,  9 Feb 2024 03:11:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net-procfs: use xarray iterator to implement
 /proc/net/dev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170744826842.23533.13519089196625957262.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 03:11:08 +0000
References: <20240207165318.3814525-1-edumazet@google.com>
In-Reply-To: <20240207165318.3814525-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Feb 2024 16:53:18 +0000 you wrote:
> In commit 759ab1edb56c ("net: store netdevs in an xarray")
> Jakub added net->dev_by_index to map ifindex to netdevices.
> 
> We can get rid of the old hash table (net->dev_index_head),
> one patch at a time, if performance is acceptable.
> 
> This patch removes unpleasant code to something more readable.
> 
> [...]

Here is the summary with links:
  - [net-next] net-procfs: use xarray iterator to implement /proc/net/dev
    https://git.kernel.org/netdev/net-next/c/0e0939c0adf9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



