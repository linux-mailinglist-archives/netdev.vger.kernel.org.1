Return-Path: <netdev+bounces-152029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD019F265D
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F164D1882E56
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 21:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353221B2194;
	Sun, 15 Dec 2024 21:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcHfGbBD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC4D653
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734299412; cv=none; b=ed2eb91o82uHFAuArNVTb8mxoeOcux9Z7HxDxPAv9bKxSZGFP1IAhyXTTjJiGx3mVcBik3RdO6WpiBQb1ezPTzXEdGXEJe++YPZBGEIgz2VLQehhEgQVL5Dh4JHXcxh4leBK7pYhq88jl2f1fJdIbM99OQiz9owxhWNdegXdzYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734299412; c=relaxed/simple;
	bh=MDPo0GZKLLJmOvKSL/gMKYic+8JR+JRrekwKu2S42H4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P0MpyMC94OpT5KXauwSN2btFhoZZymsrFQjGt9m2XdCEWKtWzeQptxtGtpGBH6iGJkEihtIYC+wzUnfnH7UIWe03csRUgWyC8JRi4+DgPGA7UH6gFKRbejAVJGiLHv72hlOSHbYo+yKh6NbCTX4j6LjWbpc9ztpPkl8D6TIzk7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcHfGbBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931B3C4CECE;
	Sun, 15 Dec 2024 21:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734299411;
	bh=MDPo0GZKLLJmOvKSL/gMKYic+8JR+JRrekwKu2S42H4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TcHfGbBD8MPaOtPGabu36FyXC2KXfpwJkvxp1dEmuQfE2cUy3U1c3iJmax0LeZYbB
	 oGsvdIWKclBWTZxVZ383zbFd7EjnlSEdnkLl91QjihrPToLFQs7SE43/uPLxeB+O/2
	 updA0FydQDt2RLpv9WYsXw8t33H9XjV+vGqcnd805Zoz6SuVBewb9UDXzU466+droW
	 w/rmbmN/4pBfWVw6A2FaW8nBfGaJ2J/F+BryVAmtNLr4RUkm7SAL5IlgJ/+PTzLlKs
	 gvYOGlu1nxsHbfXxLh5OoDMjE37WIlNp/ffjTMSreNg7uwKJmiwng3RFRz30eYCWM/
	 83ss2qJ1ToGlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEF93806656;
	Sun, 15 Dec 2024 21:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] net: phylink: improve phylink_sfp_config_phy()
 error message with missing PHY driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173429942851.3588300.14931705727998562399.git-patchwork-notify@kernel.org>
Date: Sun, 15 Dec 2024 21:50:28 +0000
References: <20241212140834.278894-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241212140834.278894-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Dec 2024 16:08:34 +0200 you wrote:
> It seems that phylink does not support driving PHYs in SFP modules using
> the Generic PHY or Generic Clause 45 PHY driver. I've come to this
> conclusion after analyzing these facts:
> 
> - sfp_sm_probe_phy(), who is our caller here, first calls
>   phy_device_register() and then sfp_add_phy() -> ... ->
>   phylink_sfp_connect_phy().
> 
> [...]

Here is the summary with links:
  - [v3,net-next] net: phylink: improve phylink_sfp_config_phy() error message with missing PHY driver
    https://git.kernel.org/netdev/net-next/c/ffcbfb5f9779

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



