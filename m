Return-Path: <netdev+bounces-219379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D0BB410F7
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E32A7A6030
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398922EA741;
	Tue,  2 Sep 2025 23:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlefcvvJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106042EA46F;
	Tue,  2 Sep 2025 23:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756857005; cv=none; b=rlOkgRW/3Kap7oH8af1H2uLX+gmoTitq5/OCKanhJs7ww8cZK6/5wKEoXxOaRaAcGbX75krB1V+rAYZejKwgeCD3tXs3gipKplZOOWDnInAJM8PGW/TLRtuU4wlcIDMjVaYSkjy0ArkLYEZxvG0BfiDPZiizrQMiJA6XUjapDtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756857005; c=relaxed/simple;
	bh=B2JNTPVo6Lp/RPUmNM+REI5T/yYpUL1NFFW7x/3DKw4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mGjBZUBgS2KizKX6Q9dVzPuJu96vocK6xuY3y4kMnoF+1cIG51LsGbeKsOZhVu7d0vSlmVs58gDiT0SHqiXDffpbOJAvApwQHPEfmD8gVnImSsjNBwx9c7jrY5+Jnl4SSpX5/XLHNI67AVlz+aopNN6UMyKA3fZ8kzk0Oe+6lCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlefcvvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996FAC4CEED;
	Tue,  2 Sep 2025 23:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756857004;
	bh=B2JNTPVo6Lp/RPUmNM+REI5T/yYpUL1NFFW7x/3DKw4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DlefcvvJxLucv4kf7HCNE5LLGJFuz970kzqTeqxlZ//M4YXjxItwXDiY4cZiXTvPz
	 116FoPvH2Kf71ORlgjeezyFtWvh8yI8hmMnB8GEifAUac2vT9FIRy8YGm4E2s+htDC
	 duqBJFjW+H+7tEKgXRg/ujl6T8NFiJ+5jezCTc8mQQlDkIfP/iBxN6tW/tuDq/wsNG
	 wLqmyuyaGtI4vmx4ceS0Xl6bqE7P8wl3ENcBr+zhfzzkENnPJkLwN2DtOYqDcBL3li
	 mPPcVDVmykpTDp4IO1DcW7oV6bSO663zomDNFpXDEn6iubp3/01z2RRGRofhYtYnnF
	 T19x0XiRii9Tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F86383BF64;
	Tue,  2 Sep 2025 23:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: macb: Validate the value of base_time
 properly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175685700999.471478.8153319794036429097.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 23:50:09 +0000
References: <20250901162923.627765-1-chandramohan.explore@gmail.com>
In-Reply-To: <20250901162923.627765-1-chandramohan.explore@gmail.com>
To: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, shuah@kernel.org,
 linux-kernel-mentees@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Sep 2025 21:59:19 +0530 you wrote:
> In macb_taprio_setup_replace(), the value of start_time is being
> compared against zero which would never be true since start_time
> is an unsigned value. Due to this there is a chance that an
> incorrect config base time value can be used for computation.
> 
> Fix by checking the value of conf->base_time directly.
> This issue was reported by static coverity analyzer.
> 
> [...]

Here is the summary with links:
  - [net-next] net: macb: Validate the value of base_time properly
    https://git.kernel.org/netdev/net-next/c/3586018d5c3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



