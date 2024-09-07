Return-Path: <netdev+bounces-126145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDD396FF03
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 03:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229911C22326
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D982E659;
	Sat,  7 Sep 2024 01:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBY/eAIb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D18C125
	for <netdev@vger.kernel.org>; Sat,  7 Sep 2024 01:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725672639; cv=none; b=SlImt7XvLWfIMl1E3DZox7ZLepIqt6oXg/DDkUlMF4ypaPNi2AFXpuitbX9WwEwrRaQPUjMyYbccNva4pyewDGo60hRMkzowkJbhtX8wBVmhmmi8BCdIbPYeJH2CUgSdELOdTdNMfi+/8+kVIlpT9qLpp1DIuNPYIpcUDfRETBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725672639; c=relaxed/simple;
	bh=pMRqArSz7Bfz6cdj3yxhGtzIY3Qk9ZsfutLoDeCKJNs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jzdqcyUgBrdRpBNAtW37YeqgqXSlm54A0mnWLA72MR26kshQwsy2eKsCUcgVNBuIlp8P0cTUROwImHo3zgFS4YaZf0EPRoTIMs2EqGK12jmCdV3/FhVtXG4yjH8Evsc/mtLJcbzr68guZWCZaoYz/aEeSTCi6C9dQn2Tnher5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBY/eAIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6141C4CECA;
	Sat,  7 Sep 2024 01:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725672638;
	bh=pMRqArSz7Bfz6cdj3yxhGtzIY3Qk9ZsfutLoDeCKJNs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TBY/eAIbuE7qpg+XzWR2CBlqosizBY3RdKWSO7UKTFs13i8jx4QbXPSDncJ+xh1gl
	 KcS4VbN8RCLgYU7xhuNXhF3HkiPHu9/CK0YCuZ14AHIUruCKcNzt50Tz/Osq4mil7K
	 3gARmemeMd+nLO5B6dly+tbdhFNtNYtNh5+coTUxIdyEexZflp8/pVs2iPH4/ve4tk
	 UVI6uYsa2AmodavHuid1AM8Fhg6m9QWecAGa+/1MBrotULbsHowxAt7VOEiZM2Xmfs
	 o+FfjHPuSgZkOXQnDxeeGhR9UhpDvwi811JZWIiTCVKvbKCPzDjx/Hauab9Tq0hLPT
	 VjAEvnPp0fLlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD463805D82;
	Sat,  7 Sep 2024 01:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sfc: siena: rip out rss-context dead code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172567263950.2576623.2125488427515968911.git-patchwork-notify@kernel.org>
Date: Sat, 07 Sep 2024 01:30:39 +0000
References: <20240904181156.1993666-1-edward.cree@amd.com>
In-Reply-To: <20240904181156.1993666-1-edward.cree@amd.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, ecree.xilinx@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 4 Sep 2024 19:11:56 +0100 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Siena hardware does not support custom RSS contexts, but when the
>  driver was forked from sfc.ko, some of the plumbing for them was
>  copied across from the common code.  Actually trying to use them
>  would lead to EOPNOTSUPP as the relevant efx_nic_type methods were
>  not populated.
> Remove this dead code from the Siena driver.
> 
> [...]

Here is the summary with links:
  - [net-next] sfc: siena: rip out rss-context dead code
    https://git.kernel.org/netdev/net-next/c/32b81e4f0e5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



