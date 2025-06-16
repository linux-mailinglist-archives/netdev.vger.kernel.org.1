Return-Path: <netdev+bounces-198294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB1BADBCD6
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 00:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D39516FD74
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF42224B05;
	Mon, 16 Jun 2025 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1TwYURr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DBE224220;
	Mon, 16 Jun 2025 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113024; cv=none; b=kqiDMOzyltMdcJ3TUSOJ0WfbhV2bc4MbL0FuSUCIhdKzbD2EShegwD0HIkLjq8l8QasbfuhxbyJgENbFNGf69+VUVetxMk/QCT825Rl8qyYZODRYiqo2kedrdC3E3CcGMobsOupxLSlEhTUCsclny8rR8Y35trINjSTqKuP+24s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113024; c=relaxed/simple;
	bh=d5BEqk4RRg8pwxeZeJbTJIGu5mltoynolT2xlZo7cF4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IzCA3lOfupB6INfdhuRnfd3+2DA7AubYvKU42C2XxZlYtz/9bLuvuEXjbH8tl+lZja/8nGBLS5SyigGoAKBe8SVfnAWFGEAETYFE/wAnNpBdEucaiDebCwTlXF+KnSjLgjBTMIoqhxXSsC3m4bQ3ub9XvWyAqwsFDNW86fPMOeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1TwYURr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7439C4CEEA;
	Mon, 16 Jun 2025 22:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750113024;
	bh=d5BEqk4RRg8pwxeZeJbTJIGu5mltoynolT2xlZo7cF4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a1TwYURrV44dJhZtr8NpQCDVdfm4rzExDBML5YS70dhoOFoStfJSPADds3VBW7As1
	 XvdIZ65ihLaFkL58VSmKTefFNum5u4AOGBMhxTaTKqFcZHxM0VeNnOXnzH9HFBY1Ad
	 SMxSodMim3aAd4OY5NOEd8bb/myJ3jDpVDjceC0E0+Arsq6BU94ypCQqMwbDE5ptyk
	 T3TgKITCydeTSIn8Fvesh/iaaGvvG6uRiSVXH0dPkv/DT2sCP9DqUgayJojhkS9fwR
	 YjUlbybgDDe6kbzDDSiFXCCPkpBqAMlApbBKvM0H/kUo+2HGmah/MioipFIhXJ91+X
	 hQ98owtU7mlfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD6838111D8;
	Mon, 16 Jun 2025 22:30:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/8] gve: Add Rx HW timestamping support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175011305249.2535792.11700277354646227955.git-patchwork-notify@kernel.org>
Date: Mon, 16 Jun 2025 22:30:52 +0000
References: <20250614000754.164827-1-hramamurthy@google.com>
In-Reply-To: <20250614000754.164827-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jeroendb@google.com,
 andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com,
 pkaligineedi@google.com, yyd@google.com, joshwash@google.com,
 shailend@google.com, linux@treblig.org, thostet@google.com,
 jfraker@google.com, richardcochran@gmail.com, jdamato@fastly.com,
 vadim.fedorenko@linux.dev, horms@kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Jun 2025 00:07:46 +0000 you wrote:
> From: Ziwei Xiao <ziweixiao@google.com>
> 
> This patch series add the support of Rx HW timestamping, which sends
> adminq commands periodically to the device for clock synchronization with
> the NIC.
> 
> The ability to read the PHC from user space will be added in the
> future patch series when adding the actual PTP support. For this patch
> series, it's adding the initial ptp to utilize the ptp_schedule_worker
> to schedule the work of syncing the NIC clock.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/8] gve: Add device option for nic clock synchronization
    https://git.kernel.org/netdev/net-next/c/db576b61e694
  - [net-next,v5,2/8] gve: Add adminq command to report nic timestamp
    https://git.kernel.org/netdev/net-next/c/e0c9d5682cd5
  - [net-next,v5,3/8] gve: Add initial PTP device support
    https://git.kernel.org/netdev/net-next/c/acd16380523b
  - [net-next,v5,4/8] gve: Add adminq lock for queues creation and destruction
    https://git.kernel.org/netdev/net-next/c/21235ad935e9
  - [net-next,v5,5/8] gve: Add support to query the nic clock
    https://git.kernel.org/netdev/net-next/c/c51b7bf84091
  - [net-next,v5,6/8] gve: Add rx hardware timestamp expansion
    https://git.kernel.org/netdev/net-next/c/3bf5431fef75
  - [net-next,v5,7/8] gve: Implement ndo_hwtstamp_get/set for RX timestamping
    https://git.kernel.org/netdev/net-next/c/b2c7aeb49056
  - [net-next,v5,8/8] gve: Advertise support for rx hardware timestamping
    https://git.kernel.org/netdev/net-next/c/a471e7f87e08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



