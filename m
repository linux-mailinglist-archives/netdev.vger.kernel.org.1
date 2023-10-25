Return-Path: <netdev+bounces-44307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FE47D7864
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 01:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408A6281414
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E47234CF1;
	Wed, 25 Oct 2023 23:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kV5aWgNl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD54347CF
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 23:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9050C433C8;
	Wed, 25 Oct 2023 23:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698275424;
	bh=syA8tSJQGVVexUFPUvXgXI6B00D5f27wwhNUVPyn/Wg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kV5aWgNlr28ULSSC8Fa2QtAVkf5hFvIbRDTo1+4Lp7A7ptFELZPEUrqzQ+sGyZb9q
	 a9cyxkF5JT2odoEPyySWklLjHkMSblKVsC6dfcObJQGiXFN1I0VVf+NInqfWbQOuHQ
	 iwCkc/1l+mYaklHzuWkfgErN+IAWB9v/zeFxC77azJ8Da78I1g2/3+NTv7E4DMXAR6
	 d9JsF+cmYXrB6qEoRYoRhR18HFlH8iTz0pyI5cEor39vMIKdHWxxAkzXEfxbhTliea
	 V+iFzw2YqUnJzrgQPS0shXZsNajvRv37rv3Kecg6EvnIGAGUMMOoV9xvo7mjSEZmhS
	 b1iFRPLxP59Xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D1A0C3959F;
	Wed, 25 Oct 2023 23:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] netfilter: flowtable: GC pushes back packets to
 classic path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169827542464.7495.6756157867363734179.git-patchwork-notify@kernel.org>
Date: Wed, 25 Oct 2023 23:10:24 +0000
References: <20231025100819.2664-2-pablo@netfilter.org>
In-Reply-To: <20231025100819.2664-2-pablo@netfilter.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, fw@strlen.de

Hello:

This series was applied to netdev/net.git (main)
by Pablo Neira Ayuso <pablo@netfilter.org>:

On Wed, 25 Oct 2023 12:08:18 +0200 you wrote:
> Since 41f2c7c342d3 ("net/sched: act_ct: Fix promotion of offloaded
> unreplied tuple"), flowtable GC pushes back flows with IPS_SEEN_REPLY
> back to classic path in every run, ie. every second. This is because of
> a new check for NF_FLOW_HW_ESTABLISHED which is specific of sched/act_ct.
> 
> In Netfilter's flowtable case, NF_FLOW_HW_ESTABLISHED never gets set on
> and IPS_SEEN_REPLY is unreliable since users decide when to offload the
> flow before, such bit might be set on at a later stage.
> 
> [...]

Here is the summary with links:
  - [net,1/2] netfilter: flowtable: GC pushes back packets to classic path
    https://git.kernel.org/netdev/net/c/735795f68b37
  - [net,2/2] net/sched: act_ct: additional checks for outdated flows
    https://git.kernel.org/netdev/net/c/a63b6622120c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



