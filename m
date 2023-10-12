Return-Path: <netdev+bounces-40492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA9A7C788A
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CC9282B68
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EF73E478;
	Thu, 12 Oct 2023 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GH8w6x4R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90CC3B28A
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AC3BC433C7;
	Thu, 12 Oct 2023 21:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697145674;
	bh=JDqDcN35jjlG1aV7JE5yfePTlGTwz3k5XoD8NBK4fxQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GH8w6x4R3rJktOJAld+wSvSMgn9T8jaSuj/+5vo3DABmb6KETDZ+N1CR+2uIWv2fo
	 qhZL1FGubV9RzQ0OKEk94bUOkw9wcd4jIj4cHAgNBFAwwb0RCdBb+Gz993KwGXKusq
	 AGfDXQNCHFVSl6L1iQK73/L++tgh409U9evSorxqAQDQVdpNHT89aijLwQpLyzwgQG
	 NLc2fGTcff0MMwIxc2EApkDW8mbA5vdVaEhg9tM4J6OcNum2+X0s9VkCDxv/RFpykk
	 XQSpl38S8D0UT8bpzwhDcKGLEeM83+NncQCYBdbrF/2OxjeQxmD2qbBcya1z8nKMWw
	 RpKWhTb0+IOag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39AD7C595C3;
	Thu, 12 Oct 2023 21:21:14 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.6-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231012110443.13091-1-pabeni@redhat.com>
References: <20231012110443.13091-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231012110443.13091-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.6-rc6
X-PR-Tracked-Commit-Id: b91e8403373cab79375a65f5cf3495e2cd0bbdfa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8c127b0576660da9195504fe8393fe9da3de9ce
Message-Id: <169714567422.14457.7076633708395048875.pr-tracker-bot@kernel.org>
Date: Thu, 12 Oct 2023 21:21:14 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Oct 2023 13:04:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8c127b0576660da9195504fe8393fe9da3de9ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

