Return-Path: <netdev+bounces-18796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2198758AA8
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 03:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4F01C20F04
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 01:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB8E15C1;
	Wed, 19 Jul 2023 01:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BA7ECA
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 01:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA564C433C9;
	Wed, 19 Jul 2023 01:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689729020;
	bh=8uyzKeu0wc6Hx7Imh1qAvDMKXqLGtbXjib7QCg+BnoY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gmKQOLX/yRw1rehxHT36YwhiSpD2wemNY3fpDVKio9obYi6NVZzPuebwgwYq1DXnR
	 tA+sC/Fp1IfGiQYaoFhnYGmga7srDWHemBWhuN4t9ZsGgECmvShFwtu/7G/H0cx64h
	 xGATYg4BHEpzJZ9rMEo3zoX7hXkb3a5tCMMF9iMJkV7tC33+dHQsoAeSnAA1OnYyfx
	 z+k9zmZJKKWKhZ/O2Qo2+deNMiBFF56o60TUB3nEaeDqMm+XVCzUlOsGg3vMcsPTLO
	 fQTFR3n5yvXRuj7MKjt9Pjmmn5bV3RVDjDcbsejeid7BUUciZ10+5XYQSOmmQhoTkF
	 2S6exVlPRzMpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B84A3E22AE5;
	Wed, 19 Jul 2023 01:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] net: mana: Fix doorbell access for receive
 queues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168972902074.27339.4961524881836853022.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jul 2023 01:10:20 +0000
References: <1689622539-5334-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1689622539-5334-1-git-send-email-longli@linuxonhyperv.com>
To: Long Li <longli@linuxonhyperv.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
 shradhagupta@linux.microsoft.com, sharmaajay@microsoft.com,
 shacharr@microsoft.com, stephen@networkplumber.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 longli@microsoft.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jul 2023 12:35:37 -0700 you wrote:
> From: Long Li <longli@microsoft.com>
> 
> This patchset fixes the issues discovered during 200G physical link
> tests. It fixes doorbell usage and WQE format for receive queues.
> 
> Long Li (2):
>   net: mana: Batch ringing RX queue doorbell on receiving packets
>   net: mana: Use the correct WQE count for ringing RQ doorbell
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] net: mana: Batch ringing RX queue doorbell on receiving packets
    https://git.kernel.org/netdev/net-next/c/da4e8648079e
  - [net-next,v5,2/2] net: mana: Use the correct WQE count for ringing RQ doorbell
    https://git.kernel.org/netdev/net-next/c/f5e39b57124f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



