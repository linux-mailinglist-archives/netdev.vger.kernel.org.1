Return-Path: <netdev+bounces-117024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C7E94C61E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 23:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63DB41F2722A
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 21:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57D115CD7F;
	Thu,  8 Aug 2024 20:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfI52fgv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAFB15CD42;
	Thu,  8 Aug 2024 20:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723150793; cv=none; b=bax/C4dXn4HKf6MI0SEz81Dq1W+wJLNJyyeVhV/poq/x09czL82xPj/00Cu1trusGq8T/gOgLFPKoyGsvmoRx71Q6vDhC1gW+82398bWDnogA7kokQQlNRw+PR5QuaZj44bL98bX760v9f+vLBDggHqqhKhzEd8Uj17x/5afxpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723150793; c=relaxed/simple;
	bh=+t/NENyUIfnrnclvQQHiuOgfSa4fYHh4IlL9MG62GO4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UeZG2MV7aNwJWBf0twnb0RslNFZ019MNZdBT3cSsVClLIBPTQGxEnZy0RagpgoHpq/VxhWM/LphtXQw/8rm8MKV5Oa98slJeWXzPTMQywD+zg1SnheR4JXgBNLiqIQInYGHbfKCDYH9nRDRnP8zQnWdsrVL3psMYeFyDQ8BcN4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfI52fgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC66C4AF0D;
	Thu,  8 Aug 2024 20:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723150793;
	bh=+t/NENyUIfnrnclvQQHiuOgfSa4fYHh4IlL9MG62GO4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RfI52fgvELH5rprmu4jjCoXt2RPEALE00kJSw7UFdKr18+S0au3NoYXQks2MBhXCh
	 ZW1M/v8T+8OU+oFqPlRZiqCrxjx406Fo0FVjaNvOJt8AsCqPXSkp1aN1zd0/BMXtrr
	 sX2fgZbCW63LuOMr2jl7MnAcIRjWr1bYP0+gJlaS3MPXf7q5Wq+jD/wBcvGUrtoEOM
	 s7ZRhehYAJjkHZb4Hxzk8gjiZrv6+68ish8H4Yw6g5xI71yAZf19T7Ch+teMVUGCOc
	 eeeXKQUX2rolAj1IxKQAL63u6JAt9VQ6gtXZhQZmkS3/8F7GGRPkV+U7cQy4UkfR4k
	 g791ziCApLJNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4593810938;
	Thu,  8 Aug 2024 20:59:53 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.11-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240808170148.3629934-1-kuba@kernel.org>
References: <20240808170148.3629934-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240808170148.3629934-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.11-rc3
X-PR-Tracked-Commit-Id: 2ff4ceb0309abb3cd1843189e99e4cc479ec5b92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ee9a43b7cfe2d8a3520335fea7d8ce71b8cabd9d
Message-Id: <172315079215.3297575.14894632820956357203.pr-tracker-bot@kernel.org>
Date: Thu, 08 Aug 2024 20:59:52 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  8 Aug 2024 10:01:48 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ee9a43b7cfe2d8a3520335fea7d8ce71b8cabd9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

