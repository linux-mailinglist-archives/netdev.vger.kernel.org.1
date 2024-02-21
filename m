Return-Path: <netdev+bounces-73835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC22385EBE7
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 23:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468BF28506E
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 22:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F132D3C470;
	Wed, 21 Feb 2024 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rf0vFPSy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7DB3BB37
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708555227; cv=none; b=JSxM9H8X+/o07MPUEjIjGyXHay/jJ5QckeqmiQwNjHVcmwR/82CRdnz3UWG2yIYESUPAeL3Pt/UySAXLGJeIXnp9NQaUQWM7nylIBR9jtWqq8l0xGr5smJDfLGjt48xcOT+qjDmIH+hGp2ESYG60zzwVixcK13c3FjdUayxJicY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708555227; c=relaxed/simple;
	bh=Id+aOBIfOJHwZ8AUWPHmj2p+YQSIsIzK+yrQWfkOusM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a3pmJ4cs1EvdWPYug3CjLKcJgppPOf6dRUXPfEvd0SHAag7tNNGG7JyJSMKSvcqBWTr31ZwAHv65eJsYr9i4GYVf8tEsc4p0CJDR+XAG76JjGvZTAtOslh3zmTWmX5F2b1pn/XpaN2vn1wuy4On859MvfVyBrgGVGfy/i4Z831s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rf0vFPSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DBD0C43390;
	Wed, 21 Feb 2024 22:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708555227;
	bh=Id+aOBIfOJHwZ8AUWPHmj2p+YQSIsIzK+yrQWfkOusM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rf0vFPSy6eVehCufvWjgt5OL3esK9QTnL3q9PDXq45NqmOxZrK1lVLgSqYkyf8Ki+
	 ocWSec1BDRwK010Aw1FIqmAgNSB87QYCOrqAquuT6AZxWRCCi5Y+NszvQ38uk4Y0QE
	 N4PNJ4E7a8fmF5iP+uyKnt3etJmiNX0Ju/y8hH9YqKADZ94Iut2kuvu7iPBlx7jHhX
	 wQkYigrUf7y36w9g+DroWCXI+Q/4llLh8FZLft6rt+kLy3FcI4yl5GmioMjjB0efeM
	 g1pnBlHegjZvdhFFyn4+YBt/hYKlcO1FahWkdHVFMqB6gyJMAuLVNXx2PGuhpXuHhe
	 ZjRgBWcloFhvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 261EAC00446;
	Wed, 21 Feb 2024 22:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: mxl-gpy: fill in possible_interfaces for
 GPY21x chipset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170855522715.2434.359995649688728546.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 22:40:27 +0000
References: <20240216054435.22380-1-Raju.Lakkaraju@microchip.com>
In-Reply-To: <20240216054435.22380-1-Raju.Lakkaraju@microchip.com>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, UNGLinuxDriver@microchip.com,
 lxu@maxlinear.com, andrew@lunn.ch, linux@armlinux.org.uk, kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Feb 2024 11:14:35 +0530 you wrote:
> Fill in the possible_interfaces member.
> GPY21x phys support the SGMII and 2500base-X interfaces
> 
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> ---
>  drivers/net/phy/mxl-gpy.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [net-next] net: phy: mxl-gpy: fill in possible_interfaces for GPY21x chipset
    https://git.kernel.org/netdev/net-next/c/59f95f5da813

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



