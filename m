Return-Path: <netdev+bounces-28716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18688780590
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 07:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F101C215C2
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 05:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6722C13ADA;
	Fri, 18 Aug 2023 05:18:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F955134D3
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 05:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81D14C433C8;
	Fri, 18 Aug 2023 05:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692335895;
	bh=QdLqdIjISuh8OpzVyyaN3TMdoeWkEO26hO5xJu8AK1A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NHD0ybKzCBDIXsTHCiOujm3GI3XMpKP5JtJbugpPX0dY+g9lX36ed8TZYODxShPUN
	 pU/QtklVEkYT1HgnDtNv1P9JZbNfN52PdTi9hnrJA16nfox0eu15drpqKqGPyhblzF
	 bLDoUkCLb5LA9qXhuosjCQ+XrYyuKMwDWjbGvSDxvdcpveKoPC9AjaP1XnZiHIflT9
	 KgGQlg+sxf5Kt7tRUtmLiZCQpuPz1ZofLXMWnllsBHncFfn8+p5hsRjhHF0FVRjNVB
	 zcLEsY6Ddo8EAeLisVQ7uAb3Nf6Zt/Qq7fzvNjl1HO3FgRxbUA1JMdvUR2WQvbl5O3
	 tkX8UHcAwLqoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6EFC5E93B34;
	Fri, 18 Aug 2023 05:18:15 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.5-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230817221129.1014945-1-kuba@kernel.org>
References: <20230817221129.1014945-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230817221129.1014945-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc7
X-PR-Tracked-Commit-Id: 820a38d8f2cb3a749ffb7bbde206acec9a387411
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e8860d2125f51ba9bca67a520d826cb8f66cf42
Message-Id: <169233589544.13368.883924351693507238.pr-tracker-bot@kernel.org>
Date: Fri, 18 Aug 2023 05:18:15 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 17 Aug 2023 15:11:29 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e8860d2125f51ba9bca67a520d826cb8f66cf42

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

