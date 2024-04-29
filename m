Return-Path: <netdev+bounces-92139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3872F8B58C3
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 14:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699AE1C21F49
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 12:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3603EA71;
	Mon, 29 Apr 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQgJfJEV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A926200A6;
	Mon, 29 Apr 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394430; cv=none; b=lWAnlw2UJl5Q+5gTn6xAX4HiQPYBEunB9K3oNwPsRc6D0ImrbfQuN2MNUJIn58FqD14sdlmna5tkqrlbd2d3ktpKKl4gxJ0LMHN7VBw3VcQ2MZAAgRwSYT2gSwYRvOIupw3eDteqpJ/6vK/NLhsnVhOsQ/lPvtNig9MB8rlgMZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394430; c=relaxed/simple;
	bh=87Rk9acUbU1c3cr0M/lXRo4KVIueJyuGIf44rO9GCQg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kDCDTovbDoyEsh9VIo0ITfPcw9pfodJF2zBcEKOgYUyu3CYUrg6kA/3a/122L+KqO1XbpHwhwujd4mXqNayDqK0wexU6TBFLpyfD8snheItF1tv1uFHdIhtTyFxslxWtdLPSxUOKH3pZ7F5qhuH/UnQaq5pjGlTe30xO+IYviMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQgJfJEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1554C4AF1C;
	Mon, 29 Apr 2024 12:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714394429;
	bh=87Rk9acUbU1c3cr0M/lXRo4KVIueJyuGIf44rO9GCQg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CQgJfJEVLd9yjkZelAZ3kAyWk/sy8nLWUbD0D6QMLjlVYlA6dmfEIKobfW090I7Zg
	 dgpOaBB04b5EjJKmbF0qAeQTsfW3tZGPrPlNKfc0hkauyLGh41dVcJr4c5yN3bZWWc
	 uhorh3ErfYmOjMSfH2AjWvEOXO3qiKQkGwOyjITRW+CgEkyEC++/diIp+V+ZBsmU2h
	 /yV+Pnv07OihuKSnxuwy6iVQ+gJNzd9vzJhDAcTX+HrBLiL7ADJysnEhH2kNQv6Xc6
	 eEBc8y80+dIchs4Zu6FQswfuW1RMW/XdFGLj9ldW6nmdj3CAzX6J3WQWeEh1A09+dX
	 D0lRwauG3bHGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AB838C54BAE;
	Mon, 29 Apr 2024 12:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net: dsa: realtek: fix LED support for
 rtl8366
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171439442969.25762.4960715126381337221.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 12:40:29 +0000
References: <20240427-realtek-led-v2-0-5abaddc32cf6@gmail.com>
In-Reply-To: <20240427-realtek-led-v2-0-5abaddc32cf6@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 27 Apr 2024 02:11:27 -0300 you wrote:
> This series fixes the LED support for rtl8366. The existing code was not
> tested in a device with switch LEDs and it was using a flawed logic.
> 
> The driver now keeps the default LED configuration if nothing requests a
> different behavior. This may be enough for most devices. This can be
> achieved either by omitting the LED from the device-tree or configuring
> all LEDs in a group with the default state set to "keep".
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: dsa: realtek: keep default LED state in rtl8366rb
    https://git.kernel.org/netdev/net-next/c/5edc6585aafe
  - [net-next,v2,2/3] net: dsa: realtek: do not assert reset on remove
    https://git.kernel.org/netdev/net-next/c/4f580e9aced1
  - [net-next,v2,3/3] net: dsa: realtek: add LED drivers for rtl8366rb
    https://git.kernel.org/netdev/net-next/c/32d617005475

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



