Return-Path: <netdev+bounces-56208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A229F80E2A5
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 04:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D7F1F21C79
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 03:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286158828;
	Tue, 12 Dec 2023 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLDf8MTK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7F179E0
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 03:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9649C433C8;
	Tue, 12 Dec 2023 03:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702351225;
	bh=904puYQsBkTzdQniJcHEpofJ4NJsJwMekQa4mCR3E14=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hLDf8MTKoBe9N13ZOLtRMd4a27X7dDciTAWhBRDbjzQgl7vI+B0QZrrQhjqLHldxz
	 prC8+x9j+2zpP+73a4xcQO1Rfw9KWtuUCyZ3g9907NDAJVgOzPj3n0BviMoK8tbi1H
	 maam3lxNvJYvPnKjCNBVhPPaqqv/yub2/KxJeYiR0lwy1UMJsDuJYZx1WghDfG+4bj
	 tVhW3DGp0ANzRpieDyKmrTiDE321U4Z4R0h/SecrZP3a3DC4sf6nhXTM1jzpkhH37F
	 Hkgl+MzAv4KIWwev3m0aiBmCG2e2FEhukatxWzdjQyT0OwhhkgjkCrHTL9RSLxcN8t
	 cx5fTl4gRIlOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B16ABDD4F0E;
	Tue, 12 Dec 2023 03:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6] netlink: specs: devlink: add some(not all)
 missing attributes in devlink.yaml
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170235122572.10568.5224501495681522792.git-patchwork-notify@kernel.org>
Date: Tue, 12 Dec 2023 03:20:25 +0000
References: <20231208182515.1206616-1-swarupkotikalapudi@gmail.com>
In-Reply-To: <20231208182515.1206616-1-swarupkotikalapudi@gmail.com>
To: swarup <swarupkotikalapudi@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Dec 2023 23:55:15 +0530 you wrote:
> Add some missing(not all) attributes in devlink.yaml.
> 
> Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
> Suggested-by: Jiri Pirko <jiri@resnulli.us>
> ---
> V6:
>   - Fix review comments
> V5:
>   - https://lore.kernel.org/all/20231202123048.1059412-1-swarupkotikalapudi@gmail.com/
>     Keep stats enum as unnamed in /uapi/linux/devlink.h
>     to avoid kernel build failure
> V4: https://lore.kernel.org/all/20231126105246.195288-1-swarupkotikalapudi@gmail.com/
>   - Change the commit message
> V3: https://lore.kernel.org/all/20231123100119.148324-1-swarupkotikalapudi@gmail.com/
>   - enum name added for stats and trap-metadata enum used by trap command
>     in include/uapi/linux/devlink.h
>   - Fix generated userspace file's compilation issue
>     due to V1 and V2 patchset
>   - Move some attributes e.g. nested-devlink and param again as a TODO,
>     which needs some discussion and will be fixed in a new patchset
> V2: https://lore.kernel.org/all/20231122143033.89856-1-swarupkotikalapudi@gmail.com/
>   - Rebase to net-next tree
>   - param-value-data data type is dynamic, hence to accomndate
>     all data type make it as string type
>   - Change nested attribute to use correct fields
>     based on driver code e.g. region-snapshots,
>     region-snapshot, region-chunks, region-chunk,
>     linecard-supported-types, health-reporter,
>     linecard-supported-types, nested-devlink
>     and param's attributes
> V1: https://lore.kernel.org/all/ZVNPi7pmJIDJ6Ms7@swarup-virtual-machine/
> 
> [...]

Here is the summary with links:
  - [net-next,v6] netlink: specs: devlink: add some(not all) missing attributes in devlink.yaml
    https://git.kernel.org/netdev/net-next/c/68c84289bcc0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



