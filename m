Return-Path: <netdev+bounces-189409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A8BAB205A
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 01:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67817A0648F
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 23:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474A0266585;
	Fri,  9 May 2025 23:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+wwJjkc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D62266572;
	Fri,  9 May 2025 23:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746834605; cv=none; b=BetCVg/sJhVr1vy6WI1p5SrchiKskqeQdEdJWvFL4ic/Avg6JDo+hAazwfveBQEbNR/IYgKVkA2GbTS/o2qegOYySSH+SUzsBzbG9FXabX5p6ZxITpjpkWQI5yiyf/ONlm1LQvCwm7kNVr78BUQXYxJ6Vx8Mu0eSkiIt2sKDXIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746834605; c=relaxed/simple;
	bh=y9YOw9IOsmX9ImQInii2PeQ/fBvsQkMiqqEkNWPaO1Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tB/Nm/vw2WJSjp+IP8aOE7UCtwgVSVROzjsuOWs5hg8GZQvA/4pQVKgJqwX+jNsqjm+SB8bKLtYXveu5RJQKGjuuHypioF/i48FS1cTbzGNyD/BBmopUMcBTbaEwhMJ6IAxpmhGrCU5YR9R7CUreqx2ZFvjrD9CoLftbORKz87o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+wwJjkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89193C4CEE4;
	Fri,  9 May 2025 23:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746834604;
	bh=y9YOw9IOsmX9ImQInii2PeQ/fBvsQkMiqqEkNWPaO1Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i+wwJjkcKbYSvPyzZdADHMORbJSIwrCvCmJoHcGkSKjPgG9QHEzK7m/aK1LJaIGRT
	 BOJzupMXpSJXKrn0DZcrLDtt9PKWQJqU95HyXc+/ZgGRy9p5t1i3O9oxAHClpk711l
	 g+FqvLb+05Wfq8wGXcjtg52aAvQnsUmTZKsDjCMhDP2a4MVmzPpXhTd2aVQs6UHD2m
	 nX8rSVpnHtnC6Q6p/VCco0G7YBpfOmuVGFbYgx5sTEjt7pdw2tgKptqJwqFHl0uN6J
	 hub9H8u88UlRymWoyleTEQ/TgTkpReLPTgFK83MzkX3VsXrJLWkFJVmCUb1wdeRF2K
	 CKFbCUVR3I4nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 339F1381091A;
	Fri,  9 May 2025 23:50:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: gianfar: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174683464274.3845363.11807603557264014705.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 23:50:42 +0000
References: <20250508143659.1944220-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250508143659.1944220-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, kory.maincent@bootlin.com, claudiu.manoil@nxp.com,
 andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, richardcochran@gmail.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 May 2025 17:36:59 +0300 you wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6. It is
> time to convert the gianfar driver to the new API, so that the
> ndo_eth_ioctl() path can be removed completely.
> 
> Don't propagate the unnecessary "config.flags = 0;" assignment to
> gfar_hwtstamp_get(), because dev_get_hwtstamp() provides a zero
> initialized struct kernel_hwtstamp_config.
> 
> [...]

Here is the summary with links:
  - [net-next] net: gianfar: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/17c6c5a09df0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



