Return-Path: <netdev+bounces-220054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD48FB44506
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A2557BC43B
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB718341AB1;
	Thu,  4 Sep 2025 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDKyvkOQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B2B340D9D;
	Thu,  4 Sep 2025 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009119; cv=none; b=qfpE/7iV9CO1KNDpPWqXpv93AVNHfb1KXhRW9Qo7rB0kPXPw0gaEQp4eX+7hUNMuK9UuPvIgl0juSbT3cq/4rAM/sk10sC9SxUQkVvS5twT/qCzp4dFikTdM0PUSPtVo0/Qs3cvUB3B5Ng0c9k4CLJNrqqabkMivYJj3p1pkNvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009119; c=relaxed/simple;
	bh=sPud2mbzfjHn0WTsss2JLEFVZDp3pSnqDvA+x92935o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NtR92APEw8USujIN2rKdGWT6OyzY3c5B0GIVlu8jG90webUqvF+r4P52BYwUDfq0vEnTIbAmOtmokqvtw6N7jYNZBzI/EpUBYEDqLW29k6Qf9auV8xPIRwpcJ/8N7J5Ih/9st+qlAE1AWYp+S8QxwJixbTztnkRoNMURd2mBa6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDKyvkOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9382DC4CEF6;
	Thu,  4 Sep 2025 18:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757009119;
	bh=sPud2mbzfjHn0WTsss2JLEFVZDp3pSnqDvA+x92935o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uDKyvkOQ7l1l7vbMjLKDSeN8MsxSgKs1nel7LoNbo5seecjKnLgsDo6tcUJYrJuvn
	 rAWr8kz5FVE1cOv3dACGf8FpysAIiIeMiVPXaBcCdh8OJVTIPQf/3E2fhcq4oJ890R
	 JpTNo4aCwiWoD5mTYSS7hO8uwEy8vtsp4RthzHGBU8vPmfC875CjZL3T13VMbYVTq/
	 Ec8HefSbCrcGWsSixfYx1qBQK2UBIUiy/eaktNTr2TqgKvfPyuHKCRia7tlqfx4fsY
	 EW1y/oUUxQwv61hKc5ELK7jwNs1EWUey01oVkFgvbWarAbpnUE7dwtI6GFquC96V+5
	 cgKgXPXyVuJ6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEC7383BF69;
	Thu,  4 Sep 2025 18:05:25 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.17-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250904155948.3679807-1-kuba@kernel.org>
References: <20250904155948.3679807-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250904155948.3679807-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc5
X-PR-Tracked-Commit-Id: 9b2bfdbf43adb9929c5ddcdd96efedbf1c88cf53
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d69eb204c255c35abd9e8cb621484e8074c75eaa
Message-Id: <175700912423.1902706.1910939035969095917.pr-tracker-bot@kernel.org>
Date: Thu, 04 Sep 2025 18:05:24 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  4 Sep 2025 08:59:48 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d69eb204c255c35abd9e8cb621484e8074c75eaa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

