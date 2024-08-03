Return-Path: <netdev+bounces-115458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD76946676
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 02:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590BB1F22309
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 00:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D434A1D;
	Sat,  3 Aug 2024 00:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N60qXV9N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB33B80C;
	Sat,  3 Aug 2024 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722645035; cv=none; b=GZwdJJaaEIg3sApTRSxdOX1MnxPfNjRzNEQqMvi3P5/C9p4aDXErg+l3eslxMXQT+zW6B6chjBHRVSq5qaZf8t+qY0y4IHJ3z5WBthFYn8arSkrA8Gvxo5Dy9iOct95tZI1Fiprd2guRJeNuy3Q944NvkF/rE9A3yqZbZXpJJhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722645035; c=relaxed/simple;
	bh=QsepNdyGkjDb4pNJbbaugh0oyc7h+m9/WNuPF2KmIMQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eICIE6mqg1yffI5oo9v7Ail2hnrYedNJttqhH+sf0SOz2ruiLt933mxeqEK4c01uNKfjveV+Es69taetnD+BF6UGq56wKQFqCq8Jecxb4iQd5KxE3MsifE29ZKAZAIs2LX9ih0rt5g6RQgTeh4KTC7kmmyd0m/viWFkAITkBEBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N60qXV9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58CE4C4AF11;
	Sat,  3 Aug 2024 00:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722645034;
	bh=QsepNdyGkjDb4pNJbbaugh0oyc7h+m9/WNuPF2KmIMQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N60qXV9NZnbzd+42lOrVGD2zrr0j/sJwOObb36AkOWGQTEnJD+gdTuV/z+Wop3hbV
	 MpFMXqrYn2DqksY+7ydf+TRAQeHV3aMv9q0KKhCmkIbylARXwr0uWBr5UPqBsUEYke
	 qF/Ho+was/JM/7gMchFSBGxhZxoowv/B3Ywb5QEGU30960ACfkD9IX20yJj2k6e3An
	 HrV7WEqbgg6au552UT1vcmjzIMNX9rSDpC7g0bSgdJSppSysVWz/RXO6aV4mTAZw19
	 7JkI+7SZk+1d3DhedR01h4r62E7Msz2HHbrmrmaiR3+DG5Xp04Vntb8KFktOUWjd9R
	 LOnXCVsSuLTkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46E9DC4333A;
	Sat,  3 Aug 2024 00:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: vsc73xx: speed up MDIO bus to max allowed
 value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172264503428.23714.12001402331123268852.git-patchwork-notify@kernel.org>
Date: Sat, 03 Aug 2024 00:30:34 +0000
References: <20240731203455.580262-1-paweldembicki@gmail.com>
In-Reply-To: <20240731203455.580262-1-paweldembicki@gmail.com>
To: =?utf-8?q?Pawe=C5=82_Dembicki_=3Cpaweldembicki=40gmail=2Ecom=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 31 Jul 2024 22:34:55 +0200 you wrote:
> According to the datasheet, the VSC73xx family's maximum internal MDIO bus
> speed is 20 MHz. It also allows disabling the preamble.
> 
> This commit sets the MDIO clock prescaler to the minimum value and
> disables the preamble to speed up MDIO operations.
> 
> It doesn't affect the external bus because it's configured in a different
> subblock.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: vsc73xx: speed up MDIO bus to max allowed value
    https://git.kernel.org/netdev/net-next/c/8d5be2c4f447

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



