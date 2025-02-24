Return-Path: <netdev+bounces-168920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B37A418E0
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 10:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 572A87A6C8A
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 09:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9181724BBF7;
	Mon, 24 Feb 2025 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msyrKkEV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC5C86340
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388800; cv=none; b=nrisOWFQV4buxEBVdzxeH+aduAGkosUMA6JcHI/edmBYt8E+w3Sl0gyY4VOwgl8XwqMs/cKmd1Gi3kPcYmtYnyr8Pp7R8lMODz1MvXm6pENtYP4IskcdINiAL/NUfoRh7XgpuxXduBamfFfBZBdV/70zHMenXMxbrguiREXzrzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388800; c=relaxed/simple;
	bh=t1za7wnmR1L7Lv5M8y1FSf5NXzUtNaCTpSMZVGanyDo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=elYMMhwUndAfE04aq3LKhPTye1wVykkGDwn+LIkbWFp0x6ztzff2H85unv6wmObn78prgSuuluydfPwMXIcgF+gbXjSX/ZbvWjPuckJVQuwSc0UNhxExCV2nDvrqoqNqgiH/dvoBA0NyFeW13ck9QtQg1zjxkYlNxrDYnCguL4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msyrKkEV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2133C4CED6;
	Mon, 24 Feb 2025 09:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740388799;
	bh=t1za7wnmR1L7Lv5M8y1FSf5NXzUtNaCTpSMZVGanyDo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=msyrKkEVneJ/eEEjKQMssLT+9lZYBMRGfIhgS3snDdpTyoFXDc69xcLxv4gHWQxdl
	 9B5iOIuhi4er6Qm0FoMqcOb3wCZ3x5T/oFCuDdW0gyltoI9A7r6oqd2dWN0fY1ZGRo
	 0n7ENmyBbfgvA795j1Yjp5dHYEtKOTO5a09H7t5Op3fZmajf61xIwFY4Ak7kWzOVIj
	 FIqVLr3p2dbmSvXRnC9VzLUiMp36Fg+hqYRNKIgPLMeOxvaDmzlROeX5vh1Od1AEPu
	 Ynu8YDSnw+Gk3QkP6OtYhAjCYL2l8pUBfN5RjYqtzpsyM5QMOtomuNIVxZgGoQf39+
	 QGW7buCm9SM6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710F2380CEE5;
	Mon, 24 Feb 2025 09:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: dsa: rtl8366rb: Fix compilation problem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174038883127.3064328.15382079866284721155.git-patchwork-notify@kernel.org>
Date: Mon, 24 Feb 2025 09:20:31 +0000
References: <20250220-rtl8366rb-leds-compile-issue-v3-1-ecce664f1a27@linaro.org>
In-Reply-To: <20250220-rtl8366rb-leds-compile-issue-v3-1-ecce664f1a27@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: alsi@bang-olufsen.dk, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 luizluca@gmail.com, netdev@vger.kernel.org, lkp@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Feb 2025 19:48:15 +0100 you wrote:
> When the kernel is compiled without LED framework support the
> rtl8366rb fails to build like this:
> 
> rtl8366rb.o: in function `rtl8366rb_setup_led':
> rtl8366rb.c:953:(.text.unlikely.rtl8366rb_setup_led+0xe8):
>   undefined reference to `led_init_default_state_get'
> rtl8366rb.c:980:(.text.unlikely.rtl8366rb_setup_led+0x240):
>   undefined reference to `devm_led_classdev_register_ext'
> 
> [...]

Here is the summary with links:
  - [v3] net: dsa: rtl8366rb: Fix compilation problem
    https://git.kernel.org/netdev/net/c/f15176b8b6e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



