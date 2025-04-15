Return-Path: <netdev+bounces-182857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10860A8A2B2
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF9217F201
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD8C29A3D7;
	Tue, 15 Apr 2025 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glUCUgEl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1911629A3D6
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 15:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744731000; cv=none; b=thOmBMRWwppg0jiExxmxDkvE0i5XwJoq1xTBlgJJpghfb5ac5zQ7FCDs2HlMpOGSbz1JlqYkVa3HaxkYskdAJbeNTOxbdhkc+tqbp1xFYZ6wZ4Y4Tk7qEXE/eFWQPEP9nFiojgNKPM4dX4KLRJc23pNYKZyUNeiA2LBfYBjDOdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744731000; c=relaxed/simple;
	bh=nGnJsCoHtlRlNhhHQNhmdiShHkfPwI/He3+BHy5RPOY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XduXtppC4GrzUJrFH0aAQZjjJduOPI8hAfkVE/iybuEEER+Yh+hu5SRMft6Xq6p826V5iEtckBp4FC5F2P2yl3aJzc3PBz/VaSv/DsAAuJCUpL+EZyahzB9ZTybVAYTJBniJBhSLS+tI5EpxeU2q1IewUIEhYqWkKeBvbyzyO8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glUCUgEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912E8C4CEEB;
	Tue, 15 Apr 2025 15:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744730999;
	bh=nGnJsCoHtlRlNhhHQNhmdiShHkfPwI/He3+BHy5RPOY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=glUCUgElEiyF01Ub2VXOw5AVpMkj9KTvHb1dMwX3S3wnSkE4k4QGK5m9z4+u95UNN
	 +pN//Z+w/RW/dIVsymsF2+h4ctRTQ84hgqEuu5TkSM2RbIqWd/bJWVhFdVOFgnNquD
	 ftY8wlowzhF1CmONGSNZpGrjO4Za2Wbfq3uYx1ae8NY74CJPT6GcqDtvihIiMApwY7
	 XwsCJxAMZJp4Ltasmmp2JBKfZTHFr/5p4Rui+jXYWCRqC4jw7uV+hA4/Wsx07fkG1C
	 AcnqGsD2Fzdmcab+6k8q4cbrghKAiR3kqz1ZfH3xjgiPZcZ4B6OFWK9CzNgJmF1Dh5
	 wheCp66qu40TA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD463822D55;
	Tue, 15 Apr 2025 15:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: txgbe: Update module description
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174473103750.2677629.7039403894736647114.git-patchwork-notify@kernel.org>
Date: Tue, 15 Apr 2025 15:30:37 +0000
References: <20250414022421.375101-1-jiawenwu@trustnetic.com>
In-Reply-To: <20250414022421.375101-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 mengyuanlou@net-swift.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Apr 2025 10:24:21 +0800 you wrote:
> Because of the addition of support for 25G/40G devices, update the module
> description.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
> v3:
>  - remove fixes tag
> v2:
>  - post for net-next
>  - sort device speeds from the slowest
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: txgbe: Update module description
    https://git.kernel.org/netdev/net-next/c/f15e41068795

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



