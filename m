Return-Path: <netdev+bounces-93687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF328BCBB1
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 12:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DBD6B21531
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 10:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE5F140366;
	Mon,  6 May 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGrlRAVe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078714205F
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714990229; cv=none; b=duHsLbcAeg99RY6U1tQNLkoRWCBjkriuiy/FkLXRGthWjQzRpgQnQ0ClkCdmExUvEhyYy7ePrHja5O/S3d0EdRxnLLu6AK7xNREbpcA+Ylwvk0HI8acDErj4fy/B0r+h6c72M8RzCMz9Nq9yGsQSf9BXZgYIuBLH4jZPbx1363U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714990229; c=relaxed/simple;
	bh=EapbHApuaZlgbFolqiYU1GhDVMglnSsaLtD99MLbGUc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FQxlh355duWlZ+N4SSA+XJWbXB9VwIoPt/KNnfvWRNRim8OHh061AOrc3Ms7SdYvjwrwF5QuMjnJNkADvXwpcF1YIS8CyyIRtWzFYlm0IvRa+0sFyM83jB4I0MFq+DEErFxj0WCgzMzOfsYh65uvEfr1YUmEYUMWrwJu0jpWgKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGrlRAVe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85D03C116B1;
	Mon,  6 May 2024 10:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714990228;
	bh=EapbHApuaZlgbFolqiYU1GhDVMglnSsaLtD99MLbGUc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gGrlRAVegXyWZKEX2qOw3TgGr1ot/L3hf7toIL423pcxAtSnX0JLc19Q20YzhAQOd
	 Qo6NfZqDlgNyU6IACReoFgaieoEnbNrDNYr0cuLjZVWy71pW8m3BBmVOnX8vzMmjDy
	 D6cV0cn8HzqLSkV5gRZdbIXip90oXqZRrDfA8BgY3YolpeCggrMTzimWIyMsGZ4T/L
	 Kb1mDFDc7AaJpIUd/6zGgPe5FNrqwUKpuOBSEoL0lgl0AEh/FVmXSN6opoHcHqrkJJ
	 pmd4EmfIX741KFFtgFfcw6sILXLrtqYfEhpY21Z9VUBAu9e9+MxH4/PUacufOhhCLg
	 Amcv7DaRwDe0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E638C43335;
	Mon,  6 May 2024 10:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net-next v5 0/6] Add TCP fraglist GRO support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171499022851.27492.8472409181269102533.git-patchwork-notify@kernel.org>
Date: Mon, 06 May 2024 10:10:28 +0000
References: <20240502084450.44009-1-nbd@nbd.name>
In-Reply-To: <20240502084450.44009-1-nbd@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 pabeni@redhat.com, edumazet@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  2 May 2024 10:44:41 +0200 you wrote:
> When forwarding TCP after GRO, software segmentation is very expensive,
> especially when the checksum needs to be recalculated.
> One case where that's currently unavoidable is when routing packets over
> PPPoE. Performance improves significantly when using fraglist GRO
> implemented in the same way as for UDP.
> 
> When NETIF_F_GRO_FRAGLIST is enabled, perform a lookup for an established
> socket in the same netns as the receiving device. While this may not
> cover all relevant use cases in multi-netns configurations, it should be
> good enough for most configurations that need this.
> 
> [...]

Here is the summary with links:
  - [v5,net-next,v5,1/6] net: move skb_gro_receive_list from udp to core
    https://git.kernel.org/netdev/net-next/c/8928756d53d5
  - [v5,net-next,v5,2/6] net: add support for segmenting TCP fraglist GSO packets
    https://git.kernel.org/netdev/net-next/c/bee88cd5bd83
  - [v5,net-next,v5,3/6] net: add code for TCP fraglist GRO
    https://git.kernel.org/netdev/net-next/c/8d95dc474f85
  - [v5,net-next,v5,4/6] net: create tcp_gro_lookup helper function
    https://git.kernel.org/netdev/net-next/c/80e85fbdf19e
  - [v5,net-next,v5,5/6] net: create tcp_gro_header_pull helper function
    https://git.kernel.org/netdev/net-next/c/7516b27c555c
  - [v5,net-next,v5,6/6] net: add heuristic for enabling TCP fraglist GRO
    https://git.kernel.org/netdev/net-next/c/c9d1d23e5239

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



