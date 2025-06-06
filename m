Return-Path: <netdev+bounces-195415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9377AD0135
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 13:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143C2175529
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 11:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FC72882A6;
	Fri,  6 Jun 2025 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6ej6Vz1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E848C11;
	Fri,  6 Jun 2025 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749209397; cv=none; b=s7/r4iViL8RZ6ZGsTP3jVsREky++2H54/Jub7OyLVlpPMpRWYB+Lld5/6Zly2kCERmxuDedGsnaYa52ofg/k0jspgJqh5MWFjwBDfBbf5gi6mWZUa8pOp4XqFOaJnp8eipghVZkdtJPCvw5kyBPFbTFQ3xLPpRyav6G32wUetdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749209397; c=relaxed/simple;
	bh=cBiavoyhnUOaPt1BwOXLTc0hTIQzKDyHJgcKWt47iAI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jb0MOgsb/beu6UhFZUtJ+X7vK5OlISl1peTQGdZrJ+1/bdXf9Cx2Sv+anxgKb/q92DWDyrY2gc9aKn1uFEVIEmoEvAIcjycskfiEbb1J9uBVXy8TIWp64is3dUz748K+NnhplBpXIOHkxvit07n9aKq77r5O8OvVjL4TPGc45pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6ej6Vz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF128C4CEEB;
	Fri,  6 Jun 2025 11:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749209396;
	bh=cBiavoyhnUOaPt1BwOXLTc0hTIQzKDyHJgcKWt47iAI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C6ej6Vz1Jl288yUxrmCCiJ/I4RwBIdmmi4qoQYnYFtWa2tKbKZnA4W07ZSLOR/MFv
	 UPhpJ36O/A/x3CoW6RENq24rPDYdrTT3svNQGYnOnOaBNOfig+pvSoZk6jonX9cgbF
	 94T/6UDaq7IeVkQ9/xlnwar5F1BSSvubfsr6VlQI78P5wiFP+zGYGcJwRUF3U8B1Um
	 RDzCTri4NZsNz5CZ1Oxb3siT2493Fox6+QJQYfj2cajcs2k4P3GxjvbGwVeZuNLkmM
	 akEj0qbPUZKjQR0e7HhTE8qGkT+hVJbEoxPoqbzt/MiB5hOXrUFmV24hsm1se88oeW
	 PcRLAitpCl/kQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD853805D8E;
	Fri,  6 Jun 2025 11:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: enetc: fix the netc-lib driver build dependency
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174920942850.3814198.2791344535997265319.git-patchwork-notify@kernel.org>
Date: Fri, 06 Jun 2025 11:30:28 +0000
References: <20250605060836.4087745-1-wei.fang@nxp.com>
In-Reply-To: <20250605060836.4087745-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, arnd@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  5 Jun 2025 14:08:36 +0800 you wrote:
> The kernel robot reported the following errors when the netc-lib driver
> was compiled as a loadable module and the enetc-core driver was built-in.
> 
> ld.lld: error: undefined symbol: ntmp_init_cbdr
> referenced by enetc_cbdr.c:88 (drivers/net/ethernet/freescale/enetc/enetc_cbdr.c:88)
> ld.lld: error: undefined symbol: ntmp_free_cbdr
> referenced by enetc_cbdr.c:96 (drivers/net/ethernet/freescale/enetc/enetc_cbdr.c:96)
> 
> [...]

Here is the summary with links:
  - [v2] net: enetc: fix the netc-lib driver build dependency
    https://git.kernel.org/netdev/net/c/82cbd06f327f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



