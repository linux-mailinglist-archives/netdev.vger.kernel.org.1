Return-Path: <netdev+bounces-26554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4F47781CE
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 21:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D061C20A71
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 19:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E312B22F1F;
	Thu, 10 Aug 2023 19:50:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0E020CA8
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 19:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C7C4C433C8;
	Thu, 10 Aug 2023 19:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691697004;
	bh=m7wsLm6cINbgrJRhcEN1/O+nRC9DUA51asBVUkiq1fY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IGIRD5mfRrCh2yyyo8qdvkfyF6BBlRCV9c/BpJejsoETuWhr8nZYJwgDKw1sgtrd5
	 Ef3w12TxpNpXlyMzT4p802yQy2HAna+ze5YKL0ocIU8U0ooCQAQVwNieO3J4i8SeVk
	 yCu1zNZB10Yb11L7UdhIf1op8sSb2HtBivLR/tLc68pR69lgfYS6YKdSjLJXNw+i5y
	 fbcOrWZlIegsBrP4G/kjjDriZXEy+w+wpdBXeLN3C7m23lZFnHe1gkTEIJNObYHGfK
	 /qSehQYBDe9UkZqB0vBE6UFGw0ZiZ8A85QWA+667GCPcDvlONHHqwUslkytsNwxA2h
	 R+m1SA9sETHDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35888C39562;
	Thu, 10 Aug 2023 19:50:04 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.5-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230810185922.92197-1-kuba@kernel.org>
References: <20230810185922.92197-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230810185922.92197-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.5-rc6
X-PR-Tracked-Commit-Id: 5e3d20617b055e725e785e0058426368269949f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25aa0bebba72b318e71fe205bfd1236550cc9534
Message-Id: <169169700420.10464.407068100361851410.pr-tracker-bot@kernel.org>
Date: Thu, 10 Aug 2023 19:50:04 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 10 Aug 2023 11:59:22 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25aa0bebba72b318e71fe205bfd1236550cc9534

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

