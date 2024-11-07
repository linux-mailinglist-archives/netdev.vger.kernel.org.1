Return-Path: <netdev+bounces-142606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DDC9BFC3C
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37395286189
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0471DB54B;
	Thu,  7 Nov 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXnLDNzd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E0C13CFA6;
	Thu,  7 Nov 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944832; cv=none; b=Pi5aa5RrnS0KYPpJr7DtPcdmhQmArPxE5Ny/6IdB7wP1iGIG/jtMFgNaGsmXdmCTTVFng50N4EcJLOsJT/MUIVsBNqwchbUkoodMUSboz/81afzmm/CHh6xDsV4ZL9CcMBMcFVWmhKdiPoByRtzA76HBsWbScEmIrVV/GvSLb/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944832; c=relaxed/simple;
	bh=532jMIfuDg1ogK3TC9C2/ZA3fr7KDNNjjlqo/f3sPYg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FTcLxyHuij90kteTGy7NT2yca13YeYnEyp6ro2DKjtke4X26KsmhqypAmVy+I0GK5ziCcZMHisFI/8C3s4b9pCldx2l6FBb0J8i1zAArUSEBONE/WwFJpbPtooqC4co4M6zyoGqIPRCvIWW6kfxY4ej2e+LHtcV8OC7cVMcpxnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXnLDNzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248E1C4CEC6;
	Thu,  7 Nov 2024 02:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730944832;
	bh=532jMIfuDg1ogK3TC9C2/ZA3fr7KDNNjjlqo/f3sPYg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TXnLDNzdApu7oeS1R6H0JZK8Dxd1G3cqHvafNb5LVehyv2AHPqKjJFlkAsm2izw7Z
	 QYDRM8GrQRfwnUPza4CoFg0TbJu8Ais2ApPnTw44ufAfV/qm4Po7DtKY2S9TEjUpYf
	 Vppt4H4PmBEk58s0ZtzCE8r5Qjq7IHb/w3/wTzszLch1RI4wDygdESNkFTYLdTelvd
	 2Vz877ApPOsFBw8+jCjYcM0FrWAmpqtxwX2nTeqP827XcSs4Tmw0MnVw/uhzkjKlJJ
	 neC8/MueAP6wFYnL8fgTHnyrXAicmdZjMHewxtiaMB2eOepRCfIdcpgfQudIb3xLp0
	 Kl2dt9r/Wp17Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70A9D3809A80;
	Thu,  7 Nov 2024 02:00:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net-next] net: broadcom: use ethtool string helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173094484124.1489169.8971635919773008705.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 02:00:41 +0000
References: <20241104205317.306140-1-rosenp@gmail.com>
In-Reply-To: <20241104205317.306140-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, justin.chen@broadcom.com,
 florian.fainelli@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bcm-kernel-feedback-list@broadcom.com, rafal@milecki.pl, opendmb@gmail.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 Nov 2024 12:53:17 -0800 you wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer. Cleans up the code quite well.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: split off bnx2x changes.
>  .../ethernet/broadcom/asp2/bcmasp_ethtool.c   |  6 +++---
>  drivers/net/ethernet/broadcom/bcm63xx_enet.c  | 12 +++++------
>  drivers/net/ethernet/broadcom/bcmsysport.c    | 20 +++++--------------
>  drivers/net/ethernet/broadcom/bgmac.c         |  3 +--
>  .../net/ethernet/broadcom/genet/bcmgenet.c    |  6 +++---
>  drivers/net/phy/bcm-phy-lib.c                 |  3 +--
>  6 files changed, 19 insertions(+), 31 deletions(-)

Here is the summary with links:
  - [PATCHv2,net-next] net: broadcom: use ethtool string helpers
    https://git.kernel.org/netdev/net-next/c/fda960354eac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



