Return-Path: <netdev+bounces-111833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4987893359D
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 05:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D7F284FA6
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 03:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D0146BF;
	Wed, 17 Jul 2024 03:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYeqepLi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818997470;
	Wed, 17 Jul 2024 03:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721186305; cv=none; b=VkCx0cA6GzvOhljB9yuuLVpbtj9diaMY0cl7egcIInR662fXH6BG0lS/yTb7UbEQNUUomU0PmLRBwd5NIx7NfHy4tq64B2ee8N3L1HRnq0jFV5+TcvKb7/jRR6OjxPqTsfPwzz4RNynDm6hklIP9JxmOuCkOMa3lG1ZhWl+rOpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721186305; c=relaxed/simple;
	bh=I8CQ0U3NqahQXeHjkloDUQhgs39lVV2fDrovWgcivWI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Eaq7nX4qqwu1dD+M+VeZe2lNCbwza2vQ/p/fWtDjyjdSPeh3P4ievOnW8d6gcWBNOIVpI6KkJTZWmIi3XpGkhPK0DD1z1EPH5B971PHgQdUti4jNmEhLg0z09NsTx1UYInpSwmn+6awBM/yIMPPIpnriZQVYaFdt71q7paywbOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYeqepLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AF1EC116B1;
	Wed, 17 Jul 2024 03:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721186305;
	bh=I8CQ0U3NqahQXeHjkloDUQhgs39lVV2fDrovWgcivWI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lYeqepLiQCgNez8J/Hm2mNsNEmZEzQdzK+ztVNo/O0RLyf79ZLypTz+ZxhQC5s1jj
	 YCIqL62ypgoeyZwOtFNh0bWYmrTbZMRJ4nj57XEZ3h6KNXvzOLhVx540EzEtLhF6jr
	 xMv8a3QibC8ZJj7hBWFYB4gusdzVr/Qk0Q/1bGxuzjWWEGQ3QEtn91MHTPF8jEVjyv
	 en6B5GBgv0CRw3jWE/OGBsw2veYvm60VujKtyEOFzZyW53Eawg01cdXv/lQ1lT2CzL
	 GSLlz47Nmo8U/Xf409c4JIjI9+TVNl7qoRkWIdMztmVDtAQ2UXrbsaygfp79Z6cRnt
	 YLTqy8QUjGVIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5058BC43445;
	Wed, 17 Jul 2024 03:18:25 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240716152031.1288409-1-kuba@kernel.org>
References: <20240716152031.1288409-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240716152031.1288409-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.11
X-PR-Tracked-Commit-Id: 77ae5e5b00720372af2860efdc4bc652ac682696
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51835949dda3783d4639cfa74ce13a3c9829de00
Message-Id: <172118630531.26472.14995872094367271844.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jul 2024 03:18:25 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 08:20:31 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51835949dda3783d4639cfa74ce13a3c9829de00

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

