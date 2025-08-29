Return-Path: <netdev+bounces-218042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3893BB3AEF7
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 02:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790F81C87091
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF4A53A7;
	Fri, 29 Aug 2025 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agrvXAPJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5879BB652
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756426217; cv=none; b=BbYRzsyMNObfwEXON7FFCRyzlU6yGzogkbUBxUJ5KvVlmlR9+xts/81dI1RLBRgGb0d5NWwsajnwMA/86rnAfE+3pkfIWVgG7RIMq5wPKduZhfDRiV6dg9+VAoR9I07z8yHz/FBlVWfD9CQRp8Qi2m3PJLrnI8AgRiSscVSqdRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756426217; c=relaxed/simple;
	bh=hONIgUn90JXmtJ/LcCcjDjmw9IerACNZrgqP7w+2R6A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZPpQcBZ2FSkmPiXCAcVGK4dG/XVwKb/KjKFfBTCABe2GyQ5+c/0aiAAqupgvg7zRCqRFtAm7Nk414mAZHK7R2ouFMjGw9PcElOvkL9hMNY6Vr5pJa97I4aDU2JOn2sYegdi6kDfVBwvEJJL+ll68hpsUfdjN500AAtAtxjcNTwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agrvXAPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD45AC4CEF4;
	Fri, 29 Aug 2025 00:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756426214;
	bh=hONIgUn90JXmtJ/LcCcjDjmw9IerACNZrgqP7w+2R6A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=agrvXAPJpDuYO79Ew3dDuzbJ/UVmBofwsUOyugDhdXn98gG6h0n3FmF1K6etyjEOm
	 mWhg7BIqN72uZ0e39n0Cl3nwIBsF7051Zs+2+mq9UjRPTvS3bHT0Veqwa/ajVi9gsd
	 sndGV+QXIyS8+t6NQTHANwIM9iuCtESNuBcCf1iW68cAPsisiHXSqNHt/pNC5QVIoN
	 +YbhFB8aqfe/D3PgaW3nuzGJ82ebsGd4f/Mt/GmMpgmUym5/Fj+V/pLSu7jDBWlOcm
	 ZPHuBpzbP2qCYmS1uoc0LCcvEFch8ifEGJu8ev4meVotePVGvDjPbmc+ICjfzinmak
	 7MD/U0ZmRwzBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADE5383BF75;
	Fri, 29 Aug 2025 00:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/12][pull request] ice: split ice_virtchnl.c
 git-blame friendly way
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175642622175.1655896.9938957913462315548.git-patchwork-notify@kernel.org>
Date: Fri, 29 Aug 2025 00:10:21 +0000
References: <20250827224641.415806-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250827224641.415806-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com, gregkh@linuxfoundation.org, sashal@kernel.org,
 kuniyu@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Przemek Kitszel <przemyslaw.kitszel@intel.com>:

On Wed, 27 Aug 2025 15:46:15 -0700 you wrote:
> Przemek Kitszel says:
> 
> Split ice_virtchnl.c into two more files (+headers), in a way
> that git-blame works better.
> Then move virtchnl files into a new subdir.
> No logic changes.
> 
> [...]

Here is the summary with links:
  - [net-next,01/12] ice: add virt/ and move ice_virtchnl* files there
    https://git.kernel.org/netdev/net-next/c/5de6c855e23e
  - [net-next,02/12] ice: split queue stuff out of virtchnl.c - tmp rename
    https://git.kernel.org/netdev/net-next/c/1948b867c1cc
  - [net-next,03/12] ice: split queue stuff out of virtchnl.c - copy back
    https://git.kernel.org/netdev/net-next/c/879753f3954f
  - [net-next,04/12] ice: extract virt/queues.c: cleanup - p1
    https://git.kernel.org/netdev/net-next/c/ce5c0fd759c6
  - [net-next,05/12] ice: extract virt/queues.c: cleanup - p2
    https://git.kernel.org/netdev/net-next/c/3061d214eead
  - [net-next,06/12] ice: extract virt/queues.c: cleanup - p3
    https://git.kernel.org/netdev/net-next/c/cfee454ca111
  - [net-next,07/12] ice: finish virtchnl.c split into queues.c
    https://git.kernel.org/netdev/net-next/c/c762b0a537ac
  - [net-next,08/12] ice: split RSS stuff out of virtchnl.c - tmp rename
    https://git.kernel.org/netdev/net-next/c/f4e667eb2ab8
  - [net-next,09/12] ice: split RSS stuff out of virtchnl.c - copy back
    https://git.kernel.org/netdev/net-next/c/2802bb558e08
  - [net-next,10/12] ice: extract virt/rss.c: cleanup - p1
    https://git.kernel.org/netdev/net-next/c/4c2ce64efd0d
  - [net-next,11/12] ice: extract virt/rss.c: cleanup - p2
    https://git.kernel.org/netdev/net-next/c/270251b946a9
  - [net-next,12/12] ice: finish virtchnl.c split into rss.c
    https://git.kernel.org/netdev/net-next/c/e0d2795ab48f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



