Return-Path: <netdev+bounces-15672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F84B7491FD
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 01:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3561C20C72
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 23:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50E915AD7;
	Wed,  5 Jul 2023 23:42:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298081548B
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 23:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0043C433C8;
	Wed,  5 Jul 2023 23:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688600562;
	bh=mQwSV/WhgBqTT+Gf/XxCaf8OIlzlS1QxSGJvq3DCLeg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=HoXJEmtowHepiCJAIZUCc/fVmW4qQKtxgJvEmxxfqEoCDF3kvgwzB+3Q3Bqtaigcj
	 dUJTloB57lezuKo4Za2aTQd21bv7Mn/WqEPQjABz8lVkxlxJJpg+YC2tI05u7PcVWx
	 9c6Wq0mXFwi+X8I0UPbzok0yFhr+vKB/MSZUysk/G0W0hjp+awDVsH2w9tUcyqL3ei
	 nBRNbAPvyZZmMLWefzXG7LbYdL8+0bSmxunscgnf0uEXeha7YshFWMDrD1EUQtdg7U
	 iCW4Cpd3Abmv0Z3JyVyIUS8it7qBz+dVuJcDUyW0QncYZFXdEmHO866BkHbdhvTWEL
	 +N2iBEukI9XgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D574C0C40E;
	Wed,  5 Jul 2023 23:42:42 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.5-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230705190945.602792-1-kuba@kernel.org>
References: <20230705190945.602792-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230705190945.602792-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc1
X-PR-Tracked-Commit-Id: cc7eab25b1cf3f9594fe61142d3523ce4d14a788
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6843306689aff3aea608e4d2630b2a5a0137f827
Message-Id: <168860056257.20183.11442487377795774975.pr-tracker-bot@kernel.org>
Date: Wed, 05 Jul 2023 23:42:42 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  5 Jul 2023 12:09:45 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6843306689aff3aea608e4d2630b2a5a0137f827

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

