Return-Path: <netdev+bounces-137389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9EB9A5F23
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09162839A1
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 08:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AB11E1C06;
	Mon, 21 Oct 2024 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfgGIy1y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E5B1E04AE;
	Mon, 21 Oct 2024 08:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500623; cv=none; b=CEWMTNehy72POSU4Ugh21ZsURo0C3Q/VEYVKBvBDI7IBvFi0O//2I45ZbDS90W+oq4H3k5u+Pc0qb24NVvbXvnUAu32sH6t3p0dSAfcVjOEKoVnW4wtywbbwkzsjUcloca/X5ZuEpkX6nyqOl8SF43SgpotI5cHoMe/CgE+lacs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500623; c=relaxed/simple;
	bh=Iy+hm30igYv6jpxvbuKuqpyzuaLAIodPsiDrsG/R32k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jovUjLvgwiasE2PThdhu/OtRJLKBC/Yl4IPB/UKbiv+cBxLB8w0572AVlQ1FAC3zFGFxilnqasvzYCyLnsfTOQv1oBU/qB8dOsqZaDarH2SRIWV0HwWcU3K8QMjhWaFMat6cAYM/kDLGDZcIywthA/E2Tgst/CY7jss84wbdz7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfgGIy1y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F26C4CEC3;
	Mon, 21 Oct 2024 08:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729500622;
	bh=Iy+hm30igYv6jpxvbuKuqpyzuaLAIodPsiDrsG/R32k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VfgGIy1y3ArAoJ/rT2c2ScobcgFPFg3/sniXNy/1M5pJFBPlgN1g45pB5lTlWKzcr
	 AUz4y8XYCdi/5AR/UhgprMDzbycIX6MdYSwB4PNW6E5PztpglsyWHHR6rJtKWQms1S
	 OZ4k+J8vvhp+e9b9bMuKw5l0YmEO3qqLHbYzf3lgdwz1sF0VAtnUOf5H//gev3xq2p
	 4UmGhu8M9B3zrqrSO5pPhEkYa5CIVgesbhKfF+7NrtGBgH/AJGHCGYxgTK9E0FbBS2
	 yOBspTCbCE5BuUyQzURcY9Xn0d8piQSuGfZ40j1/ly8HqiWDNlPfTZRhhHulWkER2Y
	 veWUiK914AjzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC2513809A8A;
	Mon, 21 Oct 2024 08:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 RESEND] net: sfp: change quirks for Alcatel Lucent G-010S-P
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172950062876.174108.7327089355032767917.git-patchwork-notify@kernel.org>
Date: Mon, 21 Oct 2024 08:50:28 +0000
References: <TYCPR01MB84373677E45A7BFA5A28232C98792@TYCPR01MB8437.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB84373677E45A7BFA5A28232C98792@TYCPR01MB8437.jpnprd01.prod.outlook.com>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 12 Oct 2024 01:39:17 +0800 you wrote:
> Seems Alcatel Lucent G-010S-P also have the same problem that it uses
> TX_FAULT pin for SOC uart. So apply sfp_fixup_ignore_tx_fault to it.
> 
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> ---
> The previous patch email was corrupted by my email client, so I did a
> resend.
> 
> [...]

Here is the summary with links:
  - [v1,RESEND] net: sfp: change quirks for Alcatel Lucent G-010S-P
    https://git.kernel.org/netdev/net-next/c/90cb5f1776ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



