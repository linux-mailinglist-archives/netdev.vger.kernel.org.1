Return-Path: <netdev+bounces-33346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BED3079D78E
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 19:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7828E282162
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 17:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980468F52;
	Tue, 12 Sep 2023 17:30:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ADC33E9
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 17:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7681DC433CA;
	Tue, 12 Sep 2023 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694539827;
	bh=jY1Awx/zJ8uERdrkQB3TRrvUQI/gcKna6LoRMJstXUA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E/t9Flx/fWi84dHdFwR3jcCGmvtmqGxGiHfezLMCs+0YUJwUGYtMtasaGQe6HSFG7
	 Y/pIsVKHIVV8cCdi/JD9RqfK7UPi0X48Fv+rZgXZfBlsdjRY3YfOeTSr5axHCJCUV/
	 24BK6eyFJdZLcZY6zdfLJtRJHMoxg63ufVHsrwJr3Q9ib4f9wbtzCoMAnY/+faijtY
	 e9ZZkcBKCxwVcJBJ9yOYdg48KYKWWcwClO+Zkwjy2MRzGT1fKCo5VCTSdbAuAM3Czo
	 BvSLpZ2w5+cfDrZyTVvnHfL16YC6aBUwqXHgOrlQ+2l5FRYXnAC57RAQcDjY9NEPbF
	 pY8tR2XNsuu1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AE66E1C280;
	Tue, 12 Sep 2023 17:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] tcp: backlog processing optims
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169453982736.29997.7573604370058315270.git-patchwork-notify@kernel.org>
Date: Tue, 12 Sep 2023 17:30:27 +0000
References: <20230911170531.828100-1-edumazet@google.com>
In-Reply-To: <20230911170531.828100-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, soheil@google.com, ncardwell@google.com,
 ycheng@google.com, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 11 Sep 2023 17:05:27 +0000 you wrote:
> First patches are mostly preparing the ground for the last one.
> 
> Last patch of the series implements sort of ACK reduction
> only for the cases a TCP receiver is under high stress,
> which happens for high throughput flows.
> 
> This gives us a ~20% increase of single TCP flow (100Gbit -> 120Gbit)
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] tcp: no longer release socket ownership in tcp_release_cb()
    https://git.kernel.org/netdev/net-next/c/b49d252216e4
  - [net-next,2/4] net: sock_release_ownership() cleanup
    https://git.kernel.org/netdev/net-next/c/11445469dec8
  - [net-next,3/4] net: call prot->release_cb() when processing backlog
    https://git.kernel.org/netdev/net-next/c/4505dc2a5228
  - [net-next,4/4] tcp: defer regular ACK while processing socket backlog
    https://git.kernel.org/netdev/net-next/c/133c4c0d3717

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



