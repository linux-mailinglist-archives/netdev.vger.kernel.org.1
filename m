Return-Path: <netdev+bounces-82000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B78588C0A8
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 12:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A5C0B231D9
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D8255787;
	Tue, 26 Mar 2024 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdoWeBba"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB9254911
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452629; cv=none; b=OUR1SBNrivG1XJMeyaCHmFbp6wBvp17YRzzmXOQD8C9wkabGAMQb1hIixYRnG1KYrWn3KQObCSGEYVzdbvKrO2eyXKX3GxrQojsNBRh+6ZNzbgKDlCKcc280ffg4BRdgtReaHlkH/odxch+m9DyNcvEXu1ws5u7FnwH0ekTkRYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452629; c=relaxed/simple;
	bh=pNzuutPYocGa/VGVc10Do0k8DJm+idqgUki5Q+34L6o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dMflm48JhvJLi7k8SkVuMrPiPvW1QrrD0+vu4ciCmeedu6438o699QrImOHFdP7w3gZIeE74RgmfdMxl7My9ncm/yzumlvuvP/mZth9xSAeK4vtTHHDiNTjk/3P7ys5GafhkNVfb47vZtqka3eYAcFo2UrpL649kkTGemHwGLdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdoWeBba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30073C43390;
	Tue, 26 Mar 2024 11:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711452629;
	bh=pNzuutPYocGa/VGVc10Do0k8DJm+idqgUki5Q+34L6o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GdoWeBbat4FFKOfZyIcGtcOGUuFKXYk+l1Til6KdyjTtPHl4Vk3dLulWkyJZfK1kf
	 ytKdW5oO40ESuGXHtD2Cqb7x7oMasluUplT/XxrIaQEndAqyJxkmRy+rwn9Jn8vlwR
	 a5cj5QLCSauBL0vt4X+yqQHKTYAxgxKuDJsED8WR8eFI4oBPGkGkQdN7kPXAL9qimb
	 g9Bjapj0UExmtMH4XLCt51VRPWF2spxHLcBXsnUk+Ckf1SfQq4bnHsiPWUPej+ZsNH
	 01G6ep/xYA1YhLLPhKAOzS90BEhQaM6bfzYLaKwz05Xa/LUJ47OKscosR/r9LvVBPS
	 O4qIVFF6cWvhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C9CAD95062;
	Tue, 26 Mar 2024 11:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 net-next 0/4] net: Provide SMP threads for backlog NAPI
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171145262911.30090.18130373990794866304.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 11:30:29 +0000
References: <20240325074943.289909-1-bigeasy@linutronix.de>
In-Reply-To: <20240325074943.289909-1-bigeasy@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, hawk@kernel.org, pabeni@redhat.com, tglx@linutronix.de,
 wander@redhat.com, yan@cloudflare.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 25 Mar 2024 08:40:27 +0100 you wrote:
> The RPS code and "deferred skb free" both send IPI/ function call
> to a remote CPU in which a softirq is raised. This leads to a warning on
> PREEMPT_RT because raising softiqrs from function call led to undesired
> behaviour in the past. I had duct tape in RT for the "deferred skb free"
> and Wander Lairson Costa reported the RPS case.
> 
> This series only provides support for SMP threads for backlog NAPI, I
> did not attach a patch to make it default and remove the IPI related
> code to avoid confusion. I can post it for reference it asked.
> 
> [...]

Here is the summary with links:
  - [v6,net-next,1/4] net: Remove conditional threaded-NAPI wakeup based on task state.
    https://git.kernel.org/netdev/net-next/c/56364c910691
  - [v6,net-next,2/4] net: Allow to use SMP threads for backlog NAPI.
    https://git.kernel.org/netdev/net-next/c/dad6b9770263
  - [v6,net-next,3/4] net: Use backlog-NAPI to clean up the defer_list.
    https://git.kernel.org/netdev/net-next/c/80d2eefcb4c8
  - [v6,net-next,4/4] net: Rename rps_lock to backlog_lock.
    https://git.kernel.org/netdev/net-next/c/765b11f8f4e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



