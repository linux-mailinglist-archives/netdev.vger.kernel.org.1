Return-Path: <netdev+bounces-219367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F98B410C8
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2605F562165
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5A52820AC;
	Tue,  2 Sep 2025 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTeKnxgb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B53327B500
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756855805; cv=none; b=nLCr5rB9Z4K5JjO102nOuPjkHuKZ1ET/IkC9epg46xyL+jx0q6VTpX7baOgvMQ7PGAmxNNsE1+NZEHE3Cnis4LQfSj31w7iyjfEybf8eySgDezlP9ucXTXuwpHgJvEbgmvmIZks8n8+mhZWi6T0RRFUjD/LIbOcQWT6qGInCnqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756855805; c=relaxed/simple;
	bh=1iZHQBshwuHRevEymIo6dco6n3zU0Jqlwgkf7PR+1RY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pnQcPG4duKe0eU8u1Y+K3GTt6zcSND2ubxpyxlFoD27GkOWGTRio/fRsebQSmnluJMScg275ar3s5TUSYPufJSoAbiuk4sSSP2rp+1n2TGIOp2CiY0Ga1oDqgkqGWk7RXXQh9dzcWyJZpPxlA99ua9gvmaIvqHkwLFWvouctgGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTeKnxgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D53DC4CEED;
	Tue,  2 Sep 2025 23:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756855805;
	bh=1iZHQBshwuHRevEymIo6dco6n3zU0Jqlwgkf7PR+1RY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZTeKnxgb/Z/dOgj/1iq8q5bGLdxCO3rZ5Ufdig3FJjcKuZng1USjJ1LgDa6Nnr1oO
	 1yUXMe25Gw4crK7zRakx2vgTib52m03TpuN/IxiAAMfIoqrXTomJpQ3DRSt3jEjTgk
	 09rmI7exzcBZYt9zbCcgtM6s9uTHwIeDJPuMPmHc9UFgzrqWDS8QoiICuWnChldRNm
	 ayiLNjbqUY5BtkQAY0F6bUjPz6NUDyAiyqS16t2fnM0P/VJUcRjSvu/Snitipaz/ew
	 EQAFxrCLKS5pdYusG1jdp0FQ99C1CoppC/Cwx7DBKwZwbjBDxlpPyKbRmIVZHONuX7
	 kmpo1NVzJ7Nig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE053383BF64;
	Tue,  2 Sep 2025 23:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] net: fix optical SFP failures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175685581051.468066.16262895219684043683.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 23:30:10 +0000
References: <aLSHmddAqiCISeK3@shell.armlinux.org.uk>
In-Reply-To: <aLSHmddAqiCISeK3@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, matt@traverse.com.au,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 31 Aug 2025 18:34:17 +0100 you wrote:
> Hi,
> 
> A regression was reported back in April concerning pcs-lynx and 10G
> optical SFPs. This patch series addresses that regression, and likely
> similar unreported regressions.
> 
> These patches:
> - Add phy_interface_weight() which will be used in the solution.
> - Split out the code that determines the inband "type" for an
>   interface mode.
> - Clear the Autoneg bit in the advertising mask, or the Autoneg bit
>   in the support mask and the entire advertising mask if the selected
>   interface mode has no inband capabilties.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net: phy: add phy_interface_weight()
    https://git.kernel.org/netdev/net/c/4beb44a2d62d
  - [net,2/3] net: phylink: provide phylink_get_inband_type()
    https://git.kernel.org/netdev/net/c/1bd905dfea98
  - [net,3/3] net: phylink: disable autoneg for interfaces that have no inband
    https://git.kernel.org/netdev/net/c/a21202743f9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



