Return-Path: <netdev+bounces-109896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE4292A332
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ABC61F23159
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7B881AD2;
	Mon,  8 Jul 2024 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZUMSpRq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E92824B5;
	Mon,  8 Jul 2024 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443035; cv=none; b=Iot54r0bqdZ57+qptJxrtafQx8kRud80lWQnUQOzzAZmdp1WXYQ+uXHCMCRxQQf55UwKyvNYIoS8GNzEw5KLwCYKRneyRIFF6iLempOTnQsIw/y7l6fNrDkfxuk6Jt/9qWJ+JyL9eKF9Fn9NY73WVNuRszpHf8TAi49khzX7feY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443035; c=relaxed/simple;
	bh=V3aqqYL6ua7qgetjLwetbv/p5bVprjmRsG1goa+0u+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sb29ilP6PI3ISw8DB0Q/cLXhd5ZuxhQO0u1zbp1YAWIgKInVokz65CGOCizftZtqWbVPcsjlMafLIRthrLlyHMlw79hkxNqtB+Ky938Ud6lQnSIv0F9JZE+HjG+INyFA3J0lJo71Fsyc6nicmupRy3CdpGLJgyZ25Fw3l3tsYJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZUMSpRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67C0FC4AF0A;
	Mon,  8 Jul 2024 12:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720443034;
	bh=V3aqqYL6ua7qgetjLwetbv/p5bVprjmRsG1goa+0u+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nZUMSpRqLKV3iLA1/JErWRtZIrsSJ/oWAuHHpeljt58UiH4CLC4fVmiwi02WvKcd7
	 Y/uxwSinA8xqi9nOxM6VhlvXPPKXuBFXA+XUYaEJZfLQFlJgmgIS51peZ5bWHf5uhX
	 pCSdd+7Nh/BaNwn1Zf4jnGydp3BX1zcLIEMtfwAZvzdgcipmIxkZqWRrYIEemw9/4G
	 zq1Zb6PfucGEZCn4rMimKyj7ZCdKhWiLfjoy8EcRlq9/DpEVFxDr68+0OlQ8NL3jxV
	 Z8XJdbpFGQeVxRT1nBXg39Erf/VKovscYOKIqZqAA9592y802G6zldfdQvM6LV8BfQ
	 c9Fb/nXLbMIUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55A3FDF3714;
	Mon,  8 Jul 2024 12:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/1] net: dsa: microchip: lan9371/2: update MAC
 capabilities for port 4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172044303434.27885.6700462773905874303.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jul 2024 12:50:34 +0000
References: <20240705084715.82752-1-o.rempel@pengutronix.de>
In-Reply-To: <20240705084715.82752-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com,
 woojung.huh@microchip.com, arun.ramadoss@microchip.com,
 florian.fainelli@broadcom.com, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  5 Jul 2024 10:47:15 +0200 you wrote:
> Set proper MAC capabilities for port 4 on LAN9371 and LAN9372 switches with
> integrated 100BaseTX PHY. And introduce the is_lan937x_tx_phy() function to
> reuse it where applicable.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/1] net: dsa: microchip: lan9371/2: update MAC capabilities for port 4
    https://git.kernel.org/netdev/net-next/c/5483cbfd863f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



