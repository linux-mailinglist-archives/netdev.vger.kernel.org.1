Return-Path: <netdev+bounces-211120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DE9B16A5E
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 04:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D790356736C
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 02:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCC8233728;
	Thu, 31 Jul 2025 02:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aM8F3D3a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6241991B2;
	Thu, 31 Jul 2025 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753928393; cv=none; b=FtlM0fODC+2PG6b1Tk700ygwjt9QZXc7gWCybHwxmd7Heeqiiac3SxrHhXDM+KOxIlZlCztnU/T/50EuT24JC9a0rVU9j1uhiXVn23WqdLluJmngTn4uFaSpXj9Hiw3v7hLW10f0Vkux041K5uWRZuHWmk1XKJ9lOXK26EKlMoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753928393; c=relaxed/simple;
	bh=i/6GAdG5KEczQqUZSzP9yW8+aVRd+1iYuI/ibGxBFlw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ucUlGiXTo/9ljGirT/2laO9O1ryGQMVHjZ6438SkaKfWSEBDEREe9BFI+wHe69cudPs9KflgjhosVALgGOiMeHlXWNtsERjNLFZCg63Q7BudcRcxFdx+0qRixn4mtAqpjdB5pGPfNuCPYOzGCNSnzim6OaZ/etwLZ294+Ej7gSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM8F3D3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6DBC4CEE7;
	Thu, 31 Jul 2025 02:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753928392;
	bh=i/6GAdG5KEczQqUZSzP9yW8+aVRd+1iYuI/ibGxBFlw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aM8F3D3aHGYDz+x4OX+u9cnySDroze/EXqOCQD/w08JdkMQbjpFZi2upL1WmvWowR
	 tiZrE/tsjwVf3FJZnRbz8Z0guBNI0U+5cuVZqn2k6udraXayY3cmgBlne5IcBW/8Hw
	 vikhXMLGSPYQ1ar0ludAtMo5IenUaZY3xjOIUgr97L95wupueGB/sr7wsPK3RhVllw
	 gsU2/ZU8VrcjTNEfBfnLyf6T0rlpTGot4eCA3v/5qvXFTI/5QTprDjwGe8ZToZy9rS
	 9o+hbEzGG0qK1mdysrnbvtavnySjk8pX0k/1OWHFTwmroz2o/f1Gmwrs12y4vuG/z5
	 Dx+XD8puy+glg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC70383BF5F;
	Thu, 31 Jul 2025 02:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mdio_bus: Use devm for getting reset GPIO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175392840851.2582155.14607525521532592549.git-patchwork-notify@kernel.org>
Date: Thu, 31 Jul 2025 02:20:08 +0000
References: <20250728153455.47190-2-csokas.bence@prolan.hu>
In-Reply-To: <20250728153455.47190-2-csokas.bence@prolan.hu>
To: =?utf-8?b?QmVuY2UgQ3PDs2vDoXMgPGNzb2thcy5iZW5jZUBwcm9sYW4uaHU+?=@codeaurora.org
Cc: geert+renesas@glider.be, sergei.shtylyov@cogentembedded.com,
 davem@davemloft.net, robh@kernel.org, andrew@lunn.ch,
 andriy.shevchenko@linux.intel.com, dmitry.torokhov@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, buday.csaba@prolan.hu,
 hkallweit1@gmail.com, linux@armlinux.org.uk, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Jul 2025 17:34:55 +0200 you wrote:
> Commit bafbdd527d56 ("phylib: Add device reset GPIO support") removed
> devm_gpiod_get_optional() in favor of the non-devres managed
> fwnode_get_named_gpiod(). When it was kind-of reverted by commit
> 40ba6a12a548 ("net: mdio: switch to using gpiod_get_optional()"), the devm
> functionality was not reinstated. Nor was the GPIO unclaimed on device
> remove. This leads to the GPIO being claimed indefinitely, even when the
> device and/or the driver gets removed.
> 
> [...]

Here is the summary with links:
  - [net] net: mdio_bus: Use devm for getting reset GPIO
    https://git.kernel.org/netdev/net/c/3b98c9352511

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



