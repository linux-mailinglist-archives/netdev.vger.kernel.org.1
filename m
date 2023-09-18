Return-Path: <netdev+bounces-34385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFE57A40E0
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 08:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36B81C20A48
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 06:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C895397;
	Mon, 18 Sep 2023 06:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E415382
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 06:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 179AEC433CC;
	Mon, 18 Sep 2023 06:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695017423;
	bh=faJDfVTZnoXkaUKIebi8ZF6NXz+I7LuFrleI7sNVv+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gkxF72HxLz7PfD16qDdAg95DepUjDf9zUjjPhQfZFpnt8oXcUruzLLKwA7NqhnPHo
	 HZfiB3q7uFVkLS7Pay25tKAuoLXh0f9b24EgSdvcTGjKqUDw1uH2cJDkpxyrHPJ4qK
	 luIVowfQ0IjIkudpdGUTsB4/df1HZM/0HVj4UrUs2a47E3+tIU7iCaSfyfG6cubLXP
	 RmWarXaNHHRZuz0FZMcInl78dUUJFkJP8ZSJ3YsPwCVf2mjoj9rg5acNGSPnsGkxE7
	 EXFAojiiilgqDKfVN5zqluGyJry2DC3MPIT2xbaqI+UKQW5mwTvxWPD9jlldBiB9zQ
	 VETE3Hfq4KQPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05572E11F42;
	Mon, 18 Sep 2023 06:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeon_ep: support to fetch firmware info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169501742301.10972.7267111808150683547.git-patchwork-notify@kernel.org>
Date: Mon, 18 Sep 2023 06:10:23 +0000
References: <20230915081608.2155837-1-srasheed@marvell.com>
In-Reply-To: <20230915081608.2155837-1-srasheed@marvell.com>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
 egallen@redhat.com, mschmidt@redhat.com, vimleshk@marvell.com,
 vburru@marvell.com, sedara@marvell.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 15 Sep 2023 01:16:07 -0700 you wrote:
> Add support to fetch firmware info such as heartbeat miss count,
> heartbeat interval. This shall be used for heartbeat monitor.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
>  .../marvell/octeon_ep/octep_cn9k_pf.c         | 10 +++-----
>  .../ethernet/marvell/octeon_ep/octep_config.h | 22 +++++++++++++----
>  .../marvell/octeon_ep/octep_ctrl_net.c        | 24 ++++++++++++++++++-
>  .../marvell/octeon_ep/octep_ctrl_net.h        | 18 ++++++++++++++
>  .../ethernet/marvell/octeon_ep/octep_main.c   | 16 +++++++++----
>  .../marvell/octeon_ep/octep_regs_cn9k_pf.h    |  4 ++++
>  6 files changed, 77 insertions(+), 17 deletions(-)

Here is the summary with links:
  - [net-next] octeon_ep: support to fetch firmware info
    https://git.kernel.org/netdev/net-next/c/8d6198a14e2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



