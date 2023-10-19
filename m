Return-Path: <netdev+bounces-42483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AD47CED7E
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 03:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E92280EF6
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A040C39F;
	Thu, 19 Oct 2023 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYvIVcfA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF6D80C
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAA4BC433B7;
	Thu, 19 Oct 2023 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697678425;
	bh=ujbwjyPp7flADUazRHX5T83U0iFam3+e8fdXdyBTKio=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KYvIVcfAyngBOjo7IePqG8nfiNBMGFCiyeHcHhu7wCH0hWqkA8jBLhScXP0K50qCF
	 S68wJRig72qroLZ1FCbLUqIHtIrvTvbkC7AX7oCZVcJM9hGocMbrrDH7Gj/ZmDoQz5
	 lr+oXZrsd/Kbh/u5uccGhtTwiGBQWQTyuXV2avSq/yQdey8lSzTh9QNkiRsfcwdj3V
	 ts8P2AW2frXSPX35vIywjuHBhbT/pa5lB5XgFbjkrz7XVhjrubbOhSmiz4tkYxHDl/
	 wdrDonH2Kqdsz4haWMYpd0nx3NMY9fvzjacWPuvswfMK6lLWqaEYINNXG/tMFehfd1
	 MfcdIb1ugyNgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C40F5E00083;
	Thu, 19 Oct 2023 01:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: mdio-mux: fix C45 access returning -EIO after API
 change
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169767842479.18183.7049442961896700081.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 01:20:24 +0000
References: <20231017143144.3212657-1-vladimir.oltean@nxp.com>
In-Reply-To: <20231017143144.3212657-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, hkallweit1@gmail.com,
 rmk+kernel@armlinux.org.uk, f.fainelli@gmail.com, michael@walle.cc,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Oct 2023 17:31:44 +0300 you wrote:
> The mii_bus API conversion to read_c45() and write_c45() did not cover
> the mdio-mux driver before read() and write() were made C22-only.
> 
> This broke arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dtso.
> The -EOPNOTSUPP from mdiobus_c45_read() is transformed by
> get_phy_c45_devs_in_pkg() into -EIO, is further propagated to
> of_mdiobus_register() and this makes the mdio-mux driver fail to probe
> the entire child buses, not just the PHYs that cause access errors.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: mdio-mux: fix C45 access returning -EIO after API change
    https://git.kernel.org/netdev/net/c/1f9f2143f24e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



