Return-Path: <netdev+bounces-206941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DFCB04D26
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 02:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3CDF3B3250
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D206819343B;
	Tue, 15 Jul 2025 00:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMTyCV27"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750912BF24;
	Tue, 15 Jul 2025 00:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752541187; cv=none; b=O08qlfm9G9Z43fBx/pzniX8+i7N49tOIseuCj43Fpl5bbyWn2E4I3XYq1Izeo8wW3uR34YVQwRyrWQvCwhTsctA0OvCcIBufHFgtWHdsI5tK85tZMfn4KIpjyPUntaLyk7p0M4pxSN+94lXx8qqC1Za9q5CsvV6XSte1Jg922Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752541187; c=relaxed/simple;
	bh=BAmMF3masB8hOzrJYoLKNs9OQnyWaKnpd12q+wIjnTs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DikmnpdoOskynVsf5VLjTmzo4K35cW1QPfN7GbiBb8aOetMXcoaXZqVu6Tvd+7IzgJM5j0PnfEpvzDz+N+rXc7gAOCB83d7qAoR+2sTN7ZK7sYoq4hbV5S2gZYEXlPmpgZtG33pGL9wwxxIykRm9MkHuPOp7NsFsc6zeBigPN3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMTyCV27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EE5C4CEED;
	Tue, 15 Jul 2025 00:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752541187;
	bh=BAmMF3masB8hOzrJYoLKNs9OQnyWaKnpd12q+wIjnTs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gMTyCV27tKKAKJfaSLGjlfDNl7nt0VfKLHxM1NzpwkP4vYUiKeaxtxcaB1iq7QbsB
	 P0GqaFn+AYEtMimEgB3/R3+DmWUlQTjfVumgs4+fHwyHKq/6YNHzWeUwIjKpp9mQEU
	 WAilK4k1joOBG6WZwa/rD5wcLa/p7KQ+BN6x1lBttkfctPerESDIXCPY2w9MdMEHeH
	 GD4WixAH2M+ztZcUSTMQ8d+lRgLZ3DJfosy62RUqZ+H2rVDWN9txu1AuDsa2RNg2fk
	 +OqAeAh5h4QVkiJypNsdrYLdvV6AuUl29cz0/hGxZqa0nFsSOmEt1MmPjSsXrN1ibN
	 XStaRy7JifPaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C7A383B276;
	Tue, 15 Jul 2025 01:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: Don't register LEDs for genphy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175254120801.4044098.17800015732191157887.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 01:00:08 +0000
References: <20250710201454.1280277-1-sean.anderson@linux.dev>
In-Reply-To: <20250710201454.1280277-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ansuelsmth@gmail.com,
 f.fainelli@gmail.com, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Jul 2025 16:14:53 -0400 you wrote:
> If a PHY has no driver, the genphy driver is probed/removed directly in
> phy_attach/detach. If the PHY's ofnode has an "leds" subnode, then the
> LEDs will be (un)registered when probing/removing the genphy driver.
> This could occur if the leds are for a non-generic driver that isn't
> loaded for whatever reason. Synchronously removing the PHY device in
> phy_detach leads to the following deadlock:
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: Don't register LEDs for genphy
    https://git.kernel.org/netdev/net-next/c/a44312d58e78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



