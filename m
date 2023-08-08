Return-Path: <netdev+bounces-25633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAEE774F73
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F362819CE
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399821C9E5;
	Tue,  8 Aug 2023 23:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBA718035
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69B16C433CD;
	Tue,  8 Aug 2023 23:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691538024;
	bh=RpkfSsTj63Ao0/zLN6DzdQtPy3uqu9XlwAbYoRpejGU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l6eyH3DEFyPLZqhoKX6LAs4QPnRRV+X2e9nZFwjwlSKuQX7JNuyI12pFaHsa24LsB
	 QlOkX1G/4uCT8aM5Vxkhh3D+/DGKqYKlup8DyjTef1tIMspFozk3ko6hDQR1B9gYsx
	 Wx2gLbg6L0g61Ft7+yC7xztqhMf46ZwD93fvfAL6sWUdzeFDjRGs5wqsw4ls7LrvYz
	 VRRl2iI4B6C7nE8UEWnDJbHUKqJ/yV9iAgsIuCcJ8YMuj37sfbPety+uF11WYaazIw
	 Y/8f09WWzU0FjLs481uZX52OA20EkoEpNunyNdlm/X51JkbT04GPj2ZnrjNMZnTL5C
	 57Hs4CbmUdNgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3FB53C395C5;
	Tue,  8 Aug 2023 23:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net 0/4] There are some bugfix for the HNS3 ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153802424.28457.4555959031610597293.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 23:40:24 +0000
References: <20230807113452.474224-1-shaojijie@huawei.com>
In-Reply-To: <20230807113452.474224-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shenjian15@huawei.com, wangjie125@huawei.com, liuyonglong@huawei.com,
 wangpeiyang1@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 7 Aug 2023 19:34:48 +0800 you wrote:
> There are some bugfix for the HNS3 ethernet driver
> 
> ChangeLog:
> v1->v2:
>   delete two patches in this patchset:
>     net: hns3: fix wrong print link down up
>     - This patch is being analyzed according to Andrew Lunn's suggestion
>     net: hns3: fix side effects passed to min_t()
>     - This patch is unnecessary suggested by David Laight
>   v1: https://lore.kernel.org/all/20230728075840.4022760-2-shaojijie@huawei.com/
> 
> [...]

Here is the summary with links:
  - [V2,net,1/4] net: hns3: restore user pause configure when disable autoneg
    https://git.kernel.org/netdev/net/c/15159ec0c831
  - [V2,net,2/4] net: hns3: refactor hclge_mac_link_status_wait for interface reuse
    https://git.kernel.org/netdev/net/c/08469dacfad2
  - [V2,net,3/4] net: hns3: add wait until mac link down
    https://git.kernel.org/netdev/net/c/6265e242f7b9
  - [V2,net,4/4] net: hns3: fix deadlock issue when externel_lb and reset are executed together
    https://git.kernel.org/netdev/net/c/ac6257a3ae5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



