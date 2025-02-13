Return-Path: <netdev+bounces-165964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E91A33CF3
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E468A1889455
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99932212D7A;
	Thu, 13 Feb 2025 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNU7TkkE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D8020E717
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739443802; cv=none; b=LPT0tcmV/z27EweUWVvm3bsSgrb3nLjI3KiLOxJE3DJlVJzIMR4j/LL+9NV2PmdJP3OcQhvAnVKH2g2Q9nPWb4L53XjtFKsj5nu0k0uef//rFsjTwNXq/qvoDoJnpS5t9AOkxbtXtxhRvLPGr7WQSp+50DrmWDM2KIxpObHU3eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739443802; c=relaxed/simple;
	bh=EmgFZclLpQ6mkv0XEm01W/8nKRvFjm/b2ZRsTuA1oBc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tVupPRsm6uogVTfQhG0qJOvSFFEAEBhzoVBiWqyw+AGGcBP71217FDjOswdiqwsvX5ptSOFcFnEQEHUSYpsSC8biZ9Ih0SWnzAjnx9rTr97pb1rYq/AHVz9I2mDRyIbG1zNsqU7Q0xrqzdbzoXlmPFrHKFoHivehcuxzyi3JZrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNU7TkkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E030CC4CED1;
	Thu, 13 Feb 2025 10:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739443801;
	bh=EmgFZclLpQ6mkv0XEm01W/8nKRvFjm/b2ZRsTuA1oBc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SNU7TkkE9+Pq83nxYt3ieBKPuPcfCcvDqf22n2dsiXU6/KQjYP2Vs3Y9FbMQjefac
	 tBU4rSpbOi74RXCTPx6Wwnb++uJ+V8ld9gONM4mpjnOF2VkCtNmuwt3svVR7oaWVBt
	 JIimvlYdA0fwr5FzQFasU7j6hsEEWoOSochaiffSKKcScYw5K+7IQDeE0F9onCQTsJ
	 uxGcS9lK6UfL9tfYbWk4lSSVmWHPduMTUlmfkIXVqHjgBCLQCYqliyeq0GKVDtJW++
	 bxP6F/Sd5RVkpw79Zwabhjp84fLVZ4vhBRqYfl1sFBsAxfjHgdLFKPkEC9OdLqJbhz
	 AZhSrSBU+Dvgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FD1380CEEF;
	Thu, 13 Feb 2025 10:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] arp: Convert SIOCDARP and SIOCSARP to per-netns
 RTNL.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173944383101.1182479.12815558202490033852.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 10:50:31 +0000
References: <20250211045057.10419-1-kuniyu@amazon.com>
In-Reply-To: <20250211045057.10419-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 11 Feb 2025 13:50:57 +0900 you wrote:
> ioctl(SIOCDARP/SIOCSARP) operates on a single netns fetched from
> an AF_INET socket in inet_ioctl().
> 
> Let's hold rtnl_net_lock() for SIOCDARP and SIOCSARP.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> [...]

Here is the summary with links:
  - [v1,net-next] arp: Convert SIOCDARP and SIOCSARP to per-netns RTNL.
    https://git.kernel.org/netdev/net-next/c/7aca0d8a727d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



