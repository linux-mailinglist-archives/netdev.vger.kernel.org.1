Return-Path: <netdev+bounces-154110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1F69FB495
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 20:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE0C165817
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D222D1C5CBD;
	Mon, 23 Dec 2024 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhCQvYMB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AAA1C3C1C;
	Mon, 23 Dec 2024 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734981022; cv=none; b=Q1Zrnu/SiiPvhSkaPPjximrvehOQT6uzyfD/jBuJH6LJojFLezk0qzwbEp7ibNUweMoqdTVFSJmMriloNmo14I3V5WtNqsL1omeiXrArdEYkgJc46vW3Q3ZwCOW5GTABgLVe+NCDsnPoVHPleCYd41Q2KkjHjllG4/BIijg+gF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734981022; c=relaxed/simple;
	bh=22e0cf0mt6smWzc3GXJN29SgqDBF4lXxlE940Guk1RE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=plJ4HiTtnewEZ6pelNLZMs7Z21BzXKoC57b7DeHHJ4rq1UUhqTTesYpyb4IsoOaG2cNhtHmrxKrDqwOEzV+3xju30mKmHEi70Zua+yONv7tSggnNva9O63QfzM3eaYmTROX8cjjTWlhBlrmQcWzgKoOQrE+n1Idinot+jC3bie4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhCQvYMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77258C4CED3;
	Mon, 23 Dec 2024 19:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734981022;
	bh=22e0cf0mt6smWzc3GXJN29SgqDBF4lXxlE940Guk1RE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BhCQvYMBrcl8bYr7S+fA9BVNl7tbEQiAN7gc+BUDHhjiF+NXS2jbb2YMac5Z8tdJB
	 Kxj3+t1ofElWoskLWF/1w469IDGOj7iEegjXz+bCNEJKwT7Ex9qqg1N3XN38kzipG9
	 LLNhsHHO553x0kId5TJyBkSutjUmBVlxRe4WEfjMc9ehWc+fKA8+7oic6tfI2PrU5V
	 6+KCrisTIZQSoZzeg/8h7v3Z2UdwhaWgbMIp1EJ06kza2xWsWi6YdCrOTduCwGzwFv
	 55hiPCgM/Pa0TmuuyASh2llQ5Tyo/9e/IEVyWoAXU9zBperO94yI0qWd5IHnyNtbjt
	 JOfylLGYNRQ4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D7A3805DB2;
	Mon, 23 Dec 2024 19:10:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/9] net: lan969x: add RGMII support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173498104074.3934211.3884630987619297533.git-patchwork-notify@kernel.org>
Date: Mon, 23 Dec 2024 19:10:40 +0000
References: <20241220-sparx5-lan969x-switch-driver-4-v5-0-fa8ba5dff732@microchip.com>
In-Reply-To: <20241220-sparx5-lan969x-switch-driver-4-v5-0-fa8ba5dff732@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
 horatiu.vultur@microchip.com, linux@armlinux.org.uk,
 jacob.e.keller@intel.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 robert.marko@sartura.hr, rmk+kernel@armlinux.org.uk

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Dec 2024 14:48:39 +0100 you wrote:
> == Description:
> 
> This series is the fourth of a multi-part series, that prepares and adds
> support for the new lan969x switch driver.
> 
> The upstreaming efforts is split into multiple series (might change a
> bit as we go along):
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/9] net: sparx5: do some preparation work
    https://git.kernel.org/netdev/net-next/c/c71b59690aa1
  - [net-next,v5,2/9] net: sparx5: add function for RGMII port check
    https://git.kernel.org/netdev/net-next/c/dd2baee10840
  - [net-next,v5,3/9] net: sparx5: use is_port_rgmii() throughout
    https://git.kernel.org/netdev/net-next/c/05bda8a1bded
  - [net-next,v5,4/9] net: sparx5: skip low-speed configuration when port is RGMII
    https://git.kernel.org/netdev/net-next/c/d9450934f915
  - [net-next,v5,5/9] net: sparx5: only return PCS for modes that require it
    https://git.kernel.org/netdev/net-next/c/9b8d70ecfef7
  - [net-next,v5,6/9] net: sparx5: verify RGMII speeds
    https://git.kernel.org/netdev/net-next/c/95e467b85e69
  - [net-next,v5,7/9] net: lan969x: add RGMII registers
    https://git.kernel.org/netdev/net-next/c/fb6ac1829bb5
  - [net-next,v5,8/9] net: lan969x: add RGMII implementation
    https://git.kernel.org/netdev/net-next/c/010fe5dff164
  - [net-next,v5,9/9] dt-bindings: net: sparx5: document RGMII delays
    https://git.kernel.org/netdev/net-next/c/f0706c04721b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



