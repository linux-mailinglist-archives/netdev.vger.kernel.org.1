Return-Path: <netdev+bounces-50508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A82B17F5F5B
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 13:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA4628135E
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 12:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3415322EF0;
	Thu, 23 Nov 2023 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQDMgdbL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197521D524
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 12:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9030CC433C9;
	Thu, 23 Nov 2023 12:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700743823;
	bh=fjIpqH4w2K3lwifRvfoCoC1dEe10sv4/Tjdklvhbi6Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TQDMgdbLHYk9prYATjDAoCQiu0a7wRlul9M+MeUiI18mUXtx9wnP98vW9f4q9ERMt
	 UTYzv/WIuPneU4pM/ZUeSwVS+JCSzwI86thFsghZy6bhVK04NkW1WdjQaAPgckI4AD
	 hBfKnxFBsUAnUcki0cF63WYenYXcPR+CbIH0kKlgfOBmnTNrSA8mBSfuqOOTjUkx4C
	 Sy1bWsgywfrcAAdoIyIbU8RKFbuyLROGPvS0nvrH1b4mc7MqKPsPu6xUfRuOaIvrt5
	 /NA3J4a2pQ2K0zei0+Y/4oHSsuKDPoTtYypwSbeS8e/0OKuGP6kTHxC0qDZbZNpR0V
	 wHeyVwwqPjJog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71861EAA95A;
	Thu, 23 Nov 2023 12:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: veth: fix ethtool stats reporting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170074382346.23261.15708201274861910727.git-patchwork-notify@kernel.org>
Date: Thu, 23 Nov 2023 12:50:23 +0000
References: <c5b5d0485016836448453f12846c7c4ab75b094a.1700593593.git.lorenzo@kernel.org>
In-Reply-To: <c5b5d0485016836448453f12846c7c4ab75b094a.1700593593.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, lorenzo.bianconi@redhat.com,
 huangjie.albert@bytedance.com, toshiaki.makita1@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 21 Nov 2023 20:08:44 +0100 you wrote:
> Fix a possible misalignment between page_pool stats and tx xdp_stats
> reported in veth_get_ethtool_stats routine.
> The issue can be reproduced configuring the veth pair with the
> following tx/rx queues:
> 
> $ip link add v0 numtxqueues 2 numrxqueues 4 type veth peer name v1 \
>  numtxqueues 1 numrxqueues 1
> 
> [...]

Here is the summary with links:
  - [net] net: veth: fix ethtool stats reporting
    https://git.kernel.org/netdev/net/c/818ad9cc90d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



