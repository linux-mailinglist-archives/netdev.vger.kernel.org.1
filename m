Return-Path: <netdev+bounces-218348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8294EB3C0FB
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 18:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0ACC3AFF33
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 16:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E842335BC2;
	Fri, 29 Aug 2025 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVABIDad"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587C3335BBE;
	Fri, 29 Aug 2025 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485573; cv=none; b=Wqdoh2SGL+2qO/XokZeIUHHhOy55qS4IXhh12cStrNFzYikoG9X6/lNcAVejg2VdnyjTNnXv7CC95AvumJwVh2s+scRjTGGrvy0OFxYvmnwQWfV7PL8bpJdr3b+8St6YstkOFBHnexxmKQ4zZ5/A2dkJ4U64qb6xVN0zpQd7F8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485573; c=relaxed/simple;
	bh=bWhguzLHK7hoj+xRZ1wK5l2zxEDm4LPIKRfZ6x+QEg0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DaTFRt4D/B9j9x6n6ScZQMg2DiOGx0zCBzk9hSR7fsO7a0cRHmYxBsvrUveopPHYXZgdKk1VCpo/Kl/XejW/QMa569VPSSA3JIPXKs1mHhuRcpk/ZkWPVFEuWMyA9lN2mWq36v8u0ZxMpBq6s4x5mwLuZwQmSoUtWmfIiAGggSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVABIDad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39083C4CEF6;
	Fri, 29 Aug 2025 16:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756485573;
	bh=bWhguzLHK7hoj+xRZ1wK5l2zxEDm4LPIKRfZ6x+QEg0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GVABIDad5ODUFjuasxp/TgwedagTd21AHA/JTzZTo1v9V+OD0Kv6Vm66ET7p7TJhG
	 zK13b6QFqZle6S2DICg5w7AWiOb1huHJcWz8DGzBpizovgG12MUsFmwhRi84D7Bsu6
	 G/1mga3+wzZMmWB6fR38VOmImy9j80E465FUiAq+9uXy6SXdUKb4UMXUccmqR0/neQ
	 gE0MfUuVnPdOUitTQqH1Je5TBfdsMlnqwLQeH+BUnwO6avKrEEI5QSq2PpuhYuMxRN
	 9ccIudbWTbqB2jYlkz++38u7y+EjOJ4J0KYlX4C/eLOWyerQUxX5JfqrhQczDq+32D
	 9Ijk9CA1BVpEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34CC7383BF75;
	Fri, 29 Aug 2025 16:39:41 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.17-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250828105330.27318-1-pabeni@redhat.com>
References: <20250828105330.27318-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250828105330.27318-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc4
X-PR-Tracked-Commit-Id: 5189446ba995556eaa3755a6e875bc06675b88bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c736ace0666efe68efd53fcdfa2c6653c3e0e72
Message-Id: <175648557986.2275621.6670511814922677043.pr-tracker-bot@kernel.org>
Date: Fri, 29 Aug 2025 16:39:39 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 Aug 2025 12:53:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.17-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c736ace0666efe68efd53fcdfa2c6653c3e0e72

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

