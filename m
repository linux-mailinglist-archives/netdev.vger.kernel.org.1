Return-Path: <netdev+bounces-204713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AA0AFBDBD
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 23:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA848167534
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF178289E38;
	Mon,  7 Jul 2025 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJpRB2/G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9988A289376;
	Mon,  7 Jul 2025 21:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751924395; cv=none; b=FshNZJBGktMfDo8wNhXfVSIIkyxhLDuW6mKghb/gfTxoisBauTDv7IUHu9TiD8Dk99mcN5qI3uKSA1NLpE67TfytpB/repYZDy3ipq4NYS9jkiMuQ/zqidNSg4w6iZJKBOGKr35U81w8P4lfihljeEM8z/dxIymQFD7R+IYrR0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751924395; c=relaxed/simple;
	bh=vKwf7J4/Yez++rf1dSaDra+PpL20hsRiVmyUiMrOE9g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wh2fgwYbHfvKfFU0Q8WBMRxa32gPjP4OnFaCaiZSNGbsBSfSL/201k/RNGemNRVlL5r50FV17phaXITXr8J24d56eDMSv3dQ5kwiJx8nrp6IRevgbRnfn73PxKJK9sbHI2uZn3X6Fg7T1rGcNtkXGQ5AjrR9xFlJVbtcEQMBBPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJpRB2/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D348EC4CEF6;
	Mon,  7 Jul 2025 21:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751924394;
	bh=vKwf7J4/Yez++rf1dSaDra+PpL20hsRiVmyUiMrOE9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VJpRB2/GVsCVo3RYe6cbXwOwTaxo/0MJbik0rP1GxbNqfYTLgGcdLLWwAwnTjBcj0
	 ZlE2nXuyQjMi7B4eMnvZoYFQT3VdALoXhS7R6JnmCl7m1PAJA9mc4equL2Xg9lEWBk
	 KRD26zMLWHfmIMzS71o7tqskY4vC+Z0af3QtU3miTIus2kraVNHx3ZMNOAzjEIjfv4
	 vXb7LNbwDGphDKjanLOVLc+wAwKhKdBm3ojoNgvzeyYuuPOYZm8G91I6KiRjEsm4ns
	 YjHkxDNwmed0oP0LDwfwb4n04ut0+/CwlzEmBarMC3vc67f98zWCaOIs/zsLsypKRM
	 g0SY/9ppW5Ezw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C6438111DD;
	Mon,  7 Jul 2025 21:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: lan78xx: stop including phy_fixed.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175192441800.3428827.14101244886688483731.git-patchwork-notify@kernel.org>
Date: Mon, 07 Jul 2025 21:40:18 +0000
References: <626d389a-0f33-4b45-8949-ad53e89c36f5@gmail.com>
In-Reply-To: <626d389a-0f33-4b45-8949-ad53e89c36f5@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org, o.rempel@pengutronix.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 3 Jul 2025 07:49:12 +0200 you wrote:
> Since e110bc825897 ("net: usb: lan78xx: Convert to PHYLINK for improved
> PHY and MAC management") this header isn't needed any longer.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/usb/lan78xx.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] net: usb: lan78xx: stop including phy_fixed.h
    https://git.kernel.org/netdev/net-next/c/5c3f832de236

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



