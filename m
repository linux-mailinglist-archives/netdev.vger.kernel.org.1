Return-Path: <netdev+bounces-132915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D74E9993B84
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 02:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1486A1C235F0
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2103129CE6;
	Tue,  8 Oct 2024 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StnJGvBM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEBC101C8
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728345628; cv=none; b=hyomZE29LGpM8vBa0SwPHr5JaORB+fPn7ID05eJ6OYtVVEwPZRjkcLzUkBhFYL1fSzChrG2qLYrXNBrHY7ARNJ+aPQJEK4FaD9Cw0fRBwY68qQM+mBFXqUAe+uZguxiLdI1TX2DGaehN36KVUNYc4yoiKoihdLJA0y1luohiLwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728345628; c=relaxed/simple;
	bh=FB/5h7dy8LTEYjMQSx5FZ7+jOkZRkwzOKlwmxv1UVyo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lR4ijqEwn9rQEIvPZqrkBbJMqglcDe19G5E+XNmFFi+lgmYVZXC+VNL1beejukcnTih1Zi6QehsAMM3WGSwNYROjp4bXn87V4ic5AcZRx/ga0vEuHaNFCnEXrkII5Z/+W+BThrQeUXyhb7qTHPiWV8ZA6LQt5hcseTV5PThrnJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StnJGvBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63968C4CEC6;
	Tue,  8 Oct 2024 00:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728345627;
	bh=FB/5h7dy8LTEYjMQSx5FZ7+jOkZRkwzOKlwmxv1UVyo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=StnJGvBM3olodn6IkUrv53qFAWX+Nndyk12cNB4DEgQYsx9RkLwkk3x2LjakWoNKS
	 ASZnZKuHCHbJ9M/Dtq6Duapl5La1rR+UsQb2I9LP/jz0cHnnePxM+U9XYBmPyKq6y3
	 0chfEhNVqIXyjolk42L7iOUfFIQkkMyLl74pQoEWA1Zl5FL0nhtA6HQcXfkb7j1hbr
	 pjwGa5ov8QY/3X/9j1UGFluB5OE+8q+wXHe1nDNr9mScw/Ju+al74Vd/MuiKVU2erZ
	 r6kwFVRwPXfGmZh11cI/pqM++08DcEk3dPVRhhfZYuLsfB+xFLImWcFXa09zrmcAyn
	 1WTjDayp3td2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEFD3803262;
	Tue,  8 Oct 2024 00:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP
 is enabled"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172834563151.23025.54590458700428554.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 00:00:31 +0000
References: <20241004142115.910876-1-kuba@kernel.org>
In-Reply-To: <20241004142115.910876-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jonathanh@nvidia.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, mcoquelin.stm32@gmail.com, hawk@kernel.org,
 0x1207@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Oct 2024 07:21:15 -0700 you wrote:
> This reverts commit b514c47ebf41a6536551ed28a05758036e6eca7c.
> 
> The commit describes that we don't have to sync the page when
> recycling, and it tries to optimize that case. But we do need
> to sync after allocation. Recycling side should be changed to
> pass the right sync size instead.
> 
> [...]

Here is the summary with links:
  - [net] Revert "net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP is enabled"
    https://git.kernel.org/netdev/net/c/5546da79e6cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



