Return-Path: <netdev+bounces-192513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA4FAC02FD
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 05:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01261BC1B7E
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 03:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34989158DD4;
	Thu, 22 May 2025 03:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNMFvVsQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116A15381A;
	Thu, 22 May 2025 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747884606; cv=none; b=BEzdrsaeb3JhdkPdA7oos4/bM0G2l9kWja3OOdd92wL6CK7nxx0UImWSEcy6jmLfl0iKsVEbS9AKtmH2i7UUUc8XZI7qhzxKsI+QadAAxKD5ApKbScipLiQ7hIY0OZ8XqZjvzRtfST7AM7ho+OLQ86mPQqcN7OwiADZZLojhxf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747884606; c=relaxed/simple;
	bh=F3QYeqfw3fb5C5b/cssGX7pGImSvJCuFQi3Z94a+iUs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eQ3NaflLvHZ8Z6w9JfAbP/RowPArf9f6Jze/pcCDO4/FeLspt9D0tURZ7KYesjBj0l6oIMPLWhUtJfQFUyG+n6t/753szwXfEX8JXFuKext283UpXGhACXBLI4ITFIYPfuQfHIxOE/rLeTGliyFtc3cQVJ/YwDMYMw6QZ6sIbuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNMFvVsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD06C4CEE4;
	Thu, 22 May 2025 03:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747884605;
	bh=F3QYeqfw3fb5C5b/cssGX7pGImSvJCuFQi3Z94a+iUs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CNMFvVsQHtzlv3yc0XWkoesPBEpdL3YAm6l6lbu1DZ3oNrpdi2WXvGlLzXr8U1BkW
	 DrAslfmKnpqqRwklHx5C55MqL8n0igh1314HCM7finyMZU8xMwV2XSqFq8udQQZ4w+
	 3GUHmVQA3mOwgb5gX7qdqAcL+iqO5n2y7ZamOJbrP1TgtDTluoi4dAwOqqQuGEsAzm
	 ZWEZxrIlgi7pl5mGLWVcxqMJqQtDz3idXvm2x/74PPpTR1d44kZEihsBIHPQmBC0yy
	 xcm968TlzBh1Ac2Cvrbgb5O+rIAgY0kSszAa6TRp58jJaYqBGPWqzeG0E6FJ3kKtyj
	 766j03CqhDr7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34A70380AA7C;
	Thu, 22 May 2025 03:30:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v12 0/6] net: phy: Add support for new Aeonsemi PHYs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174788464101.2365353.11675172147979380830.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 03:30:41 +0000
References: <20250517201353.5137-1-ansuelsmth@gmail.com>
In-Reply-To: <20250517201353.5137-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 kabel@kernel.org, andrei.botila@oss.nxp.com, fujita.tomonori@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
 dakr@kernel.org, sd@queasysnail.net, michael@fossekall.de,
 daniel@makrotopia.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 17 May 2025 22:13:44 +0200 you wrote:
> Add support for new Aeonsemi 10G C45 PHYs. These PHYs intergate an IPC
> to setup some configuration and require special handling to sync with
> the parity bit. The parity bit is a way the IPC use to follow correct
> order of command sent.
> 
> Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
> AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
> AS21210PB1 that all register with the PHY ID 0x7500 0x7500
> before the firmware is loaded.
> 
> [...]

Here is the summary with links:
  - [net-next,v12,1/6] net: phy: pass PHY driver to .match_phy_device OP
    https://git.kernel.org/netdev/net-next/c/31afd6bc55cc
  - [net-next,v12,2/6] net: phy: bcm87xx: simplify .match_phy_device OP
    https://git.kernel.org/netdev/net-next/c/5253972cb955
  - [net-next,v12,3/6] net: phy: nxp-c45-tja11xx: simplify .match_phy_device OP
    https://git.kernel.org/netdev/net-next/c/1b76b2497aba
  - [net-next,v12,4/6] net: phy: introduce genphy_match_phy_device()
    https://git.kernel.org/netdev/net-next/c/d6c45707ac84
  - [net-next,v12,5/6] net: phy: Add support for Aeonsemi AS21xxx PHYs
    https://git.kernel.org/netdev/net-next/c/830877d89edc
  - [net-next,v12,6/6] dt-bindings: net: Document support for Aeonsemi PHYs
    https://git.kernel.org/netdev/net-next/c/3e2b72298904

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



