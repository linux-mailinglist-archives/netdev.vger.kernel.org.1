Return-Path: <netdev+bounces-24807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BF6771BF7
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 10:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B64281018
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 08:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7162BC2E3;
	Mon,  7 Aug 2023 08:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA57C2E9
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 08:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81388C43391;
	Mon,  7 Aug 2023 08:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691395222;
	bh=VOlGI4tsJH0DXSIyo+nk+LkdS1FSpSSTmhdrQu5dz9M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uAPPg5NZcgFDH27oyjjeIOS2mN78L5knd0YSA4S+5vt9SU66vQIGkvEVvhjHnGawk
	 6MLOjrdkjGAo/N25j0E3hcqraVsAhc0peRopnME04j5thw0dNg92miH6yOifMWPsV4
	 oeMfrg2W+thjiJ/YUvaNxQ+7VVMwP5VTFvBym3s8bv9LPEqNMxilrckR0/yQJH6nje
	 kr4VWZKaZ16DWzjGpXWVu/ZboNHP2Ww/Vhs05Z7L7qIN2Y7KTQESCV6XKY1s7cBLrC
	 AT4tah1mU5vzA+cUBUftXj//3U64GZ3elocIfvW8vhS5wJF7rZvk9gEhBHwE350WTo
	 Y65YVwAz4f5PQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F0DAC73FE9;
	Mon,  7 Aug 2023 08:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ndisc: Remove unused ndisc_ifinfo_sysctl_strategy()
 declaration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169139522237.32661.15291881886128235378.git-patchwork-notify@kernel.org>
Date: Mon, 07 Aug 2023 08:00:22 +0000
References: <20230805105354.35008-1-yuehaibing@huawei.com>
In-Reply-To: <20230805105354.35008-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 5 Aug 2023 18:53:54 +0800 you wrote:
> Commit f8572d8f2a2b ("sysctl net: Remove unused binary sysctl code")
> left behind this declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/ndisc.h | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [net-next] ndisc: Remove unused ndisc_ifinfo_sysctl_strategy() declaration
    https://git.kernel.org/netdev/net-next/c/2c6af36beb2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



