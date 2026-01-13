Return-Path: <netdev+bounces-249253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A33D1647A
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBEDB302532A
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 02:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145002ECEB9;
	Tue, 13 Jan 2026 02:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kG6O3r1j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62C42E4263
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 02:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768271433; cv=none; b=gL1rMLQyE4y2Vdrg8irFmv5c1m7IoQt8jSCaS+8DS4arXx0yWmZzDXRXWDjP/qBdoyV7QcbKFtB3CHHu1pesjwiNA9xMZIprpK8RYOC6DdOZG9A4izvYDwMiAj3s5Z/2zCkJ9JbilBVqNMi8KbX7VP5BKIfgn7ww5Ve765nMI1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768271433; c=relaxed/simple;
	bh=Vi3rzSgWIi6ZciNWDxnNv1hap5mZmRzNE3Oe+jevWRY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GgjO7Y0IDG+89VHoM5AlZZG7dFWL1F8De2rJdb6+vIkhk9+Ai9VWIUegWMZAvhKzWWb6bQarBYW5dMIx6BCKeS1fB9ThvttBXLS7Pd7mL0gacsafquwoCBLFQRCrh5+UHdIvqLK9QSIUkeaSUQReLuFaVkfEQdeBJC0q4x6GtnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kG6O3r1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F56C116D0;
	Tue, 13 Jan 2026 02:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768271432;
	bh=Vi3rzSgWIi6ZciNWDxnNv1hap5mZmRzNE3Oe+jevWRY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kG6O3r1jsLteU4aBEUIbVGU2CBDv/J38/+b6P2/fC72pyrsJAz4KI8F0T+S469TM+
	 peX5FpbIsHwAjLJkUOpaLtgppc93NJr0iL0ipxxmUxLT7jhOim2pwmoYmP60pqeuPZ
	 WXIx3I6Iljb8+FLRSskomfwgzA84qjzhDwQ+pxKVHxjOC7BgnObUheqT/Gt+ac7q42
	 cj9k5Z1ho4xp/Okng0QwOmQimfOvYicGdgrnJ1oBuDHz7A9BRylvFyLEn/j6wqOLUQ
	 f2T70O2R9fulODvAk+8vdvGqXLy0bIU6N7V+8k7Aan1VWYxjlHnuJ/mZp3UX69v7aO
	 zGfobIEs7Ps5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B59A7380CFDE;
	Tue, 13 Jan 2026 02:27:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5][pull request] Intel Wired LAN Driver Updates
 2026-01-09 (ice, ixgbe, idpf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176827122627.1606835.15446889653932291994.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 02:27:06 +0000
References: <20260109210647.3849008-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260109210647.3849008-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri,  9 Jan 2026 13:06:37 -0800 you wrote:
> For ice:
> Grzegorz commonizes firmware loading process across all ice devices.
> 
> Michal adjusts default queue allocation to be based on
> netif_get_num_default_rss_queues() rather than num_online_cpus().
> 
> For ixgbe:
> Birger Koblitz adds support for 10G-BX modules.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] ice: unify PHY FW loading status handler for E800 devices
    https://git.kernel.org/netdev/net-next/c/2769e6c3a1bd
  - [net-next,2/5] ixgbe: Add 10G-BX support
    https://git.kernel.org/netdev/net-next/c/483dd5f36f89
  - [net-next,3/5] ice: use netif_get_num_default_rss_queues()
    https://git.kernel.org/netdev/net-next/c/ee13aa1a2c5a
  - [net-next,4/5] idpf: update idpf_up_complete() return type to void
    https://git.kernel.org/netdev/net-next/c/72dae6ad55df
  - [net-next,5/5] idpf: Fix kernel-doc descriptions to avoid warnings
    https://git.kernel.org/netdev/net-next/c/7fe9c81aa24a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



