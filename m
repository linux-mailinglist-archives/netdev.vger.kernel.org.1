Return-Path: <netdev+bounces-112271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 097B1937DB7
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 00:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8841FB213FD
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 22:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF75147C87;
	Fri, 19 Jul 2024 22:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hV+YPMWv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97476AD2F;
	Fri, 19 Jul 2024 22:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721426646; cv=none; b=RhZcRM5OEskY4tAc/0YlRDRKLzSn/11g6Nme7mXCqhbmtNG6JaR/UQs2L/es/dEJIt7buURoR/VEAG2VC5e+ppIadflcmvp8zyRvih5n1eAfSI68yNyYG0PhVscbtsyHSzOBiawQxZZuJQ0+XMVtz9szqCGjGH62J2hY/I6uyaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721426646; c=relaxed/simple;
	bh=3Ug3s6+XQt0ZmfBgqCe7InCCXjeqLSy2VbgIDUyQrsc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JOH8YeYWuRMQJvS15u9CdqhWBbwta0gLlZkNb2ZH81i5e/ijBLnkU9jlsGlNHawDEZWxYt/LgiI9Nxnl6SpcQ+9xCCJX5XBFFRJMpTGXGwonEK4J8HgyfUQykqEh9tKVU02xlHYV24BLSufsvDt8crigO2AWLoIx0neeP4LeXjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hV+YPMWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E26BC32782;
	Fri, 19 Jul 2024 22:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721426646;
	bh=3Ug3s6+XQt0ZmfBgqCe7InCCXjeqLSy2VbgIDUyQrsc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hV+YPMWvcJYAvttBcvpUt+4/P0vdv60Xf/lWmQAp82G0IVJV4/tuGU8EUkm8blYgG
	 //KCXbTj7Ftt2P0muhgHPsIeg4bwPpYBue+sfqJVNHXczqbqkshtNmNcgWAh7j3WlP
	 1OPvfEJo8wzEXsdq8N+dx0UFPXwWQp1kxvPElFIOY8kaypPrD1KXMNvKU2uq3enh5T
	 MuxsYsRPQKJMZnBTUwsgO0esa3sPz8uk8sI3CDfRu6fQdeDYDxAoWXxqFp5L76x/tM
	 rtkuO9CctDic/0u4A2GKG+O4VQxpm9K2Ekop12XW/cSCa3JMOxi7C7OcrZsHmtXq9p
	 WX+Zdz0KNho6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 634E4C4332C;
	Fri, 19 Jul 2024 22:04:06 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.11-rc0
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240719161638.138354-1-pabeni@redhat.com>
References: <20240719161638.138354-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240719161638.138354-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.11-rc0
X-PR-Tracked-Commit-Id: 4359836129d931fc424370249a1fcdec139fe407
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7e78951a8b8b53e4d52c689d927a6887e6cfadf
Message-Id: <172142664639.13042.11435996253239343247.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jul 2024 22:04:06 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jul 2024 18:16:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.11-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7e78951a8b8b53e4d52c689d927a6887e6cfadf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

