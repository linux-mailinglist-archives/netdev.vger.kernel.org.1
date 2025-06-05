Return-Path: <netdev+bounces-195277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F89ACF2B7
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 17:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE41B3AEBEC
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F822750E3;
	Thu,  5 Jun 2025 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppSaaZT+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A3A2749F0
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136208; cv=none; b=uqKs9sbl3g5DIif9xhvQZ81tGcnyfApw4xmTt1DX++PP51ZELsm99zOIDOX+wQWYq5iW1h6nDyaMw85r99dqWnQmLNTED1Io82DmElsK5uPQbl3xEJC3TvRXfwrYHG9njDNbHge40QbsHTiBFR2lhBV6QRHyecJ+uGbjQWeo58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136208; c=relaxed/simple;
	bh=MND0zaRoHgUt2CNArAX4g2D3v+Z/Mw63xvl8W/7IrE4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aHNWU0BIwaU45vaxYUjpseaVeLNosrJzmY4mgUVsBHYSnbhI5jLsyqOjpAEWy+l+JIUSxmplQvH4EzqMkvceXBNbmmik6yOIxFJoxVG0JBadvBLh++j820v7qSZfhgP/Mc/CpGn9yC7iA1Y6ZPTOKccwWSPWhuil0rTfheKhaWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppSaaZT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A2CC4CEEB;
	Thu,  5 Jun 2025 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749136208;
	bh=MND0zaRoHgUt2CNArAX4g2D3v+Z/Mw63xvl8W/7IrE4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ppSaaZT+SDNH+7/tiqSU8wY9tQUbla7iIWhGe0SDzluiYkhxujlSS4WtrwN8Ky01o
	 vnjBO5mlwbKVhT/stabXt5Cz4mnHvek/9ryIFMGXEFz/7ZZiv+R89Lu8rD18tFCMlX
	 uGOSKCeM4C/BJpOxq4J5ZmYOHLazZtjaZdfH43/w+01VsDmkLuFU5o/tnQvwnwXkLE
	 jqw5NzMD4RtHYEzQAPplBEZqUzWfU1MLvIm/7iJh5mkAoAw+zG3OArAytq6MG2pas9
	 +sEdMw4KPbqqBzGq7XBMh5l1gvttVbs+TvgxjHM/HNTQoXY7lW5kZGWV/gx6FkC5C5
	 uFYL+NdF6zuqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3469B38111D8;
	Thu,  5 Jun 2025 15:10:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6][pull request] iavf: get rid of the crit lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174913624000.3108661.16952580622962815003.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 15:10:40 +0000
References: <20250603171710.2336151-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250603171710.2336151-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com, sdf@fomichev.me

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  3 Jun 2025 10:17:01 -0700 you wrote:
> Przemek Kitszel says:
> 
> Fix some deadlocks in iavf, and make it less error prone for the future.
> 
> Patch 1 is simple and independent from the rest.
> Patches 2, 3, 4 are strictly a refactor, but it enables the last patch
> 	to be much smaller.
> 	(Technically Jake given his RB tags not knowing I will send it to -net).
> Patch 5 just adds annotations, this also helps prove last patch to be correct.
> Patch 6 removes the crit lock, with its unusual try_lock()s.
> 
> [...]

Here is the summary with links:
  - [net,1/6] iavf: iavf_suspend(): take RTNL before netdev_lock()
    https://git.kernel.org/netdev/net/c/dba35a4bb4a3
  - [net,2/6] iavf: centralize watchdog requeueing itself
    https://git.kernel.org/netdev/net/c/099418da91b7
  - [net,3/6] iavf: simplify watchdog_task in terms of adminq task scheduling
    https://git.kernel.org/netdev/net/c/ecb4cd0461ac
  - [net,4/6] iavf: extract iavf_watchdog_step() out of iavf_watchdog_task()
    https://git.kernel.org/netdev/net/c/257a8241ad7f
  - [net,5/6] iavf: sprinkle netdev_assert_locked() annotations
    https://git.kernel.org/netdev/net/c/05702b5c949b
  - [net,6/6] iavf: get rid of the crit lock
    https://git.kernel.org/netdev/net/c/120f28a6f314

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



