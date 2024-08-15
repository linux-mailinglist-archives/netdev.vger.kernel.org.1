Return-Path: <netdev+bounces-118813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB42952D57
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 13:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F751C235E9
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 11:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FAC7DA91;
	Thu, 15 Aug 2024 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YW64gDs0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E6C7DA84;
	Thu, 15 Aug 2024 11:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720838; cv=none; b=YcJ4J50SB3WpL1IJZCDBb9tIGsdlix1ULK09uXEDO2wl1rkyJToRc5rRqnH7rJ87+DkObDWwhytlJVVJ5vLO01yxyrNWl/KBerQtbqz9QTuJN77Z2LedMvTBxbtASQ0iAOrsiXieJ7HyRr87KC7ByLlPYHITbJ6Ctl2ryAtBKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720838; c=relaxed/simple;
	bh=m/qA4e13rC4egcD9SYA+BVaEI91NsmhDojb5RHvrrWU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q8/QEYMVM2iFupHcooa6qNOHqAFJoMkYkaNn+SqMyh9KOi3Uqc9fhDZr7XUGp0ru3kcUjzlPAU83OJ+MVNsGLb4qW9o7zs38XFNe6cob0jDnc5X1EN1s7awwvBZ7aV11s7GAfxh6lf/mBVb14Y3WQYrdDPcx6NABsS3omLb2UZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YW64gDs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AAAC32786;
	Thu, 15 Aug 2024 11:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723720838;
	bh=m/qA4e13rC4egcD9SYA+BVaEI91NsmhDojb5RHvrrWU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YW64gDs08CAEqVuXYEqQVZZbN5wjhCsjPaw0mErXUcIjneXYpzKi+orQyoNSbA79B
	 xLQnXqRBtO31GDV8N5B+/etI+SW5ze2LDguU8l07TF1m6aHAxvtj0C3s4babB7poEN
	 fOt8emvh2MUfz9QCmpQtFejG4qwzNW3kdlkBUh6fJ3frZQbybALvnMZidMLJWuD7sm
	 uh6xPSfc5IkjXQYjwXqFaIgv1tKAX4LtwtM+JQKdrmfSXzQksz+v97gFW3fntRwOpp
	 D6PKzyZUUe08EFP8q2eDG7dlF+5TFtQtnJhHe+kkbuZeFhFnT2B648YK/UQFWnjPbs
	 fiuUIMT1WxttQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5F04382327A;
	Thu, 15 Aug 2024 11:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] There are some bugfix for the HNS3 ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172372083743.2824509.8926356666875428584.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 11:20:37 +0000
References: <20240813141024.1707252-1-shaojijie@huawei.com>
In-Reply-To: <20240813141024.1707252-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 shenjian15@huawei.com, wangjie125@huawei.com, liuyonglong@huawei.com,
 wangpeiyang1@huawei.com, jonathan.cameron@huawei.com,
 shameerali.kolothum.thodi@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 Aug 2024 22:10:19 +0800 you wrote:
> There are some bugfix for the HNS3 ethernet driver
> 
> Jie Wang (2):
>   net: hns3: fix a deadlock problem when config TC during resetting
>   net: hns3: fix wrong use of semaphore up
> 
> Peiyang Wang (3):
>   net: hns3: use the user's cfg after reset
>   net: hns3: void array out of bound when loop tnl_num
>   net: hns3: use correct release function during uninitialization
> 
> [...]

Here is the summary with links:
  - [net,1/5] net: hns3: fix wrong use of semaphore up
    https://git.kernel.org/netdev/net/c/8445d9d3c031
  - [net,2/5] net: hns3: use the user's cfg after reset
    https://git.kernel.org/netdev/net/c/30545e17eac1
  - [net,3/5] net: hns3: fix a deadlock problem when config TC during resetting
    https://git.kernel.org/netdev/net/c/be5e816d00a5
  - [net,4/5] net: hns3: void array out of bound when loop tnl_num
    https://git.kernel.org/netdev/net/c/86db7bfb0670
  - [net,5/5] net: hns3: use correct release function during uninitialization
    https://git.kernel.org/netdev/net/c/7660833d2175

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



