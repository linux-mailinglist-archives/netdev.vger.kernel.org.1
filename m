Return-Path: <netdev+bounces-140916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8934F9B8970
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 03:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8D51C20E77
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91DF148827;
	Fri,  1 Nov 2024 02:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXeLS9HE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F0913C9C0;
	Fri,  1 Nov 2024 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730428835; cv=none; b=RxnKOIBg0zx0+GmnKgfMyW847E99L7X1CZK6u20BM+2P4Kdaky4pVMocn+daXBzQV7u04aS7a6U+dSn7pemzcXLEAuBPbTex3zTncjndAupkjCQ0NIcPcFj2C+pBNLsQx5r/41iYwAeNLGn0vrYoZwx/sH6dOTBUXLQqYJUDm/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730428835; c=relaxed/simple;
	bh=x+K8U/7ojpsolt4ih86/2mbduUf8H+CikPIEqbmtqDQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tl4EdJdL30zp39snxo5dyc7bICrv1y0733+Cs2tcnGFt1z0ueEFfgZzcVjQWtwh/Kq3qOIPNSDKsiCTvYwohOfeUqDNozlH9eASaE0Ud330aJENuw2xp8+ipFyy1wK4kB1u9FqEw+tp0/8UGHTR5gUeK/42U/HvxJswXcb5jxLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXeLS9HE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465A7C4CEC3;
	Fri,  1 Nov 2024 02:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730428834;
	bh=x+K8U/7ojpsolt4ih86/2mbduUf8H+CikPIEqbmtqDQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BXeLS9HE8Zqe3ykBSd4ep+D1HPdcjNj60P/CuIC0uKT1+xlcpyYsMSomiRd71yY4y
	 2PFvWjRl+nghM7QjPt9wDZiMkw7lEmuwoRR+bvMXwmCQ97Rt91VSXqeTdJOVgkbnvI
	 RTP9fa/0+LmloNEtV/ktXvpp3nd9yDLFLsJfKI6hFjqz0gqUyumwBN2Jil0FDXPhTk
	 rGMK+7yZBZvSHvTIGMKePfRhhv7QOVDof5dgCflqU8PWX0X6tEGWWdYtxaRmhuJJ5F
	 0UYYSdOoX+dQygvpFs/VqTlUaznLSrhCZb5gxeFf3SgCnZhM90P2hqFFOmYCKMuxW5
	 gVKodxB1JRMcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E26380AC02;
	Fri,  1 Nov 2024 02:40:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: fjes: use ethtool string helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173042884205.2159382.4530585895783581040.git-patchwork-notify@kernel.org>
Date: Fri, 01 Nov 2024 02:40:42 +0000
References: <20241029232721.8442-1-rosenp@gmail.com>
In-Reply-To: <20241029232721.8442-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Oct 2024 16:27:21 -0700 you wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - net: fjes: use ethtool string helpers
    https://git.kernel.org/netdev/net-next/c/dbb9a7ef3478

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



