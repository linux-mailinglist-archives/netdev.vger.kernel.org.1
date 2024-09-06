Return-Path: <netdev+bounces-125765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7265C96E822
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 05:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0B47B22937
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 03:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704BE7FBD1;
	Fri,  6 Sep 2024 03:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFMFha2I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4879F7D3F1;
	Fri,  6 Sep 2024 03:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725592812; cv=none; b=A+FBnQL6mlV6vJDkkzAYxiVwLDDl8td3F1Xu/rJdQfHaoHPh2YDm3xDmcB9RHL7sT2B3mNLKDWeCI+CHc0Pln7A1gZIoFGDkPScVMu/IXLhfTy7NX3fdLm2yCFvBYDvK8p6odPUHR6o2JJ1kdGiOoV7izUQpGBf78wkYc3nfXSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725592812; c=relaxed/simple;
	bh=WP/S3K8BBaz0nWu9GG6RTR6S17IAlIp/Xy0dMLbRizo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DwrDo4RpsPFgwMC74AVB9sVgKPchuGDp4i/gMYtDSMMkTfg37RRjTC+YYcqbq1wX0JJuNFNOl38gP75O4iRzKdh5q8RLm+2Vc5htvtk7XENzod2JWicJsZT6TnJdvnAIoAl8N2OFkyDEghXebeKJoHsAWvoDjWOIDFqMILV31hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFMFha2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC84C4CEC6;
	Fri,  6 Sep 2024 03:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725592811;
	bh=WP/S3K8BBaz0nWu9GG6RTR6S17IAlIp/Xy0dMLbRizo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CFMFha2IO6ZW4CEOHttJHA8tWRwPKQu4ljMSO4F8rqNX+HS/YBu6gF3UJxs7f3/0V
	 2PV1aWcING4PKKghj+2IdEHLrvACqYI+U7P2UPWkHjBUI51ulw+LCy2VNaJh4dP4Ep
	 sV7wjJ62OjOJUW/7WoyewzYbh8w50rl88K51W5Mq0lr5P6QZTuw87dDV4gGcrOSStF
	 gcyuqHkYezdpiKbgKhMnGPBNF746uZvhEoJXIsmtnA/mz9g2ZVngYDJGaY/mZ7jkP6
	 t88+m5kYHsi5KzzvouD1ZlOYiuwX2SDR28CKmnqIKYQoRZ9LM5lfL6qlBcYs2P5Q0i
	 EYxOYs7oh51hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC19A3806654;
	Fri,  6 Sep 2024 03:20:13 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240905224537.2051389-1-kuba@kernel.org>
References: <20240905224537.2051389-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240905224537.2051389-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.11-rc7
X-PR-Tracked-Commit-Id: 031ae72825cef43e4650140b800ad58bf7a6a466
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d759ee240d3c0c4a19f4d984eb21c36da76bc6ce
Message-Id: <172559281259.1917326.18048086809716116556.pr-tracker-bot@kernel.org>
Date: Fri, 06 Sep 2024 03:20:12 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  5 Sep 2024 15:45:37 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.11-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d759ee240d3c0c4a19f4d984eb21c36da76bc6ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

