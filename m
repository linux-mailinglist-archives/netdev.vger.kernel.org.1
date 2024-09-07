Return-Path: <netdev+bounces-126129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB38996FEDD
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 03:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD881F23438
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B5D4689;
	Sat,  7 Sep 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kv3gA0aX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4325234;
	Sat,  7 Sep 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725671429; cv=none; b=q7FM4KMq842ml4wZUYlfcfGRucDuY5pYBRpBa7DQXTVcEXePTMw+6kK6nAJDGQeTm/OsERPnq1Zmkd0HNuICxdc4W6dgwgKsZfg7TA0W1q7XUSlA7sv7QwNsD+x9uOYOLdJbjLaML6SGdl9bFj5LvyvjPf98H57Q2jnZCJ4ghgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725671429; c=relaxed/simple;
	bh=RjgEQ4IDKz8MDPKKASWVIm+yag3cFie0S2QOnGZw80I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KgAJaaMWjqx1FV2hLlwdl8nx1hK8nh7lxTYO2L0l4Oa+DvJErk9Rb3cDa3mYywGrZgjhoSeuHozGGit+nRn0qr3J00yL9LQ6FCwbK1rNE8OVvX+JZO7j44jaeoPXPj5rwKipo9FeM3nJuWeE/45DsbYmFlDs5KXQscX7o5hv81U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kv3gA0aX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A928C4CEC4;
	Sat,  7 Sep 2024 01:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725671429;
	bh=RjgEQ4IDKz8MDPKKASWVIm+yag3cFie0S2QOnGZw80I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kv3gA0aX3jCPpYca1yPAIATnITxf9BFZg2AT1VH6VeaMQK5/gWV6fh/6kkIOmwOYS
	 y9rkj+HMgARDgUrQ3MXq+T7WdOwNUpdMV5rYArjxkCDxp2e0ht2p8y+isNXnPVySRo
	 40N+TTm9PLgnZyh+N5BWf8FsUEHMEYnGz+vNt/qUirDo74VNP/YPYKyCzyeh/dOAmb
	 PJU8T8zRP+myJuwiDJeJDyWNcrGqlQrDccVbTExblE93il5CFDMs1Y775FAHAvJwlq
	 duHecSnUHxQoLS49VpCOPDDHBe98ImTa1AKrj15A7vfZd/SP+v6O5nH9YhQ96uaM6A
	 AxNxovbrWRzDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E0A3805D82;
	Sat,  7 Sep 2024 01:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sfc: convert comma to semicolon
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172567143000.2573151.11944760575272253397.git-patchwork-notify@kernel.org>
Date: Sat, 07 Sep 2024 01:10:30 +0000
References: <20240904084951.1353518-1-nichen@iscas.ac.cn>
In-Reply-To: <20240904084951.1353518-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Sep 2024 16:49:51 +0800 you wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> [...]

Here is the summary with links:
  - [net-next] sfc: convert comma to semicolon
    https://git.kernel.org/netdev/net-next/c/be8a17fe994d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



