Return-Path: <netdev+bounces-159590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F79A15FD2
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E9F1886B7B
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 01:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413561B7F4;
	Sun, 19 Jan 2025 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLTreuTA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBFC1B59A
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737251412; cv=none; b=SOdjpVHn03d8UF+NrpBMrRZgmlfZPmkLYx3pdpUaRRkU2AV2VEPHh0jDhCfoklaxWmm/l0j0bshDr2LByR1j3S083YXX0ytsP+tjbDYJPYx6bUPfCA9INT13IGvNivFfZI0QSSBIAlb55+hbvdBnyon/j4YDL0V6524SNq5aTj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737251412; c=relaxed/simple;
	bh=GQXZaI4e6FQPH23YUYjOqk6+QoB3FSskLTxSrSMhKb8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YV86xoW0cnas42nGnm7UTtkVZwuYzeCF9Hhf3Mfj7BrmB56/1oAx2kztlQJ3ytOaN5Q2F9PUzTJEEENFc4w1KFb39NJATv1vwP5Q5I1Txe/tcrSLeDM7kRkTz9/cFv0F5LJD76O+lCo25kb3ffzOJxSvqvGlCtYij38dMsZGWCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLTreuTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E8CC4CED1;
	Sun, 19 Jan 2025 01:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737251411;
	bh=GQXZaI4e6FQPH23YUYjOqk6+QoB3FSskLTxSrSMhKb8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oLTreuTAZaMJAXax+AcrrFM5Co+KrfqzdOIkwXuPk65YACBooXh2cZ89R9QdDk4wt
	 7szrbZmniGxv8J3wiVurPvvGLGGbugMOjrNGYcqmiqQwIFjmcgRuskvC+gr2Bsud0Z
	 Jtv7oyrxwxKes9qyYCubSRed/Uoba7Vb4o5JP9VM4EWlCz4uUbQXKK0a0U5/duaK2r
	 P8lYzZhDILtaa2K+jBMevyEGjhfO5jV5LY0zm8f8zN4NjoqdJKqNo32HfX8mIcmUdX
	 VeBhifYxW3iivderYeS0e7FbESr5eDyO65EwHautZSM6jMg7VIvBakXvGCZgSACIcf
	 dBfLV0rLKSSeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BC9380AA62;
	Sun, 19 Jan 2025 01:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/4] ethtool get_ts_stats() for DSA and ocelot
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173725143498.2533015.9693076056324492568.git-patchwork-notify@kernel.org>
Date: Sun, 19 Jan 2025 01:50:34 +0000
References: <20250116104628.123555-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250116104628.123555-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, horatiu.vultur@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 xiaoliang.yang_1@nxp.com, yangbo.lu@nxp.com, richardcochran@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Jan 2025 12:46:24 +0200 you wrote:
> Picking up this set again after the end-of-year break.
> 
> Changes in v2: trivial rebase after the concurrent merge of the "net:
> Make timestamping selectable" set.
> 
> Link to v1:
> https://lore.kernel.org/netdev/20241213140852.1254063-1-vladimir.oltean@nxp.com/
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/4] net: ethtool: ts: add separate counter for unconfirmed one-step TX timestamps
    https://git.kernel.org/netdev/net-next/c/6a128cdf1926
  - [v2,net-next,2/4] net: dsa: implement get_ts_stats ethtool operation for user ports
    https://git.kernel.org/netdev/net-next/c/4b0a3ffa799b
  - [v2,net-next,3/4] net: mscc: ocelot: add TX timestamping statistics
    https://git.kernel.org/netdev/net-next/c/8fbd24f3d17b
  - [v2,net-next,4/4] net: dsa: felix: report timestamping stats from the ocelot library
    https://git.kernel.org/netdev/net-next/c/e777a4b39b14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



