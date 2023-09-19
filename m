Return-Path: <netdev+bounces-34926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA42E7A5F55
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 12:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93671281C4E
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 10:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCF43398F;
	Tue, 19 Sep 2023 10:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3B4110B
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 10:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD81BC433C8;
	Tue, 19 Sep 2023 10:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695118823;
	bh=qqeF1t+aH5aNEKTxzWsZ3xvz/bvHp6L6xuIECCmBhj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LAuVtHbHaMDkGyohq09nOuuW8r5VNJpc102mH76gG8VKF2Sj1K0W/PEP2urzF819d
	 Kd8pZq9cs1EST7QN/3G4eZBrR9bY9CmbikpkQ7hFwDwOF3DWMoD951da8AGQ4cy2uM
	 UFwLl+Uj5Vp0/ZlBgYYAopFPVYLvByk0aNAW7br/44QvAra7q1Ga7cAjQkFfiMedYt
	 ZSh1firVEcq08I2z2kMDzSxj38n8TN6yTvtPjlqEcZA6gP4q5WF+VnfeeLyQ84JvUn
	 NMiqXQgr7wEjEiRSSOps1svC3V+oBMzQM7ssGHDZUWT0SRNAV50T6ORMG53ThoPC5f
	 pmsNbMv39mXZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A21FBE11F42;
	Tue, 19 Sep 2023 10:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2 net 0/5] There are some bugfix for the HNS3 ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169511882366.4546.6244271992953408805.git-patchwork-notify@kernel.org>
Date: Tue, 19 Sep 2023 10:20:23 +0000
References: <20230918074840.2650978-1-shaojijie@huawei.com>
In-Reply-To: <20230918074840.2650978-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shenjian15@huawei.com, wangjie125@huawei.com, liuyonglong@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 Sep 2023 15:48:35 +0800 you wrote:
> There are some bugfix for the HNS3 ethernet driver
> 
> ---
> ChangeLog:
> v1->v2:
>   add Fixes tag for bugfix patch suggested by Simon Horman
>   v1: https://lore.kernel.org/all/20230915095305.422328-1-shaojijie@huawei.com/
> 
> [...]

Here is the summary with links:
  - [V2,net,1/5] net: hns3: add cmdq check for vf periodic service task
    https://git.kernel.org/netdev/net/c/bd3caddf299a
  - [V2,net,2/5] net: hns3: fix GRE checksum offload issue
    https://git.kernel.org/netdev/net/c/f9f651261130
  - [V2,net,3/5] net: hns3: only enable unicast promisc when mac table full
    https://git.kernel.org/netdev/net/c/f2ed304922a5
  - [V2,net,4/5] net: hns3: fix fail to delete tc flower rules during reset issue
    https://git.kernel.org/netdev/net/c/1a7be66e4685
  - [V2,net,5/5] net: hns3: add 5ms delay before clear firmware reset irq source
    https://git.kernel.org/netdev/net/c/0770063096d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



