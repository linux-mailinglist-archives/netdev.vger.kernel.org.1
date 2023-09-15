Return-Path: <netdev+bounces-34071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE1F7A1F67
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 15:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77BB8282898
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 13:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF7310944;
	Fri, 15 Sep 2023 13:00:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34CDFBF2
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 13:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F928C433C8;
	Fri, 15 Sep 2023 13:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694782825;
	bh=FysBair8IqhMXuCVUmuDEL1dzWA//+ebiJFZz7oApy8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CYzXQa9EpfLLJKGAGaOyQWfBB31cLRNpul0aaZvAurcrs1floqku/ZmbwAu4dGxG9
	 uVJbMWwuUVYuxOxVo9LirF8CuB4tiFNKb+cxVEJ13MjbjhOv1zw6eOXyK+g4I06z4O
	 XxgHeUA5UcJ4IL+0QYSq+QAzm5jBJ9ddLEC5oXhJy/AwGm1BPOq6ohBjMMO7Hq731F
	 lLeMgpLdo2tv18YLOhOxB44qHw0UuJgvZL/CzrQqmLq4oKz398JxnBVPoep5K+Bn82
	 x+pNEeU9Ac0DxRWgvl9W+6kRVsOrREaPTFfyVBUA9eVD6yN7oB/nHoF+yY0RLH+jD8
	 QFc5OXnrd7xaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46C1FE22AEE;
	Fri, 15 Sep 2023 13:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v2] octeon_ep: fix tx dma unmap len values in SG
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169478282528.10241.426302600668968163.git-patchwork-notify@kernel.org>
Date: Fri, 15 Sep 2023 13:00:25 +0000
References: <20230913084156.2147106-1-srasheed@marvell.com>
In-Reply-To: <20230913084156.2147106-1-srasheed@marvell.com>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: aayarekar@marvell.com, davem@davemloft.net, edumazet@google.com,
 egallen@redhat.com, hgani@marvell.com, horms@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, mschmidt@redhat.com, netdev@vger.kernel.org,
 pabeni@redhat.com, sburla@marvell.com, sedara@marvell.com,
 vburru@marvell.com, vimleshk@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 13 Sep 2023 01:41:56 -0700 you wrote:
> Lengths of SG pointers are kept in the following order in
> the SG entries in hardware.
>  63      48|47     32|31     16|15       0
>  -----------------------------------------
>  |  Len 0  |  Len 1  |  Len 2  |  Len 3  |
>  -----------------------------------------
>  |                Ptr 0                  |
> 
> [...]

Here is the summary with links:
  - [net,v2] octeon_ep: fix tx dma unmap len values in SG
    https://git.kernel.org/netdev/net/c/350db8a59eb3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



