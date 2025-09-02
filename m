Return-Path: <netdev+bounces-219175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED826B403A3
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 655587B83DF
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 13:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C43C3218BF;
	Tue,  2 Sep 2025 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIkOfZ84"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682C832144F
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819818; cv=none; b=SZnKwYDw/uwNxC+SZZPvSlPTPd85exOPatag5P+ijIN2sNUQcOXE81+Bg1nQkGgzGqc9e2cpCSbWR6QvP0y8tRMhNjGsfqafO0TciNYA1wOvZLyPRZ2v4rk9+MeB3U/IYljALJgfX0h4iWh76quQLDEZ++14zQ3mC4y7A5rD1mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819818; c=relaxed/simple;
	bh=6Cadree29dBYx0msb0fvAe3k28CSS6O9N62KdRcG1JU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SuDNYFksygthd/ArsxaESDK+3UIro2IBv1SA6BX4XRl6l7QNbY8fr7itk7iFbTBqmDhT4df50ecNiomRkHmesb8X68nc6YknfhkLmx+sKO37c0oO1r20MB2E5oMxHHoErEmErBUKIq9V3Vu5j8sGeHuFYc8CdrwULCRs0bjVgZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIkOfZ84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0264BC4CEF4;
	Tue,  2 Sep 2025 13:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756819818;
	bh=6Cadree29dBYx0msb0fvAe3k28CSS6O9N62KdRcG1JU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AIkOfZ84Bc2JTo2MK0WMchEfg/aiicEijHWduSCuYlXLagzXNFjazINTaGChPXP0T
	 M+sDFZ+AVt7iNUSLwDfpFHbL55FdMh80SaNvi+3qMlqhf/xHNnVIPSsiHSr7omWo/6
	 ZLMcYYypDxc5oksSaj9Mqp1B5y6KpWZXmdN2qXqZDL/krLD6tRNeX29UdrjNeINi9P
	 KPL9i9Wh/gHs/34U0Sb0uLrxMTcYNy+6ZJdiAQGFox8CM19mtTwUjI1nB9wEIylkt0
	 pdUIKtFEAfw0w4lV3Zdy0N+IM69wXayrkUITKx1ju+keeCcr0vzBM6IDGGZXWDD9Rw
	 LW2yGaT+ATGDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE6D7383C250;
	Tue,  2 Sep 2025 13:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V3 0/7] E-Switch vport sharing & delegation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175681982321.297907.4047842558919189677.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 13:30:23 +0000
References: <20250829223722.900629-1-saeed@kernel.org>
In-Reply-To: <20250829223722.900629-1-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, gal@nvidia.com, leonro@nvidia.com, mbloch@nvidia.com,
 horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 29 Aug 2025 15:37:15 -0700 you wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> v2->v3:
>  - fix error handling, Simon.
>  - Remove redundant struct field comment, Simon.
>  - Add Reviewed-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,V3,1/7] net/mlx5: FS, Convert vport acls root namespaces to xarray
    https://git.kernel.org/netdev/net-next/c/2e894b99c017
  - [net-next,V3,2/7] net/mlx5: E-Switch, Move vport acls root namespaces creation to eswitch
    https://git.kernel.org/netdev/net-next/c/faa6ac53cdaa
  - [net-next,V3,3/7] net/mlx5: E-Switch, Add support for adjacent functions vports discovery
    https://git.kernel.org/netdev/net-next/c/17426c5d4b1d
  - [net-next,V3,4/7] net/mlx5: E-Switch, Create acls root namespace for adjacent vports
    https://git.kernel.org/netdev/net-next/c/9984ec9f1f50
  - [net-next,V3,5/7] net/mlx5: E-Switch, Register representors for adjacent vports
    https://git.kernel.org/netdev/net-next/c/a0a7002b9439
  - [net-next,V3,6/7] net/mlx5: E-switch, Set representor attributes for adjacent VFs
    https://git.kernel.org/netdev/net-next/c/5d8ae2c2cfe8
  - [net-next,V3,7/7] net/mlx5: {DR,HWS}, Use the cached vhca_id for this device
    https://git.kernel.org/netdev/net-next/c/0c2a02f3c066

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



