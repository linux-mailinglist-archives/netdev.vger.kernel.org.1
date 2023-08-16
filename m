Return-Path: <netdev+bounces-27977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0921777DCE4
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 11:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E8E281818
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 09:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB21D516;
	Wed, 16 Aug 2023 09:00:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F4D532
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A05FC433CA;
	Wed, 16 Aug 2023 09:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692176424;
	bh=F/rNh/pWufFSeeYbf819D/PW9ficslBX3e3RS8IcVAg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UK/m7C8boCaUAPEr+IxztQ8uogbd9lDrOtt3+coHsxzgn7cwIXf/VCRSDZ05EowZT
	 vM+pCuPV66d+yP3llG8tzY7jUiEmj2C4SEX/ZAWK1ui6mLqW+KFLr+p0qW6Bphomew
	 5Rd8Bcj21U7Sqcj/gNcq6vJINCBjmK1d0tSJkx/+dx5BIRSX16MNHeyf2IsHhnpNYI
	 c7zc+OuL+12mgQIBsorA1uredmhnRlygM9LGyFz01nS/5bvAHh+apFBDCuairRVzTm
	 MgPNMBe0IGAwwF8fV40pwEQYEllkT1CjgYT65dolDX+KMM48RecUODuvWSMPQE3JOW
	 1FXPRjFSY9uUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04257C395C5;
	Wed, 16 Aug 2023 09:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] refactor registers information for ethtool -d
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169217642401.25260.16017787272530906946.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 09:00:24 +0000
References: <20230815060641.3551665-1-shaojijie@huawei.com>
In-Reply-To: <20230815060641.3551665-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shenjian15@huawei.com, wangjie125@huawei.com, liuyonglong@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 15 Aug 2023 14:06:37 +0800 you wrote:
> refactor registers information for ethtool -d
> 
> Jijie Shao (4):
>   net: hns3: move dump regs function to a separate file
>   net: hns3: Support tlv in regs data for HNS3 PF driver
>   net: hns3: Support tlv in regs data for HNS3 VF driver
>   net: hns3: fix wrong rpu tln reg issue
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: hns3: move dump regs function to a separate file
    https://git.kernel.org/netdev/net-next/c/939ccd107ffc
  - [net-next,2/4] net: hns3: Support tlv in regs data for HNS3 PF driver
    https://git.kernel.org/netdev/net-next/c/d8634b7c3f62
  - [net-next,3/4] net: hns3: Support tlv in regs data for HNS3 VF driver
    https://git.kernel.org/netdev/net-next/c/3ef5d70b82ad
  - [net-next,4/4] net: hns3: fix wrong rpu tln reg issue
    https://git.kernel.org/netdev/net-next/c/36122201eeae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



