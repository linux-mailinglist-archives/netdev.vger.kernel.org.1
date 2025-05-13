Return-Path: <netdev+bounces-190279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5824DAB5FE2
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 01:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E169865F4B
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 23:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F65F215066;
	Tue, 13 May 2025 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c09Gh76p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270FD214A7B;
	Tue, 13 May 2025 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747178995; cv=none; b=btsAIwiq8NPdIjNml94G8Fu2hDNkQn2sZBjyQMxGEwGWtKyYkL1PCWMWOslA5RVApVd+2sSZP4PPDCvel9A0bmec8k4MlygFSinG9xgrjS83EcUf+J4i0FcY4JnzQUtDWgDjjUnLuXtdKIg0yiZRq4sgwKQPetL+jIVhH6Qvvro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747178995; c=relaxed/simple;
	bh=V6v6GxO0RNmk9V4SKjq+WHNNy5mFb28a8s2NoiAFvJQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AhipE2AEJXhEk0eUjUH0Vl5NSj0OJViu3oqd4MAIr6e9SiLRd6meBJg34NHW1rpf4cuuYC5e9IyV9eF+5ES+7KJ3Jwtv/ttR9mn6B2PyREQ8M8GrUllZlDpjLNRd3EfGNlGCYe865Q8pt8mjT+18N4agftBGS8ktuS8jXFF29Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c09Gh76p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA5DC4CEE4;
	Tue, 13 May 2025 23:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747178994;
	bh=V6v6GxO0RNmk9V4SKjq+WHNNy5mFb28a8s2NoiAFvJQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c09Gh76pg2C9i0oPtDWa+lGtbLtXeOf+7XU7XHkTnj9h8/qZiLZR1qkStz/udRHTx
	 mfpA93rNbugpeEmu8rd9e0YoBFAPH+qTX74Hx08oEHgguAbGUWrW5LZn50a0YozL2P
	 kYvfi0CNMbYch+20pz0XW8O1qL5n05dQUYTFr08C6g8Ni1BJUMErh71Qv6gJYx7YbM
	 7fmstQ8htWBtB60B3Rb/6LfSqZTWvIe8jN2tN946ASoGS+n0CK8U0GIptGtYz7OP8e
	 h/FqZy7WvpwceJRVX8UYWQ0QGYuloaaTeETLFGdqiTM58zzcqghRQqAFlXhJXxcYY5
	 0FI0coE5h3J/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C74380DBE8;
	Tue, 13 May 2025 23:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: enetc: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174717903175.1822709.17136638266645022987.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 23:30:31 +0000
References: <20250512112402.4100618-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250512112402.4100618-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, kory.maincent@bootlin.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 claudiu.manoil@nxp.com, horms@kernel.org, richardcochran@gmail.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 May 2025 14:24:02 +0300 you wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6. It is
> time to convert the ENETC driver to the new API, so that the
> ndo_eth_ioctl() path can be removed completely.
> 
> Move the enetc_hwtstamp_get() and enetc_hwtstamp_set() calls away from
> enetc_ioctl() to dedicated net_device_ops for the LS1028A PF and VF
> (NETC v4 does not yet implement enetc_ioctl()), adapt the prototypes and
> export these symbols (enetc_ioctl() is also exported).
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: enetc: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/51672a6587a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



