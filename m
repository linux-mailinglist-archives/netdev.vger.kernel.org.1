Return-Path: <netdev+bounces-17704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 141F7752C4C
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 23:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D84281F30
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 21:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EF4214E8;
	Thu, 13 Jul 2023 21:41:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B11B200D4
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 21:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77B0FC433C7;
	Thu, 13 Jul 2023 21:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689284489;
	bh=IcII+NxPvhFSzsqRXI7pfW26hOmMapasS2oE0JpvGtg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bV8OqkQRk6ppgmron+FMhynSM+5IcDZ5ZB7/egtm8TVMSCL+vl+TPpxEhtHkFhxE0
	 Ja5R55b631rKOxuq986Kse7Ys8aO9dQJiJWx73a4Bo9GJMmH9zFU6h9nsK6MevLcfK
	 w1LAmTmMu0OZ87NR5LGV1k1bf/P7N3dTurwCvvHwGNhtTnrr6xN9Xxb9boySK+jqkB
	 p9RA2C3WmcMMJtSQQm+AEFsMlCV9XQVaB/0vI7ZX7rzbQmfD54me7YcTUKjRG3pqT2
	 Ao+WCoekbNXInOHq973eI6PHhMAjHulyJRhEyKNznPYBc4+lz0JOxCeW9qnK9TkZvR
	 GuqZYkMtOk0OQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6510CE29F42;
	Thu, 13 Jul 2023 21:41:29 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 6.5-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230713110415.38918-1-pabeni@redhat.com>
References: <20230713110415.38918-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230713110415.38918-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc2
X-PR-Tracked-Commit-Id: 9d23aac8a85f69239e585c8656c6fdb21be65695
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1983d427a53911ea71ba621d4bf994ae22b1536
Message-Id: <168928448940.12038.6513241835374231625.pr-tracker-bot@kernel.org>
Date: Thu, 13 Jul 2023 21:41:29 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Jul 2023 13:04:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1983d427a53911ea71ba621d4bf994ae22b1536

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

