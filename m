Return-Path: <netdev+bounces-46730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9596C7E61F6
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 03:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60547280F41
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 02:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CA410FE;
	Thu,  9 Nov 2023 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlaKoe4P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5649910E1
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 02:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4942C433C9;
	Thu,  9 Nov 2023 02:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699495223;
	bh=I4vzEOuc35l4pm4gfrzl13r/E3m0mxg1sr3yqH5Yxy8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FlaKoe4PxlSJKnMn+iEO7z4JnfKD1vIGyd1tZZ5Hk66y+SGN66f2Q7sLJcUvUjA0Y
	 3ugv4hdGp+8p8VAksVinRgf/D3Pql/2K+jb2paiCefESyO6cLMj6dccSmZJPOPQq2c
	 x2wY1rZ8xPfZc33IsU3Lp7b/x33/RAWzecGogQ8UwslADkyDm2blaNwYO6Tq8ZnmAt
	 mIld26E4Fu1ZtkFOQ3cgT/PzZ8oQn3xArxdEw6MlcoHLU/FLTvE38YwYUmt4bMHk7t
	 OTquEqwdT0uPPIpjo3EoEzq0dKGDw+pdeBnc75f+cTxGmwX5fkkYhr6s2mYco5zHah
	 VJ6wSIBkvQLFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8493E00086;
	Thu,  9 Nov 2023 02:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: act_ct: Always fill offloading tuple iifidx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169949522368.6460.3054206731226534744.git-patchwork-notify@kernel.org>
Date: Thu, 09 Nov 2023 02:00:23 +0000
References: <20231103151410.764271-1-vladbu@nvidia.com>
In-Reply-To: <20231103151410.764271-1-vladbu@nvidia.com>
To: Vlad Buslov <vladbu@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, pablo@netfilter.org, paulb@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 3 Nov 2023 16:14:10 +0100 you wrote:
> Referenced commit doesn't always set iifidx when offloading the flow to
> hardware. Fix the following cases:
> 
> - nf_conn_act_ct_ext_fill() is called before extension is created with
> nf_conn_act_ct_ext_add() in tcf_ct_act(). This can cause rule offload with
> unspecified iifidx when connection is offloaded after only single
> original-direction packet has been processed by tc data path. Always fill
> the new nf_conn_act_ct_ext instance after creating it in
> nf_conn_act_ct_ext_add().
> 
> [...]

Here is the summary with links:
  - [net] net/sched: act_ct: Always fill offloading tuple iifidx
    https://git.kernel.org/netdev/net/c/9bc64bd0cd76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



