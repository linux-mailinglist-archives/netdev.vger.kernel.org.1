Return-Path: <netdev+bounces-27238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB8277B215
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 09:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085B01C209BD
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 07:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD21479D8;
	Mon, 14 Aug 2023 07:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92286D24
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 07:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 473D0C433CA;
	Mon, 14 Aug 2023 07:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691997023;
	bh=jhFV/JpuSGgfOz8lvkYj1LQJRDM5kK366b5Chwpb518=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mVwc7+LeDyup4gwGmXqxYnHD72H/mORST2vsSisbUg5yT7w/v7eRnVX6ZGNnWq+VF
	 ol66Hu6AEZLLUL07rx0wYIHwewr3Xh31sw4gqplMPvjxrOdjo+7aqve2xiOLcDmGTv
	 vP1G4/8Z2iZn4bfpk3ISTQ2LWuHV1ebKvRK4V7UiacINRtgiBpxb4yqEtytOJeKvmC
	 F0yE8otlkymU04Iko+9ueQ5LhcPRvb897uKLk8cR1kcUvYmpHMHX3oMpJ51zGIpSoU
	 ENP737rBV4ykVWNq2hxo4PYzGqvhwy33sHsgQt0xkN/TMqPwSzmTqkh28HZ3XWBXlf
	 e/pg5sZQ2KGqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2FE1BE93B34;
	Mon, 14 Aug 2023 07:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] Use helper functions to update stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169199702319.11756.6682442018581629637.git-patchwork-notify@kernel.org>
Date: Mon, 14 Aug 2023 07:10:23 +0000
References: <20230810085642.3781460-1-lizetao1@huawei.com>
In-Reply-To: <20230810085642.3781460-1-lizetao1@huawei.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, idosch@nvidia.com, razor@blackwall.org, jbenc@redhat.com,
 gavinl@nvidia.com, wsa+renesas@sang-engineering.com, vladimir@nikishkin.pw,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 10 Aug 2023 16:56:40 +0800 you wrote:
> The patch set uses the helper functions dev_sw_netstats_rx_add() and
> dev_sw_netstats_tx_add() to update stats, which is the same as
> implementing the function separately.
> 
> Li Zetao (2):
>   net: macsec: Use helper functions to update stats
>   vxlan: Use helper functions to update stats
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: macsec: Use helper functions to update stats
    https://git.kernel.org/netdev/net-next/c/bf98bbe98553
  - [net-next,2/2] vxlan: Use helper functions to update stats
    https://git.kernel.org/netdev/net-next/c/3c0930b491f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



