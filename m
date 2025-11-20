Return-Path: <netdev+bounces-240296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC17EC7232E
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 05:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F09234DF96
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 04:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B7C2BE7D1;
	Thu, 20 Nov 2025 04:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jotC5qrH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E500288520
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 04:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763613664; cv=none; b=UBhmh9ebje2B9HhtX7vYsz+VApovDUmhUy9vlx7pTDUw5Ek1hFJJMHPP7TzyWDIVPpNA/6pVgEq/P+VKTCIn4ZuiloLPMTz3PK8SBJRwXyT6ZM0AugkvhFEdu1Ew4R2P7iCnJyPF7iI6xOZAfvvXK8vpOXW3MxRdrp5j2KpHvKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763613664; c=relaxed/simple;
	bh=HG6DoPY+1p4uvkldykkcbyjQrsKU7zwAkKrGTbsvekk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hml7GsSH4j6zzPNUF3gy7d5Vjn+y2B44audPeVqf0HifM9LYWoF9QFcDK+bA4+tOpX9tSXrMS98ZNPr5uet4on/n8TjUNLAAAuEOogokk1dCHAdVaUwexMVnyczkNqZFfHIxK7VZ/XY0TT3i+15YLrdHuygx+N8oHqWoaCu2FI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jotC5qrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A3BC4CEF1;
	Thu, 20 Nov 2025 04:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763613663;
	bh=HG6DoPY+1p4uvkldykkcbyjQrsKU7zwAkKrGTbsvekk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jotC5qrHrAlcqKRX2sZLox5dG7a8nKTQYdavbqHpRgHdaSbBe9J/k1Rb5cGDwLI6Q
	 Dff7jik2QU0/Jm8kGvt95to6DNCxiEjnv4azr/qS4n56j6tWs8ja5RKyWsg1Yo3Wi2
	 +4DV+lXwaEF8ladoAQ+Lk3SnjkPgirIU4YVdh/A6xNNWgWucSCketFCHHx3quYI0Wo
	 CB4SOHltFRZEAoI4soX3pzgRA9835dWgzVNEWpSlLlJR7SGn15xBDFRoHjLO19nAeO
	 JdAmyUr/0tEg1XvYr7KV2X1x/M6dfuLRTSevfqc2U28QCpGOxF2cEbc/YO4mKNRNrC
	 v+/o/NXgchCmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBC3C39EF978;
	Thu, 20 Nov 2025 04:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net: adjust conservative values around napi
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176361362874.1080161.4423432545769385771.git-patchwork-notify@kernel.org>
Date: Thu, 20 Nov 2025 04:40:28 +0000
References: <20251118070646.61344-1-kerneljasonxing@gmail.com>
In-Reply-To: <20251118070646.61344-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 kernelxing@tencent.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Nov 2025 15:06:42 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> This series keeps at least 96 skbs per cpu and frees 32 skbs at one
> time in conclusion. More initial discussions with Eric can be seen at
> the link [1].
> 
> [1]: https://lore.kernel.org/all/CAL+tcoBEEjO=-yvE7ZJ4sB2smVBzUht1gJN85CenJhOKV2nD7Q@mail.gmail.com/
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: increase default NAPI_SKB_CACHE_SIZE to 128
    https://git.kernel.org/netdev/net-next/c/3505730d9042
  - [net-next,2/4] net: increase default NAPI_SKB_CACHE_BULK to 32
    https://git.kernel.org/netdev/net-next/c/01d738561899
  - [net-next,3/4] net: use NAPI_SKB_CACHE_FREE to keep 32 as default to do bulk free
    https://git.kernel.org/netdev/net-next/c/2d67b5c5c67f
  - [net-next,4/4] net: prefetch the next skb in napi_skb_cache_get()
    https://git.kernel.org/netdev/net-next/c/5d7fc63ab841

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



