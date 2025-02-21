Return-Path: <netdev+bounces-168696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C31FFA40374
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 00:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0833B189EEEE
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 23:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79DB2512D7;
	Fri, 21 Feb 2025 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vhf0qQ0v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C086824E4BF;
	Fri, 21 Feb 2025 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740180599; cv=none; b=r8wE8ccnlxou5et1agiXaNlUfUx+vq+GKTGAYsYXfuy4Q2GrEjqOPRtskKnmQZHggvhHH6myYld4QgAsoEl5Z72x8jcH20K3bECoVlUFfMu+Yuuc++cAsDwXd1RLrMWq4RwnwgU5UqC3TDb34AYB2cblyRrB3VZ158PHVQogis0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740180599; c=relaxed/simple;
	bh=QrMx7i4NMDdJbHUydUFTbi3xniAj9JRWH5I9HdeVqLo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ixzt+nPvAheen3is9wzsIztDggzW7ZqF7A29LoppzGPEOVz64IceF+nmJk07UwHhplsm9xcXAoSLPll15t/2Jd05rrQmHAI2WoNhnFgikSYeMQlZCuaxGwxo+h5pFgi8Ud6V16QNmGZXI43rnPxRzwEIs6+wtALjEuAal070F/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vhf0qQ0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A63C4CEE8;
	Fri, 21 Feb 2025 23:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740180599;
	bh=QrMx7i4NMDdJbHUydUFTbi3xniAj9JRWH5I9HdeVqLo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vhf0qQ0vCz6xbOdbibyG2YHM2tMMySz7NsFKC6XSaFWiZwrj8+gN4WI9EcdE7mB9z
	 CgZtJohGoYNSq8eTYZqy/+G5ljGja9lsexvwGWx3Hx58mcRrOGycxnYpY09IS9CG/1
	 9qYRUrnGQ9waRJo9lV5hUXrD4l28dMIpxA0la7gTMUF6CCqh9WpK9AY2xqoE68w5tM
	 L7TtXKezCXzpikGbuzwWZzE2V8z4oIGEW1CNei5d7RHzOibB1lsW0DwUNJZbALMfZv
	 LhQtOFjY3UpqgbTxohqrk7Fn5bGkiDqULziREnmHoN6z9rAp2Rx9RGdY2L2bIGhHD+
	 e4ryu3fN+hJbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FC9380CEEC;
	Fri, 21 Feb 2025 23:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sfp: add quirk for 2.5G OEM BX SFP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174018063000.2236176.16722302541554170478.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 23:30:30 +0000
References: <20250218-b4-lkmsub-v1-1-1e51dcabed90@birger-koblitz.de>
In-Reply-To: <20250218-b4-lkmsub-v1-1-1e51dcabed90@birger-koblitz.de>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, daniel@makrotopia.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Feb 2025 18:59:40 +0100 you wrote:
> The OEM SFP-2.5G-BX10-D/U SFP module pair is meant to operate with
> 2500Base-X. However, in their EEPROM they incorrectly specify:
> Transceiver codes   : 0x00 0x12 0x00 0x00 0x12 0x00 0x01 0x05 0x00
> BR, Nominal         : 2500MBd
> 
> Use sfp_quirk_2500basex for this module to allow 2500Base-X mode anyway.
> Tested on BananaPi R3.
> 
> [...]

Here is the summary with links:
  - [net-next] net: sfp: add quirk for 2.5G OEM BX SFP
    https://git.kernel.org/netdev/net-next/c/a85035561025

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



