Return-Path: <netdev+bounces-158986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B9CA14071
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 18:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ECCA167DFF
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA8C22D4C4;
	Thu, 16 Jan 2025 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+r2N8Hq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B522922CF3B;
	Thu, 16 Jan 2025 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047631; cv=none; b=AHlr5X6C3eGTeQN4TVCYVTWtL6xdc6ygm6jxm7LaKk88+MJgHfntRZRJnbIZ52rUs1+Lr1cl+0dOSXUql0MNE06LslG5IGmKCTNxuF6LVe1ha5TrKk4odQ0qkboryyy6fOCQoi/QX4rNOyDfGMmYTKG/4q6qWZLNXyVTgfQvM7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047631; c=relaxed/simple;
	bh=OqDFn4Doo4sjMH/E3IkZnefGfk0NEfdqGvLT7j55bFg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ooCZZzauzFkYuKBrdqafuL9OhBFQmHjXjjWVItkdLDevvF/BdXqhvTRhDhEvarHKyagwUi90SF4trGFU2o/0xgwK51W9bOTdJPl4cxrFv62430hSLEH5ZZ28kz10y4H+MGi/3My1YOzLbn3XGihj15wR2wxyGYcQaMa5LL/hjx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+r2N8Hq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968B4C4CED6;
	Thu, 16 Jan 2025 17:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737047631;
	bh=OqDFn4Doo4sjMH/E3IkZnefGfk0NEfdqGvLT7j55bFg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=o+r2N8Hq3ddrDxjFKy8CkYD0mVOxdRNwnI/v3Ey1njVL4ra3KFb1ukDqnueYOm9gn
	 MHY2PQrlNqAfoS2HoGpVfe4J31PxLYTLkiSM+85Q/27WFjPFF3eZJcnModIQhgzTz7
	 G2x5krM6L9HwC9eogzY8UiJfwzEPNykKE7pTaiCCbNx+AZne+lbzkP9hEpSw4hMYgC
	 xRZBpsmMENICQVHumPs2ottzFKu+XExhyreAeyW3WR9Yb3i2qqh33MmyDN17fb63qV
	 4pQXdz/ryP5LvjeMvc1aw6DzdOHDVsJHcb4Lt0/qMv9VfYWr9EFkfoLD2x9AQXIyb7
	 GKiFzpwsj8Qrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB8CD380AA63;
	Thu, 16 Jan 2025 17:14:15 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.13-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250116144619.40965-1-pabeni@redhat.com>
References: <20250116144619.40965-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250116144619.40965-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.13-rc8
X-PR-Tracked-Commit-Id: a50da36562cd62b41de9bef08edbb3e8af00f118
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce69b4019001407f9cd738dd2ba217b3a8ab831b
Message-Id: <173704765452.1527932.12141926384174401387.pr-tracker-bot@kernel.org>
Date: Thu, 16 Jan 2025 17:14:14 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 Jan 2025 15:46:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.13-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce69b4019001407f9cd738dd2ba217b3a8ab831b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

