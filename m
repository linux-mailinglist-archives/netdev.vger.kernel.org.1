Return-Path: <netdev+bounces-38218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C8F7B9CC6
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 13:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 221421C20837
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 11:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C5A134A7;
	Thu,  5 Oct 2023 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TekfBu60"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30DB11CA6
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 11:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EFF8C4936D;
	Thu,  5 Oct 2023 11:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696506029;
	bh=4pACL5HWda+e9AWnT6cUgDZsSSumw6F/Dt93tnglR4E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TekfBu60DC1HnNcqn+WzLmFOtqME+V68pkPq27Agt9AS+tAkaLLqelmSGTJaBjMZi
	 xZYZC6hBRU1mNhvy6StTM4yL8wrIn4sSyK0LdQyTTXAbOhrZ51cGPQ7hj+xpoZJ97v
	 WJAUlfH/V0PHkuugyChPKGMemOXLFlJympdy4Gv7Ec2wxpQH5RW4y7PnAZOiOxKnQX
	 Px9ziBiuPqHTRz+kKzP6qcaJZ+dnDAFlqJSIpWU6w34iY7balopgAdZkOI+SFgdUb3
	 Nb00fJj/z4kAaygL8Q/fa+HtZZb7oMQ/0s1jMZpj98Uxd6I4S0mLTIgNyD2BzPTZk8
	 Pht0ba5J+OcXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EAC67E11F51;
	Thu,  5 Oct 2023 11:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/4] net_sched: sch_fq: add WRR scheduling and 3
 bands
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169650602895.11144.4055004484580068482.git-patchwork-notify@kernel.org>
Date: Thu, 05 Oct 2023 11:40:28 +0000
References: <20231002131738.1868703-1-edumazet@google.com>
In-Reply-To: <20231002131738.1868703-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, soheil@google.com, ncardwell@google.com,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, toke@redhat.com,
 jiri@resnulli.us, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  2 Oct 2023 13:17:34 +0000 you wrote:
> As discussed in Netconf 2023 in Paris last week, this series adds
> to FQ the possibility of replacing pfifo_fast for most setups.
> 
> FQ provides fairness among flows, but malicious applications
> can cause problems by using thousands of sockets.
> 
> Having 3 bands like pfifo_fast can make sure that applications
> using high prio packets (eg AF4) can get guaranteed throughput
> even if thousands of low priority flows are competing.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/4] net_sched: sch_fq: remove q->ktime_cache
    https://git.kernel.org/netdev/net-next/c/2ae45136a938
  - [v2,net-next,2/4] net_sched: export pfifo_fast prio2band[]
    https://git.kernel.org/netdev/net-next/c/5579ee462dfe
  - [v2,net-next,3/4] net_sched: sch_fq: add 3 bands and WRR scheduling
    https://git.kernel.org/netdev/net-next/c/29f834aa326e
  - [v2,net-next,4/4] net_sched: sch_fq: add TCA_FQ_WEIGHTS attribute
    https://git.kernel.org/netdev/net-next/c/49e7265fd098

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



