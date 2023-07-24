Return-Path: <netdev+bounces-20273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7DE75EDF1
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148C72814B9
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 08:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B001C10;
	Mon, 24 Jul 2023 08:40:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2893517C1
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 08:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 927B9C433C8;
	Mon, 24 Jul 2023 08:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690188027;
	bh=muEb+uNpKl5zSX4ozom2S92rcYpLMhy8kUk94G3z58k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O576/h8d3assd2/k+GUAhQuhUcrv7Kfpbq6xOL/fQwNFRIIpFlOk/EZgI2t7DCj5k
	 g38bBTuXrr92N+ycy7oR+w0DaG6K4WiGHycureC/jk+Zujt3Znri+/K/4TczjwqpDw
	 RlA5+CMKbUz1mw3u/W3LCpdJ0pyGuUffuaufE6wn6r3nnzFypyVrVJwRUhkNVmLIze
	 ecCd8/6kIehCa/GUS+DqF7t0H1YVqJwshke9CPVFR2SxtvgLJOg5TJRW6pRF0qbm5+
	 n7KojLr6tV+Lrxq0DE7fG7fuQaHo0yj1L+sd39IgwuLPoR4mmHznJQ27oAVa805iID
	 NKFnXnFX35T4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74FA6C595D7;
	Mon, 24 Jul 2023 08:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] There are some bugfix for the HNS3 ethernet driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169018802747.2769.940666506687962832.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jul 2023 08:40:27 +0000
References: <20230720020510.2223815-1-shaojijie@huawei.com>
In-Reply-To: <20230720020510.2223815-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: netdev@vger.kernel.org, yisen.zhuang@huawei.com, salil.mehta@huawei.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 lanhao@huawei.com, chenhao418@huawei.com, wangjie125@huawei.com,
 shenjian15@huawei.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Jul 2023 10:05:06 +0800 you wrote:
> There are some bugfix for the HNS3 ethernet driver
> 
> Hao Lan (2):
>   net: hns3: fix the imp capability bit cannot exceed 32 bits issue
>   net: hns3: add tm flush when setting tm
> 
> Jijie Shao (2):
>   net: hns3: fix wrong tc bandwidth weight data issue
>   net: hns3: fix wrong bw weight of disabled tc issue
> 
> [...]

Here is the summary with links:
  - [net,1/4] net: hns3: fix the imp capability bit cannot exceed 32 bits issue
    https://git.kernel.org/netdev/net/c/b27d0232e889
  - [net,2/4] net: hns3: add tm flush when setting tm
    https://git.kernel.org/netdev/net/c/6d2336120aa6
  - [net,3/4] net: hns3: fix wrong tc bandwidth weight data issue
    https://git.kernel.org/netdev/net/c/116d9f732eef
  - [net,4/4] net: hns3: fix wrong bw weight of disabled tc issue
    https://git.kernel.org/netdev/net/c/882481b1c55f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



