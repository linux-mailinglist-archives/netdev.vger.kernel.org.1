Return-Path: <netdev+bounces-215133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 720C1B2D264
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 05:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7AB11C43785
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EACE2C21D9;
	Wed, 20 Aug 2025 03:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2iw4Sj2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B492C21C5;
	Wed, 20 Aug 2025 03:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659479; cv=none; b=BIkUNgn7EHGTsRbKNLXveEVqz6901Wt/Ws9KL/iLx/MMrCUsIq6tJAXIsyoH/mxRYpiJ6KsS1DfH2ri5VXswuPqukdhq7KD5cpVAKavtVZt/S8mhqX1wOPNlbckrePDeHArfRPm20fnWxW61T2/DMVlazHHvn2nJDbmGoU03Zvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659479; c=relaxed/simple;
	bh=WA7nptLs5nmTytv6EXdoUn9wcl45BVV/ylHzwVVn2vU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k9SGOaoIlgkgQXg96Kuy94lmCx9nO8vRF7ZpI1pVrQ1OqdV+aQ23shD5O8oir78eyj/b4oxyOxAMIDSmrPPrIm6sGUvgTRMBjUJXtBI7okvM+DVM5a4ccb/yZyV3c+8wVKqSV146oj5nu28tUyyR5OlYogWXlHQ0+6WKB1hb7Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2iw4Sj2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E056C113D0;
	Wed, 20 Aug 2025 03:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755659479;
	bh=WA7nptLs5nmTytv6EXdoUn9wcl45BVV/ylHzwVVn2vU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S2iw4Sj2ni2eRw404Mf9BjFQrkvoKsHfPM/RaY1kMoE8Jt0Kfrs9WRTiM7Wvzr3YI
	 ZvtpNKgzmYGFTqIK+MaQWaKvPfMvjSRT//cP79TBt4tPVA/JiqVczUb4NcgxexlsK/
	 ejfwRY2jVdcRr1tkgxWtdBfCrhF39H6kutJcQgoBMCqjutpZ6KAyliwJRwxfvI+jpB
	 xMeMCKNBPAlTCFm5NCc0wv/Zadd19gjNtWNzU0quRpU9zx2nwm2t+49UeHTySsqNg4
	 DwWYv6TgUTv2uC0kkTh9QJlLRhc74Lv7K1hMLNqiBLsDsZUoW+HnKFKAhqb0wbhvVy
	 usqZ6zoRIqZbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CB3383BF58;
	Wed, 20 Aug 2025 03:11:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: asix_devices: Fix PHY address mask in MDIO bus
 initialization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175565948874.3753798.3012658456952516915.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 03:11:28 +0000
References: <20250818084541.1958-1-yuichtsu@amazon.com>
In-Reply-To: <20250818084541.1958-1-yuichtsu@amazon.com>
To: Yuichiro Tsuji <yuichtsu@amazon.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 syzbot+20537064367a0f98d597@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 Aug 2025 17:45:07 +0900 you wrote:
> Syzbot reported shift-out-of-bounds exception on MDIO bus initialization.
> 
> The PHY address should be masked to 5 bits (0-31). Without this
> mask, invalid PHY addresses could be used, potentially causing issues
> with MDIO bus operations.
> 
> Fix this by masking the PHY address with 0x1f (31 decimal) to ensure
> it stays within the valid range.
> 
> [...]

Here is the summary with links:
  - net: usb: asix_devices: Fix PHY address mask in MDIO bus initialization
    https://git.kernel.org/netdev/net/c/24ef2f53c07f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



