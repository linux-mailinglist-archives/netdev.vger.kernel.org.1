Return-Path: <netdev+bounces-191805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A86ABD547
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 12:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B088A0444
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 10:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3082701D2;
	Tue, 20 May 2025 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh9Rw5MU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856BE2701DD
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737594; cv=none; b=et0FgqQvQ1Gye75fekv9eAbLJLyxeOk4yt3M3MY4D7LFgh0Aja/YVk8uWm9NkuPQzUME/Nz+K66IbSYVoFpr6XKfQxyMW9YS54KBKQ4wHeBuqW3QqeAPnN6HMPh0lXEafxnoG/X88vl+x9Xdt5e/P/tas+oEeswUtZbTXADiHdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737594; c=relaxed/simple;
	bh=sx815yxCPMCHtaQyP6o68PmEHvtCXCcRWgkSBKZgI/c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R31okaxBBFcbO1iF3HcWK45zH9AMgjoMHYcJMNenSjXUyUK47CNvhkfc5F9rL5orCGMsew96BjMkeaHcxTb6oaeZuwWsmr+UFcB4glUTtppo03MINEi8n4aOquZbxuYcUMpAEdpgex/999TcHn1Xg/KRZxGiwnrP1g3DVoZ8bm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh9Rw5MU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038D5C4CEE9;
	Tue, 20 May 2025 10:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747737594;
	bh=sx815yxCPMCHtaQyP6o68PmEHvtCXCcRWgkSBKZgI/c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vh9Rw5MU7Kt6ILdmF58RWEqRpt7HAZCAvgbuwc34LGqBCdPhdcd9yIc27Scl/F6zA
	 OEnZ3AI35c3lA0F+rnne09Z7tcwgUxWpuT4yIzrqVRMDOqzG9pagcHaSA8YkuWZb7U
	 uDjvt1AirSFfbEsgqUvORpv5rieEJR9PVtejb0+efASQagD1C+VoUOTsPHrsPWlkes
	 xw0JoWvnhZlHOm0+NXId8qXZ2+0+8Nwq2aC6mdOdPe0WQG7ejOOIM/92q3rB7u7PHT
	 Gy8OeWa9GtURICfk6/A3udNdBv29IPfO2kBOXQQNWrtsMuqjKS3GvSqARWKwFV7Kxp
	 fT1IapFezC4RQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F48380AA70;
	Tue, 20 May 2025 10:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: phy: make mdio consumer / device layer a
 separate module
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174773763001.1260973.15264235840147013260.git-patchwork-notify@kernel.org>
Date: Tue, 20 May 2025 10:40:30 +0000
References: <dba6b156-5748-44ce-b5e2-e8dc2fcee5a7@gmail.com>
In-Reply-To: <dba6b156-5748-44ce-b5e2-e8dc2fcee5a7@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, andrew+netdev@lunn.ch,
 pabeni@redhat.com, edumazet@google.com, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 15 May 2025 10:11:54 +0200 you wrote:
> After having factored out the provider part from mdio_bus.c, we can
> make the mdio consumer / device layer a separate module. This also
> allows to remove Kconfig symbol MDIO_DEVICE.
> The module init / exit functions from mdio_bus.c no longer have to be
> called from phy_device.c. The link order defined in
> drivers/net/phy/Makefile ensures that init / exit functions are called
> in the right order.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: phy: make mdio consumer / device layer a separate module
    https://git.kernel.org/netdev/net-next/c/31be641d7426

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



