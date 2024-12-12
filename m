Return-Path: <netdev+bounces-151503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8F29EFC9E
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 20:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D90A28C847
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 19:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1960B18FDB9;
	Thu, 12 Dec 2024 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJ+J+wbi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C6425948B;
	Thu, 12 Dec 2024 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032384; cv=none; b=jBoPwrBslJOiI1UVNtkwBn96IzIRkax2Ypdg99q2Hdp0JHQQ9qNy27326tI7efp6bNMHdaiBKc1TzvRLeNjkdJImLaHLRM0gYz6+wbMaWpsigBcx/+GvlX61DxuvvpXMAEHTFGIxLm+X89EYQBSEjV+JGOgu3UsqmVfoJbSRibM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032384; c=relaxed/simple;
	bh=JWYS5ALhAgqzXpQkGTU0FCGHTTihxg12b6d6jkH2b0s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TTXvRjfKZp4yDf0AMbKbK1zAcJ22wonWulmst6PFAhQUeFcrpbY/yMVb2RPtwfL3FfCfeC/tHAT1StDzvhiPeg5KRDJmnv4MDhDoS1TB+n//F41V95Zhvjnze3HHa1gVBio5bWO0ECV2QhYeiSbg9TxRuO3kIAwPuOLLxDJQgx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJ+J+wbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42B5C4CECE;
	Thu, 12 Dec 2024 19:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734032383;
	bh=JWYS5ALhAgqzXpQkGTU0FCGHTTihxg12b6d6jkH2b0s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VJ+J+wbiE3uNwwfTTOVh0KKoK+5h0LO2tw9jTGotTsjLBfN8VHzjx++hJljsyVpjh
	 OjSeo54Mq+Uk28Pog4bJNZShTMhtPZnFvXtm+N0bg3WILVTUPgg0Rp37w2E/xmQxWw
	 nj7qQss/4M4tpXd8MYOBE55u8LMJepGzLz1Ko0GS80OaIedxTRjkl9/t1Q5Q9jQlSm
	 C1YV8fgPpFqT5Gz0NwQPcrVEj+VE4KJd+rQHoWAb1t8Dy3aeMswfGge9vMo9v/MxE4
	 Lfi/zDkwXM3tQ76/upDtcANHJYl3JniazwSSEpL7xJzTpQMj7mdAeF/O8+QN6+TjWq
	 cI9ktgfJMQJfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34212380A959;
	Thu, 12 Dec 2024 19:40:01 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241212161437.3823483-1-kuba@kernel.org>
References: <20241212161437.3823483-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241212161437.3823483-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.13-rc3
X-PR-Tracked-Commit-Id: ad913dfd8bfacdf1d2232fe9f49ccb025885ef22
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 150b567e0d572342ef08bace7ee7aff80fd75327
Message-Id: <173403239975.2418467.15225825908653589423.pr-tracker-bot@kernel.org>
Date: Thu, 12 Dec 2024 19:39:59 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 12 Dec 2024 08:14:37 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.13-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/150b567e0d572342ef08bace7ee7aff80fd75327

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

