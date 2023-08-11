Return-Path: <netdev+bounces-26631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2870778736
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 08:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB661C20D0D
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 06:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456391111;
	Fri, 11 Aug 2023 06:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2170DEC6
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 06:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AAB2C433C7;
	Fri, 11 Aug 2023 06:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691733622;
	bh=6LNa9JJcfZdfgAVGyBkQEVTJr0mmWNH8jOI/qg7ecgk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D6G+FNuU5ItVWYVcfFG/95JsfgdBD2uHAAeaPfNeW0vfC+ZtjM7S0Xazln+26D8a0
	 FvUoZCkZGysi0c99STViKFKFwCgh8+BYu2F/sAh83sU7hfSsxFLVqsBB0rMgLiylvh
	 9BhcQHhJFSiKi4DsCiOIAZrB05rAzVgh2xax53zFPZAEV3gPpDT6OhMUD4vnftnRCo
	 k90GqW+xSDdRFMdgm7sAeX1tHp1yaKOCVeqfYKJ0Zil9qxMjV9m/R0/bdOz+aUBg+E
	 cZuREvp+WPb9qzIndFaTE03qdt82BJFhGUhYK/p+1mO7oJKZMGhDW69nqxb4a4pEA2
	 5dgS86nZv+mjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80809E1CF31;
	Fri, 11 Aug 2023 06:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: ftmac100: add multicast filtering
 possibility
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169173362251.17468.7632455108026648840.git-patchwork-notify@kernel.org>
Date: Fri, 11 Aug 2023 06:00:22 +0000
References: <20230808124307.2252938-1-saproj@gmail.com>
In-Reply-To: <20230808124307.2252938-1-saproj@gmail.com>
To: Sergei Antonov <saproj@gmail.com>
Cc: netdev@vger.kernel.org, vladimir.oltean@nxp.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  8 Aug 2023 15:43:07 +0300 you wrote:
> If netdev_mc_count() is not zero and not IFF_ALLMULTI, filter
> incoming multicast packets. The chip has a Multicast Address Hash Table
> for allowed multicast addresses, so we fill it.
> 
> Implement .ndo_set_rx_mode and recalculate multicast hash table. Also
> observe change of IFF_PROMISC and IFF_ALLMULTI netdev flags.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: ftmac100: add multicast filtering possibility
    https://git.kernel.org/netdev/net-next/c/7a1c38215820

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



