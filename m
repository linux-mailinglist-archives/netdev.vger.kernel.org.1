Return-Path: <netdev+bounces-133347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89466995B89
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E8DEB22AA9
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC642185AB;
	Tue,  8 Oct 2024 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+3IWVN7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C9421859F;
	Tue,  8 Oct 2024 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728429631; cv=none; b=FtGH5UgfQ4Sx8xcODpgAl0iqJLRfVlFVJ7UqCWFAXRkDTzy8fN6RwbR0BgbzvCjCKTqcCVT4kDpWYb++lZ1Lq+Xd7SFRAXAasYsvpHqWkpcns7wAZOe3r7dUPufAcy+zkLZUHKTKwZEAP0cxv1vW8k3VECSxjwLZNNo7O8wBWas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728429631; c=relaxed/simple;
	bh=mR3+lXQDiSYsN1Jax/lllHbLO4Ki5BW2SXn3G5pvL70=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nIMn644F9SA2bvPTluH/YHa5aTItlxY0A8JP5gmsZ0DZffQfZ8LM/SJODaCEtxO9+wFHJ0JBgqKg3AB4/NgL6RIo/Z7Xm/EsOsmBXJyi5JqulK2mqeC0X964CbHN/8lT45MP950REjU+3MvPVsLfu5qtigGp4bbLt5Vjx7LeS00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+3IWVN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA91DC4CEC7;
	Tue,  8 Oct 2024 23:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728429630;
	bh=mR3+lXQDiSYsN1Jax/lllHbLO4Ki5BW2SXn3G5pvL70=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q+3IWVN7tKrQROMPOFy7qHlpsE9D/Xe9g/dOmj9FJgWneJZkD9mVO2t4tkjugZhhx
	 bHy4ZNMF/Shwv3DyEXrvBsLiP/pfzCZeISE1jzSZcFljsmTcwbyhXCTx4eFjJTccXz
	 x2U8te6dI/+e6oek6pEwHNzm64w7LbiumT9c8OEfz8jA/+XsfE04RltP0QFkuHjWVP
	 ww5SsTGJWLEe+tNZJ+ClgFsKk0iiRzsebzNXORUKs367pUNwtqbOgBccsypMDk42kG
	 cIEX/jPimav0ftKKs57hHjjvAaerlCu/VYNqmCevI5YHEVyZtKADYQYgxJdjyxn2nY
	 MiaxyOXO9P3ZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 350CE3A8D14D;
	Tue,  8 Oct 2024 23:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: smsc: use
 devm_clk_get_optional_enabled_with_rate()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172842963499.718280.5990808046980050800.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 23:20:34 +0000
References: <20241007134100.107921-1-brgl@bgdev.pl>
In-Reply-To: <20241007134100.107921-1-brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bartosz.golaszewski@linaro.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Oct 2024 15:41:00 +0200 you wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Fold the separate call to clk_set_rate() into the clock getter.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/net/phy/smsc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] net: phy: smsc: use devm_clk_get_optional_enabled_with_rate()
    https://git.kernel.org/netdev/net-next/c/881c98f44fdf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



