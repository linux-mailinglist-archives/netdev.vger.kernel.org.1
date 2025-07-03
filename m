Return-Path: <netdev+bounces-203882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDA6AF7DEF
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 18:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B78F1C83C4B
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 16:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC242580E2;
	Thu,  3 Jul 2025 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeFrJhOB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FA5257422;
	Thu,  3 Jul 2025 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751560240; cv=none; b=P2eBL1x0cUounVyFTQFyeJT+eZxTts4ixNM3DnBPctzbowiDtR0NODEI2ilQywHhyoQge31z5K9EuqiEj6Hi8PiE0UtZINorbuSp/3DI0cbD/UqeIJ1cHEV3UfbO0j/e5PMb2IBo8DcQS4tiHouwoi9koL5tr2nETSVLpvkPf3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751560240; c=relaxed/simple;
	bh=O279xNs8YrIaFUCyk/pQxFUpUexGzNu13mGsgpBqY/M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rvuVXXJp18JB0YEIV+ivuCj8gpTg7PydXBN6dZijKNtHD7JXJUDhPTvKxX6aaQfS7FYREVF5l5A/LrUNsHAwgTi5GDc9gBK731W+3wJo0vPf3oFaGWNp0aaAdygF0spAeE1X/WZdgG5e26g/UgfEh8jzO7uFYxWdxXTKIHNmALk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeFrJhOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F25C4CEE3;
	Thu,  3 Jul 2025 16:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751560240;
	bh=O279xNs8YrIaFUCyk/pQxFUpUexGzNu13mGsgpBqY/M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PeFrJhOBAC7whUVO4ha7XCIIcbPfR8uLS16/+VARK/c1Dl+jMva3R2QEKLIUB/wxl
	 OUiIG182daYQSpWC+GAu5vIZZi5zGNPV2gLhqCVA01vlcRd5B1fZW5DwvmqcFpQym3
	 i4lIru3DNQvxx0IUmrzUqebIFViPqnRPCaDyDyvkc9q2XBu9hMs45vqE/RA0Lg+7Tt
	 lrbHUEN16XtrnRa/jWRTeGTxoHA6WT/W03Q+cu5/r8bwfwyx1iF9x6KHphUDBdSOOj
	 NMiRFF2JDIKjTV8sFF9pCDNMzhkjmIRvJl0g7jT4T/gVmc/bZl4sVMLNgnVUMqVmIa
	 QIXcgnyIoXVcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE288383B274;
	Thu,  3 Jul 2025 16:31:05 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.16-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250703132158.33888-1-pabeni@redhat.com>
References: <20250703132158.33888-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250703132158.33888-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.16-rc5
X-PR-Tracked-Commit-Id: 223e2288f4b8c262a864e2c03964ffac91744cd5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17bbde2e1716e2ee4b997d476b48ae85c5a47671
Message-Id: <175156026439.1548768.2368770173056020475.pr-tracker-bot@kernel.org>
Date: Thu, 03 Jul 2025 16:31:04 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  3 Jul 2025 15:21:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.16-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17bbde2e1716e2ee4b997d476b48ae85c5a47671

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

