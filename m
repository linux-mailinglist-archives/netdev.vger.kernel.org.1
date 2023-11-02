Return-Path: <netdev+bounces-45655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471BA7DEC7E
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 06:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B39281AAE
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 05:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440B74C9B;
	Thu,  2 Nov 2023 05:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0467xkY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E166441D;
	Thu,  2 Nov 2023 05:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B18A3C433D9;
	Thu,  2 Nov 2023 05:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698904287;
	bh=KS0fczX2dAdOr8GV1PTSbC52MJ+hvjBHXS1uM+w5D9o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K0467xkYbmEoZ8B2rj4TeopHXPjMr5kP6v0doOE7OSwz0BJtaJADLPvMNxe7u1jGz
	 ttdMpI7339WbVxiCzwL4lPvcgTMfr58zsuBVWqpHHEnClsmzDN04l3m70MMAx5SEt+
	 sBid+gVX0jgSdtHh0mQwKVtHgt4KVZjsoWfqujRDa0N+0k0d2JuHdsLUGXO9EgaFBm
	 xkavcYxTnI6im5imGtGtfDpnuBgP7jLz0GHWaWynPLZQcVQ8A3NSJEIawi7F9XxOLR
	 P9yHNHnS1+WpdSAK1xXjDzAuK6kM+8Th3UEwe/nQMzGRIAeeyu1vN8dlUDKu6zI6zq
	 7sPqlzhGt2zug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 915A3E00095;
	Thu,  2 Nov 2023 05:51:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] hsr: Prevent use after free in prp_create_tagged_frame()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169890428759.30377.15549694691524756764.git-patchwork-notify@kernel.org>
Date: Thu, 02 Nov 2023 05:51:27 +0000
References: <57af1f28-7f57-4a96-bcd3-b7a0f2340845@moroto.mountain>
In-Reply-To: <57af1f28-7f57-4a96-bcd3-b7a0f2340845@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: m-karicheri2@ti.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, bigeasy@linutronix.de,
 yuehaibing@huawei.com, william.xuanziyang@huawei.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Oct 2023 15:19:01 +0300 you wrote:
> The prp_fill_rct() function can fail.  In that situation, it frees the
> skb and returns NULL.  Meanwhile on the success path, it returns the
> original skb.  So it's straight forward to fix bug by using the returned
> value.
> 
> Fixes: 451d8123f897 ("net: prp: add packet handling support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net] hsr: Prevent use after free in prp_create_tagged_frame()
    https://git.kernel.org/netdev/net/c/876f8ab52363

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



