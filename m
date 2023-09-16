Return-Path: <netdev+bounces-34286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F41F7A304C
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 14:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B06F1C20C73
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 12:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697BE13FEC;
	Sat, 16 Sep 2023 12:50:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DD113FE6
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 12:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7766C433C9;
	Sat, 16 Sep 2023 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694868625;
	bh=jjoEE6tC7f+hsIkthroMitLnYIzNSOizdbLWbd7sroY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TLcK42t9RvvrpvCU5/zfHTjW5ZzbuhiejZNDFspv5k1VMJFHAA2lIj7qFewr66c6z
	 U5jwyB7Odq3RPkWMCVTGl+4YFLr8SdB/4/Y8B7kPeJOku60oW0AbU5vNdyhv0C+LOK
	 OrrLeGljT7zgvQNX0ihwwxfJ24v/6d+zT0y+582XD/yJs4hHVUvxzv4rzLe6bxyUZo
	 VbLdHVcEAk22Kodzcb3bD280Wu1qPh2q5BEeJV+7f+hECgCLGxOfXpYmmSVWWmBOLo
	 mXAMWRhr4rXtHLa74+zSRZ5GIVzPYIgRvaDxoVAxmL+ZTxh+9iwQldZVoaeBJb/TEw
	 TTtrtsBQCbjhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99D8BE26881;
	Sat, 16 Sep 2023 12:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] tcp: new TCP_INFO stats for RTO events
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169486862561.28624.17117099280401372946.git-patchwork-notify@kernel.org>
Date: Sat, 16 Sep 2023 12:50:25 +0000
References: <20230914143621.3858667-1-aananthv@google.com>
In-Reply-To: <20230914143621.3858667-1-aananthv@google.com>
To: Aananth V <aananthv@google.com>
Cc: edumazet@google.com, netdev@vger.kernel.org, pabeni@redhat.com,
 davem@davemloft.net, kuba@kernel.org, ncardwell@google.com, ycheng@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Sep 2023 14:36:19 +0000 you wrote:
> The 2023 SIGCOMM paper "Improving Network Availability with Protective
> ReRoute" has indicated Linux TCP's RTO-triggered txhash rehashing can
> effectively reduce application disruption during outages. To better
> measure the efficacy of this feature, this patch set adds three more
> detailed stats during RTO recovery and exports via TCP_INFO.
> Applications and monitoring systems can leverage this data to measure
> the network path diversity and end-to-end repair latency during network
> outages to improve their network infrastructure.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] tcp: call tcp_try_undo_recovery when an RTOd TFO SYNACK is ACKed
    https://git.kernel.org/netdev/net-next/c/e326578a2141
  - [net-next,v2,2/2] tcp: new TCP_INFO stats for RTO events
    https://git.kernel.org/netdev/net-next/c/3868ab0f1925

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



