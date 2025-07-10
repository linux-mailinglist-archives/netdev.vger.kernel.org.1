Return-Path: <netdev+bounces-205641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD69AFF732
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 05:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300A81C43D74
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 03:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E8728136C;
	Thu, 10 Jul 2025 03:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkH1wiXJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2327428134C;
	Thu, 10 Jul 2025 03:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116405; cv=none; b=qUkMO596wFk0jpDGVmHEtIAIJiCkl6FIO65wKGcMwZd0yoo/RXgetutbsvwSZ2d5z4eoMO++PiVGdoh/0O0tyEXx2PLhTJWuB5vqHdjEPDa9C0fkN+39ay5lvGP33QbmSegVK/imPhpS5/3LPih8AltdmVX/9orxcA/PvijnZcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116405; c=relaxed/simple;
	bh=oyTTKAm8NxEW9WEWNi24ZZzDpdrF2xXPDNHBe+pVZdM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h16Xfu7GNQlrteCjzeyzx0fyXMwfoejz3awlcqawqYHJgsEKYVe5I6u7oXn50ILRzTOXePtHE6iESpMv7UEKlOLLzDYcDuwkV/OZnHm6m7WX+QbAyVquSYQBe74ZycVGJPGv7hhGg25kDOH/CoViel3dB8e+aW+7Hu9YOwUVXds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkH1wiXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D23CC4CEF0;
	Thu, 10 Jul 2025 03:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752116404;
	bh=oyTTKAm8NxEW9WEWNi24ZZzDpdrF2xXPDNHBe+pVZdM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JkH1wiXJ3IyBrWAtBjNGvCYNwGLaFSRmUYgR/wbpGk7vVgl87dMoMS22UEbGWZff4
	 jSr+4bFGcyxwjzNpOYp2Apy4XxH0v2RUx8hT0MF1aqLyES/4rCUwxAL7EP/yH9GxUo
	 kvrwtTQu58fVxBt8WQ4S09nc67hqOKDxkWFx5Fyuvm2/u+5TAVcmHQYbfAY4NXXBn1
	 jEYyB1jpRJ5c8PXW4HQpedwJkh92NEtOTBfjUt9eL0whWv7oTE7eL2WLDYQjdiVH+Y
	 tHJZ9OKHD6moGNK2H2BZMCNfckXtXrBZMRSXtbDns2l8xxDcylAjcDyVauNdJMUSEG
	 FKA01f7cGm4gQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D7F383B261;
	Thu, 10 Jul 2025 03:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/4] net: phy: bcm54811: PHY initialization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175211642700.969691.12423732626621793373.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 03:00:27 +0000
References: <20250708090140.61355-1-kamilh@axis.com>
In-Reply-To: <20250708090140.61355-1-kamilh@axis.com>
To: =?utf-8?q?Kamil_Hor=C3=A1k_-_2N_=3Ckamilh=40axis=2Ecom=3E?=@codeaurora.org
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org,
 andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 8 Jul 2025 11:01:36 +0200 you wrote:
> Proper bcm54811 PHY driver initialization for MII-Lite.
> 
> The bcm54811 PHY in MLP package must be setup for MII-Lite interface
> mode by software. Normally, the PHY to MAC interface is selected in
> hardware by setting the bootstrap pins of the PHY. However, MII and
> MII-Lite share the same hardware setup and must be distinguished by
> software, setting appropriate bit in a configuration register.
> The MII-Lite interface mode is non-standard one, defined by Broadcom
> for some of their PHYs. The MII-Lite lightness consist in omitting
> RXER, TXER, CRS and COL signals of the standard MII interface.
> Absence of COL them makes half-duplex links modes impossible but
> does not interfere with Broadcom's BroadR-Reach link modes, because
> they are full-duplex only.
> To do it in a clean way, MII-Lite must be introduced first, including
> its limitation to link modes (no half-duplex), because it is a
> prerequisite for the patch #3 of this series. The patch #4 does not
> depend on MII-Lite directly but both #3 and #4 are necessary for
> bcm54811 to work properly without additional configuration steps to be
> done - for example in the bootloader, before the kernel starts.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/4] net: phy: MII-Lite PHY interface mode
    https://git.kernel.org/netdev/net-next/c/67c0170566b5
  - [net-next,v7,2/4] dt-bindings: ethernet-phy: add MII-Lite phy interface type
    https://git.kernel.org/netdev/net-next/c/fbe937473f3a
  - [net-next,v7,3/4] net: phy: bcm5481x: MII-Lite activation
    https://git.kernel.org/netdev/net-next/c/34bf222824f6
  - [net-next,v7,4/4] net: phy: bcm54811: PHY initialization
    https://git.kernel.org/netdev/net-next/c/3117a11fff5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



