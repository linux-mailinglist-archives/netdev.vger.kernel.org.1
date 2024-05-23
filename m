Return-Path: <netdev+bounces-97893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56AC8CDB2F
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 22:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29AA2B2312D
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 20:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506FE84A30;
	Thu, 23 May 2024 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzYWjv9y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2899F53E31;
	Thu, 23 May 2024 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716494570; cv=none; b=si3+RFSvCs9IaD721CuQ/OApfaSeX8AAi//GgWSfycSI/bIBLUytURSh9BUBqFd47JRwwCMb3C/rBUK/4bRkRbXFFfIud6O2TbBbvbqCb8Dq/Hr7zvchMBcAsXHhaH0O/+SwiONnLWQ8aFrXiU7uPxlBp7vgSSmAebHv3yScu5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716494570; c=relaxed/simple;
	bh=OIjNckgATrIkeg88ERlWSV+GtAfRcUDG3/S8uGy05OI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OCmH3Sb0z2rksmkwmHzgNpLKNN8EUceStwRzMi+I0dSahWiqNqK5Ce1eZzG69VfPn33j6Q01McCpSAryNT/uaIJ9zaAYDL0cjxDcsevg0EV9uKDFGsfp+PzNdtAdqAb13hpwx+GBBN9D0ayJotDSKOecbsGtmF+bFgC8PZjIqfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzYWjv9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00B84C32789;
	Thu, 23 May 2024 20:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716494570;
	bh=OIjNckgATrIkeg88ERlWSV+GtAfRcUDG3/S8uGy05OI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YzYWjv9yu70vSqrJ2PD0IIz1XOK3FmmTZL0nwHl24X2V4NyG7AKjXyE6PJB1P2amG
	 qs4AadeIx66W6oz4wXynlA3orhqW5VDO/cDE9WQHUUdj6qdzDYeP/SQY3BbSokkRXz
	 +RZfcfqBoGPnO908RQMli+KRvEeXmLHLKHAyzwbpyU2g9ncU3kGuy5s3v7UCccjVZL
	 DjPJa9J1nLloro5e5QBY46YlYC0alcoIO+lQh9VU8bbBAZUgV4hQ0A53sc8xMlBPub
	 19YEEKDOfEGdglY5ySLMz1FVVI+Qbn5ShsAdgFvnejaa6DVYoVUNdjBRnBtu4DoLYL
	 JEx2I4n+s8zsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA05FC54BB2;
	Thu, 23 May 2024 20:02:49 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240523161524.82511-1-pabeni@redhat.com>
References: <20240523161524.82511-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240523161524.82511-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc1
X-PR-Tracked-Commit-Id: c71e3a5cffd5309d7f84444df03d5b72600cc417
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66ad4829ddd0b5540dc0b076ef2818e89c8f720e
Message-Id: <171649456994.26887.15819093666961155589.pr-tracker-bot@kernel.org>
Date: Thu, 23 May 2024 20:02:49 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 May 2024 18:15:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66ad4829ddd0b5540dc0b076ef2818e89c8f720e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

