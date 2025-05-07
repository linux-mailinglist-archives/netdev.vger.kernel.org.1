Return-Path: <netdev+bounces-188608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2728AADDE6
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 14:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125354A3101
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 12:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A112586D5;
	Wed,  7 May 2025 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbiFF3kG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1950D2580EC;
	Wed,  7 May 2025 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619199; cv=none; b=oZU3IsWkEpDMH+d1B46z90yGH7sHAzhjPGiFrVZBBBNS6tNLg4TEoJlatlJ1gQ1jz8NjnfQQNL/rPJQODdSNwsfI8P76h5NLISEJCWgZXaHWpYTQVj4O/6pXd0HL7n0iamwfjZXLkzbEdOhLhZCvSm/uVDD4RTejwlold3gGscs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619199; c=relaxed/simple;
	bh=zUVxyov8pzynOlK5IOnXvIkSrF7p+GCIJi7UhZ8sRyI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pWVURHbj9l0EpTbA6Xoj5VkReo2tQCfkdMjhxGCByDHFYhdh9T+U7exAQT17lIaQUm9iXhZhW5SDJ7imwJhzssndZURuVrbXL+DMIPpoN12itmuWeH9zQROFW7Ram8EWV2O2u+8OTPTwu/Tq3IpGJPUzU5Wq8EPKEd70yImfm8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbiFF3kG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A25C4CEE7;
	Wed,  7 May 2025 11:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746619198;
	bh=zUVxyov8pzynOlK5IOnXvIkSrF7p+GCIJi7UhZ8sRyI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DbiFF3kGzr+yR+zTkEK12acmgkBbnkrDe2z65u42Ly4cs90kOmkNcmXN/qmMxkWnt
	 a9ceL5IUsrPNM4YE8mVYhXakX61W7GjOXTMmXtrR3SDW6xf4KAHU0J3V76o2LogoEp
	 VNnhNmhWqWosqZn41P1lYCEXHWjWrjj6mmz6xStZCLiCUgA9m6BHGqyB/3E4fVBexz
	 bb++ZMNiS95bx1dROMBtmySZopyHre8ZsxrkNiKg/jUlfX/E7WCkQVPGJMf0qSu+Mm
	 WyAzqWXJknhM8vc+OiB7bIvHTh/GTMLFG0Q69yvHFq+yvBd2rMTvBmx1bCcCS9eBDG
	 qCsP1BpdVwHDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC91380AA70;
	Wed,  7 May 2025 12:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/7]  lan78xx: preparation for PHYLINK conversion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174661923750.2198858.15834248841787525369.git-patchwork-notify@kernel.org>
Date: Wed, 07 May 2025 12:00:37 +0000
References: <20250505084341.824165-1-o.rempel@pengutronix.de>
In-Reply-To: <20250505084341.824165-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, woojung.huh@microchip.com, andrew+netdev@lunn.ch,
 rmk+kernel@armlinux.org.uk, Thangaraj.S@microchip.com,
 Rengarajan.S@microchip.com, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, phil@raspberrypi.org,
 maxime.chevallier@bootlin.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  5 May 2025 10:43:34 +0200 you wrote:
> This patch series contains the first part of the LAN78xx driver
> refactoring in preparation for converting the driver to use the PHYLINK
> framework.
> 
> The goal of this initial part is to reduce the size and complexity of
> the final PHYLINK conversion by introducing incremental cleanups and
> logical separation of concerns, such as:
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/7] net: usb: lan78xx: Improve error handling in PHY initialization
    https://git.kernel.org/netdev/net-next/c/232aa459aa40
  - [net-next,v8,2/7] net: usb: lan78xx: remove explicit check for missing PHY driver
    https://git.kernel.org/netdev/net-next/c/3da0ae52705d
  - [net-next,v8,3/7] net: usb: lan78xx: refactor PHY init to separate detection and MAC configuration
    https://git.kernel.org/netdev/net-next/c/d39f339d2603
  - [net-next,v8,4/7] net: usb: lan78xx: move LED DT configuration to helper
    https://git.kernel.org/netdev/net-next/c/8ba1f33c55d2
  - [net-next,v8,5/7] net: usb: lan78xx: Extract PHY interrupt acknowledgment to helper
    https://git.kernel.org/netdev/net-next/c/f485849a381f
  - [net-next,v8,6/7] net: usb: lan78xx: Refactor USB link power configuration into helper
    https://git.kernel.org/netdev/net-next/c/d746e0740b28
  - [net-next,v8,7/7] net: usb: lan78xx: Extract flow control configuration to helper
    https://git.kernel.org/netdev/net-next/c/ef6a29e86785

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



