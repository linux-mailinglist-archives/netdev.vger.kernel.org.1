Return-Path: <netdev+bounces-42794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F91B7D02A7
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 21:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 288E42821F6
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DA73C08A;
	Thu, 19 Oct 2023 19:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE151hnv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1ED3C06D
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 19:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 288FEC433C8;
	Thu, 19 Oct 2023 19:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697744502;
	bh=146dGb+6XobHWS/WTm6XBevDFMhJZ4JqrHRQSP2wcIM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UE151hnv/LGmQo/uuTV92amBQOnmIRaaeu9rdnTZ4/hH+UMjjQqa9JKLSJeO5u0je
	 Wrn8tCN2b9JHWYwsrPYNlT3+X0IUZYiakZYSKno46F93FYgcwGDM0wv4/F6J8NxGoD
	 p1HzD8uO1POkkprWGPQDYFJiwfwfPDXsr8RClrYuD5rfD9x19wTwOhHoMejRk2lXVt
	 tc7cQDoetMi4yWAt+01OZrEVzU18SpWRC2O1FE8sh4LAH5Y0t4LRk/mdtY/1H8Ubaf
	 4wx3B2NfC3wWWcm5EeU57lvUxDztSoJUlK1IG3l6Af8/ljQYK8yPRrVkiSkUK7PQMZ
	 kqCQz39KknhgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 157A7C04E27;
	Thu, 19 Oct 2023 19:41:42 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.6-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231019174735.1177985-1-kuba@kernel.org>
References: <20231019174735.1177985-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231019174735.1177985-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.6-rc7
X-PR-Tracked-Commit-Id: 524515020f2552759a7ef1c9d03e7dac9b1ff3c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce55c22ec8b223a90ff3e084d842f73cfba35588
Message-Id: <169774450207.26229.8169337360472386974.pr-tracker-bot@kernel.org>
Date: Thu, 19 Oct 2023 19:41:42 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Oct 2023 10:47:35 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce55c22ec8b223a90ff3e084d842f73cfba35588

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

