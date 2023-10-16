Return-Path: <netdev+bounces-41189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C907CA30D
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41960281575
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEB51A5A0;
	Mon, 16 Oct 2023 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvcsjdpJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39E1A59B
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27437C433CA;
	Mon, 16 Oct 2023 09:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697446825;
	bh=2sNNMP6abmnvCW923gvUf2uYIqNVOSfWTb6+o57SVXw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZvcsjdpJnNxwu3gy37clKejKfQnmHIgK6ZynshNx3+CxubNq6BL11wX9lvIP83oYX
	 pY4jJOyHn18l0ngN/RcstiqCA35QZBPAhI3gkUrf+j5adBRjrzFPj9lAqPHuIXdDvE
	 XERHKd/UZEV4B6dbaOIYLGAUVxQvys5jbiqCOFKQed6hIjkeVcFBMul+R3UI6ErXrz
	 CiInVJfyfO54MoY0yK6dcNTvleEyjyrq2U8H9cfxZ/he37C7EEnhCp0D8LbXNplTxN
	 0aTkdrUZc+09TqlVJ3CD655TmdW0HgLcPtWWOvlJ/spJ7yfumhfA3AH5408PaiEvLW
	 ieploVV7OXpPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F972E4E9B5;
	Mon, 16 Oct 2023 09:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tsnep: Inline small fragments within TX descriptor
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169744682505.7474.1136319975584731643.git-patchwork-notify@kernel.org>
Date: Mon, 16 Oct 2023 09:00:25 +0000
References: <20231011182154.20699-1-gerhard@engleder-embedded.com>
In-Reply-To: <20231011182154.20699-1-gerhard@engleder-embedded.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 11 Oct 2023 20:21:54 +0200 you wrote:
> The tsnep network controller is able to extend the descriptor directly
> with data to be transmitted. In this case no TX data DMA address is
> necessary. Instead of the TX data DMA address the TX data buffer is
> placed at the end of the descriptor.
> 
> The descriptor is read with a 64 bytes DMA read by the tsnep network
> controller. If the sum of descriptor data and TX data is less than or
> equal to 64 bytes, then no additional DMA read is necessary to read the
> TX data. Therefore, it makes sense to inline small fragments up to this
> limit within the descriptor ring.
> 
> [...]

Here is the summary with links:
  - [net-next] tsnep: Inline small fragments within TX descriptor
    https://git.kernel.org/netdev/net-next/c/dccce1d7c040

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



