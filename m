Return-Path: <netdev+bounces-38364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8D47BA93E
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 20:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 01BB0281E51
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F7A28DD7;
	Thu,  5 Oct 2023 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVHID9Th"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66760262A7
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 18:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1FF1C433C8;
	Thu,  5 Oct 2023 18:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696531170;
	bh=TZ6/vINZYzeuHgj6hf8EA6U0aoqe+o4/SxXZ1oXnEAQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UVHID9ThKqPbs7uJarC6dj6k3PKqvi4QsRK/kL13UfdQP8ZRL/Mly8M8oMo2E0UoG
	 wBCYKkT+9WipWxx1RVRaqLa036U+f+Pbp6qfTNUrvW7/J5N7aJ/ZF/ZccTK4iqCTQL
	 2WvPjhyb7KyoJAJtsHWsVNSdFwRaDWTGGEOugiQ7JEliFx+2Mnu/b2+H89yLlMsEzT
	 Sgy7pCHQaOLuAAdiL+Mk87p6H474CyIHV0YU/3pBDNuaGQsiFuA/PIzzN2MHYJNoGj
	 nil6HVJTJSyAF4vCrQRV/VglpoZu0NTKhOXpqPyWG2TvmyQ2ZO1sVldXy5EPpa/UxS
	 LrdCS6Dzwq52Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BEF3EE632D2;
	Thu,  5 Oct 2023 18:39:30 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.6-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231005182140.3847567-1-kuba@kernel.org>
References: <20231005182140.3847567-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231005182140.3847567-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.6-rc5
X-PR-Tracked-Commit-Id: c29d984580212f8a5e75b65c99a745f29511f83a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f291209eca5eba0b4704fa0832af57b12dbc1a02
Message-Id: <169653117077.4044.9754330321075907934.pr-tracker-bot@kernel.org>
Date: Thu, 05 Oct 2023 18:39:30 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  5 Oct 2023 11:21:40 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f291209eca5eba0b4704fa0832af57b12dbc1a02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

