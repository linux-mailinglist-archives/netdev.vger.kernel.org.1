Return-Path: <netdev+bounces-202722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A700AEEC1E
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 03:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30CE17C00D
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 01:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F2718C00B;
	Tue,  1 Jul 2025 01:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ7SeQ1g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0761641AAC;
	Tue,  1 Jul 2025 01:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751333985; cv=none; b=Gb8NXfsHHIengKrULfjLr1WHMJUlob2q/6t5NQUUtAzmFjnrlSAjPLQXGkbjJf0Cwbohc4ZiE+1JDPIvMqnvursfcXrSn1M8MGVoA5qqbRjUDtqXRw3vFN0q4iQaLC6i7+k6oqGq0zcI7MxBoIfTQQ3SXJ4cv9F0Iv9rBTV6mRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751333985; c=relaxed/simple;
	bh=lpXn/IbPmBztt3EyZclDY209c4/2IE+H8dNAxJfAwLw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fMc7fXsfhzGbg4WXf0UsasF2kjRzFMvjUxTiwljPGWZNusEFMEh35WCZ4HMitoimea4/APaOYrpR6O/BcsyEdaQVFzQLeYkb11MzLCvOKwVS0rQDkXZIPrg8RUIaCY6aNiGy543jdEvyiW6WjiOTtcgBcJXMFc61WOaUbKN5A4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZ7SeQ1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CF8C4CEE3;
	Tue,  1 Jul 2025 01:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751333984;
	bh=lpXn/IbPmBztt3EyZclDY209c4/2IE+H8dNAxJfAwLw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DZ7SeQ1gwGAxE8bRE09IhTsmn1IZ8YKF8iEV5UAh9m41T7L4uLeyuHA7tvdMBy9D+
	 OM0yDvwTh8ekRp5nSyvrw6/nq0IAse3vYwVmoQ6vGQ1Nmts+VR9HPK0QtpwoytksgZ
	 NOFp7M5B5fnJ46ByfJ6Vv3UDR+9+z1o9bkQ4lI5G4+ynH6FAaExSDk/7BhcN7u+WA4
	 1ooYiiX6kXplnSvOwDrvB4bXoygcqPrdP5X5ZQYuZ7DGaYXGuSoUABWGGWxNenxr1H
	 /E71qlnjI1Hwz3I3YhaIXznjDCuRilAD75pNbjxAZ+NI8i8dOan91DwinlqCiEeOXa
	 RNCxZ9SDOTV2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0BC38111CE;
	Tue,  1 Jul 2025 01:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 1/1] net: usb: lan78xx: fix WARN in
 __netif_napi_del_locked on disconnect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175133400951.3632945.7814356575110770254.git-patchwork-notify@kernel.org>
Date: Tue, 01 Jul 2025 01:40:09 +0000
References: <20250627051346.276029-1-o.rempel@pengutronix.de>
In-Reply-To: <20250627051346.276029-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, woojung.huh@microchip.com, andrew+netdev@lunn.ch,
 rmk+kernel@armlinux.org.uk, Thangaraj.S@microchip.com,
 Rengarajan.S@microchip.com, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, phil@raspberrypi.org,
 maxime.chevallier@bootlin.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Jun 2025 07:13:46 +0200 you wrote:
> Remove redundant netif_napi_del() call from disconnect path.
> 
> A WARN may be triggered in __netif_napi_del_locked() during USB device
> disconnect:
> 
>   WARNING: CPU: 0 PID: 11 at net/core/dev.c:7417 __netif_napi_del_locked+0x2b4/0x350
> 
> [...]

Here is the summary with links:
  - [net,v1,1/1] net: usb: lan78xx: fix WARN in __netif_napi_del_locked on disconnect
    https://git.kernel.org/netdev/net/c/6c7ffc9af718

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



