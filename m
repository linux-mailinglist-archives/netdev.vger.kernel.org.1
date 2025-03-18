Return-Path: <netdev+bounces-175633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7627A66F8C
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2A9E7A5B8C
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8AB2066ED;
	Tue, 18 Mar 2025 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNmFt+iG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D6A1F9F5C
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742289599; cv=none; b=F5QeBURM5hjTc+19ZaNfb3Sxe+SgPaDYuIQ/R7aqFXG6j5YfN9KK7tCXr07m8SZS1V9CyPfXCNvGq0VCehFhxwIrlC8px2UqT9uTDpVxzA5JGsFC+eIm7i3sEQVGYFr4IsV8n3dhQO5MA4ijafWSAgHJAu5TUyQy3FFnSPby45U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742289599; c=relaxed/simple;
	bh=DrXQOb6P7nIG853PWLe4cVfSzJFyi6R/Q4pnGf2pOXk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tV/92VX2/I3HB+MoU7XG8X9FKhmWvUtUv9J9J4ToLCSBHUdfRxe0mzSFkP34xS9YvM6J2VOm8NrEPQwm7yVzESSGtLnSB1DlWCTB2EdMKJERp02F2aj01vhCgHAie6Y7mtoQnd/YV3P9K/dUDPtJG2hvufFvgFc20Te+EaJwGdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNmFt+iG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB0FC4CEDD;
	Tue, 18 Mar 2025 09:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742289599;
	bh=DrXQOb6P7nIG853PWLe4cVfSzJFyi6R/Q4pnGf2pOXk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vNmFt+iGi9JfXTLHiq3Di6i9FUZjesjx6Uri+y5TBs4ltvW38r+oGck6f3LiFQ1b4
	 dapg6b3r8slV7M8XCm17mJCWTM/BDVzI5rDm83hQ1PZX8eiMlTJV01p6u72mGjLiIo
	 snS2vynH+JoqCtvJv3KKXVs74AuydbL5IvxT+vki5/SahyFhDtAC0HSeYOcM+aAa6s
	 LKZWC9EJYkdjEVNdC6ASHW7CHkUUOahqAyQW74EcHrq7m64Fmk1BKSTG+EIqLXjyPX
	 v6AxQNxNF2/7ynEctmarcHzzQWnLU2gEgZbngEwTapUylBIZo12J0/WHgQm+GQgk+G
	 rHvpCJT/w9MBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB79A380DBE8;
	Tue, 18 Mar 2025 09:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6][pull request] Intel Wired LAN Driver Updates
 2025-03-10 (ice, ixgbe)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174228963476.4094705.15383077591873902488.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 09:20:34 +0000
References: <20250310174502.3708121-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250310174502.3708121-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 10 Mar 2025 10:44:53 -0700 you wrote:
> For ice:
> 
> Paul adds generic checksum support for E830 devices.
> 
> Karol refactors PTP code related to E825C; simplifying PHY register info
> struct, utilizing GENMASK, removing unused defines, etc.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] ice: Add E830 checksum offload support
    https://git.kernel.org/netdev/net-next/c/905d1a220e8d
  - [net-next,2/6] ice: rename ice_ptp_init_phc_eth56g function
    https://git.kernel.org/netdev/net-next/c/178edd263386
  - [net-next,3/6] ice: Refactor E825C PHY registers info struct
    https://git.kernel.org/netdev/net-next/c/66a1b7e09fb0
  - [net-next,4/6] ice: E825C PHY register cleanup
    https://git.kernel.org/netdev/net-next/c/50f4ffac918e
  - [net-next,5/6] ixgbe: add PTP support for E610 device
    https://git.kernel.org/netdev/net-next/c/18a9b8e358c2
  - [net-next,6/6] ixgbe: add support for thermal sensor event reception
    https://git.kernel.org/netdev/net-next/c/affead2d904e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



