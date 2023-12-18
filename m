Return-Path: <netdev+bounces-58405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E012816445
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 03:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 004DEB21626
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 02:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7D22114;
	Mon, 18 Dec 2023 02:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxH+JEW3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA20023A2
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 02:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64D93C433C9;
	Mon, 18 Dec 2023 02:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702865504;
	bh=AmZhc0MWGqXXfHW6Z4KHWN708ahoHHK58zr6QD3pckQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BxH+JEW3t9UieCOybTY4gqrqOV8ij9J/NRSQtQQ8+8OVGTVwMDm72VGhAnqFzFdab
	 /5oj7Mo1XrAMJbqypQw6JCLb6RHGoBLpxPKYQaIcConwIGBbg/9xumxxL2fyjxhkG6
	 fjHjnS3Q7t+GcsCqqk+k023mekgUDXkstGLk2cA7kywbW8f4LDGU1O/h1JG7J9+HBj
	 MlE+zAyHXfjflR7ye+BzAXb4hNf2h7fRsFJ9itow4oauKEh8UtT61Zt0L35B2Elc+v
	 zWZ71SqDOJU0TbyqvUvrF4pn45gyBdW6aLq3pUfWRWzq4p4O4JqPU2SO0jUz9xSCHg
	 Pf8njOiBVBtCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4FB90D8C984;
	Mon, 18 Dec 2023 02:11:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: rtnl: introduce rcu_replace_pointer_rtnl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170286550432.14308.2113369674273572192.git-patchwork-notify@kernel.org>
Date: Mon, 18 Dec 2023 02:11:44 +0000
References: <20231215175711.323784-1-pctammela@mojatatu.com>
In-Reply-To: <20231215175711.323784-1-pctammela@mojatatu.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 jhs@mojatatu.com, victor@mojatatu.com, martin@strongswan.org,
 idosch@nvidia.com, razor@blackwall.org, lucien.xin@gmail.com,
 edwin.peer@broadcom.com, amcohen@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 15 Dec 2023 14:57:09 -0300 you wrote:
> Introduce the rcu_replace_pointer_rtnl helper to lockdep check rtnl lock
> rcu replacements, alongside the already existing helpers.
> 
> Patch 2 uses the new helper in the rtnl_unregister_* functions.
> 
> Originally this change was part of the P4TC series, as it's a recurrent
> pattern there, but since it has a use case in mainline we are pushing it
> separately.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: rtnl: introduce rcu_replace_pointer_rtnl
    https://git.kernel.org/netdev/net-next/c/32da0f00ddcb
  - [net-next,2/2] net: rtnl: use rcu_replace_pointer_rtnl in rtnl_unregister_*
    https://git.kernel.org/netdev/net-next/c/174523479aae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



