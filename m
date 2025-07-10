Return-Path: <netdev+bounces-205873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42696B00979
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 19:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197AC3BE00B
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 17:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A92C2F0C55;
	Thu, 10 Jul 2025 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEsMkVuI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732DD2F0C4B;
	Thu, 10 Jul 2025 17:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166962; cv=none; b=dn5dhHkJ8y2GB1LjAVUmPk6VyGe2Nv0bjp3FxiCnBXvlduOO/IAYTJr6U5bs2H0sPr9cLLGn+kyvFZIUYGa+3aZuwtNkDGVX8cH0Pv319NZFPYayvxlZNORhfXSE9txSwny8wjnXGO2ZVYGjZ7KVsIXYOSpi7H4HHr/Kmqcee8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166962; c=relaxed/simple;
	bh=EdOYXz0e5KWWn92XPCoK3tblMuiCQ49no9UA9ssbaGU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LLgBC9FdgiGYNQQRTDtb2YO36MsUYDUu0+nYyak9gSSl9nJ6freKzHpUrUPf9XX54zwAX9HJiqSKH8AdE4JqJTO/mtuMokS+ZfcYhN6Z24ZsUkEjudwqCJnXqrbBPnh3UEufB2q/2GejBiudCAWoRaPy9iO0+mLnfqWl8NXWgr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEsMkVuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D42C4CEE3;
	Thu, 10 Jul 2025 17:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752166962;
	bh=EdOYXz0e5KWWn92XPCoK3tblMuiCQ49no9UA9ssbaGU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sEsMkVuIIHmxqdb64W/qASE3K5rtUd8Edi+pajZiekqfCvAM0JitNdE9SzZZ7FZy0
	 eb1VU/NxMW1fodiCgk9TWgwaEN6VsVIzCQBG3AUUrOx5B8qid/V/RPEVgqS3SDHI5D
	 OypwPGJ1PjvBdnrzjIMXmTkZtlmraQ5T9lYMmw3+IuADWG+eEbQ7G12U0CWuvRw1FP
	 61VOmvWViUk+/ObYbHTamXxQHpsjLtD1udaqGHuvAGpxeAhRJD8+WmbwHhvdmPPCX0
	 aUlBTwtmsjYL4NCXVWYI85Hm9sDtILHXr3LJjM9A0rlv/50SYM+/bDx0ccecF8cU6K
	 q86b3IuobCD9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71392383B266;
	Thu, 10 Jul 2025 17:03:05 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.16-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250710124526.32220-1-pabeni@redhat.com>
References: <20250710124526.32220-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250710124526.32220-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.16-rc6
X-PR-Tracked-Commit-Id: dd831ac8221e691e9e918585b1003c7071df0379
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bc9ff192a6c940d9a26e21a0a82f2667067aaf5f
Message-Id: <175216698391.1599846.5663451077568586007.pr-tracker-bot@kernel.org>
Date: Thu, 10 Jul 2025 17:03:03 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 10 Jul 2025 14:45:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.16-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bc9ff192a6c940d9a26e21a0a82f2667067aaf5f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

