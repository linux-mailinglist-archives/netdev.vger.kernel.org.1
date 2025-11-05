Return-Path: <netdev+bounces-235648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D1CC33773
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 01:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FF7E189FA39
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 00:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E31223BF9F;
	Wed,  5 Nov 2025 00:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+bAC1oC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4666023BCFD;
	Wed,  5 Nov 2025 00:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762302052; cv=none; b=XklwBCcsKEDdYm6y0V+rlVxVfFAyMBh1fm/mhYReRDWBFVCRYhzsJNJf9MMJH8R6VOLhJ2LZDpv3QSOpPiFrm+stV1TgcGkOlbq0YOrAQ5+RseZZ9WVtJkz8nIruDn/byinRFjQ5NVA0n0EjeFjtkSQzkC5cN5nP0ORyU9d7cWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762302052; c=relaxed/simple;
	bh=7DyAlec1xWCVNfF5OX01I6lH9WD9w558h5r3Ww1gBdE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gmDU7K1SJuVKv5fcAUrDgGisosi0fdJpaWP+NxOik7WcFSuUUDSIZnP5pzqFXjFw/k4KJoRBuNKQ/C3mDmGJJLMQ/gSixT7aRgbHyhI3TXi1Y8kOt2kKIPseTyvxCrI9II1lAsfhY//nnAK+OBdaaF+1U6EYDpy6xdgLEkNxSWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+bAC1oC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC808C116B1;
	Wed,  5 Nov 2025 00:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762302051;
	bh=7DyAlec1xWCVNfF5OX01I6lH9WD9w558h5r3Ww1gBdE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H+bAC1oClEuze5WlYEP3EiaLxxqE2Z84NDcK30LtRMXZH3n3kiaNP01ax9o4xiVAE
	 5uavSlChZl588zDEti4ynxrOPEAq/p2sWABSXaGCVVyVK87iYQDr2XO2PgBz54U0j/
	 WBGvkOvFVGRHMP7QbsUy4xKr2Y3phGuhOK1gHcSOiHaAFpKmO7hKrBQayHeHH7yo36
	 p7poNmHcK1Ht20XAIRRs1EV3nYnk7agHxkgfQ0+jkaYGRoPqR2nW1ngfT9MHLtGwUY
	 VrGsiQHfP2DsatVRUco47W3kX17q6dnLBiHffCAHp5MFGjBRYnRG3KKY4pGx5WN1ES
	 s15TGN8c/axQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0B0380AA54;
	Wed,  5 Nov 2025 00:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in
 IFLA_STATS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176230202574.3035250.1803056015244340569.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 00:20:25 +0000
References: <20251103154006.1189707-1-amorenoz@redhat.com>
In-Reply-To: <20251103154006.1189707-1-amorenoz@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, nicolas.dichtel@6wind.com,
 toke@redhat.com, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, kuniyu@google.com, sdf@fomichev.me, shaw.leon@gmail.com,
 cong.wang@bytedance.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Nov 2025 16:40:04 +0100 you wrote:
> Gathering interface statistics can be a relatively expensive operation
> on certain systems as it requires iterating over all the cpus.
> 
> RTEXT_FILTER_SKIP_STATS was first introduced [1] to skip AF_INET6
> statistics from interface dumps and it was then extended [2] to
> also exclude IFLA_VF_INFO.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in IFLA_STATS
    https://git.kernel.org/netdev/net-next/c/105bae321862

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



