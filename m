Return-Path: <netdev+bounces-29916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6B8785313
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 10:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4611C20C49
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 08:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6BAA958;
	Wed, 23 Aug 2023 08:50:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48357A921
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 08:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7981C433CD;
	Wed, 23 Aug 2023 08:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692780622;
	bh=NidenGIyv8tKf7O7kBYlmnD3vSpGprd6aGJi2ekcb+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DRD0dJQhpdnsSBXuVAdOKu8uFHktwUdxW5XTGaZ6gglo3rht4qlOHXyP7SqZRjA7o
	 2Vzq96scGsjOnohTfVnRjXh7X4p9MpuqnBJheHLgYokOw1awlmoCN/VDEDT28R653r
	 oLFtJvK3YxdNNGKKEG1lJh6sconAZSiN+lEVefeyv57FrJKvdfhBzpWtFpVAo9ewAc
	 pylamtYLLgxxLolJUODmU2gjHryd+4oM0X1Rv5NEbcx8dTJKVulKkwbYuDypl3/NdP
	 1MyqAOcb6kVzRCD7otezTwTh34hLD0qPTgnz7BpTHCpqMiIiPi+GtoEHEdQEnHH3sn
	 lFzhJX+DUAU+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A48C7E21ED3;
	Wed, 23 Aug 2023 08:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: Avoid address overwrite in kernel_connect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169278062267.13745.13237443824798371659.git-patchwork-notify@kernel.org>
Date: Wed, 23 Aug 2023 08:50:22 +0000
References: <20230821214523.720206-1-jrife@google.com>
In-Reply-To: <20230821214523.720206-1-jrife@google.com>
To: Jordan Rife <jrife@google.com>
Cc: kuniyu@amazon.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 21 Aug 2023 16:45:23 -0500 you wrote:
> BPF programs that run on connect can rewrite the connect address. For
> the connect system call this isn't a problem, because a copy of the address
> is made when it is moved into kernel space. However, kernel_connect
> simply passes through the address it is given, so the caller may observe
> its address value unexpectedly change.
> 
> A practical example where this is problematic is where NFS is combined
> with a system such as Cilium which implements BPF-based load balancing.
> A common pattern in software-defined storage systems is to have an NFS
> mount that connects to a persistent virtual IP which in turn maps to an
> ephemeral server IP. This is usually done to achieve high availability:
> if your server goes down you can quickly spin up a replacement and remap
> the virtual IP to that endpoint. With BPF-based load balancing, mounts
> will forget the virtual IP address when the address rewrite occurs
> because a pointer to the only copy of that address is passed down the
> stack. Server failover then breaks, because clients have forgotten the
> virtual IP address. Reconnects fail and mounts remain broken. This patch
> was tested by setting up a scenario like this and ensuring that NFS
> reconnects worked after applying the patch.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: Avoid address overwrite in kernel_connect
    https://git.kernel.org/netdev/net-next/c/0bdf399342c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



