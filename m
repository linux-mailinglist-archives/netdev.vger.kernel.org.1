Return-Path: <netdev+bounces-43996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 059DA7D5C51
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 22:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E501C20C5A
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 20:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28293E47F;
	Tue, 24 Oct 2023 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e73w4vOa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E983E478
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 20:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EBDEC433C9;
	Tue, 24 Oct 2023 20:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698178824;
	bh=VkJ+mJU6Y+Tg2FljsDTVDaVBWuCONGhE9eSL5JORb/E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e73w4vOafUwVhrLApRp+pfRMunaNNQK8igGWPJT154Cv0ER8yZHp3x8HqhkJTmUy1
	 0LyEApjvdRLPt7Jgh2Op5wxfvHZ5HnplwOZBhO0Hhm4tmtERPKMKajskqxd/buWsrG
	 AN0FXZZTATtWpnWL63G/4puL44ftDS+/iRRsFRK8bSlPgxVHMqy0drPoo8KBQnTxS6
	 4rruAlfq5mtxY7VIYzVt0xAy0Rf7dJI+eGxuXxHnX+2tlmgqR8s96cn/sEyrpXf/Fn
	 oo6a3EHOewN96dqlSh9meZfba+RkQN9geLBKLI/i4kn9JclyCgkfw9UrtVgiEn/9dx
	 f4DoOSQGC19aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 541FFE4CC1C;
	Tue, 24 Oct 2023 20:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2023-10-24
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169817882433.2839.2840092877928784369.git-patchwork-notify@kernel.org>
Date: Tue, 24 Oct 2023 20:20:24 +0000
References: <20231024103540.19198-2-johannes@sipsolutions.net>
In-Reply-To: <20231024103540.19198-2-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Oct 2023 12:35:41 +0200 you wrote:
> Hi,
> 
> We have a couple of last-minute fixes for some issues.
> 
> Note that this introduces a merge conflict with -next,
> which Stephen reported and (correctly) resolved here:
> https://lore.kernel.org/linux-wireless/20231024112424.7de86457@canb.auug.org.au/
> Basically just context - use the ieee80211_is_protected_dual_of_public_action()
> check from this pull request, and the return code
> RX_DROP_U_UNPROT_UNICAST_PUB_ACTION from -next.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2023-10-24
    https://git.kernel.org/netdev/net/c/00d67093e4f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



