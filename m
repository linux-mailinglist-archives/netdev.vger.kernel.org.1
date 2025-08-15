Return-Path: <netdev+bounces-214137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EC0B2858C
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A5F600C2E
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762801E51EB;
	Fri, 15 Aug 2025 18:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtOhg4pt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52457317710
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 18:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281339; cv=none; b=bzdBpOT69ZAi1jYHSF3Ac59JhERvUMrwi2P3IWRMLVOQh2fYrUPRpeTzibiMYrHnjCNgmDRckj2QxC7cDCYMh01QeRgWZL7RQGoLWEwuf6MrIc/e1mCG6F7tmeiAHuARpfKdzzZj5dBvQ8rV4auqTZPVbqZS8jEoRjU061W8m9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281339; c=relaxed/simple;
	bh=oocrOYmjQrnWef3Ueu+zSgsyTbFsYX1546ToFhsmQck=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fOKtE2PcyO/Q2FhXHXj3ph6zTIj71y8ADZ0BY2wNr6QZ7jaOXIRlib3bCWj18X1xyrJNK99j+MCHZ9dzR5nr/L6ZkfCzrgDftwEtU267NpyBz2OwjPw90Xfqt4ikcQB0IwQYz3th7VDadJ8EOgWN8xowv0AAPSMQ10rX2n9KMv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtOhg4pt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26842C4CEEB;
	Fri, 15 Aug 2025 18:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755281339;
	bh=oocrOYmjQrnWef3Ueu+zSgsyTbFsYX1546ToFhsmQck=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QtOhg4ptcehctIgHu0wIY1KXpp0nArjblcY+9DF5sWR4SEJx+RiPJotwi3FaDG79n
	 I64gM7U1Stxj5Dac7dYoRAh2wEQOV5pBw3D7oa0bxdgbJIybjQ5nzCovzCQojBE1Jj
	 Q9aONaT2gHjB3WNH5kMx57GNG9IMNwBqak8FLe/ncqa8uMRriMb5+IKF5Um8ld/HLs
	 8pDJEpPekv/K0ia3SpGh12H2GbRgKK1gXxuZfiuILFJK20pHPw4894HoqOk790mmQx
	 8qWxgersb7z+bF5Q+m7OSLvDQrOiFkPvAip1dvpcb8rR8aF1SA26yp97mBsxoJE1iT
	 +BXw1yHf0fNCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E8339D0C3D;
	Fri, 15 Aug 2025 18:09:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] mlxsw: spectrum: Forward packets with an IPv4
 link-local source IP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175528135025.1165776.2187573508561513859.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 18:09:10 +0000
References: <cover.1755174341.git.petrm@nvidia.com>
In-Reply-To: <cover.1755174341.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 horms@kernel.org, idosch@nvidia.com, jiri@resnulli.us, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Aug 2025 15:06:39 +0200 you wrote:
> By default, Spectrum devices do not forward IPv4 packets with a link-local
> source IP (i.e., 169.254.0.0/16). This behavior does not align with the
> kernel which does forward them. Fix the issue and add a selftest.
> 
> v2:
> - Patch #2: disable rp_filter to prevent packets from getting dropped
>   on ingress.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] mlxsw: spectrum: Forward packets with an IPv4 link-local source IP
    https://git.kernel.org/netdev/net/c/f604d3aaf64f
  - [net,v2,2/2] selftest: forwarding: router: Add a test case for IPv4 link-local source IP
    https://git.kernel.org/netdev/net/c/5e0b2177bdba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



