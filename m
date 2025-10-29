Return-Path: <netdev+bounces-233768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC7BC18095
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 03:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35A41C67EE9
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F18C2253FF;
	Wed, 29 Oct 2025 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRH/Zish"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0702F224B0E;
	Wed, 29 Oct 2025 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761704429; cv=none; b=T407B939BYrPyz1fbwqC+Cj5QlqEfNiFtJLg2xnlddCHqAVv748ZxzKzji3NZwpnuIPWKfTLn+Saaas49GIkdKz74A0fdLywnDix3++lVexVkd8G6S2xQMiRkkQMWBIt1Blm90bz9Lzsu48bkxXVjOnLzh+78KXMmT1A97URO/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761704429; c=relaxed/simple;
	bh=gqlrnFgCwni2QD8CDRB3o7cz9/QMgUMtjgK7QZSCHH4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OZOykPuLHRv9+zVzAPAhj291auQ+8eRGeulUcd7cyXquSZ1PA4IZbSuGLw5FvXvEn6aNNHJ/H4p6oK51lBaX/KjmcwwDUrtE/FomSU0/raXjWy/4J7NWeYvdtL+V37OuC6FfUxMfmcAYO6p2Iz/07Gota1qY5f9MCEGxCKnFPJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRH/Zish; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739ADC4CEE7;
	Wed, 29 Oct 2025 02:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761704428;
	bh=gqlrnFgCwni2QD8CDRB3o7cz9/QMgUMtjgK7QZSCHH4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pRH/ZishxO66AfD4edHnJdwIETSmjyXlQZGOp+H+GyDpdAKCRRYtQ/3Sez/7tZgrm
	 jS/NzKMxpyqQQgXJFBn5hrIkkrvxSBkB0kiGeX+FEXCl5e+YaZqYxO0VsxPp0a8K3h
	 YF/dfXCZ0SSHkC61NlWF5YAHhARLCMDsbp/l/H/ZiOMg+OdnRYkh/khd/BAUeLTy6t
	 Eyd01Q7mXQVDWcVqyHkX6iG5tOIHW4HiSyCDdWWEZ0roFiiARD3OLJV0tGglBeDv52
	 XxEersqizLGb/UP5GzW8d0R5cLLecdVbzy3+KKjG3XR1jkPcEH4fQ8ywwCMHyqOgyr
	 1b4vdng5C1FRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E0C39FEB75;
	Wed, 29 Oct 2025 02:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: phy: motorcomm: Add support for PHY LEDs on YT8531
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176170440584.2467162.6911069666444153662.git-patchwork-notify@kernel.org>
Date: Wed, 29 Oct 2025 02:20:05 +0000
References: <20251026133652.1288732-1-cnsztl@gmail.com>
In-Reply-To: <20251026133652.1288732-1-cnsztl@gmail.com>
To: Tianling Shen <cnsztl@gmail.com>
Cc: Frank.Sae@motor-comm.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shaojijie@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 26 Oct 2025 21:36:52 +0800 you wrote:
> The LED registers on YT8531 are exactly same as YT8521, so simply
> reuse yt8521_led_hw_* functions.
> 
> Tested on OrangePi R1 Plus LTS and Zero3.
> 
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> 
> [...]

Here is the summary with links:
  - net: phy: motorcomm: Add support for PHY LEDs on YT8531
    https://git.kernel.org/netdev/net-next/c/a8abe8e210c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



