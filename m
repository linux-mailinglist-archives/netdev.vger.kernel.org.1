Return-Path: <netdev+bounces-40641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF287C81D0
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F452B2093B
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 09:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A2810A10;
	Fri, 13 Oct 2023 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2W9lLMV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AD310A0A
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 09:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92DCBC433CA;
	Fri, 13 Oct 2023 09:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697188827;
	bh=UgvGFrvWG4EJprTnN8d19E/uI6Vkq4RefazGkehLIWU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q2W9lLMVtOVcqbMsbF8jk+vr25MO3lrqlXEeuMhX7bFiI7WxK2wMAavUHE23J3JVO
	 zbKObods08x3lK9+A+UjZujicpGh+HdJsPK95ZvMrvCX1PcFAmE/eYvq9HRRETIc7l
	 oAPabgG+0+2hvCnUPVPdTDTAkMblxYhcyLbyDvHk0eB/9P2cyGuGvgv5Mfsy1kBMkb
	 6a2Rt4b8U1Oej+p9UXAOnNBXlOU0cYdQNAxi9NLvx3AMqDDZ5TRtFzy7dKDP4Gi2bD
	 5sKBo1kEqbmy7To8L6jCIpQonfO5LJHHhP6zcDdAzFbTyyJvD0e/xnZqX9d/Pl54qM
	 RE1ZiIW/upcJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79990E1F669;
	Fri, 13 Oct 2023 09:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mdio: xgene: Use device_get_match_data()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169718882749.6212.17155020342550479874.git-patchwork-notify@kernel.org>
Date: Fri, 13 Oct 2023 09:20:27 +0000
References: <20231009172923.2457844-9-robh@kernel.org>
In-Reply-To: <20231009172923.2457844-9-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
 quan@os.amperecomputing.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  9 Oct 2023 12:29:04 -0500 you wrote:
> Use preferred device_get_match_data() instead of of_match_device() and
> acpi_match_device() to get the driver match data. With this, adjust the
> includes to explicitly include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/net/mdio/mdio-xgene.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)

Here is the summary with links:
  - [net-next] net: mdio: xgene: Use device_get_match_data()
    https://git.kernel.org/netdev/net-next/c/a243ecc323b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



