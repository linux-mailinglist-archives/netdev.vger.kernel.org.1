Return-Path: <netdev+bounces-132129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E389908EF
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35580B296A1
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F0227452;
	Fri,  4 Oct 2024 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhCZlF+z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099A01E378A;
	Fri,  4 Oct 2024 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728057630; cv=none; b=XV5cd+ZlYn4tDtTeUHYzCesjMqNxbK2J7neLiP02eGLgAKIJLVC96aTCMiJ0zjhUGgsd/yD67RFQmPjbofsOJdKxX9brVHe13iSJuG8zAXaeEf1U2gfrjnFw2GRKwUjtOtXZZ2b66JEbuXiAP2DpFGbv3eTQW6a8JuszAZsdMcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728057630; c=relaxed/simple;
	bh=JNZ8HspAV68Ys6XzkHl++/2UMiIrKbHOvCUq48tzyYQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U7jpzaluynhhTa1n0tkWEUeXkjZ27E2pV2C3sRywooUQ4oAiX19KdLikMvyReNu5RXm0uy/g2yKdxGMTlR5knoMTWYtwoQETcVMBBUINUGmzNJBBWBAXvc25slmHMEIhqiM0Q+KzOlwdKayBp/+UO0hmUH+S+apP2mPkrxcKzUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhCZlF+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E290C4CEC6;
	Fri,  4 Oct 2024 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728057629;
	bh=JNZ8HspAV68Ys6XzkHl++/2UMiIrKbHOvCUq48tzyYQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LhCZlF+zUi+U5zqgBu2FJyjp8j3IGzhnFx8sPH2cg5u8yAhvbYtf0IGu+f5gjPn9H
	 Q2yJQw7QCcIeQl9WgZYo0lDBYtdbcjq3Hx+py1CSTz5ISYhv1+LnTi5agAGCEprY3F
	 o1cwrE6nBz/45gCsf5tNCDzAPgJpL/j1JjPiNsMamvyOhQG1hzewquKTbkoC6erusE
	 CWlPY0KlXWQ3tcMD9ExMxgR1RHgTt/yY8hAplaPulUagyZ/aod1QhnqzgTZUlAiK5a
	 etScC4vV27sVb4Wd1SH4CnuNwbMn1N+m0Od4PfVBcXiSz9TynVhodb6OwV4lF2iGkz
	 PfQmW/T4hwl9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 717D739F76FF;
	Fri,  4 Oct 2024 16:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net: ag71xx: small cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172805763329.2643552.7781892599754804264.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 16:00:33 +0000
References: <20240930181823.288892-1-rosenp@gmail.com>
In-Reply-To: <20240930181823.288892-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 linux-kernel@vger.kernel.org, o.rempel@pengutronix.de, p.zabel@pengutronix.de

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Sep 2024 11:18:18 -0700 you wrote:
> More devm and some loose ends.
> 
> Rosen Penev (5):
>   net: ag71xx: use devm_ioremap_resource
>   net: ag71xx: use some dev_err_probe
>   net: ag71xx: remove platform_set_drvdata
>   net: ag71xx: replace INIT_LIST_HEAD
>   net: ag71xx: move assignment into main loop
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net: ag71xx: use devm_ioremap_resource
    https://git.kernel.org/netdev/net-next/c/ab4239c8a724
  - [net-next,2/5] net: ag71xx: use some dev_err_probe
    https://git.kernel.org/netdev/net-next/c/27dc497b7b7e
  - [net-next,3/5] net: ag71xx: remove platform_set_drvdata
    https://git.kernel.org/netdev/net-next/c/94656823c1ac
  - [net-next,4/5] net: ag71xx: replace INIT_LIST_HEAD
    https://git.kernel.org/netdev/net-next/c/8b4ed4d5ffb6
  - [net-next,5/5] net: ag71xx: move assignment into main loop
    https://git.kernel.org/netdev/net-next/c/d14fe43e0007

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



