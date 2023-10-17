Return-Path: <netdev+bounces-41623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E2B7CB77E
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 02:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D102813D5
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 00:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF847646;
	Tue, 17 Oct 2023 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9x4wcCA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E8D622
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3690BC433C9;
	Tue, 17 Oct 2023 00:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697503223;
	bh=PPM8uza8iKK0cld/Dp/cBWNbZAbXvGTRJkI8TgUPmy4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I9x4wcCA/JPchBam2ixiVgu043QHaspzX9PEmphqRe9WoMsAL1F+8jPWxqNGbuUTU
	 1/B7u3PxCC9GRlO5kEljGIq/A1QbN8U+TNJExRYGfkGOsKI6P8bWIhJ1l6YhSXvaMc
	 9LfIbjAbp3QvOOyZHZRikDeTHYd1jPWV08qAhfUFnaBEMmPRQlcj550AuoFKmNONye
	 TDL+zoZrRbm4Q0Wda7OQBiiOZD4ePWAKDYVwZtTex6aaUu2Pt8/6Veqx+BCSjJiAdq
	 rhWoC8MIMxtAQEw8Fowcguzlh+Xutf2fI91HKFFwzVpoYe/gD+bnzGz8nzYQKV1tW5
	 VapBnIyKjx4zA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D777E4E9B6;
	Tue, 17 Oct 2023 00:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netlink: Correct offload_xstats size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169750322311.25327.3849969114129158174.git-patchwork-notify@kernel.org>
Date: Tue, 17 Oct 2023 00:40:23 +0000
References: <20231013041448.8229-1-cpaasch@apple.com>
In-Reply-To: <20231013041448.8229-1-cpaasch@apple.com>
To: Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 kuba@kernel.org, petrm@nvidia.com, edumazet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Oct 2023 21:14:48 -0700 you wrote:
> rtnl_offload_xstats_get_size_hw_s_info_one() conditionalizes the
> size-computation for IFLA_OFFLOAD_XSTATS_HW_S_INFO_USED based on whether
> or not the device has offload_xstats enabled.
> 
> However, rtnl_offload_xstats_fill_hw_s_info_one() is adding the u8 for
> that field uncondtionally.
> 
> [...]

Here is the summary with links:
  - [net] netlink: Correct offload_xstats size
    https://git.kernel.org/netdev/net/c/503930f8e113

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



