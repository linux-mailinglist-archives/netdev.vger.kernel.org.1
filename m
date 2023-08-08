Return-Path: <netdev+bounces-25239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AD37736A6
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 04:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47FF21C20DE2
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 02:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80E7160;
	Tue,  8 Aug 2023 02:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E555EAD1
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 02:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB34BC433C9;
	Tue,  8 Aug 2023 02:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691461822;
	bh=/+DRvaBB5Nd3aAt5Veav+v9Zfcn0y2zUi12SaKI4aKo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NV1GKiWymmQBxJ/6zZrUypC/032+6OnsONu7VcwHa3l1rPAKxfX1Si1Td7xw0PZqC
	 ijefgIA4x7s2hbkp+whgM+dGHah98qwNxKP+iJaNRezb1t7yQJKv/Zsfmjpx2RLpCY
	 Z6SVsyMc0oGjiiE52oHcSe3hpUQHNf2FVZ+WEWozU8G1nKp5PqB9x2EUPIzGxwv3hh
	 FiaX/g1CLKyFM9CVs5304/reISWFADYeRqmvHDgZWBRtkeGaOCsvrMzXWNfQ9wwGj3
	 P/GHAE1ShUpZqwbFG/A4KvPljL2IsObar89TzoGbmKFUHLyOG2xGLHNh6TAkDyUb9g
	 WfrpvVeIP2orw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A168DE26D5F;
	Tue,  8 Aug 2023 02:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: Remove redundant initialization owner
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169146182265.15123.6784529323477269174.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 02:30:22 +0000
References: <20230804095946.99956-1-lizetao1@huawei.com>
In-Reply-To: <20230804095946.99956-1-lizetao1@huawei.com>
To: Li Zetao <lizetao1@huawei.com>
Cc: ioana.ciornei@nxp.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 4 Aug 2023 17:59:44 +0800 you wrote:
> This patch set removes redundant initialization owner when register a
> fsl_mc_driver driver
> 
> Li Zetao (2):
>   net: dpaa2-eth: Remove redundant initialization owner in
>     dpaa2_eth_driver
>   net: dpaa2-switch: Remove redundant initialization owner in
>     dpaa2_switch_drv
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: dpaa2-eth: Remove redundant initialization owner in dpaa2_eth_driver
    https://git.kernel.org/netdev/net-next/c/43265d3fceeb
  - [net-next,2/2] net: dpaa2-switch: Remove redundant initialization owner in dpaa2_switch_drv
    https://git.kernel.org/netdev/net-next/c/ca46d207c972

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



