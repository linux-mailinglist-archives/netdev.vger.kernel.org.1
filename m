Return-Path: <netdev+bounces-19673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AA575B9E0
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 23:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E883D28207C
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8561BE99;
	Thu, 20 Jul 2023 21:53:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62E2168B0
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 21:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B6AAC433D9;
	Thu, 20 Jul 2023 21:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689890024;
	bh=Ks/7SzKUrQWpvpD7qyUupUycx9MQHR2Gx+74B3iJ7lQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qy6zhdF3xa3LWBYitjL5iHR20cnNSmnnBAhYCC10PqjIUquz2oGRI+K/VNjWRSjmP
	 zvt3uVlbem8aTgz/pTdsCb4EzHTJAwFIyqXuXSs2PHxzJoOEVpdH5einv1rQxLp+D+
	 EbRpV9PhodWEkaRDMBITh56i7Y9Lsr4yvkZ+cdZfTUrUy4HYw4ArKPhE9w6xAXJBXm
	 nuGpQdTlOZmvrEdckkM24Qhw0toUNvy+dSpKKhKpNn4twrS6F7fyaDa/S0LCKXU7SE
	 6p/VEFTRpQyllwE9EOxSAC+bNwUn2Sswo4e6UvCb3IK4y7QTyRWlsVBT7ZxXpJVD/a
	 MAAISpTppXTdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28AE2C595C4;
	Thu, 20 Jul 2023 21:53:44 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.5-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20230720214559.163647-1-kuba@kernel.org>
References: <20230720214559.163647-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230720214559.163647-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.5-rc3
X-PR-Tracked-Commit-Id: 75d42b351f564b2568392a4e53cd74a3d9df4af2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57f1f9dd3abea322173ea75a15887ccf14bbbe51
Message-Id: <168989002415.13899.12157867587483013615.pr-tracker-bot@kernel.org>
Date: Thu, 20 Jul 2023 21:53:44 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 20 Jul 2023 14:45:59 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57f1f9dd3abea322173ea75a15887ccf14bbbe51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

