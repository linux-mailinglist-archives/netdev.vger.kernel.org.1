Return-Path: <netdev+bounces-155782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B171AA03BE2
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 11:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23C11646CF
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 10:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE4F1E3DC6;
	Tue,  7 Jan 2025 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJwqeYPV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA951E47BE;
	Tue,  7 Jan 2025 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736244611; cv=none; b=qy6P/7Zc8EqFxX1TO1QKkF+CuGcaXLUsh4w6BX4rHmVqoxTiW16XTNjI3vm1+7aX6A2e3a8sO4yOSfU+FnV01GWHCNno7k9nBYtXccF5zc4/8liiAkEc/4TUtedh06cf3NeF3jnRsp27vEQ/F8v9WwKKHpbMWZZ8jziPkIOt6Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736244611; c=relaxed/simple;
	bh=5bEVFGZ/3kqEH3ft/INVb3O3lfmDpksxz7qJlBKHdfY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qEtjcvjeM9piDVFNGxLvl5sx+uxuuY9cySWGxpBPta/0eD2xRs/AnR9zY80LjMrt4++Ka7rKThXvOvS0CzU2nxsCtZ9wF1jUfb8RvU/XsFzQqG0iowSHwlBUWfaJQN7Qve6WxgZn50nPLatsTetaiKJrMeIrkjuNmMg2Ez/1rNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJwqeYPV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71367C4CED6;
	Tue,  7 Jan 2025 10:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736244610;
	bh=5bEVFGZ/3kqEH3ft/INVb3O3lfmDpksxz7qJlBKHdfY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tJwqeYPV74pJLrqLp7MKw6n4nCoenPU+Y0Yw5LKIcIf4obY8frYSRwvuD+OKn0BSD
	 hW7hSTajdYCzdObz6uzsP/5ybRlJ8ZmKCS6eUgybs+6uoVx+bhkhhWykC2VbLV0c8f
	 tz4WB6pllPOxh1A9QpyW9jqT+UQqHVqFoCVhPsXWOSjkqICm3M7T7DqWiOB2PgQWdy
	 MWADjcJfgyqCQEuTWh8TCWkC750pjZ9oTMS6h2aLFqJYyzzG4o3B6cz2h0pYNjjnqu
	 /EzfASlao/O9pNb1om+cXXkqXcWshRd5AHUGvO92qnWT6DRCqags5XHgk1aQyrtSuO
	 3bRQfGSQWQghg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB497380A97E;
	Tue,  7 Jan 2025 10:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] net: stmmac: Set dma_sync_size to zero for
 discarded frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173624463153.4094378.15118164239287100695.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jan 2025 10:10:31 +0000
References: <20250103093733.3872939-1-0x1207@gmail.com>
In-Reply-To: <20250103093733.3872939-1-0x1207@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, xfr@outlook.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  3 Jan 2025 17:37:33 +0800 you wrote:
> If a frame is going to be discarded by driver, this frame is never touched
> by driver and the cache lines never become dirty obviously,
> page_pool_recycle_direct() wastes CPU cycles on unnecessary calling of
> page_pool_dma_sync_for_device() to sync entire frame.
> page_pool_put_page() with sync_size setting to 0 is the proper method.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v1] net: stmmac: Set dma_sync_size to zero for discarded frames
    https://git.kernel.org/netdev/net-next/c/51cfbed198ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



