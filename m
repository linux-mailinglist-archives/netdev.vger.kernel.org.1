Return-Path: <netdev+bounces-147783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 276649DBC72
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 20:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68DC9B21AA1
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 19:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED83E1C3041;
	Thu, 28 Nov 2024 19:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfurvpTq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37B41C1F23;
	Thu, 28 Nov 2024 19:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732821585; cv=none; b=P9WcnoS5/99a+uw3NpFqV9OVMEUahPFnq/cd8dWRNiutkaPTXTFH/NaA5o5nEUYnGat0hTWRtq9Cp4fNa2Zc6eBBocqGlQ5R7JDIqw8kNB0PhpPUG1nw7w3WE9RlxCbFE4G3W6iGJeGGvkAFgLM8yzYx8MtpzIznJe0LkMf2K3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732821585; c=relaxed/simple;
	bh=bGzu/UYt3Xj9yEDb+GnTV1ppMbvTCTfIHASuj0sUzpE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OgkZmuYoZCMviBmqCxMCIyihm7GnH+AQp1/K7xa8s0Ji2dLmLfuS2LKzMc8X5SqZS3nowq/pFXL8Ls+g8mNphZ7BibHMZCTceoxl6md/Aby8d3HPgWcYF83TC6KjFs9rUB2tnQ8soXsrXquXML0TDoMPm5p+NoAY0BW7o/efx2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfurvpTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73E4C4CED4;
	Thu, 28 Nov 2024 19:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732821585;
	bh=bGzu/UYt3Xj9yEDb+GnTV1ppMbvTCTfIHASuj0sUzpE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cfurvpTqgIjS4fzCaJOCHN7C4UzJj3sDtlHgZi1iUazEoMeBRcH5bJ5vL/BjmyhzC
	 gAaVmdcy72tbhnGIbgv1KQkgQZZSYbj7uOWw82nCNL1r20Tf0UNC3FOl0CGFJ05jiD
	 Lum7fy+eIwCPuzNPF9wXOZLCzpm3r9z1zP6DU5zAYzXaubtdrKiue/8UoDEOFFcS4G
	 fkrsetsQcEcMUxE1t1FHoLk7EcOBgaU1mkdxQ/gJIU9z9VT63o+T1P56RuhMICcIgu
	 Vk0Tt2V5zahl6PGtase4xjEQwFcAhBxC1ExODr4AlE6fO0/TlGrXM0aWu+k7TK+m7f
	 xNPXb2AIyfMxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F84380A944;
	Thu, 28 Nov 2024 19:20:00 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241128142738.132961-1-pabeni@redhat.com>
References: <20241128142738.132961-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241128142738.132961-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.13-rc1
X-PR-Tracked-Commit-Id: 04f5cb48995d51deed0af71aaba1b8699511313f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6d7695b5ae22092fa2cc42529bb7462f7e0c4ad
Message-Id: <173282159884.1826869.13998358571660244760.pr-tracker-bot@kernel.org>
Date: Thu, 28 Nov 2024 19:19:58 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 Nov 2024 15:27:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6d7695b5ae22092fa2cc42529bb7462f7e0c4ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

