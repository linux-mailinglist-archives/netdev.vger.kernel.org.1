Return-Path: <netdev+bounces-110261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B627092BAD5
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF3A281B73
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AEE158D92;
	Tue,  9 Jul 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t9vbrFjq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7BE1EA74;
	Tue,  9 Jul 2024 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720531229; cv=none; b=mPgNizJuxUFep3YPA2k1m4Ek90R/5IM3Vo2IPIJ0Uvtgc7gYioV10GhN0KUyTuuV/l3Pe86gWA5MQNuGFjO8ExMWp4ePSnq/EqsyG7PW0CQ5CysezFDx4n3hNAE4AzlTnxEfyESQjpjyalMCTaA1JggKDwFRmCun7x4aoCwrGKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720531229; c=relaxed/simple;
	bh=BgrLyZZ3OPPlPIhvPTNiCSJwn6+2VtS9YFUiTxvLlhM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mbNF7biUChj0m9L8fv9Hf0Xe6KIZdEPkniXOr87AZGcGTAS5zBNCt6KQsMtrAM82OFdxu+8yVfWeV8q+Rc/dIBa5CcLmEcQCoH4fjtj19QBrCHujL0fYLbYcCahdIvWjb7YnUNx0QbCJ/tj3MonWOJmpUWplcuU1UXli0vx8a+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t9vbrFjq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3256FC32786;
	Tue,  9 Jul 2024 13:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720531229;
	bh=BgrLyZZ3OPPlPIhvPTNiCSJwn6+2VtS9YFUiTxvLlhM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t9vbrFjqDuoI9V3g4OuryFAuUakCLvqe8ytCK5KDssSlWdFS9wJrnuNxMNU/61a/w
	 qH+hcMbzEgIlA3U+yHClg981ZA3e1qBI5zDoJzmTUIt7cI/6q03BNvffq+n2X8ZsBu
	 G0OlKhRr5DYRwrgxxREsbzgG7JtQDR4Y4vic+XfZHJ+DQTHASNKTi+wp1chMUnbXgB
	 D5rGimrq5ErgaJyFb2Xr5vTcLJGK7jhSlOLUWquEgf7PoDSABctX3uBso+vRQ7To4v
	 4k3ifgS7HNLwWSIe7RusZvdjNCg6IbJHptJ4tHzfnHNp0xmsAAGfKUaso1fmxOEAUR
	 MuVdi/DNBCWTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21B37C4332D;
	Tue,  9 Jul 2024 13:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 1/1] net: phy: microchip: lan937x: add support for
 100BaseTX PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172053122913.19292.3616221576979957912.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 13:20:29 +0000
References: <20240706154201.1456098-1-o.rempel@pengutronix.de>
In-Reply-To: <20240706154201.1456098-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
 f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 woojung.huh@microchip.com, arun.ramadoss@microchip.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, yuiko.oshino@microchip.com,
 florian.fainelli@broadcom.com, michal.kubiak@intel.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  6 Jul 2024 17:42:01 +0200 you wrote:
> Add support of 100BaseTX PHY build in to LAN9371 and LAN9372 switches.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> ---
> changes v3:
> - add function comments
> - split read_status function
> - use (ret < 0) instead of (ret)
> changes v2:
> - move LAN937X_TX code from microchip_t1.c to microchip.c
> - add Reviewed-by tags
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/1] net: phy: microchip: lan937x: add support for 100BaseTX PHY
    https://git.kernel.org/netdev/net-next/c/870a1dbcbc2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



