Return-Path: <netdev+bounces-17842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AB675334E
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B7C1C214D4
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 07:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DE77482;
	Fri, 14 Jul 2023 07:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7476FD4
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 07:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BCEBC433CA;
	Fri, 14 Jul 2023 07:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689320421;
	bh=f2yLQE1A0dXJnk7tOIQ7vV4LGA9H6uo+c2tN/Z6XpX8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pikbRO9E07MhSIi+CZyFrECYQ0BZbmiyZTwxq6+ajXwe6RQSc/aaalIIA3F5X90pM
	 DGhxWlS5h8qkABYnTWhlrsFop/w5ZPtSz+NWTtabU3gcmXZTLgQzFnyh79AIQe3aq/
	 Vo1lNC5GosfhP/wiBUvhGR9I8YmhDjLzbSo5eOXyLfQbcVBz45NLNegdysswEuk5cd
	 saDF9/A75/cgHSWHnxkguFrC/gQN9E+lTwsAVHPXxjQ5iHl4uGh4WN6HBgsNDuBYlP
	 tVtrVy5s6KMEnE6MRWs6pVYa8Wa/fKN5j/CfGRTD5xExBv9wPQYFCMK7zOrM/WwQcv
	 d994PuFeNmZbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD13FF83709;
	Fri, 14 Jul 2023 07:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: ti: cpsw_ale: Fix
 cpsw_ale_get_field()/cpsw_ale_set_field()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168932042089.7517.7146356446111190841.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jul 2023 07:40:20 +0000
References: <20230712110657.1282499-1-s-vadapalli@ti.com>
In-Reply-To: <20230712110657.1282499-1-s-vadapalli@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, rogerq@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 srk@ti.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 12 Jul 2023 16:36:57 +0530 you wrote:
> From: Tanmay Patil <t-patil@ti.com>
> 
> CPSW ALE has 75 bit ALE entries which are stored within three 32 bit words.
> The cpsw_ale_get_field() and cpsw_ale_set_field() functions assume that the
> field will be strictly contained within one word. However, this is not
> guaranteed to be the case and it is possible for ALE field entries to span
> across up to two words at the most.
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()/cpsw_ale_set_field()
    https://git.kernel.org/netdev/net/c/b685f1a58956

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



