Return-Path: <netdev+bounces-243079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0846DC9948B
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 23:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 32FEC346140
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 22:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A121285C98;
	Mon,  1 Dec 2025 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLoWHoGp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D920727F75C
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626590; cv=none; b=Z3rbMy0+vpAgt+Gci95/nDWqFNNWC9qHfGUk6Rk7cVJq8G50uV6kyHHpu3trCqlz4ADx3Fyc7Mzq73jzNvRRzxEhyGapMNcqWs9pfIRNVxtZdRGWC+5zlm02X9zjMupFHt51wzxoXMcRTQ2fU0g4TibHzGRE0nlQFWxxg8iYtYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626590; c=relaxed/simple;
	bh=MrAUjKqoqO7sPDwWODX4+FyJXxKgStkpiFajcz8ULxY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a2Nilnxr6wL/ipk8Y6sn+DJT6CEWo4dVfcS6zQBovnuE4OX/cWo4h0eqXH3Iq3TLs/kYRuiGZ4r5vllOVitJZkEeJo+n8zcqFLGdFq37ynmgEfeikxZcYPLlTi50zfE1B1OUiEyDFoqfYYxkGmssD+up/5cVKwuTd7ysH9KNjJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLoWHoGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4715BC116C6;
	Mon,  1 Dec 2025 22:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764626590;
	bh=MrAUjKqoqO7sPDwWODX4+FyJXxKgStkpiFajcz8ULxY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HLoWHoGpWy5dKJqfC8DewZrQkwKVa7BaHha5dJiLb1JbneOuriQKL/O0qpfmyD4Pl
	 4JSe7MM1hSgD9JcuqGvHiEdeARfXCA0PRlMYyqmbJmu/AwQoO8wi5n3hZV0uk71pZ1
	 XTJ3ohL7RMRr/i+Kc4GFiWMM6dOd7qf1Xq8gL3+/hLjQwWhgWkW1Iukv+2DFlW2JhX
	 MiN63a/bko4RYWW+BWWfAJcxiA7pDHuEBpFf2ofM+50Byj6RZ3dQdlRtGLsE0GMh4t
	 C3tozpDIAxeqsggAD+5S0ZFxSzvMZYiJ683S5sqb7+y7UdTPAeYuxByhPGpmpChGkY
	 SLkhl/1jM0chg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 657E8381196A;
	Mon,  1 Dec 2025 22:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: pcs: lynx: accept in-band autoneg for
 2500base-x
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176462641002.2561615.10000193096342824763.git-patchwork-notify@kernel.org>
Date: Mon, 01 Dec 2025 22:00:10 +0000
References: <20251125103507.749654-1-vladimir.oltean@nxp.com>
In-Reply-To: <20251125103507.749654-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, ioana.ciornei@nxp.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alexander.wilhelm@westermo.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Nov 2025 12:35:07 +0200 you wrote:
> Testing in two circumstances:
> 
> 1. back to back optical SFP+ connection between two LS1028A-QDS ports
>    with the SCH-26908 riser card
> 2. T1042 with on-board AQR115 PHY using "OCSGMII", as per
>    https://lore.kernel.org/lkml/aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX/
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: pcs: lynx: accept in-band autoneg for 2500base-x
    https://git.kernel.org/netdev/net-next/c/56435627d90f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



