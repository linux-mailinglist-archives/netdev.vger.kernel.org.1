Return-Path: <netdev+bounces-234564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E21C2311A
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 03:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1EE218970D7
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 02:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B92331327F;
	Fri, 31 Oct 2025 02:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbwmK0pu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035E530DEA7;
	Fri, 31 Oct 2025 02:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761879138; cv=none; b=HJdDGXEcr6Op74QWBvKC3VLNYDS11nMc5K4L8BKDY8sMryScjIi5aEe9GaQmAhsfB7qZML0l1f7OJnQ1IlhYSkkvSalhZctu5dCApd4ZIKJPay7h1WfaW6xiEQHHoTLO8yw+Ca6ru5ASNrcUAKOuVaPJeWpiWaVDLUvvu08U3ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761879138; c=relaxed/simple;
	bh=c9TVPBkYB56PbiN2aOxIb7SkXkRWxXbTSPsAELb8EIQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eTshqntpgVhJf5Rapb7Hdb+4jFM2/oHEZB/cfkberEU7uNG5tZjX0CJw07rA5FJkw1XnGBhD1xa7waZ1OLlT4c6398uD0umK3HbIccZQyUerOn9Tn3N2PGRE4hRppN54OSHixfx0DAN++jyxIQXfOh57La3e4Kw/qsOdqUNtF7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbwmK0pu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1600C4CEFD;
	Fri, 31 Oct 2025 02:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761879136;
	bh=c9TVPBkYB56PbiN2aOxIb7SkXkRWxXbTSPsAELb8EIQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DbwmK0puG8C5uLZ7+VBAx1zYolgPcQeJpRDEA1NbdzFW0sJBDozJADUC4+ZzgZcn8
	 IXqVfLN0blAbGsAhdRtWKDgpOsppkb7cQIYZPD0HuvIBkEExuGABWS2mlLjoUiAq9n
	 EG2WPZYrMAQvf2/LjZjSOOMKxcgN8Hopk6RQdpC/9JC9XIZTRClCfkdb+kxaxUtlV7
	 xEWMYPxtjNVbA49DDEhX4iqet1TpCYZJwrP70e+z6vbABH/SpwkaJ3WgMHRPdMevzk
	 RXF+8tZQN/IeJji9ysYzJTkyue5QciizSg+cdTkpoDIr/jkJIWE+pWshodaBHa+boc
	 5ig6vfVwErQgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DFA3A78A76;
	Fri, 31 Oct 2025 02:51:54 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.18-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251030142415.29023-1-pabeni@redhat.com>
References: <20251030142415.29023-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251030142415.29023-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.18-rc4
X-PR-Tracked-Commit-Id: 51e5ad549c43b557c7da1e4d1a1dcf061b4a5f6c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5763491237ffee22d9b554febc2d00669f81dee
Message-Id: <176187911297.4119220.6145535436107037580.pr-tracker-bot@kernel.org>
Date: Fri, 31 Oct 2025 02:51:52 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Oct 2025 15:24:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.18-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5763491237ffee22d9b554febc2d00669f81dee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

