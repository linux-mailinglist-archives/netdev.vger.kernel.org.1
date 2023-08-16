Return-Path: <netdev+bounces-27880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73C977D824
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 04:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E70A2816C6
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 02:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCD71FD3;
	Wed, 16 Aug 2023 02:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668DE138E
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 02:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA850C433C7;
	Wed, 16 Aug 2023 02:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692151821;
	bh=VGPGyK0hBgy5mbHbzDqa/7aXwawrO7kU/TK90WK7+0E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W8O2FCNnVIyMr3ns+kNvwbal4CXOM0hE1q+eoXkNhCfotDRw7CBDlulPj6F0MUGH1
	 mhKDxRkQsZXMJhLFX9FrWPfAOTXtJrgc4akyBw/Bu1W9FVD+bfH1SY0O3oFJX6Io+N
	 Re4IyFiQrp/RGk1qp5qeBovp8kz5UJ/S9alRsqf50BsrPrSbsNetEA32/Xh+a3OVWy
	 jXKMI4V8aoHCuhEtzZRMEJyxWARrct5HZiNiCBZu/3nh7pWyAxUKXnXWzNSuZXTmpe
	 8jX/99UvOXXRhxkG+eX5SQvqwb/7dbhFeExfheeBUgQtWLWJl+lzgbIw7lf1Oz4S6S
	 mKhpPejkU6zUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFA32C39562;
	Wed, 16 Aug 2023 02:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] team: Fix incorrect deletion of ETH_P_8021AD protocol vid
 from slaves
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169215182178.21752.7481418071695603704.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 02:10:21 +0000
References: <20230814032301.2804971-1-william.xuanziyang@huawei.com>
In-Reply-To: <20230814032301.2804971-1-william.xuanziyang@huawei.com>
To: Ziyang Xuan (William) <william.xuanziyang@huawei.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 idosch@idosch.org, kaber@trash.net

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Aug 2023 11:23:01 +0800 you wrote:
> Similar to commit 01f4fd270870 ("bonding: Fix incorrect deletion of
> ETH_P_8021AD protocol vid from slaves"), we can trigger BUG_ON(!vlan_info)
> in unregister_vlan_dev() with the following testcase:
> 
>   # ip netns add ns1
>   # ip netns exec ns1 ip link add team1 type team
>   # ip netns exec ns1 ip link add team_slave type veth peer veth2
>   # ip netns exec ns1 ip link set team_slave master team1
>   # ip netns exec ns1 ip link add link team_slave name team_slave.10 type vlan id 10 protocol 802.1ad
>   # ip netns exec ns1 ip link add link team1 name team1.10 type vlan id 10 protocol 802.1ad
>   # ip netns exec ns1 ip link set team_slave nomaster
>   # ip netns del ns1
> 
> [...]

Here is the summary with links:
  - [net] team: Fix incorrect deletion of ETH_P_8021AD protocol vid from slaves
    https://git.kernel.org/netdev/net/c/dafcbce07136

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



