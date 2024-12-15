Return-Path: <netdev+bounces-152031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F979F2664
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 23:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C2A1884B37
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365C71C3C0E;
	Sun, 15 Dec 2024 22:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYnSFEda"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F12B1C0DF0;
	Sun, 15 Dec 2024 22:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734300012; cv=none; b=VGw7wCpECM57xxreh30AjgUoB1LxMmRsJaFQX4HmWv7D6H/MyFQe7Nuh3IIrwEaDrAMl1XPNXvC9ZoLulVXaA4VWDCic8hXNPIQ4s5rYmisWIoxMjuU1LuW26kmaN3WfFxEU9yHMebUXVp6gXLZhwBeT0aW61T5kbosc+CLcYaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734300012; c=relaxed/simple;
	bh=xPw1BdIggUijSOVomyn8DE/QuxGpu73NRPHvR6FOeNk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tR4xPs2/g66rFbmiznxsavyL6FrL64QLwMHQEQDT0eHZRHtbI8Xr4ZKZTSaTLp8G3K0zqNzbAZBoRuHMu6FEdy54BnOHyDj8EUTtgzWS84WI1FtbLdV0btAscOjvA0dPAm+5/sup55Cb/2HigwrqUZq5hI9mcLlMaLJxJc0v5A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYnSFEda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94621C4CECE;
	Sun, 15 Dec 2024 22:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734300011;
	bh=xPw1BdIggUijSOVomyn8DE/QuxGpu73NRPHvR6FOeNk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KYnSFEdamkQnqowOJQ3oDBBFIOQh5Y35dfgUIYbPSwGW/kXho1KbOcTovaFFSxEK7
	 7rvO2MoTPnDeKDiIHG/Z5kSvqBkqLLxoGdzVqrl+iZO0UFVCNlNZT82/ZTEO+dK5vG
	 JlU3MTLGpixDBHlMsWgrY6/BH78TmcvMlnBmHm+S99IP3CA7xNcKUY+gLCvjGy6gJ5
	 9hvOpeSex133WBL7wH2X5Bk1gclNMOOZ4J7Qsg1s2KAVM1gkfCl3ITa8F4pptL9Y0z
	 zFdR9rU4NBocD14ncBg+pIwgJpBwmObbwPE0SUWSxV+YVRyfzO24jYu2QC0PrptmnZ
	 nyKd3XWmzoy3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2EB3806656;
	Sun, 15 Dec 2024 22:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ethernet: Make OA_TC6 config symbol invisible
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173430002850.3589621.15459457255990504708.git-patchwork-notify@kernel.org>
Date: Sun, 15 Dec 2024 22:00:28 +0000
References: <3b600550745af10ab7d7c3526353931c1d39f641.1733994552.git.geert+renesas@glider.be>
In-Reply-To: <3b600550745af10ab7d7c3526353931c1d39f641.1733994552.git.geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Parthiban.Veerasooran@microchip.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Dec 2024 10:11:43 +0100 you wrote:
> Commit aa58bec064ab1622 ("net: ethernet: oa_tc6: implement register
> write operation") introduced a library that implements the OPEN Alliance
> TC6 10BASE-T1x MAC-PHY Serial Interface protocol for supporting
> 10BASE-T1x MAC-PHYs.
> 
> There is no need to ask the user about enabling this library, as all
> drivers that use it select the OA_TC6 symbol.  Hence make the symbol
> invisible, unless when compile-testing.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ethernet: Make OA_TC6 config symbol invisible
    https://git.kernel.org/netdev/net-next/c/0193eebbb1fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



