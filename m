Return-Path: <netdev+bounces-35589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A3A7A9D66
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F512282910
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F1A1803A;
	Thu, 21 Sep 2023 19:33:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26647171D0
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D8DEC433AB;
	Thu, 21 Sep 2023 19:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695324796;
	bh=nX03GEiuuu+hp0P0Zdt7Pg36vckFVqsI3O2RACOz7P8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K2EEn/0ibQwRfHtFcrVDaLmnBF6WiiPlREB7/8L7Ca2e6LWZWqN3dct3KUjmXxvZU
	 ZfCOseM3+GPIi1VEnu0Hf10gp9NTyBn7WnQVi2nfwKY81gnr+45ApJ3wEGLcvFBMQY
	 aooI3r9B8LaHOElHwbFO1Jy4xN22+jkJ90hmMaXDn4fOxuNGLwRzZQ65HZVsM5BgO8
	 2+pyrMS79rWVIptVL8J1DKw5aAI10vOSbeTKYpUGul4p35D/jJF37oAQ+5OR5ijK87
	 wTVUnERP3qetTn/9PDrzeh0flu1lzks6rvA0Cj4NzGwgvF2XjKIWUx9Q05G0wXkMY2
	 bv8tMReJ08X1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BADBC04DD9;
	Thu, 21 Sep 2023 19:33:16 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 6.6-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230921113117.42035-1-pabeni@redhat.com>
References: <20230921113117.42035-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230921113117.42035-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.6-rc3
X-PR-Tracked-Commit-Id: ecf4392600dd86fce54445b67a0e2995bf96ba51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27bbf45eae9ca98877a2d52a92a188147cd61b07
Message-Id: <169532479656.27019.15236754010448590553.pr-tracker-bot@kernel.org>
Date: Thu, 21 Sep 2023 19:33:16 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Sep 2023 13:31:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27bbf45eae9ca98877a2d52a92a188147cd61b07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

