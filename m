Return-Path: <netdev+bounces-222748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A17B55A8D
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 02:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2EF51D61B79
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 00:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C102A1E4AB;
	Sat, 13 Sep 2025 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjtoUn6x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBD71C69D
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757722214; cv=none; b=sIxsEoGg8vbZylFcqfW2zP8aF1ILg4+sbu8oYiusJXtCekgqOB0DRhz/3cYpqkUFAPAdOY8zLdV/Sk2hwDTGwQp1+jqxyXGic6k2fAQvasdSqBdyg9HmPJC1nvSEhuHvL/5dFa+S7EjiYMTbuYvxiwAj7GDO/EQVBpCHpqOT+Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757722214; c=relaxed/simple;
	bh=1vtBeJiQ2F6f6juUCqULeZSar99kg5bfTh7K+2aJ+cA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hH+7tJcurl8e9AXYT5z+bx+1oCJ9VqdtQIjqIC6aqawGRUHqSzpAo9tdXzrUDrA8AxzM6l0FWwZOnOo3zW8LiQjr88Rei2tu7KT9JQdKxb7DOEGeAIuHmqDU6pgzbhlhGcP0EeCQp99f5PyDQ8uHKlA3tRfvHFhqqtL35ePfHZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjtoUn6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E6DC4CEF1;
	Sat, 13 Sep 2025 00:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757722214;
	bh=1vtBeJiQ2F6f6juUCqULeZSar99kg5bfTh7K+2aJ+cA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jjtoUn6xH83qMWWoWDMEpIhyr/Zm9cYtJBZXpR/hhtVriBS/mdq6oaMolJIc2U523
	 v2kcK/nLyDOnpT/3+zPknbKi6g27wnpm1LqxvYlTw4PrBl3Kw4ItG1x1RoLnDRmtfJ
	 7K04APD3G1jhMQgBvUVD7G3aKQM6qTeA7Yh1qU9kFVdXpchoXoi+POk7JovOeoUdtL
	 pJe3uSFmx+wIhbVZB8Hueac/P6HElSCpim96Gr2y3SHZCXF14cyH+mhbLaBxk03Zf/
	 8k51m0vN2HL1lOsHf7FUv052detsDvVos4LtNEDoCv9RNo+CPDPSmU6ok3G+VnIxKj
	 2iGkN12z4H0VQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE15B383BF4E;
	Sat, 13 Sep 2025 00:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mvneta: add support for hardware
 timestamps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175772221624.3109205.2311279043333788576.git-patchwork-notify@kernel.org>
Date: Sat, 13 Sep 2025 00:10:16 +0000
References: <E1uwKHe-00000004glk-3nkJ@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1uwKHe-00000004glk-3nkJ@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 marcin.s.wojtas@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Sep 2025 13:50:46 +0100 you wrote:
> Add support for hardware timestamps in (e.g.) the PHY by calling
> skb_tx_timestamp() as close as reasonably possible to the point that
> the hardware is instructed to send the queued packets.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> v2: add ethtool_op_get_ts_info(), remove FIXME from comment.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mvneta: add support for hardware timestamps
    https://git.kernel.org/netdev/net-next/c/903e6d05876f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



