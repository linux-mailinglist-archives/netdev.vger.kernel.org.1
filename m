Return-Path: <netdev+bounces-103381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D93A907C9D
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 21:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53DC1F217DA
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 19:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBED814D6F1;
	Thu, 13 Jun 2024 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxK5C5GS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21B72F50;
	Thu, 13 Jun 2024 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718307005; cv=none; b=muOfkF+ewb/ZQLEvB1TCCjRSXnIawzyyzASY8i3Arac/PfFvRp7s5bGsFjthV6DG5pXP95Ge6mCxscc0LiaooB5g45fSVk623r6KovoJ/1nuOt1YF4xK9/n7J6K0Mc9AJGIZRrWIDbG7iB3Q4EEfPBUYMT43BboYQ9xyh9SK8/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718307005; c=relaxed/simple;
	bh=sv5t4dQf4SQA6LxLXc7P9xQvlKNkzL+edrA+HnEmYsY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q0FRf/yyU9KSgOprNiXZkaLyDhpnaepetX66ZgaPCuujxMCCIx+gvvEXIuLPNcDRHHF/tkCh5t2OxZDExSd3lbVTPRd0EFSqNG4AS0QcOfL2KlCETrJF5dbQa5Q37RZ6vvOPWpt/F5orEOL89qE2PMETWT6w/Eq+SeUaRuRxD2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxK5C5GS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C325C32786;
	Thu, 13 Jun 2024 19:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718307005;
	bh=sv5t4dQf4SQA6LxLXc7P9xQvlKNkzL+edrA+HnEmYsY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RxK5C5GSW2wEhbrRwDKwBkFCSFZ7KIsXyZmHOEO+YotqNNfHUEr8pmZ5I226ZmV0I
	 L8vpZ/wFE2uLPDFbvp+Qd51LGKrzA07UeExoL6wDygB2wMNo638fDvAdCtwsNBeN9L
	 gCcM3/UUgh+FNSm6NR8GfJH+ztnN/itv3N8TrVONHSXHV1rGlayJ1jC5J/MM2V0Kio
	 +e5X4ND78lTDr2rxDJfQvnSRm07liLfIy6dSDsxvxGtVCTCQSZQc13FCSHMMVYaVa7
	 Xqs1plMvtdvTcbiF9THsxtnae0PK+iJNXrAyM+Bix+DS6HPKeOhRq7RYk9nH20weq2
	 TRlnTjHavsPTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6BE05C4361A;
	Thu, 13 Jun 2024 19:30:05 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.10-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240613163542.130374-1-kuba@kernel.org>
References: <20240613163542.130374-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240613163542.130374-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc4
X-PR-Tracked-Commit-Id: a9b9741854a9fe9df948af49ca5514e0ed0429df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d20f6b3d747c36889b7ce75ee369182af3decb6b
Message-Id: <171830700543.20849.16635949876137659751.pr-tracker-bot@kernel.org>
Date: Thu, 13 Jun 2024 19:30:05 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Jun 2024 09:35:42 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d20f6b3d747c36889b7ce75ee369182af3decb6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

