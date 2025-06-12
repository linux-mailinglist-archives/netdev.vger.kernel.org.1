Return-Path: <netdev+bounces-197118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BF5AD7897
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 19:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802993B4273
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F241927146B;
	Thu, 12 Jun 2025 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzuN1yL5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C918C221DA8;
	Thu, 12 Jun 2025 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749747622; cv=none; b=gXIMrEswc4Ny2txTdlkGTaNi6QKMX6FWIS+joiNNcbrhOSc9efH/8u0w/CL1jMTBHmK/9AEKPZofyFPKY4pR3ONZ+Tp63ne8E8XoeNUwkLJ7pk9jBuL/hvUKcdm838jLfGLDm7MmYBR8vo6S5YPE96adOX5QVL5Y8reoeI0I9Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749747622; c=relaxed/simple;
	bh=e58juMLaxZSRqEt5bRKqd9VIVVEHt9FQG6PcHqFY8PA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QBRpMdJZeREvtsPq4UxgRPBV4WyOMfkozA2zsZstc7yUoHCt4dDwVQIZ2cZsGFJ1rcoUh9A98iuEYFsxkqFMAQCBvwarpq+eloQ9ORaioNre/mPwGvYMPh08MhNa+AL+iKJayJOw7my4aRB/ncy5jjbrELCzyrFz3q2+YeuD3E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzuN1yL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECBFC4CEEA;
	Thu, 12 Jun 2025 17:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749747622;
	bh=e58juMLaxZSRqEt5bRKqd9VIVVEHt9FQG6PcHqFY8PA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lzuN1yL5EoIQ90D5qO+zMQROKhixTdN2m7bU1gGt+tg3fTOH1BcqLFngIN2F7dpXd
	 FgGsA7zO0fIQ1eEe3RNnno/LSwu8t0cX/tFe0svSd/iSgHi+MtKVnTpsxh4DMqGpXz
	 lnLI4SltNvukmdP8doS4lMJIJ/xiCTSMuDz6C5TKJEN8iGgvHfpkSBHqaIRrr1Ydg4
	 g83S+KW7lwwCsH0zthEY2jyqHm7eqxlFQSDp2gE8XcVeOhuXa46mysFNk3SVmHSiUJ
	 O5UQ4aYEAjRi2IZJ1PXbzUfwAHYc9HTTHOq/0m3+8mMe2tYoArmZdkGY4E6ghEOqtD
	 YHdAR1wJa7h0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F0D39EFFCF;
	Thu, 12 Jun 2025 17:00:53 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.16-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250612164443.2565743-1-kuba@kernel.org>
References: <20250612164443.2565743-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250612164443.2565743-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.16-rc2
X-PR-Tracked-Commit-Id: d5705afbaca2f5b3fb8766391ca6c43105d229b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27605c8c0f69e319df156b471974e4e223035378
Message-Id: <174974765216.24588.1354890385250395965.pr-tracker-bot@kernel.org>
Date: Thu, 12 Jun 2025 17:00:52 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Jun 2025 09:44:43 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.16-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27605c8c0f69e319df156b471974e4e223035378

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

