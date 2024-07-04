Return-Path: <netdev+bounces-109313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 788FF927DE5
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 21:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 055C3B23A89
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 19:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C724113D63D;
	Thu,  4 Jul 2024 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dK9zDCDH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC0513D51B;
	Thu,  4 Jul 2024 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720121818; cv=none; b=dqLrKdg3B/+/uI0f0wa5r2KaNHGZvCTTevziH4sJ+whIzy3Z9jukpfIkKadQyJoZRhmBetU2u2rW+wULJdS6tKS0WQc6cvcVo/AKWqfQUeS5loyr4hj6MLQTxUbjNidKP2Kh3xVsqWD7fIKmiAe4hkpvmT4QQB4k+fWRazw+CME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720121818; c=relaxed/simple;
	bh=Gh41B6xAP02mSWucqKce12LyiVTGrqeEtj4ohSZXv6g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tDeQmN4icmCi32uxH3euBgNVImNHU5MEUm5CHCFccxDuhpwUtvKB4PwgjhwSR7WGDGXsuAoU3zjK3sF/X9dQnIAyp8noOuobTxrwDs2G7GYupsO+Z6P3xA0o/QdJAHI2I+Faz22uIXEw49JpXWGs8LLHElnP+zGfMNIQixQkQRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dK9zDCDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79551C4AF0A;
	Thu,  4 Jul 2024 19:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720121818;
	bh=Gh41B6xAP02mSWucqKce12LyiVTGrqeEtj4ohSZXv6g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dK9zDCDHpMDfMX8xbCPq0RreRleAUPf0vua6M1L0OSumoDOgXO8ugNLSYWncuYZ25
	 fISALbS7HAyz226r5tR2hbjPIQheiPp7Cl9j1BD5UqZW7IzAW/ZHLdvf8REI8u8Gxk
	 wOVlzFr7pI3RWXILlSI4hyP1tWG9eLi/LXtk68AG2wKl/Ap8OsVhHlTg/ZKAGDPkxN
	 vLT1vmZJezH9uoUryaViMUIWKb8VZZQotSwMSNpeYHcVQxW4v7U9c+635uPqfotGIG
	 QFt23oR70swv6m+KFqFve3wjOHW32kMiOKc6SkeldemNiqi83CxrMax30fIa2ue6ip
	 f7o6PxqLJxAyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FF16C43446;
	Thu,  4 Jul 2024 19:36:58 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.10-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240704153350.960767-1-kuba@kernel.org>
References: <20240704153350.960767-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240704153350.960767-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc7
X-PR-Tracked-Commit-Id: 5d350dc3429b3eb6f2b1b8ccb78ed4ec6c4d4a4f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 033771c085c2ed73cb29dd25e1ec8c4b2991cad9
Message-Id: <172012181845.16688.7831665729645074140.pr-tracker-bot@kernel.org>
Date: Thu, 04 Jul 2024 19:36:58 +0000
To: Jakub Kicinski <kuba@kernel.org>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  4 Jul 2024 08:33:50 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.10-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/033771c085c2ed73cb29dd25e1ec8c4b2991cad9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

