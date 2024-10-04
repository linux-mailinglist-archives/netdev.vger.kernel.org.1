Return-Path: <netdev+bounces-132320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 046C799134B
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC321F23A3C
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA2A153820;
	Fri,  4 Oct 2024 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mzo+d8hy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C986114D6E1
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085829; cv=none; b=FP1/zoAqBlBtN00yT6swVVnd8U/Q8fvtqFYj9sBu3JS7i0AIqhNTrjyZpwegGHtOGbHSuH244UDdGlP5TYd/b6AHvNfzrtg3JTjTO8njl61fBkdmgqUAjM30JlqY4ZWBAc34lxKn234W+CItkHdjQxQ62O69Eq7FC6pcbR/FGkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085829; c=relaxed/simple;
	bh=7HjXIYI7Y+ZRLOpLfX8EcQxgrHIubHFITh2mmETYGwU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bw+pcBRR+a3M+qKMvCZNLRuMn2UiOA9jdlTHb++JDEW9Tv0+IHUNIQbo2Ifm84jVIJfvmR3DLwm+rSotz9neEkcNTQKFrDHtoA3tjlq9XZq85y3cWKTDYQXDmFFrwcKkXYf+itHYxog+YI+229kCeO5lGKl+zKAlRvLj+Jl1nx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mzo+d8hy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57590C4CEC6;
	Fri,  4 Oct 2024 23:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728085829;
	bh=7HjXIYI7Y+ZRLOpLfX8EcQxgrHIubHFITh2mmETYGwU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Mzo+d8hyoLvmaYsmWJb7SYlH++P5Sb6hX4Ujy4JAXooZfpZhAF1N2hAIqZVpjYs3D
	 JZnJHV8NybMdSfECGTAs9eTvPq+zYhMFFco8eRgSOSMJE/uZXXrBFceG2vRD4UTZsM
	 p7BY7Xh0lSekDSCsDM4kTYyvPICSKDyOLBtBYzxf0MJIgjx6LphgSeouZGtd1tp4Fx
	 xj7WryqzhsipW0JN+9knkD+YOGKfQxGej478ybehn4u0evHyJUmu/7TdQaU/NqNaqr
	 AspIBn0PM7FZE0j/o8QQ4dMu+bA3zjiaPBzvmSEM/2CF/cEaQIom8WODAjuJYGfyWs
	 SalNJRXZT46Cw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3453C39F76FF;
	Fri,  4 Oct 2024 23:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] net: Switch back to struct
 platform_driver::remove()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172808583304.2779846.4851485814308939382.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 23:50:33 +0000
References: <cover.1727949050.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <cover.1727949050.git.u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40baylibre=2Ecom=3E?=@codeaurora.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, olteanv@gmail.com, hkallweit1@gmail.com,
 alex.aring@gmail.com, stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
 loic.poulain@linaro.org, ryazanov.s.a@gmail.com, horms@kernel.org,
 netdev@vger.kernel.org, linux@armlinux.org.uk, johannes@sipsolutions.net

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Oct 2024 12:01:02 +0200 you wrote:
> Hello,
> 
> I already sent a patch last week that is very similar to patch #1 of
> this series. However the previous submission was based on plain next. I
> was asked to resend based on net-next once the merge window closed, so
> here comes this v2.  The additional patches address drivers/net/dsa,
> drivers/net/mdio and the rest of drivers/net apart from wireless which
> has its own tree and will addressed separately at a later point in time.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] net: ethernet: Switch back to struct platform_driver::remove()
    (no matching commit)
  - [net-next,v2,2/4] net: dsa: Switch back to struct platform_driver::remove()
    https://git.kernel.org/netdev/net-next/c/4818016ded1c
  - [net-next,v2,3/4] net: mdio: Switch back to struct platform_driver::remove()
    https://git.kernel.org/netdev/net-next/c/a208a39ed01f
  - [net-next,v2,4/4] net: Switch back to struct platform_driver::remove()
    https://git.kernel.org/netdev/net-next/c/46e338bbd719

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



