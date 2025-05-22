Return-Path: <netdev+bounces-192760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A728AC1115
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 18:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA661BC7F8D
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAC128C843;
	Thu, 22 May 2025 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeL1gCn4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771DC289813;
	Thu, 22 May 2025 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931547; cv=none; b=KJl7RvIsnH6+2BU95glgXQUFHueGtgXlcW04kW8Sg+K6nVZy/ZLHavQHc2g0QAQ/uQ+MtzVoBtDEnnW68r4SjErOpaNx86l5zGg6W62VIJ/NRR8RkBwsLyhh74Fxw2g3+nABYHxnMTeZZ1cxyehJzFjhA3ObokfFBX0MAnC1KL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931547; c=relaxed/simple;
	bh=mhbNSiaGPI2xR0fPHIR2Bdfd1SX3Bd5NEMnZHVXgFys=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LtsIbG+MXjBWFgDgBRN+rSxXN0vRpCKJC5DklSGT2HDb+rpOsMqF/eXnIJmpLpPrfH4vhC+ZLCUiJHc4/RMEOUT9aExgn9LqEHm/nOSVJxVZHHLyJQOE16Yz/TClUbtlSAV9tfVvaDQzlwuWPgQK9DJz1PEr4inGOULDB+cFPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeL1gCn4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519ADC4CEE4;
	Thu, 22 May 2025 16:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747931547;
	bh=mhbNSiaGPI2xR0fPHIR2Bdfd1SX3Bd5NEMnZHVXgFys=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FeL1gCn4bqseltxv44TW+kQPZ/bOuAKhRP2fYgHWiTrSoaBIqPAbpPvL8HgYaLAIS
	 hZpCO1acLoD4UDGUnsqiICnsTPOul/iz1eVq84YxffWISAdVtxEZ/7SBXgr32Y+m6H
	 ErhCLYZx73WwUeIWVNbs4KLfYrw/MZgj7DRnsRdpJGy4KelKDrv4pZdbEDRXwgz8oy
	 Uw9kbAnapv53lLOwSJqsT4SGwyGh6jZZ5VGmOrmdu87TTx9syhd7vamsOReyP06ycy
	 VtrN8SD4hJLUCOj16FS80khPV5hFukxbYIxXy3XgWt9yEl3AvIOs15baVNCNTOCOFK
	 HJQH2mBLcwb+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB6DA3805D89;
	Thu, 22 May 2025 16:33:03 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.15-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250522132647.48139-1-pabeni@redhat.com>
References: <20250522132647.48139-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250522132647.48139-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.15-rc8
X-PR-Tracked-Commit-Id: 3fab2d2d901a87710f691ba9488b3fd284ee8296
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5cdb2c77c4c3d36bdee83d9231649941157f8204
Message-Id: <174793158262.2940668.6502947880058669778.pr-tracker-bot@kernel.org>
Date: Thu, 22 May 2025 16:33:02 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 22 May 2025 15:26:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.15-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5cdb2c77c4c3d36bdee83d9231649941157f8204

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

