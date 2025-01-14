Return-Path: <netdev+bounces-158102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB47BA10768
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F6C1887B49
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A039234D1B;
	Tue, 14 Jan 2025 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ow2WHjQt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A25822DC30;
	Tue, 14 Jan 2025 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860214; cv=none; b=WxuZuctY+kLM3+eblipCV2Y2cgMzyvJ9IVvjtGcc0vcSu15rT1Dve+EmzVNN0gvTT2r/pWisPIUmwAdoTMcpNYj3fWA71eE/RFmI8FgTFKfGZSguVBgkSu8OeH44O2XB8geWiz5TV1GIUfipgX2MwAgucr1zYAE9QZ5Su91FADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860214; c=relaxed/simple;
	bh=plMxn+cst3kKie+wciMIyThJiMxj1za/IQtJIMB+8tU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fYZQWvfa16K28tC3c3TP0f4xdHhHECathbVimYbfGloPeV3dJy/EPBbWB2L5CwPMYgKd4zMb3OmqdLPQ6vjh4KxSdnPGzV1JoLf0Awsue4948B2LQgxtAS+iRFZWtg1nRpJQAu9zJoR4/jlICV2F7PfP5v5T8+Ny7tF8JBOPYKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ow2WHjQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B4CC4CEDD;
	Tue, 14 Jan 2025 13:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736860213;
	bh=plMxn+cst3kKie+wciMIyThJiMxj1za/IQtJIMB+8tU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ow2WHjQtU1SIKoHu9q8Z7NKLtQb0nGAOzhV3f2wGZT3hBIbQIyQ2EIKxfZZJGAPz3
	 eYZJFsk+CL47uTANie1RKbKo6tPbwTHQq91NIkpgDuUAt+yuu25z9qikhadxGiSoOM
	 WSNfQYdhyqeasGvorvie+aVCgkbHqx1sJ2BSEUZFGnrrq9G4MoAJrs0wMHLFVT2qy7
	 wiP4U9iMI2n8nX/Y6jQo+pkpGiio/ki39Lxg1GfzWYDYMHB9hbyBaad9QHj4IVDFnZ
	 t4ImpMzhUOj4XUUezozFyYYDsBMcsaUi+OqoAYP4rLQI+p8KOt3m/Y+u+YHkJltno5
	 yhBx7wVJPv2gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEA8F380AA5F;
	Tue, 14 Jan 2025 13:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/12] Arrange PSE core and update TPS23881
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173686023633.4176388.12044026937788187376.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 13:10:36 +0000
References: <20250110-b4-feature_poe_arrange-v3-0-142279aedb94@bootlin.com>
In-Reply-To: <20250110-b4-feature_poe_arrange-v3-0-142279aedb94@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: o.rempel@pengutronix.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, thomas.petazzoni@bootlin.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, kyle.swenson@est.tech,
 dentproject@linuxfoundation.org, kernel@pengutronix.de,
 maxime.chevallier@bootlin.com, kalesh-anakkur.purayil@broadcom.com,
 andrew@lunn.ch

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 10 Jan 2025 10:40:19 +0100 you wrote:
> This patch includes several improvements to the PSE core for better
> implementation and maintainability:
> 
> - Move the conversion between current limit and power limit from the driver
>   to the PSE core.
> - Update power and current limit checks.
> - Split the ethtool_get_status callback into multiple callbacks.
> - Fix PSE PI of_node detection.
> - Clean ethtool header of PSE structures.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/12] net: pse-pd: Remove unused pse_ethtool_get_pw_limit function declaration
    https://git.kernel.org/netdev/net-next/c/514dcf78afe6
  - [net-next,v3,02/12] net: pse-pd: Avoid setting max_uA in regulator constraints
    https://git.kernel.org/netdev/net-next/c/675d0e3cacc3
  - [net-next,v3,03/12] net: pse-pd: Add power limit check
    https://git.kernel.org/netdev/net-next/c/6e56a6d47a7f
  - [net-next,v3,04/12] net: pse-pd: tps23881: Simplify function returns by removing redundant checks
    https://git.kernel.org/netdev/net-next/c/0b567519d115
  - [net-next,v3,05/12] net: pse-pd: tps23881: Use helpers to calculate bit offset for a channel
    https://git.kernel.org/netdev/net-next/c/4c2bab507eb7
  - [net-next,v3,06/12] net: pse-pd: tps23881: Add missing configuration register after disable
    https://git.kernel.org/netdev/net-next/c/f3cb3c7bea0c
  - [net-next,v3,07/12] net: pse-pd: Use power limit at driver side instead of current limit
    https://git.kernel.org/netdev/net-next/c/e0a5e2bba38a
  - [net-next,v3,08/12] net: pse-pd: Split ethtool_get_status into multiple callbacks
    https://git.kernel.org/netdev/net-next/c/3e9dbfec4998
  - [net-next,v3,09/12] net: pse-pd: Remove is_enabled callback from drivers
    https://git.kernel.org/netdev/net-next/c/4640a1f0d8f2
  - [net-next,v3,10/12] net: pse-pd: tps23881: Add support for power limit and measurement features
    https://git.kernel.org/netdev/net-next/c/7f076ce3f173
  - [net-next,v3,11/12] net: pse-pd: Fix missing PI of_node description
    https://git.kernel.org/netdev/net-next/c/10276f3e1c7e
  - [net-next,v3,12/12] net: pse-pd: Clean ethtool header of PSE structures
    https://git.kernel.org/netdev/net-next/c/5385f1e1923c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



