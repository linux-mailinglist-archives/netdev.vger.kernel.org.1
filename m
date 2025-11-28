Return-Path: <netdev+bounces-242488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD94C90A5A
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 638694E1BEC
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EA2272805;
	Fri, 28 Nov 2025 02:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1t7eRza"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAFC81724
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 02:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764297794; cv=none; b=puN4FkNvQdzCm0ktpKqZpFjkHaPe+pWWkUn+zr4IOH9gJg0QMLYil+dUn5oQoZUSi+AEa+cnv6y9CwP0i0xWUYnc5896s8pzmCx+TMyJIN/swonMYgjemmgKcEugmmCQaUenqwDwFtPUE6u9NXDV1cuMYWrP+5fGhK/bRI1CQyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764297794; c=relaxed/simple;
	bh=RGGT0165BFO2BCJDwFwoCfhDphbvaPk5RlfZvnewMoY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XVdbkAV2hHQyB5XMjiusSM1xpkQ22seLTvdMCCgmIuKrgwUjz7LwTCwid5mA5r3LR607/vQPjSLhoxnMxYG7cWH/DFFs/83fPqSqdp01I27ojG3jC2k+4Xt0fqjylhDdlo5/qgtg7hWufa3ug5559qpGd/YuzYZvSD5Kz3c2onk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1t7eRza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6225C4CEF8;
	Fri, 28 Nov 2025 02:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764297793;
	bh=RGGT0165BFO2BCJDwFwoCfhDphbvaPk5RlfZvnewMoY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l1t7eRzaDba365tEYo+t+8Ex3Z1+VrZw3HJxjIiQ+UfKMBP+iVA8mRRs+OdLhwtcu
	 kOnqKEteWlCtQe7xwDGc8sy21abfwwAeSGJxgyWcXnOvBU0InC2xwANPtcDdA+xIFp
	 sFiCx/QhtoaB6gQpuaJVjyEvbggUUP+4KHE/EpF1fwvYgB4uczmSO2XN6u85xLLAOR
	 hB4ryKDT2CIaU4TM670i6yfLRBIwlli+8mubA1gUkZo6OUEuFh+s7OEI7nsCUZ7WOC
	 mrX8NwrE1BU/4j+R5RNGkopsI7i6dqMZWKKmjEyTzcVFQhX/YftHQVSEJAwd9PYnHg
	 /HplvVUrfGCIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B7063808204;
	Fri, 28 Nov 2025 02:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/11][pull request] Intel Wired LAN Driver
 Updates
 2025-11-25 (ice, idpf, iavf, ixgbe, ixgbevf, e1000e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176429761604.120099.17554633926820737992.git-patchwork-notify@kernel.org>
Date: Fri, 28 Nov 2025 02:40:16 +0000
References: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Nov 2025 14:36:19 -0800 you wrote:
> Arkadiusz adds support for unmanaged DPLL for ice E830 devices; device
> settings are fixed but can be queried by DPLL.
> 
> Grzegorz commonizes firmware loading process across all ice devices.
> 
> Birger Koblitz adds support for 10G-BX to ixgbe.
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] ice: add support for unmanaged DPLL on E830 NIC
    (no matching commit)
  - [net-next,02/11] ice: unify PHY FW loading status handler for E800 devices
    (no matching commit)
  - [net-next,03/11] ixgbe: Add 10G-BX support
    (no matching commit)
  - [net-next,04/11] ixgbevf: ixgbevf_q_vector clean up
    https://git.kernel.org/netdev/net-next/c/1645759a0405
  - [net-next,05/11] idpf: convert vport state to bitmap
    https://git.kernel.org/netdev/net-next/c/8dd72ebc73f3
  - [net-next,06/11] e1000e: Remove unneeded checks
    https://git.kernel.org/netdev/net-next/c/954ba97cca16
  - [net-next,07/11] ixgbe: avoid redundant call to ixgbe_non_sfp_link_config()
    https://git.kernel.org/netdev/net-next/c/5849b56addbf
  - [net-next,08/11] idpf: use desc_ring when checking completion queue DMA allocation
    https://git.kernel.org/netdev/net-next/c/d89a5c27e4f3
  - [net-next,09/11] idpf: correct queue index in Rx allocation error messages
    https://git.kernel.org/netdev/net-next/c/79bb84758f2c
  - [net-next,10/11] ice: fix comment typo and correct module format string
    https://git.kernel.org/netdev/net-next/c/1105a7a12051
  - [net-next,11/11] iavf: clarify VLAN add/delete log messages and lower log level
    https://git.kernel.org/netdev/net-next/c/57bb13d7eb50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



