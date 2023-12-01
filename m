Return-Path: <netdev+bounces-52812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7328004A0
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A981C20CBA
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 07:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A5C14263;
	Fri,  1 Dec 2023 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m93OSv/a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC4112B69
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 07:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFE51C433C9;
	Fri,  1 Dec 2023 07:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701415227;
	bh=iuqi543xQfoWxFHW0+MvsQohCh1U2B0JVj7IPhBC/Yk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m93OSv/aqP5/E5pVQ8HmYAwq2ajekjvStexBFk5PL+3U6aVuUobpETjgzCmSL03Gu
	 vrTLvWTSL4br9RoVmkOzjC4DFQP6+rd9UN1CmyRlTy4OZrO3Hu07L3MdMCdo2iFER1
	 E0LPynHnbR4EwbmdLzfuEb27u8rFoKqmJS/K69Sm7HROW5o5BylC5gUIICYTJb9uQE
	 7pvhtX0Y2VhYW+50MS01JLxnbToNFL8dmgP3ftG+d0di9q1tiFToR/KGkmNeKjEmgA
	 zOVzzlG7tPD3z1pPFEIOYUYfzXW0x2POL27XLqMlX1rG4zrzwxKx2JME6h4JC98QdC
	 D4DaprdYXccbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF619C4166E;
	Fri,  1 Dec 2023 07:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: mdio_device: Reset device only when
 necessary
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170141522684.3845.10488637215162933845.git-patchwork-notify@kernel.org>
Date: Fri, 01 Dec 2023 07:20:26 +0000
References: <20231127-net-phy-reset-once-v2-1-448e8658779e@redhat.com>
In-Reply-To: <20231127-net-phy-reset-once-v2-1-448e8658779e@redhat.com>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_scheluve@quicinc.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Nov 2023 15:41:10 -0600 you wrote:
> Currently the phy reset sequence is as shown below for a
> devicetree described mdio phy on boot:
> 
> 1. Assert the phy_device's reset as part of registering
> 2. Deassert the phy_device's reset as part of registering
> 3. Deassert the phy_device's reset as part of phy_probe
> 4. Deassert the phy_device's reset as part of phy_hw_init
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: mdio_device: Reset device only when necessary
    https://git.kernel.org/netdev/net-next/c/df16c1c51d81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



