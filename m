Return-Path: <netdev+bounces-151117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 814339ECDD7
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 15:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127CE188CA52
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 14:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63543236913;
	Wed, 11 Dec 2024 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+FajsLX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E023692D
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925620; cv=none; b=XwU0ksVRg+RAB2svRwg/cMjAHMwjtX1WM/XFBJ2jS7tITvxrUwFf6+wqNV20xbg382Taor/2f1KqIViX1rzBeV2kJUeUJRV1Cq9fAEzVKuBE9u7nQ2vrGU0VdXL8SwZ1Wj1KadcOe4ndJm8A8tAVzi3rC7yGbhFk70ry6lVD5xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925620; c=relaxed/simple;
	bh=5KI0t3Srr1i4GA/+pE4ZnRH7Ha9ZRUjNl/KzyXi0bzo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hZUysQrkaqVtj5AtVrNtXhEeIAsTSNCDE4P/i5Ij9nOjThdxS4jFBCDNbyzQEq9+JiT4YQqWLm27vJMjud1OyMn+7OfInoq/EY5QORLOw00j3yBLYlvmAj9gGQFQPSw94KfdN1Lko906jERpHnUUEBa5ApmP4apo16sE/tM8xCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+FajsLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E09C4CED2;
	Wed, 11 Dec 2024 14:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733925617;
	bh=5KI0t3Srr1i4GA/+pE4ZnRH7Ha9ZRUjNl/KzyXi0bzo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o+FajsLXFQlDJZESfFJpPPV6i9cUnOYhSznkjh0yfHq6MKFS4GHcOl6bb0I4k9s7v
	 ZR0UP+qQ2n8Z8XHc4EdYcQiZZ0dtfElXHKiukJ5UA611lP0s/U3kCBz6TiDzg4cuWh
	 FXCtZwLZzQ50qzEhJopvnJ9L2QIZS9CmeeHxUmoW4wDqoLvHJmTblJYrm8iiuR15Fl
	 Iq6AS83bLSky5N2dFCcFWmQ4WO2oXcTUPqrT708eSiR5bRgLlS6zN9O+jyabbgXNLf
	 WqcCgVJfxN7d8OQCPjBy++ut0XHYbB882Nvsx9YSrmRmhsHc1zyN4VOApdbFvEwOQ1
	 vGDcsEB/4WSqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBA08380A962;
	Wed, 11 Dec 2024 14:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] l2tp: Handle eth stats using
 NETDEV_PCPU_STAT_DSTATS.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173392563378.1585286.17233800331525317529.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 14:00:33 +0000
References: <20241209114607.2342405-1-jchapman@katalix.com>
In-Reply-To: <20241209114607.2342405-1-jchapman@katalix.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, tparkin@katalix.com,
 aleksander.lobakin@intel.com, ricardo@marliere.net, mail@david-bauer.net,
 gnault@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  9 Dec 2024 11:46:07 +0000 you wrote:
> l2tp_eth uses the TSTATS infrastructure (dev_sw_netstats_*()) for RX
> and TX packet counters and DEV_STATS_INC for dropped counters.
> 
> Consolidate that using the DSTATS infrastructure, which can
> handle both packet counters and packet drops. Statistics that don't
> fit DSTATS are still updated atomically with DEV_STATS_INC().
> 
> [...]

Here is the summary with links:
  - [net-next] l2tp: Handle eth stats using NETDEV_PCPU_STAT_DSTATS.
    https://git.kernel.org/netdev/net-next/c/c0b8980e6041

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



