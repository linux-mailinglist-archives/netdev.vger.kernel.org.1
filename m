Return-Path: <netdev+bounces-127943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3141A97729A
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 22:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB3CD2835E4
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 20:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39FA1C0DEE;
	Thu, 12 Sep 2024 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQJEMIwC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2641BF7E7;
	Thu, 12 Sep 2024 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726172118; cv=none; b=NrFb8YPcBuFtVcfYoEsn9jDEqGq7x+Aw+T7Z/O5bC3DV7ZoTjwFKh+xlxnjNjN83OUTPMtZl1c52ojed9tRRreGpaeKIPx0QY6UippB1uxwIwxujQ8gJL0ATIeDR4wgcFJLgfRDRWaSqa4bhYetAM1lSkpkJgG9DZ8h62FsPLO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726172118; c=relaxed/simple;
	bh=/OFhK1n6Fr6RoPyDTwFG2V2moZol0TlKxaV08MLNg00=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lfYGC0bbT/xj8YssjyQoTXL1vmgvz8qZlZGgiUxb1nqW5LcZpuIPuLlDnEvkdYh839VhFt5vlEiHh2h2nRDiC2DjckhRsDYY5zyAsQXYBTzWJyOFO7RflAdVVaOtNvbQYEFL90BoOUVEZPct65IrduVMk6+UBKtDHrdOUptug0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQJEMIwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77147C4CEC3;
	Thu, 12 Sep 2024 20:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726172118;
	bh=/OFhK1n6Fr6RoPyDTwFG2V2moZol0TlKxaV08MLNg00=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PQJEMIwCmX8P2tKuZkixHM6iFGGez1g6AHroQFV2GLQxZJ+HxqtH/hlPVQEpBnaSo
	 rKM+nYSPhqtr3LabaV+NV3MNcWonUuhnOw+V+QsRKJalvXTJGUTXwvDpJnMcZF/tGy
	 vjLX49L9Aa9DZ7paIjkcr9SNCaVkTg5BaEj9KxZGZ6eJwTOFASVPokcz2W8pMCDSe+
	 4p8jphBqhye3uOCxPffNWmtmviX+tdUxoItHnZQSYVMWT+pQwDWPzBAwlOUb0C87b9
	 rDn5iGkbuB39AwS/o9AZXiOTeAcLon+yNAD6G988a4F55b43zdiEchNOmmUA7kQ35u
	 4OTG6od/XRJqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB9353822D1B;
	Thu, 12 Sep 2024 20:15:20 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.11-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240912143205.15347-1-pabeni@redhat.com>
References: <20240912143205.15347-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240912143205.15347-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.11-rc8
X-PR-Tracked-Commit-Id: 3e705251d998c9688be0e7e0526c250fec24d233
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5abfdfd402699ce7c1e81d1a25bc37f60f7741ff
Message-Id: <172617211950.1705632.6073713942211372255.pr-tracker-bot@kernel.org>
Date: Thu, 12 Sep 2024 20:15:19 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Sep 2024 16:32:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.11-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5abfdfd402699ce7c1e81d1a25bc37f60f7741ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

