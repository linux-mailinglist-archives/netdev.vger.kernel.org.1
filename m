Return-Path: <netdev+bounces-209824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 857F9B11002
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 18:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771801CE773E
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 16:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57A82EBBA0;
	Thu, 24 Jul 2025 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Co1blXKf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F21C2EAB66;
	Thu, 24 Jul 2025 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753376199; cv=none; b=oJdIkQFYxB82Labq5BLUEPHzJn4X/pTJkeLDtv4ayUYsLh6Ji3fQvhevRZCSiWU/34DVHz6PmOwmDnsrL5ab++0dk+Rj5pALDhexBsYpTqdpG5XjLzlZwoylRchpqHcwiHhWn+ZgH9f4C4vlwkQ/YLYOw6HdcqlPnRmwx9TN8gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753376199; c=relaxed/simple;
	bh=E5g4zDzOOblZ7f+H86rvwgOkqcJ2Ozmff6PYJ0Z/ji4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SA2ZeUSSMW90tqL7LPNMlJfaGZLePbfjCuihFOvzJTc6mvI5e5/ZYNhXHwmn8DfJ+hRlCV3CVSbQIbHo//7Pktb9qJwnxX5xvVwNo9WBMpSWy7Zl/hFFYgx9RY5SyMwqSt0lOX+J2+7dm0nHRsEDh3bLIW48Uon1ao5Gzdas4Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Co1blXKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CD8C4CEED;
	Thu, 24 Jul 2025 16:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753376199;
	bh=E5g4zDzOOblZ7f+H86rvwgOkqcJ2Ozmff6PYJ0Z/ji4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Co1blXKf3TCxVeZzRtVybWsSKkqpHT4mN3n2UlMcD5VEXjWgsJC75lWzHsF3ovMKt
	 kCp2ToigAxxFxukHT4WSfcmNB3XFD5HfCuIONXlTU3/EMBTsGYOld5tR+VfWrvlnQ2
	 hfJnGtttuNx05tlSs490r83mYdW5Q5NYcBIZVEVQ8e0Y6Wn5v+UCSvRtLRMmIYnabC
	 GyROoDAfdQcN3aBuGuzJRw8EPhN+rPP85Zuidn2N6ydFD9tMBX1tuG5ig4aujgeWSR
	 oHwwx5x5VaCZ8A/wjjF+TC8weYnV3JA2YEMMzT5QxaXwpjnDqX3fJEpVoNbdD2qomw
	 ohiG8od08BA9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ED0383BF4E;
	Thu, 24 Jul 2025 16:56:58 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.16-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250724125859.371031-1-pabeni@redhat.com>
References: <20250724125859.371031-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250724125859.371031-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.16-rc8
X-PR-Tracked-Commit-Id: 291d5dc80eca1fc67a0fa4c861d13c101345501a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 407c114c983f6eb87161853f0fdbe4a08e394b92
Message-Id: <175337621718.2464257.5501815159843354649.pr-tracker-bot@kernel.org>
Date: Thu, 24 Jul 2025 16:56:57 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 24 Jul 2025 14:58:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.16-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/407c114c983f6eb87161853f0fdbe4a08e394b92

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

