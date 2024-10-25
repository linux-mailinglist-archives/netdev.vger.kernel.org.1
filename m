Return-Path: <netdev+bounces-138906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A81F9AF5FB
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 02:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B9C282977
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 00:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8727710A2A;
	Fri, 25 Oct 2024 00:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqHmFaZi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D86B10A1C;
	Fri, 25 Oct 2024 00:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729815587; cv=none; b=US8j1vZzphQqtxIgWlHXYgDZMwVCjv7cDX9pmzY3so9+N8fN9mef9vHB6yJr39CMGPKsW5AbiYJeNkVMYO5G831hTAD+eEOJPzLCpGsKlvrhHnmACTiKOLDdE5g24msikBFwv2cCaMRaLz8/+cUmlJsgcu6cA3JdO6w0HJ3+oFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729815587; c=relaxed/simple;
	bh=jBI22xMB8tnMiHQ8gd+4Ci/IQv4VdQCNPl9iH/XNv10=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VCrtqF9DpT70DCAgqbEaKZqHhZJ4TGPYLMG1kjM3mbjn2XchW9zlEV9a21Fxt3sEfK1LvgwwTwTS49WEGuDm/lWlMqwnGeOeBXo/Xkq2RmBDv6B3egThP4WE/wCrMX+Jh1suLLGXzg9OETKoKEhmd8pLYodGj8mxFuPrJo/nnxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqHmFaZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398B0C4CEC7;
	Fri, 25 Oct 2024 00:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729815587;
	bh=jBI22xMB8tnMiHQ8gd+4Ci/IQv4VdQCNPl9iH/XNv10=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GqHmFaZi2jtgwqPgUutFzhRPZLneUxNEj/a5XtnTMzbJXY/IPmh5/bnHJhRZpvowB
	 3wR9wUuJJEKLTUv1lomLFJl7Q6L+2Ok2F3q2DB/kWC6VztR6680xmtBsg+isvw/biy
	 IdaP4V/CsvXd+F2fNkohN3TeBKEToIt4pBIDlWfZxdbx2Ey12cejHMC1j4O7jma1Lb
	 H8TDgkvzIpzcyBYX4czZJlzXjJotZzVUSOKz4GuvSiLknyNftNdbRve2P0LtPnz/Oq
	 7gm+p1lmnYjBzq9I6Rz2lELvZxZ4fmyyALXSXMV/2IkCjvi5P2nD86D9d5ZXNaKVYx
	 3BatS4a0fspYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34E9F380DBDC;
	Fri, 25 Oct 2024 00:19:55 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.12-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241024140101.24610-1-pabeni@redhat.com>
References: <20241024140101.24610-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241024140101.24610-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.12-rc5
X-PR-Tracked-Commit-Id: 9efc44fb2dba6138b0575826319200049078679a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d44cd8226449114780a8554fd253c7e3d171a0a6
Message-Id: <172981559366.2421084.4779649980040390820.pr-tracker-bot@kernel.org>
Date: Fri, 25 Oct 2024 00:19:53 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 24 Oct 2024 16:01:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.12-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d44cd8226449114780a8554fd253c7e3d171a0a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

