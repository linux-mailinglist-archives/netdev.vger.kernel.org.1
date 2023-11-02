Return-Path: <netdev+bounces-45627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708227DEAF2
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 03:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 293CA2817DE
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 02:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F8015D2;
	Thu,  2 Nov 2023 02:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad6wzNfQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A24B184F
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 02:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FB5AC433CA;
	Thu,  2 Nov 2023 02:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698893506;
	bh=pfwQNW5exqv5kUaRtPyKXOVkOeUexlFHg0tTzhr6dbs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ad6wzNfQk0kCM9PdhVAGwnGYZTYkxaaqpD2yk1zAYrIlTjMSzYcF4Osgx6zkadIVD
	 bdRTeevdYuBeNlvnl2YzYNsHa/3KY/e8Q4mDy7rsiwG8K2441IN+DxYrcKe4mppC58
	 b2Yxd5vBgQW0r7nsaIS7tR6REvuciJ+5bx3Hdf7bhSkKJ3fOWXhqHvp/dEnmd7ZRDy
	 mgWCF2GWj9V3nYUVltSPWSyoU/YmLFSOJmhwgf6jtL2YlTMojLr7S+rvQO/iP3qBik
	 7Tpx+6oXBkG4co0PHN1UFCxCUbPN7MRSCl7Mh7vooZ+D1p/6IFbkdAs0YD0k6RKvA8
	 e3dogOisUedgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F6FDC4316B;
	Thu,  2 Nov 2023 02:51:46 +0000 (UTC)
Subject: Re: [GIT PULL v2] Networking for 6.7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231031210948.2651866-1-kuba@kernel.org>
References: <20231028011741.2400327-1-kuba@kernel.org> <20231031210948.2651866-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231031210948.2651866-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.7-v2
X-PR-Tracked-Commit-Id: f2fbb908112311423b09cd0d2b4978f174b99585
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff269e2cd5adce4ae14f883fc9c8803bc43ee1e9
Message-Id: <169889350612.17707.1762821092621079778.pr-tracker-bot@kernel.org>
Date: Thu, 02 Nov 2023 02:51:46 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 31 Oct 2023 14:09:48 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.7-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff269e2cd5adce4ae14f883fc9c8803bc43ee1e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

