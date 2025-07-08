Return-Path: <netdev+bounces-205057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AECAFCFF2
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB533BD386
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B312E4274;
	Tue,  8 Jul 2025 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPZotq6f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D52E4267;
	Tue,  8 Jul 2025 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990400; cv=none; b=JkBw0tGMfsoECC4++mODK92or4CaUPNaCDZrvGPj7IbwL1P1Oz92Kuil58WGLiBcAIBEoFPvhoxiE2nAikkzu71O5eGx/meeJK8AkyOPXsm3hKC0sZ+/UIphpf81f7yn2UXFNQNWXaG8Vjo+S+w2QimA5G06YuPIgswwjU4RVhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990400; c=relaxed/simple;
	bh=2rxhuaKjlE7sM4HMvsLku6ebC/mc7AD8AzLflgwKiwg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SzlO6IupDCs1+aCcAlicgZXqR+IcW5wmUEMH4EFJw12Lc2e+cqu6Rx/PqHfg2MeaGA0NAWvMsVOnkNwSP8ogRnVydsW/T0giKXr7Q/g9sJc/CiX6i0iF47zo3bYsOhgoa3U8cj8086WQ0gKdgHRZETuPzpcI1llnBLXNB6RUw5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPZotq6f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E74C4CEEF;
	Tue,  8 Jul 2025 15:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990399;
	bh=2rxhuaKjlE7sM4HMvsLku6ebC/mc7AD8AzLflgwKiwg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mPZotq6fVyuIXSnnDc2Bmd/fhH4efdkN5uXiLfvUmCndm3gpXQlzeOOV4Fz8+aSZP
	 W/VU9e63Ym42vkU/HqGqvYQ18IbUMEnuk3wyj5ohl6WXQaKaCSfGCJXJlhKnK42iGG
	 AOdZv8zhIPwEAjnBL3oc4P8+zn2fYYO6S/H6mjhD7s62LGdz0f/hXL1QWE6fzLXSa/
	 zA0uHRop1ZvH3FtD/9JNhjEoije+IOtPWsEHXbu4EYMd/NjYxi8W3TqXqTdIDTt6ko
	 IdE6ei198q88VgbhNUMSidI0y0J4559OgELeA8MGIm1w/obq4n4GhRq0kMscP5aCPp
	 WmkDpnq/pNhzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1F9380DBEE;
	Tue,  8 Jul 2025 16:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] netlink: spelling: fix appened -> appended in a
 comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175199042275.4117860.17979723803600104658.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 16:00:22 +0000
References: <20250705030841.353424-1-faisalbukhari523@gmail.com>
In-Reply-To: <20250705030841.353424-1-faisalbukhari523@gmail.com>
To: Faisal Bukhari <faisalbukhari523@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  5 Jul 2025 08:38:41 +0530 you wrote:
> Fix spelling mistake in net/netlink/af_netlink.c
> appened -> appended
> 
> Signed-off-by: Faisal Bukhari <faisalbukhari523@gmail.com>
> ---
>  net/netlink/af_netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v2] netlink: spelling: fix appened -> appended in a comment
    https://git.kernel.org/netdev/net-next/c/effdbb29fdd2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



