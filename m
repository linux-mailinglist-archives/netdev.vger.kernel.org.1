Return-Path: <netdev+bounces-27545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D67D77C5E0
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 04:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35AC281277
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 02:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AEF15DA;
	Tue, 15 Aug 2023 02:30:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2B923CB
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 02:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8282FC433C9;
	Tue, 15 Aug 2023 02:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692066619;
	bh=Xj7GAA3+ACLe64FOcRuwMFYQ1DotugxX1/UDMjO6WS8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qthan4dIFt6I8UaxB2oQPxxMA+4VodA+4T31ABcQaUnQBZobwgYByth9Wx6brpIiP
	 Bz3RfFzIpeoogR2hchugDmwIH942dFVKbc+e6l4iLJfUl6MVJ5McqmUAEWBfK6NcW4
	 dJgJ1VTlH1i1dJrApVhf/iS4PkCbXKfqT5cZKETOWBc+Cubg0UChlKHDO1uk4iCLdd
	 f/4t3xSsDDONqOLUDz0/F+qw2ryhxfSgdV9sysdLGbKbyrq2sinjUpVgpiGahYhOQ5
	 kWDJT+q56lYzLLALYAGjQSjMurd/Sw1zcnOOohj+/CcFVgHSNs823bo69T3aaf9G9c
	 7Tljxy4OZbEYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69351E93B32;
	Tue, 15 Aug 2023 02:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: veth: Page pool creation error handling for
 existing pools only
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169206661942.16325.9389282746030868287.git-patchwork-notify@kernel.org>
Date: Tue, 15 Aug 2023 02:30:19 +0000
References: <20230812023016.10553-1-liangchen.linux@gmail.com>
In-Reply-To: <20230812023016.10553-1-liangchen.linux@gmail.com>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: hawk@kernel.org, horms@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linyunsheng@huawei.com, ilias.apalodimas@linaro.org, daniel@iogearbox.net,
 ast@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 12 Aug 2023 10:30:16 +0800 you wrote:
> The failure handling procedure destroys page pools for all queues,
> including those that haven't had their page pool created yet. this patch
> introduces necessary adjustments to prevent potential risks and
> inconsistency with the error handling behavior.
> 
> Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: veth: Page pool creation error handling for existing pools only
    https://git.kernel.org/netdev/net/c/8a519a572598

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



