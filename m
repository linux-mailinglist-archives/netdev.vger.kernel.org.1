Return-Path: <netdev+bounces-26050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6F4776A97
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 23:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 293E8281D44
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 21:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279C51D30C;
	Wed,  9 Aug 2023 21:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0A82453A
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 21:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EF13C433C9;
	Wed,  9 Aug 2023 21:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691614822;
	bh=5AMCSoUJ6woWgQFaMUq9xOZ2c2rXFKpYdKFDa1nF5fk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DMI4fWdsaHdvUnmegKui5vkPRpYMNuU17U/UtY7NdS7PhsIZTFTj/lVN4B9RqE7Hv
	 brjcBHZBpjeA4tYqhf/rfjNSY4Admwy+2ayqkEoQCBFMq2LkJ0b+s7lv5l28H2TF1M
	 H4SqKoP8vxDMMelLDrD14rvM0Ydw8cCqNtfW5i36dKfSjh6LoYX1IC977sDdTw98W7
	 wbWbnVP+3ERjeK0cBe0risbA9sveLhA3VfX5PqctaQ6taRzl1xwJexiF0UN6FhYkhs
	 D8oaleSiye7UbeDZSA/mvtHC1QQwGE17mPMLQOOPI1VJB312lKp3pDQc53XIbuWXtl
	 I2n/lrlOC9veA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40301E33090;
	Wed,  9 Aug 2023 21:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] nexthop: Nexthop dump fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169161482226.5018.9274281579069243398.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 21:00:22 +0000
References: <20230808075233.3337922-1-idosch@nvidia.com>
In-Reply-To: <20230808075233.3337922-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, petrm@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 8 Aug 2023 10:52:30 +0300 you wrote:
> Patches #1 and #3 fix two problems related to nexthops and nexthop
> buckets dump, respectively. Patch #2 is a preparation for the third
> patch.
> 
> The pattern described in these patches of splitting the NLMSG_DONE to a
> separate response is prevalent in other rtnetlink dump callbacks. I
> don't know if it's because I'm missing something or if this was done
> intentionally to ensure the message is delivered to user space. After
> commit 0642840b8bb0 ("af_netlink: ensure that NLMSG_DONE never fails in
> dumps") this is no longer necessary and I can improve these dump
> callbacks assuming this analysis is correct.
> 
> [...]

Here is the summary with links:
  - [net,1/3] nexthop: Fix infinite nexthop dump when using maximum nexthop ID
    https://git.kernel.org/netdev/net/c/913f60cacda7
  - [net,2/3] nexthop: Make nexthop bucket dump more efficient
    https://git.kernel.org/netdev/net/c/f10d3d9df49d
  - [net,3/3] nexthop: Fix infinite nexthop bucket dump when using maximum nexthop ID
    https://git.kernel.org/netdev/net/c/8743aeff5bc4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



