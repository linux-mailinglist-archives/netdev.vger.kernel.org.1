Return-Path: <netdev+bounces-187297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63154AA6434
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 21:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DB4C7A617A
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 19:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001061EB5D0;
	Thu,  1 May 2025 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gs6nsrNq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC196155A4E;
	Thu,  1 May 2025 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746128649; cv=none; b=rPMmzEtr+wNBwXwQMMc24zzyUmU18L1PRG6N3Di6sgoTXNjHmnTVj6ZGlFy+R8Jy08rrIOn+FTU5uAuFu+U/JvbqrGcdnOUZb8Y703UG0fK7723rE6wtrtePh8h4FM+z9yDaEZuw1VeU73iyQYTY+i2ygVy3IzQxumU8YiIuxfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746128649; c=relaxed/simple;
	bh=hEfvwceZhVZ2xipuy9vg5Pl698+RMBqyWbyWUYg+ZGI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XVnc3jh8kXO+i3VXTIFD2rp1vr4BCjadZ8yzRRt+797/MLZmipbugwmTJJvVD6n+xakttoZ7iQp9BOZTPh5Xq+uutvV2dxC4FTKtk+7YXNHspB2wMBphPlMHLilng7gY1bLtLSS4YTxk8vbrdb8es797wFD0Wc6mul14v3mW6y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gs6nsrNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92D9C4CEE3;
	Thu,  1 May 2025 19:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746128649;
	bh=hEfvwceZhVZ2xipuy9vg5Pl698+RMBqyWbyWUYg+ZGI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Gs6nsrNqcRygUirGRWD2GWPBr4iw/JlkFC8kdLufcdZdnDKQifJp77RFC9L+2yk6H
	 oztwXHJPrum/GSDcimXsPxVhMyeyMualrBrPmWnuotZ8CL+lLNINwn8ESrJmHPn4us
	 qNiu/1KCyIk6lBP9WSVOmoc6hdHx6BrR0/6CqexwEZwXs//ZToYLRHbhxSCzTmtTmN
	 dg9VuvSb0zO4/V5ogIHYsE8ijwyR5guG5QEbARig5YlhaSxTNWLrVh+KRCh2uNBRry
	 7SnghG50Jz5OOPP/iHr4JC3qxDxVzExjAEkqyLLbVKVnsGg2Zma3w4iKdj1+yFXZwE
	 k7zM4xbmxF3pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFB53822D59;
	Thu,  1 May 2025 19:44:49 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.15-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250501163717.3002314-1-kuba@kernel.org>
References: <20250501163717.3002314-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250501163717.3002314-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.15-rc5
X-PR-Tracked-Commit-Id: 1daa05fdddebc8ea5f09d407a74ba88f6d0cfdbf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ebd297a2affadb6f6f4d2e5d975c1eda18ac762d
Message-Id: <174612868860.3061282.8975302473841265904.pr-tracker-bot@kernel.org>
Date: Thu, 01 May 2025 19:44:48 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  1 May 2025 09:37:17 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.15-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ebd297a2affadb6f6f4d2e5d975c1eda18ac762d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

