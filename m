Return-Path: <netdev+bounces-186205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 882E1A9D712
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 03:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7DF21BC7385
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 01:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417D71F55E0;
	Sat, 26 Apr 2025 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNuCnzGj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF13199924
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 01:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745632196; cv=none; b=cQjn7xkeQAd2Jlngvzz37GUcvrAIJcUOZAOo4qqzwWdMjddMpekhNJoIXp9+7ZjDm+x6nRy7hfGnVsE4Vf6iLxzN6vQmatKzvxV6qfa8bBdHu/bZkANd2eKmv8DEsWYFCPthsKfGODXrxKUQfq8ngubNQbRxyUW02reWhb6xAAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745632196; c=relaxed/simple;
	bh=cnBo5tXu8U/HH5T1ctrvE9cw1YYsO1gD5TLvmUPluvs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AJ9hz8KCnFQNnFftUIZIY0Vtk+aVKT+EMWYQf1v0Bp4omNWhyTRY5UyMNfGf6oylXBEk3J6xrNeqr4ISNK/AzAKQWx06skSzA9j+SL8yvjYwcrpjqkECoV3GkJL4HDbHaQDkdDIEjeAr9DdAl6pW2b5qqAk9wU2GrYSQhECk92E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNuCnzGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828E1C4CEE4;
	Sat, 26 Apr 2025 01:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745632195;
	bh=cnBo5tXu8U/HH5T1ctrvE9cw1YYsO1gD5TLvmUPluvs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bNuCnzGj5qiBac8rehGce09u0HS2sp5nQ0ecQ6+WXRNbx0LOKSoCYat7s0xCrxCOn
	 I0e1sHHwI83Kbnc8MnBDHi+1eTm2sUG/63ed6HWrQbpParl90W55vd3bweQKarASTn
	 VGogfDQbfcucyyCa7x0hvAvPq51rQ/FKW8EnhWN3SDhXonXcnloPT2MvnfvRUZXTtl
	 RtC54XuKUCtp6TYjOckdyu0SEVL8+4JG0xLyRm2Q+Sh/wdcZWX2YizfUSoNr5T+wCc
	 af3iZvQoJ4SuedA9oxUJZpsjPhtOymUwasi/FNRGqKXw3/AFxmpn0h4XI/Gyl12Jqv
	 DYHVTWvsxMLCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DE1380CFDC;
	Sat, 26 Apr 2025 01:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 0/3] io_uring/zcrx: fix selftests and add new test
 for rss ctx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174563223325.3898507.17577181713539439456.git-patchwork-notify@kernel.org>
Date: Sat, 26 Apr 2025 01:50:33 +0000
References: <20250425022049.3474590-1-dw@davidwei.uk>
In-Reply-To: <20250425022049.3474590-1-dw@davidwei.uk>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Apr 2025 19:20:46 -0700 you wrote:
> Update io_uring zero copy receive selftest. Patch 1 does a requested
> cleanup to use defer() for undoing ethtool actions during the test and
> restoring the NIC under test back to its original state.
> 
> Patch 2 adds a required call to set hds_thresh to 0. This is needed for
> the queue API.
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/3] io_uring/zcrx: selftests: switch to using defer() for cleanup
    https://git.kernel.org/netdev/net-next/c/43fd0054f356
  - [net-next,v1,2/3] io_uring/zcrx: selftests: set hds_thresh to 0
    https://git.kernel.org/netdev/net-next/c/4ce3ade36f25
  - [net-next,v1,3/3] io_uring/zcrx: selftests: add test case for rss ctx
    https://git.kernel.org/netdev/net-next/c/5c3524b031be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



