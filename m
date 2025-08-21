Return-Path: <netdev+bounces-215677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE2CB2FDCA
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68974A07D2D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 15:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9165F2FB60E;
	Thu, 21 Aug 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlzIaxAh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659E32FB602;
	Thu, 21 Aug 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788406; cv=none; b=Q3cV3J9QD9oOnGJpgg/SPnUp+04suq45wBUiFaazQzvsIr0ZSsKf2psJpOMCj5uxMj6lWogdlLAxqG7GGzj5pfk0+mWBaWKrHZe2Ok/II8Yhyx2ys5R7WpmC82/JiCMaIwCfVXfUBt6QHXrld99TN0Bch1IU9Oo8i0qFSzt+iJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788406; c=relaxed/simple;
	bh=lAcDvawMPBJ5147ptmLTN/COheFCO5011iJ4L0auFy8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ljBMWekloNGnWCW++Q5finpZO0O+LhkDQP6E8a7KnV1AZQJpfGottbXNXB/W+xl/exzAZ+1+YIb8tOU90lPva6Md4gf+HvKhFb8a08zT3M+fMdpx08lgFJCTD2LFU2PJyS0OzDrrg9PfQBpN6G9qctsaVA7IpklHjRGlfjBv+k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlzIaxAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E2DC4CEEB;
	Thu, 21 Aug 2025 15:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755788406;
	bh=lAcDvawMPBJ5147ptmLTN/COheFCO5011iJ4L0auFy8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WlzIaxAh0jFB2XRSjzlxTjg2/6id1iHSiUSzD1lH04Ij2DhjA4EPjHa+KrNsgqO+L
	 TPqOVtymvyo8CsTFcJBLRkF+2PS/72mjSIxwa+ZlQCNS7qLMkdPeyIx1gVIqLcLmOQ
	 gbqF5CqhmGgjHXmjBSy+T5OERfAE4o3/l8XbsXOk+k/5NYMQJKsdGGaTsKCp0xmMaY
	 R6Wl9hyhJV5q9siCwrBZDO82SkdAfkO1EwuVOZrZazeqw9lS4UX1e5huNLcIEw6h36
	 WIOfpCkftFnICVkmaw23Q+gSYM7eaJdONNqnf7Wz+f8gd7cFUdbjW6WGPzPCXB4QzH
	 VXtyEaJqF3sCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB200383BF5B;
	Thu, 21 Aug 2025 15:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: pse-pd: pd692x0: Skip power budget configuration
 when undefined
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175578841375.1075387.4213232404407239245.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 15:00:13 +0000
References: <20250820133321.841054-1-kory.maincent@bootlin.com>
In-Reply-To: <20250820133321.841054-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: o.rempel@pengutronix.de, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 Aug 2025 15:33:21 +0200 you wrote:
> If the power supply's power budget is not defined in the device tree,
> the current code still requests power and configures the PSE manager
> with a 0W power limit, which is undesirable behavior.
> 
> Skip power budget configuration entirely when the budget is zero,
> avoiding unnecessary power requests and preventing invalid 0W limits
> from being set on the PSE manager.
> 
> [...]

Here is the summary with links:
  - [net] net: pse-pd: pd692x0: Skip power budget configuration when undefined
    https://git.kernel.org/netdev/net/c/7ef353879f71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



