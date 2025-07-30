Return-Path: <netdev+bounces-211059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B09BB165EB
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 20:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4624D1AA5FF1
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 18:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A8A2DECC2;
	Wed, 30 Jul 2025 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkrXbAzn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA232DA75B;
	Wed, 30 Jul 2025 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753898469; cv=none; b=DArJN+q7XX2D/D/oyv511ZHhyKanH8rr15lDfoGFQmzw7ChaKyGGFEL5Q+D802c7Hq3hf5xIW6yqYV5RSM8veWVGWiAKcJN0p3otiw0gD6yy0jeiSbiaoT4hlE73UX8mkygcl6CjWcHP4AEjggCQOZAWRwy75PTRaKzeH8Z0eLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753898469; c=relaxed/simple;
	bh=rbL0baLyBTSurGbqHr8B/lp7Q3TgiR0gorR/4NnFkSk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fQKdfY2anJZ/2k4OSodbc8d1v3uWWp4nrkFSeuXDCemu4ULvseWe9LTE/KHTHtwnQORzy7jWQSXw5j33SzkYQpW49wUUiCgnChgUUVikCWAcxMZBzcFlKdtx6mZCFadQkyJCncpTq6McmtCP+Ty4P21AbQBI7FDPZBJqNIukY7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkrXbAzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CB1C4CEE3;
	Wed, 30 Jul 2025 18:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753898469;
	bh=rbL0baLyBTSurGbqHr8B/lp7Q3TgiR0gorR/4NnFkSk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PkrXbAzn9xfmTioWsFZqjaUU87DKK52P0ngHu6Ah+OsUhB4B4fVze10YHmr2wZlda
	 X9VZzSnuUMoflqyPbfLVXUIxuOnx6GztgFYUVHuv7AtDk0r2qJImt3wxfsue1OHxMo
	 zqXfPfuK+EcusOo2MmizvRxW0EJeYkKSMzoIU0zFklgli9BFtfLZSSG4Vclymz+o1f
	 dH1n0Pke/ZKmvkzzMX2dnJDV0a0D6pRKUtAdD+kiWcEi7gXZm+lJ+NpG1R0j8AnpPX
	 JBQD36O9tNmHo93wchZ1dqxeM5o3qfg+eXRlAf2m45aRz4rUIVEWxEM+HNrmxe+Np3
	 BNtUdsCXfyWKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DF248383BF61;
	Wed, 30 Jul 2025 18:01:26 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250727013451.2436467-1-kuba@kernel.org>
References: <20250727013451.2436467-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250727013451.2436467-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.17
X-PR-Tracked-Commit-Id: fa582ca7e187a15e772e6a72fe035f649b387a60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8be4d31cb8aaeea27bde4b7ddb26e28a89062ebf
Message-Id: <175389848555.2400114.10775447448060364828.pr-tracker-bot@kernel.org>
Date: Wed, 30 Jul 2025 18:01:25 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Jul 2025 18:34:51 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8be4d31cb8aaeea27bde4b7ddb26e28a89062ebf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

