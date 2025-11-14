Return-Path: <netdev+bounces-238557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD0FC5AF36
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 02:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A3D3B8F0D
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 01:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BE72673B0;
	Fri, 14 Nov 2025 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txw355Qd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FD4265CAD
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763085043; cv=none; b=Z43vyNJsKqGoA2Jv8XhZvXWTDbrLtOVJhAFcGE+dDko1mU0GJkWD7sT8WZ+AP5ysjo4NaDaYGlFLIEwwavxQHYdkHETpTQjMcVqZ2HYHn1eMmnAPFU5PcryBcaa8NfKAgNiL4UH+whKYEcELbvZas8Z7RArzJDWpwlNBklsHiZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763085043; c=relaxed/simple;
	bh=EXXguBk4Xu+DhCDct1nvqO8kUKbdabSvDc+tY90MIWU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=clb0ab2QjeVmweAx+TawL4ol8R7SqbfIJfMXPeI02zWf3zBDPvgk0BXBij8y6gEm4ja2zyAmrUBa2kPhngcodaRyY0LVvQUw1r9aZUmX+rran6U63fP5bWeVdEVsSsyrjTnHRZEnjVJdwJrN+fglDLPoI3QmIbfb40F+t7VQZuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txw355Qd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516A9C4AF09;
	Fri, 14 Nov 2025 01:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763085043;
	bh=EXXguBk4Xu+DhCDct1nvqO8kUKbdabSvDc+tY90MIWU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=txw355QdGSJRw+v6tqkDMSDmUzQZ6bv1EOxT/xDk3Nz9mxvrgy6uDUhVEm6T2fm2Z
	 hd7humhGHN4EQHSzhV+ZaanOvQ4mQHNCHdsAyXnFMi4qX4eSGDYN6sJh6Ook3O5F1j
	 tmCKpLoNTV6/yVK7ZzJq2garl8krILpU08ZpG7a69OTYz7DDrOg0gidOjVV2nEO1BV
	 XACKBTpJQxkjrA+aDUCEsDFQyrs4PIrqdfB6O9544BFhJvAIc3NcRASkb6RYFT0Bu2
	 3Mt+DGsSAZvmx4s/mI2Xr34q0lMcnOPBg0BG3NSJOBDyT3CeNG6JaRLR7ovhhKlbP4
	 Vwlxa8YJjk4yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E283A55F84;
	Fri, 14 Nov 2025 01:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: remove definition of struct
 dsa_switch_driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176308501199.1080966.4864293641139116760.git-patchwork-notify@kernel.org>
Date: Fri, 14 Nov 2025 01:50:11 +0000
References: <4053a98f-052f-4dc1-a3d4-ed9b3d3cc7cb@gmail.com>
In-Reply-To: <4053a98f-052f-4dc1-a3d4-ed9b3d3cc7cb@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: olteanv@gmail.com, andrew@lunn.ch, horms@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Nov 2025 21:46:24 +0100 you wrote:
> Since 93e86b3bc842 ("net: dsa: Remove legacy probing support")
> this struct has no user any longer.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  include/net/dsa.h | 5 -----
>  1 file changed, 5 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: remove definition of struct dsa_switch_driver
    https://git.kernel.org/netdev/net-next/c/4aa73c6051cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



