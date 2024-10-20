Return-Path: <netdev+bounces-137296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21D59A54F3
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 18:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09FF71C20DFC
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDFC1940A1;
	Sun, 20 Oct 2024 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuPcQDIA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C557192D9C;
	Sun, 20 Oct 2024 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729440625; cv=none; b=EcSIRTiuMJan/A80LjOBjWLjdxlHXmrot08DfpUCeCPUiPrM5G8xTJAeS7j7rPm6XkezS6ioaqTP5MusHPbN/VWGBLFtFqv/IDyEIr69qb1gaL1jWycXITmnMDAq2hEUqTIt1S9YNPwQzeoDpIGQujRopoBhCsTmm6cwSFKr61U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729440625; c=relaxed/simple;
	bh=i/w/Ikg5srtLKQmcdWO2THgNjJN21VBQ36TzWecTZfg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LinKSz0B0/PP1ZkP97fskdO/Qx596Zt8J/rkQG9xquo9zZnUq8SDvqdeyuvPey5oI/JZs1+KqEGPJ7tCYI9aQE8jt41DdTuG5Es0QhYTKfw/xByW15Ykk8ngIebbmG7d9+Ypb5yS28yQm13gD1FUDp0z1kwKsxbczcCiPSrfdzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuPcQDIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19691C4CEC7;
	Sun, 20 Oct 2024 16:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729440625;
	bh=i/w/Ikg5srtLKQmcdWO2THgNjJN21VBQ36TzWecTZfg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GuPcQDIAuHExaaj9b7S31rC/XhaRsN3iJss2glmIfrY3Zbm9KS/DGRi06R/Jr3cTq
	 ngp/uTY5Q2rPSQTE/1LhEql2vfK90U2i736MDjykID3j4MTCuC6yTMXsweU60Cnimh
	 6O8wVVM8tnm96rGbSkf7viYpzf2c9js54KzvwgHwI5h1omBzSC+DFoinBjJ4QbRbim
	 RnFikBRww3dWG99KGy/ic5md5wcoZkQm3LJBD7Bwv8AUrmRr/zsfgsSWBncKC7Fi+9
	 Dtve6TUbaQGUrw2iSueTTvn9+5D9Gpo0lp2tERHmL7bcOXMsj0Dl/GOCKy5RGB5QRA
	 WuCrYl3RnlyDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BF63805CC0;
	Sun, 20 Oct 2024 16:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: phy: Refactor mediatek-ge-soc.c for
 clarity and correctness
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172944063101.3604255.4238646255355667605.git-patchwork-notify@kernel.org>
Date: Sun, 20 Oct 2024 16:10:31 +0000
References: <20241017032213.22256-1-SkyLake.Huang@mediatek.com>
In-Reply-To: <20241017032213.22256-1-SkyLake.Huang@mediatek.com>
To: Sky Huang <skylake.huang@mediatek.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 daniel@makrotopia.org, dqfext@gmail.com, SkyLake.Huang@mediatek.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Steven.Liu@mediatek.com

Hello:

This series was applied to netdev/net-next.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Thu, 17 Oct 2024 11:22:10 +0800 you wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> This patch is derived from patch 8/9 of Message ID:
> 20241004102413.5838-9-SkyLake.Huang@mediatek.com.
> This patch does some simple clean-ups, however, this is necessary
> because the rest patches in
> "20241004102413.5838-9-SkyLake.Huang@mediatek.com" rely on this.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: phy: mediatek-ge-soc: Fix coding style
    https://git.kernel.org/netdev/net-next/c/b544223bec9f
  - [net-next,v2,2/3] net: phy: mediatek-ge-soc: Shrink line wrapping to 80 characters
    https://git.kernel.org/netdev/net-next/c/b0f90a863ca5
  - [net-next,v2,3/3] net: phy: mediatek-ge-soc: Propagate error code correctly in cal_cycle()
    https://git.kernel.org/netdev/net-next/c/93a610c00ffd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



