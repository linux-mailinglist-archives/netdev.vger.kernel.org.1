Return-Path: <netdev+bounces-159865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE26A17378
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 21:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E1816A3E1
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 20:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03A61F03F4;
	Mon, 20 Jan 2025 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXSFI/kw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E5F1F03F0;
	Mon, 20 Jan 2025 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737403811; cv=none; b=bEObfco9VezH71V7OaGee0kEGF+SrJ2+sXUojZUOZH4dCBzU/FQAngNwpT7cKXEbKFGFhIqFmnI9kWJ8NyoWilZ4SLUFGkbyiGe3Z3LA8t6SmkfxBFF6S5mb9YnphvJHwYBkj37Dga+bY8M5S8TTlLh1WayCnpmZ8ThCtzy7B0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737403811; c=relaxed/simple;
	bh=xcgzJ8GUf9rqfS8dk9jTNGkkqhrZ7aqAeGSP8qPm5UE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b373Ne0D5DMUaICl1uP4vvJvlqLVq2rhJgyEpUDzCGrjuUsx8fE2TvkKl/+z8yt6bYVKwVCLiMhPNSlSzxp5jtERs4emoPQv+gem+453JPMktoaxQ9ozt86pbgBiNfRI3//MH4jAu4ItkeQm4bx42k8/1mXHu6C7+xjU+E8h2v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXSFI/kw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AA3C4CEE0;
	Mon, 20 Jan 2025 20:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737403811;
	bh=xcgzJ8GUf9rqfS8dk9jTNGkkqhrZ7aqAeGSP8qPm5UE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nXSFI/kwDkGArDabWY40dcJWvdgFVxBAO7myQEdpbsj39T5deX/y5CZwEgi5/nB6R
	 oVf4vGAxmPe7I8XAGTx/6SAfNrw01qDlaY/06pmboQ0RTRVoIzIKddhpboSzy31gWf
	 okExTF6OsgKniCUUZGpkkzDivBYLNRym5r6v9qXpJxPnXoKWlxB8VgjOKfOFo1tlLw
	 2DedVe7ryuRx+MQ6HsV8fdNb79nE3+bLb8tQS7eA5oeNCRxlfgE9K8OqUvTHGYCn69
	 bRxrfoQNE2cHRwpOniH3WgS/kVUZcoxCm0OGEXn+22IsCUqyBTGq/mw+53h97CAnPt
	 bBr3Du7iEOpuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BA9380AA62;
	Mon, 20 Jan 2025 20:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] net: stmmac: Drop redundant
 skb_mark_for_recycle() for SKB frags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173740383476.3638218.15431747804261791679.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jan 2025 20:10:34 +0000
References: <20250117062805.192393-1-0x1207@gmail.com>
In-Reply-To: <20250117062805.192393-1-0x1207@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, xfr@outlook.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Jan 2025 14:28:05 +0800 you wrote:
> After commit df542f669307 ("net: stmmac: Switch to zero-copy in
> non-XDP RX path"), SKBs are always marked for recycle, it is redundant
> to mark SKBs more than once when new frags are appended.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ------
>  1 file changed, 6 deletions(-)

Here is the summary with links:
  - [net-next,v1] net: stmmac: Drop redundant skb_mark_for_recycle() for SKB frags
    https://git.kernel.org/netdev/net-next/c/ba5f78505fb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



