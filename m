Return-Path: <netdev+bounces-122505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FD196189E
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 22:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71C01C22F95
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB87185B77;
	Tue, 27 Aug 2024 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uORUqKvY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A3537F5;
	Tue, 27 Aug 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791232; cv=none; b=sPNMg/FdfxExWjh7f0pvn39N7pspre9zWjCXTEwPrGXnOjP+K1FswGq7bZ9xiV6r7bLzikJVGMN96+h22hfdFft3JjA7aXrZ+cDOwEiB8KoVajeJU9ZOMuCE4Q9u8IrCkq/FzNl3G1z473sdHsYEMKhTUjY8INB0NiWh8jAH8EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791232; c=relaxed/simple;
	bh=amNQT/VxWUy7VWv80n0WN7qgd2O+vHViMddE7CoLX4o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qLspJFj9EkfbXhfiaLOV5xnKq4YtlnIZ0Xz/661bZOAlQlyWnnmu9B4gfnjwnbfcG1j7UxB0r4rZJ5rDBI2XKAXa+MuXxZyuj1DLSZe7Q9YKnz6Lpqk5Ccz/Br9jHUco59FS6hPsA0kTyeA1ECYmuPDF3eZO9o1CLVfoZNJ5IYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uORUqKvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5324C4DE03;
	Tue, 27 Aug 2024 20:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724791230;
	bh=amNQT/VxWUy7VWv80n0WN7qgd2O+vHViMddE7CoLX4o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uORUqKvYIKr0CkNsCVy+SoZhql6MTFE24wL5FoidSG4j77xWjy7fL3P5Ul1bjJa2y
	 UxUSKCPedbg51ruQeZTLZRFVwdAbrF3neGHd1oCZ147SesZEq3V41Wh1Y8APOAqZ6v
	 3nADBVjZBLhC0g3qIkyLHWKAZL5SspC7w/KQesIBe8Pmd17CCbPKa1hxgwxGA3BzKw
	 N9tNgFfSkREpQE0Y96Gi8GB8OMaxnYJu8eNiH44K1PUBLmMw7JcIdhzOdHl7cDOb1k
	 rMz1PSdBnioiR0BNcT9geagPICu/HqAlv3F751TGmxUeJDqB64EZVI57J5XCeypyug
	 wqEpQ/9exHOpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341353822D6D;
	Tue, 27 Aug 2024 20:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/3] Add GMAC support for rk3576
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172479123102.757308.5208156223047265532.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 20:40:31 +0000
References: <20240823141318.51201-1-detlev.casanova@collabora.com>
In-Reply-To: <20240823141318.51201-1-detlev.casanova@collabora.com>
To: Detlev Casanova <detlev.casanova@collabora.com>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, mcoquelin.stm32@gmail.com, david.wu@rock-chips.com,
 peppe.cavallaro@st.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, kernel@collabora.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Aug 2024 10:11:12 -0400 you wrote:
> Add the necessary constants and functions to support the GMAC devices on
> the rk3576.
> 
> Changes since v2:
> - Fix typos in RK3576_GMAC_CLK_SELET_*
> - Also fix typo for RK3588_GMAC_CLK_SELET_*
> 
> [...]

Here is the summary with links:
  - [v3,1/3] ethernet: stmmac: dwmac-rk: Fix typo for RK3588 code
    https://git.kernel.org/netdev/net-next/c/78a60497a020
  - [v3,2/3] dt-bindings: net: Add support for rk3576 dwmac
    https://git.kernel.org/netdev/net-next/c/299e2aefb159
  - [v3,3/3] ethernet: stmmac: dwmac-rk: Add GMAC support for RK3576
    https://git.kernel.org/netdev/net-next/c/f9cc9997cba9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



