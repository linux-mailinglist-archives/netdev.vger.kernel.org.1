Return-Path: <netdev+bounces-143179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F639C159B
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 05:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6C91C20DFB
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D839513D278;
	Fri,  8 Nov 2024 04:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBdazqVh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B304CEBE
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 04:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731041423; cv=none; b=rVNaWPeF0sQAY6Y5SPRpx1OoeqcubSin9kuy+QZQ/WCDIvyQ9bThnRcvGyT0uZQRCXxGIoIhbx96U9TpuEIZrQOaSsi1yuAk0V4dw3mSD7Rn14Epa6dMfG0YoPAguBPl4YKsKqmChih9MX04JP/s0TjrpA2lHkeP7X8Rymkqh/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731041423; c=relaxed/simple;
	bh=WykPzlcUbDldrnUASm1PShM41J5wzL10VPXf6kJAU+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZnooT/dSBeimBvCJRnM7KuRwtWQ02ipfKuqi3YgKoPufgSl6YAHfkwlmdPqDI483kqTcb+GzZLM2MM8G3TgQnWLSfoNAmuRb/yFORBagDZ7lQgjWiHyEWrnunEqS+CwmaNPmcHlBvzNhZ+V6r/mcIAq0sMyYa3xU4bfhMsNdYHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBdazqVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3463BC4CECE;
	Fri,  8 Nov 2024 04:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731041423;
	bh=WykPzlcUbDldrnUASm1PShM41J5wzL10VPXf6kJAU+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DBdazqVhJqQ1eFjocctDTRD9T2KtbT5P0KebB3CLG8WIy4AEPSNfq1nQg5JamGC/u
	 lbU56dvL9+UGGwEZKE8pbtGb1b7x8sOm2rBsJxB7eA/05IfxL9R+SFX8QntIWQH2+J
	 N/EfOEZFXcBo3r4fPk69vqQoBDOVFXbuNmTM7Y05WFr4LPO/B/Gc90Jb6nzCxdHLkR
	 YjRHHrq8wP4PHKvUx/Duil1Ne8GoeIP0bICwHjm2z6z8PDhMkJOSbPFAMw2Ku/IoGT
	 +iAvyfgDerIhoCWKlqruycjRL3dsIVs3jeUlGrYvp/U4DnVMnCX2mbBHjnRBm0/FaH
	 HQpl3Cq+uZi7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0463809A80;
	Fri,  8 Nov 2024 04:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net: phy: remove genphy_config_eee_advert
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173104143248.2196790.13746229399258043023.git-patchwork-notify@kernel.org>
Date: Fri, 08 Nov 2024 04:50:32 +0000
References: <69d22b31-57d1-4b01-bfde-0c6a1df1e310@gmail.com>
In-Reply-To: <69d22b31-57d1-4b01-bfde-0c6a1df1e310@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew@lunn.ch,
 florian.fainelli@broadcom.com, davem@davemloft.net, linux@armlinux.org.uk,
 netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 6 Nov 2024 21:19:02 +0100 you wrote:
> This series removes genphy_config_eee_advert().
> 
> Note: The change to bcm_config_lre_aneg() is compile-tested only
> as I don't have supported hardware.
> 
> Heiner Kallweit (4):
>   net: phy: make genphy_c45_write_eee_adv() static
>   net: phy: export genphy_c45_an_config_eee_aneg
>   net: phy: broadcom: use genphy_c45_an_config_eee_aneg in
>     bcm_config_lre_aneg
>   net: phy: remove genphy_config_eee_advert
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net: phy: make genphy_c45_write_eee_adv() static
    https://git.kernel.org/netdev/net-next/c/9c477088b60d
  - [net-next,2/4] net: phy: export genphy_c45_an_config_eee_aneg
    https://git.kernel.org/netdev/net-next/c/bcfb95c9898a
  - [net-next,3/4] net: phy: broadcom: use genphy_c45_an_config_eee_aneg in bcm_config_lre_aneg
    https://git.kernel.org/netdev/net-next/c/3cc97d2fa987
  - [net-next,4/4] net: phy: remove genphy_config_eee_advert
    https://git.kernel.org/netdev/net-next/c/db73835f54fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



