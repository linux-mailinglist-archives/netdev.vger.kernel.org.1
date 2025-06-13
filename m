Return-Path: <netdev+bounces-197288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB945AD804D
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07D11897792
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1271E1C36;
	Fri, 13 Jun 2025 01:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3UhjqcM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FA41E130F
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 01:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749778210; cv=none; b=pv9TVFPik6bLryz8krffezDK85T0q5mEbLILlAxH0D+OjpRjWwbyLSfs7LJ1cS38zuCpuI0EfeHIQ1eCQYFKVmD3DOgOSM/qCNnFPvnmlkXUkjMswDv65Pp2w/aYmSlXFkgDPhmQaK4rzC93V2OKSkGt1i7aNtRafRt3lwecmGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749778210; c=relaxed/simple;
	bh=7aqaqkY2dxdVxNkfQ4rsqGhn0WJwqTkmEBr4QRxJPp4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OfdfEDWPFY6vC1kgRTl3mMh/SuX9Mc+F+bOhoZjQ/oNZfPhq9YOHZAJeMMTJyBdWMXS2hSXYh1codpOzHhCGM+anWW45KupSi0cRFqmeTJgn9ohwJwh13cPoppJM06K+i9XS1wREWh8/WirdhnpLajMljw/3KDcS6QdcKgOVOQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3UhjqcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F97EC4CEEA;
	Fri, 13 Jun 2025 01:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749778210;
	bh=7aqaqkY2dxdVxNkfQ4rsqGhn0WJwqTkmEBr4QRxJPp4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a3UhjqcM2le42dMg+YBHAjpP5ZV7Y/WEvqhcOP+IjQb2HR2kb/LrWKfKwtJzvQ5q1
	 yiYGDgXP7feuArcP5n+69kCS8VqREHMISgp1CKsyItQC7trTQ4Vb9d6JEByLG4Asw3
	 3tJ6y8gRSz8UKD9V9pH9N9uZra+P8rC59kHN871M4NuByLmEDL4PqgjguJ4zcOKvG3
	 E/e7uSE9BE4+Mn1eP2JZbhkHYkP8202ECE0hejcWs7Bim97OtZ1+7rekI1QpqQduBC
	 KjN6QVb6jjZvS2m1TbRcI66rqtOQ+4f554A+mbndKC2HwSj82NQhvVKcTH3nFtbctF
	 ajakNBO2aaoAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AEA39EFFCF;
	Fri, 13 Jun 2025 01:30:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: simplify phy_get_internal_delay()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174977823974.179245.189842303724841936.git-patchwork-notify@kernel.org>
Date: Fri, 13 Jun 2025 01:30:39 +0000
References: <E1uPLwB-003VzR-4C@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1uPLwB-003VzR-4C@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Jun 2025 14:56:19 +0100 you wrote:
> Simplify the arguments passed to phy_get_internal_delay() - the "dev"
> argument is always &phydev->mdio.dev, and as the phydev is passed in,
> there's no need to also pass in the struct device, especially when this
> function is the only reason for the caller to have a local "dev"
> variable.
> 
> Remove the redundant "dev" argument, and update the callers.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: simplify phy_get_internal_delay()
    https://git.kernel.org/netdev/net-next/c/c4688ff47fd7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



