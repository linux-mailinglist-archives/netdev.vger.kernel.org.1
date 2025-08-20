Return-Path: <netdev+bounces-215137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9951FB2D26B
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 05:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09D117B916E
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825AA2D3755;
	Wed, 20 Aug 2025 03:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMMPNhDs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1912D374E
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 03:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755659505; cv=none; b=L9NRCkOGSvD+1UbWgA99TLkeJ0anpQrs2rmlqiYDifyCKX67qXjJA6IBQ96IBSb61qRCupKG/aLJxEtG+cpIcGQ7V8zt4Ndk+0O7VjMDp2L8vJgKQ1Fd4N1Ffn7IM4hRrGkWB4J1TtnvRgC4jHDNnFRFw1LFpPUX2G9AhlDBGqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755659505; c=relaxed/simple;
	bh=5KcFUIpg+3Cb0ffpuwt/56y4Y9pyDGpEZJ7Gw7vlSRE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=olsXDt9614JUZuFKePPhIoZSeD6O7ezpnSkOA1Lgh0zjpF1pGVeHV/xkpUUQSwZNw0WNwp9cMgDBHbTWitk3v9V8aXdubMPjSfRc48E5/7WSN9/dh/kqn1R64XFZwNUZr5pGApQyRHFUucBF5TQxXNbX6ecmbN8qHdj+Rk7hCYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMMPNhDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3C2C4CEF4;
	Wed, 20 Aug 2025 03:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755659505;
	bh=5KcFUIpg+3Cb0ffpuwt/56y4Y9pyDGpEZJ7Gw7vlSRE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dMMPNhDszphRKw10tkjuzt5a3d7IkTl/VCi7mdTXmJ2pKRlutcuPGJkdqpv2Uz1PP
	 KA7kF/DvmWf9O7skH2N8n/TuXDz3akxSZ1DS2560oLSPfRoI/8mHwgYiQRo1GCPXqB
	 cNqvjrpVlKKCKdLHP7JIZ011I+x9BTyt+02PaRAUzOuCd+HCMT3ie3vY4rX98J4X5B
	 uPGJSszhRV+Cf732TumYTsvxlQSuMZOBIkHoPVEXw3mh8PgHrGhGQtyDUrp4vuTQ2R
	 Rsi+Wc97laSY1f7g0wwrSLpqlfd4OFly1WxUVTCv8lWkHZDxE0l3QMiRjJB+v1Jbq4
	 hrTmUYvu03y0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E3E383BF58;
	Wed, 20 Aug 2025 03:11:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: realtek: enable serdes option mode for
 RTL8226-CG
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175565951474.3753798.14843663767219796679.git-patchwork-notify@kernel.org>
Date: Wed, 20 Aug 2025 03:11:54 +0000
References: <20250815082009.3678865-1-markus.stockhausen@gmx.de>
In-Reply-To: <20250815082009.3678865-1-markus.stockhausen@gmx.de>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michael@fossekall.de, daniel@makrotopia.org, netdev@vger.kernel.org,
 jan@3e8.eu

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Aug 2025 04:20:09 -0400 you wrote:
> The RTL8226-CG can make use of the serdes option mode feature to
> dynamically switch between SGMII and 2500base-X. From what is
> known the setup sequence is much simpler with no magic values.
> 
> Convert the exiting config_init() into a helper that configures
> the PHY depending on generation 1 or 2. Call the helper from two
> separated new config_init() functions.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: realtek: enable serdes option mode for RTL8226-CG
    https://git.kernel.org/netdev/net-next/c/3a752e678001

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



