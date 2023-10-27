Return-Path: <netdev+bounces-44697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 391A97D948B
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93B06282385
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6301171C5;
	Fri, 27 Oct 2023 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXK9Cds2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B205E17731
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:00:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38199C433C9;
	Fri, 27 Oct 2023 10:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698400833;
	bh=rmvtbkA61r4hq692J/vNITDiPIVR5LTqd1Q2i4pE35U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PXK9Cds2BDm1626vArrGavvRKVQ2PqUMWucdpDmn/vYZ6yIhL0C4AcrL58xHn4r0n
	 JuuLkySHStIiOVogcBckGYHmsQCM8tAUKLY14625BkvjS0l01ya6BN8U/uBYq9VdSU
	 33rzjN45KV84HFb2dxx7k8ROzEfKpg/EMxIcCbmc8AdvQFX04jBl043IcisB9VCU2y
	 gM9v6xHCy0jFjuCabIsuoJja0iRt8Xh1Zn1xXKxUS2ECsNoJ/r7ITcTBf2vOfwViCb
	 pKU7bYmRGV4hWaul0C6CgFjVxNzZJIkVrw9c4wMUOqvlTGe7mvAXvX+YP+nlnwt9yS
	 2G9W5Fs6jZAGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 188CBE19E22;
	Fri, 27 Oct 2023 10:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] virtio_net: use u64_stats_t infra to avoid
 data-races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169840083309.2931.2693062060056048598.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 10:00:33 +0000
References: <20231026171840.4082735-1-edumazet@google.com>
In-Reply-To: <20231026171840.4082735-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 26 Oct 2023 17:18:40 +0000 you wrote:
> syzbot reported a data-race in virtnet_poll / virtnet_stats [1]
> 
> u64_stats_t infra has very nice accessors that must be used
> to avoid potential load-store tearing.
> 
> [1]
> BUG: KCSAN: data-race in virtnet_poll / virtnet_stats
> 
> [...]

Here is the summary with links:
  - [net-next] virtio_net: use u64_stats_t infra to avoid data-races
    https://git.kernel.org/netdev/net-next/c/61217d8f6360

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



