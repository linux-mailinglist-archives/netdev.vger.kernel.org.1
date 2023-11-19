Return-Path: <netdev+bounces-48984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC62D7F044B
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 05:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29381C20456
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 04:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D801C3C;
	Sun, 19 Nov 2023 04:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXzAJjom"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBA34C67
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 04:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28022C433C7;
	Sun, 19 Nov 2023 04:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700367624;
	bh=edUPg9eIQL/maK0mernItBkrI7/PSbxYpaLErYhKMbI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DXzAJjomxsrCtuFRv59hueLMQpm6cpBEPXBuNEpg34nPaQKtO/pzQMjW2bMV74/Mq
	 iIhWFHW7wQyVMjfGXH1UkUHRKrxhiKk56mC56hTAKutAvY6FXUSGgB48rXn4LxOnP7
	 wp1g0jGfW4JTIfBjsCHeAImAUsPMfLuOLXWzND9dNwzvs2qdIabRQwf+IB0rsCWLeo
	 0uTTVWv1ZD3srNhtYQEDLcL8P+Azrv9f4kTLEbvU9YgnMDXWjBwbdBw2jlnHK/GjFn
	 5RYUaN6gw8f+o8o8qAfapnRSGmPcMp/kPM2hEGJahzkThaYVl6gXimNhMoeeOLs7be
	 p0eV94va8o01A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F16DEA6308;
	Sun, 19 Nov 2023 04:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][net-next][v3] rtnetlink: introduce nlmsg_new_large and use it
 in rtnl_getlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170036762405.22483.8390270708146007831.git-patchwork-notify@kernel.org>
Date: Sun, 19 Nov 2023 04:20:24 +0000
References: <20231115120108.3711-1-lirongqing@baidu.com>
In-Reply-To: <20231115120108.3711-1-lirongqing@baidu.com>
To: Li RongQing <lirongqing@baidu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, Liam.Howlett@oracle.com, anjali.k.kulkarni@oracle.com,
 leon@kernel.org, fw@strlen.de, shayagr@amazon.com, idosch@nvidia.com,
 razor@blackwall.org, linyunsheng@huawei.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Nov 2023 20:01:08 +0800 you wrote:
> if a PF has 256 or more VFs, ip link command will allocate an order 3
> memory or more, and maybe trigger OOM due to memory fragment,
> the VFs needed memory size is computed in rtnl_vfinfo_size.
> 
> so introduce nlmsg_new_large which calls netlink_alloc_large_skb in
> which vmalloc is used for large memory, to avoid the failure of
> allocating memory
> 
> [...]

Here is the summary with links:
  - [net-next,v3] rtnetlink: introduce nlmsg_new_large and use it in rtnl_getlink
    https://git.kernel.org/netdev/net-next/c/ac40916a3f72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



