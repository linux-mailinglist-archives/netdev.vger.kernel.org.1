Return-Path: <netdev+bounces-166208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EFDA34F58
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 21:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86030188D700
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 20:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0A52661AF;
	Thu, 13 Feb 2025 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3E6xSfg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89372661AA;
	Thu, 13 Feb 2025 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739478480; cv=none; b=SXXxa/wKSyVRik7XpgdCgi88vJt8A/RgF4A2cp4DL9Mi33Jc3NeQ8zUzd8HXIFiey7yrU27c/Yf9bYt6AtKtFuXxg535YhDaXYYxRkf2/bQ5SwLzLkXpqGzeAhw51qJofwr2ZkNaxFnmbWPVTSTAgYS3to0cP/yEib3daoX2QPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739478480; c=relaxed/simple;
	bh=woEAnN5qHgg1k5x2s7kNWKvRZITh01pEQ/xRYoEUVQw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tV66JgytxFErZZly6fAvCQvnOaXxxwnA37mKPkBfhC9h/rtF0FIrKHHqfAREMApfGGFXM93G+APhtOX3ZIQfadBhH4yW71hV58BuS3W8y24YJof8E4UMO9QxHvMXa75fPTc9eAuAJkIQ7yXRbnAy6paujXGQvoyEuSK7/hfTI20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3E6xSfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FABC4CED1;
	Thu, 13 Feb 2025 20:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739478480;
	bh=woEAnN5qHgg1k5x2s7kNWKvRZITh01pEQ/xRYoEUVQw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=r3E6xSfgXvacXTJMgccX7OM4LbRgOtRFYTjtjs7qdjar1l4ENrL7kxwnY5KTMrQWe
	 T8A+YuQj9S9zl+6cxo64Xq5AoR1hH2viKzLLa3tuaZRiumbEQGAxQIBBODZI1mk39n
	 MgfB5k1+nD2Z6xQPLOqnIovwKijClcGhDkJB9HDb+GQYxmnzGRWfkFZmmJIOt1hZPd
	 yV6otSxCoNiRCprlZQEvckuT2z69NSEBIcllpNyao/FbUo5kt4irB4SzE/N93sQI1V
	 QNjXVFJLXk7yi9sJ2by1+/UY0O5dSgxPZej/jt8JfeF36AM+KVpRGtOvZ2mXZKlSQG
	 Wkc/gSYGyeNLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C69380CEF1;
	Thu, 13 Feb 2025 20:28:31 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.14-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250213184154.793578-1-kuba@kernel.org>
References: <20250213184154.793578-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250213184154.793578-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.14-rc3
X-PR-Tracked-Commit-Id: 488fb6effe03e20f38d34da7425de77bbd3e2665
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 348f968b89bfeec0bb53dd82dba58b94d97fbd34
Message-Id: <173947850962.1363830.12470480110292956483.pr-tracker-bot@kernel.org>
Date: Thu, 13 Feb 2025 20:28:29 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Feb 2025 10:41:54 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.14-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/348f968b89bfeec0bb53dd82dba58b94d97fbd34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

