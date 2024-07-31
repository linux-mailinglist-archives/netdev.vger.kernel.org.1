Return-Path: <netdev+bounces-114569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E60C6942F1F
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 14:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238731C215DC
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E35B1AED53;
	Wed, 31 Jul 2024 12:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4Q0+FVO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08551AE85F;
	Wed, 31 Jul 2024 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722430233; cv=none; b=fkjsJcX4cEN+n3vR/5yP0txHCgQApfx6FHscz7Go/AkfpHawTs7f1d4ZQlG2CBywkmR08yx4GGk7Pe18cP+EESVNFIRsynFMODfYpBvKaypBd6D1TIZR7RVqitkei5XfChdRYzqc9m1Mh7YFE/KdV3nMEFi0zjBA1yLZMsRO0Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722430233; c=relaxed/simple;
	bh=I/Fv8yvsDW/2wO5aWeFMZDmvx9xx+bJDvKhCyaXRW6s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mWcSaT5VrhSJszb/N4eSIL9BpgswEcNvBItTlxf09BvBhDUzLju1EOzx7faNc8zIj+lYqVPamNuZsZC2RqQF+2/nK2q9KSIlio2J/Get+DgWFsiTxq5qXmHjXw3u1lPIZhudGLzYzLh41FomfWv5sIjk/Hz3GmmKmtLsBgxtKmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4Q0+FVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72945C4AF0C;
	Wed, 31 Jul 2024 12:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722430232;
	bh=I/Fv8yvsDW/2wO5aWeFMZDmvx9xx+bJDvKhCyaXRW6s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t4Q0+FVOJ7UtKRMzpi876b5Uv1CIxtbNyo0fICELf4Rxxd7MEwp7mtSO6nbGJGiM7
	 YvZQ66rN8zEJqZKRgDGWAFjL3ToTrKGRNG1se6m5Pcw1nFfIUlOi4yU0K1mQ3sgp3K
	 v5A/6fV2Yj+YxblaGuMUqM+n/XhQJSDDyEQig0AHh7Kjkiwp9O4usxx/ajUdZFZmY2
	 Tf27XGq7gPimbxStX/ebB/5OmmHX91sOxGbJH2C1qe4rHdNZKL+gBwBMNRXhnNtjwG
	 w89ODBcPLBlEy7nZjbeYb3ZR47CHkMc44gSb5TSIo/qfENSM/G6Wot6pwWDS4vcOqU
	 edgPzRzSM2kvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5FAE5C4332F;
	Wed, 31 Jul 2024 12:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] Add support for PIO p flag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172243023238.26965.12016528241084441662.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jul 2024 12:50:32 +0000
References: <20240729220059.3018247-1-prohr@google.com>
In-Reply-To: <20240729220059.3018247-1-prohr@google.com>
To: Patrick Rohr <prohr@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, corbet@lwn.net, dsahern@kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, maze@google.com, lorenzo@google.com,
 equinox@opensourcerouting.org, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 29 Jul 2024 15:00:59 -0700 you wrote:
> draft-ietf-6man-pio-pflag is adding a new flag to the Prefix Information
> Option to signal that the network can allocate a unique IPv6 prefix per
> client via DHCPv6-PD (see draft-ietf-v6ops-dhcp-pd-per-device).
> 
> When ra_honor_pio_pflag is enabled, the presence of a P-flag causes
> SLAAC autoconfiguration to be disabled for that particular PIO.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] Add support for PIO p flag
    https://git.kernel.org/netdev/net-next/c/990c30493013

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



