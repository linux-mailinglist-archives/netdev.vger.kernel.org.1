Return-Path: <netdev+bounces-61889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97F88252A7
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 12:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E7828794E
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 11:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB152C1A6;
	Fri,  5 Jan 2024 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfX7e8Xh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A383928E38
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 11:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2337EC433CA;
	Fri,  5 Jan 2024 11:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704453624;
	bh=sUA0/ruijMtnGiRCB91ppO8HLKKqL3LPCw4EaPc7WAk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XfX7e8Xh3ZprRupmO96ZkOlfjNu8Ilvzk7Su5MjZH9CcK0o56kI9ge1CisEk/sAw9
	 wpDE4l7K+aUrr9wAknZbtudJ6gUUayaE6Rhz+5405vzegsW0jd+3cfDQUJqhxRp3UE
	 MPUl73Wi9SgO9vm6KqIwOHLG7n9NkMZ1kKMj15/Fq+pgUd2I9ciwsYPU3OGXl8nhkk
	 On3GaGxkK945ZZ8CssovWcZd+snhQd+W50vIz0uuCccj3Mbk5wif4tzlJBCFi4Tv98
	 AzydTFYS7CJT6pSLlE98objXFlIedXe5jUdMSeHbQLUaoiZPOdqCsg2yHxFB7HC6/y
	 IghKran0dFsXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D1FDDCB6F8;
	Fri,  5 Jan 2024 11:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next] net: sched: move block device tracking into
 tcf_block_get/put_ext()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170445362405.9615.14672199227322437246.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jan 2024 11:20:24 +0000
References: <20240104125844.1522062-1-jiri@resnulli.us>
In-Reply-To: <20240104125844.1522062-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, victor@mojatatu.com, pctammela@mojatatu.com,
 idosch@idosch.org, mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  4 Jan 2024 13:58:44 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Inserting the device to block xarray in qdisc_create() is not suitable
> place to do this. As it requires use of tcf_block() callback, it causes
> multiple issues. It is called for all qdisc types, which is incorrect.
> 
> So, instead, move it to more suitable place, which is tcf_block_get_ext()
> and make sure it is only done for qdiscs that use block infrastructure
> and also only for blocks which are shared.
> 
> [...]

Here is the summary with links:
  - [net-next] net: sched: move block device tracking into tcf_block_get/put_ext()
    https://git.kernel.org/netdev/net-next/c/94e2557d086a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



