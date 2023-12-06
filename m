Return-Path: <netdev+bounces-54281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739528066DC
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 07:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA63281D86
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 06:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6F210952;
	Wed,  6 Dec 2023 06:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myczzM7M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A25A101FA
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 06:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 963D3C433CA;
	Wed,  6 Dec 2023 06:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701842424;
	bh=jUV5cOpHKfd8ObTaaR6INb+aS2zVG3RBI2+AUN9U4KE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=myczzM7MYElrgbgrbzsHZnzWk406zkO4YNketek4IGtdoa1wCUVVgsi9AVpY0Xv5y
	 WnDHNr5mglwGIsX0GvW9SavUatsaOTEvOtipm4gllzbFFnh2s57el4bumoZUNrw4Qj
	 Iv96NutLoaBhf3yvplJrdovS/tQWzD7SNFouReqyakzpQB3TQ7KyPPHsIz6IQpKpyL
	 8yKkJaNU0+2LkIluX11myTLJEtWGHDm2oG17MbqipgV82M7VU3MzhoeM2aMucJ0+5k
	 3h4Ff1gw81GBCDva+oR3UyfqWnR1wVS79UmeDdyUVv3JMsmf3zsw6zQbjt61EuQxw+
	 wdptKtzUzSAZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77D60C395DC;
	Wed,  6 Dec 2023 06:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] ionic: small driver fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170184242448.7312.7374517675125247505.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 06:00:24 +0000
References: <20231204192234.21017-1-shannon.nelson@amd.com>
In-Reply-To: <20231204192234.21017-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, f.fainelli@gmail.com,
 brett.creeley@amd.com, drivers@pensando.io

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 4 Dec 2023 11:22:32 -0800 you wrote:
> This is a pair of fixes to address a DIM issue and a
> kernel test robot complaint
> 
> v2:
>  - dropped 5 patches, to be reposted for net-next
>  - added Florian's Rb
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] ionic: fix snprintf format length warning
    https://git.kernel.org/netdev/net/c/0ceb3860a676
  - [v2,net,2/2] ionic: Fix dim work handling in split interrupt mode
    https://git.kernel.org/netdev/net/c/4115ba677c35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



