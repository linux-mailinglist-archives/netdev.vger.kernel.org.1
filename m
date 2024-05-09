Return-Path: <netdev+bounces-94976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD1A8C126D
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 18:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353AC282836
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 16:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB51A16F826;
	Thu,  9 May 2024 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXIOy4dB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C411C383BD;
	Thu,  9 May 2024 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715270911; cv=none; b=T+05vbZ+to9jhnOJAcnamSyuu3fsx80kVi56XmrSEXyAK6q7dYU4tpQ7QE8srE4sLrCJ1ZBvTpULGRJBJsQrTpKRAmwZfouQHhgMCIFmDSYBFg10Ea/wvB6buQ8IAuW9zl38cmrVjiIYw75NZ6GT/SbBDeBEHDcnwnmUzIOoiI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715270911; c=relaxed/simple;
	bh=MYR+CFIkGzihpDWth62ZkNAsHCMsoZA6XvVass6Oiqg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MezW4iFpdZnujGcs9Qu8UBOrlUqmvZE/06MpGoQNESHsXXPQTFu743lKfdT0/xVkn2J22wEUqP18BLbFww7c2j7mcKUAnWsjDDcP5Lc9Yu/ZMexyrUT0dbDH6SakOkQ3ecJwhLTdMN/a/8+aBImvxjCFY4S8k3CbSfOKormn2U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXIOy4dB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 452E6C116B1;
	Thu,  9 May 2024 16:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715270911;
	bh=MYR+CFIkGzihpDWth62ZkNAsHCMsoZA6XvVass6Oiqg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bXIOy4dB/Bq8t+bicf5ZobqC1cejuvCpiNj9MFOIvRIUKBkcC6tgih4b3pLjGp4lJ
	 YzBmCb7spm6TD68uFIHgtagsxf98oAKSQ36WLLf34T4wZp9u+KFtniyWQFAxxuLELM
	 hzK3kQ3WfzqWlFCAwf27gpgQhJXzWznq4xsbatPozOr6EeWakpzRev1CHHhYWN/gyG
	 ekdF5DuKYN3NHMqLWGk4sAM8uPaJ2cg/49RyRTgALmWLTp0yW56MA1NH0qH/+ERf/G
	 dthAtUXdlGZUlKsBJ9ZpW0FAIG9rEMNBQUsfB1dosbXygqhnw8PKDJpMQCFwyn8o2y
	 +XQD1g27mWxpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3CA3CC433F2;
	Thu,  9 May 2024 16:08:31 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.9-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240509115411.30032-1-pabeni@redhat.com>
References: <20240509115411.30032-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240509115411.30032-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.9-rc8
X-PR-Tracked-Commit-Id: 6e7ffa180a532b6fe2e22aa6182e02ce988a43aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c3b7565f81e030ef448378acd1b35dabb493e3b
Message-Id: <171527091124.25065.14713515277010029379.pr-tracker-bot@kernel.org>
Date: Thu, 09 May 2024 16:08:31 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  9 May 2024 13:54:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.9-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c3b7565f81e030ef448378acd1b35dabb493e3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

