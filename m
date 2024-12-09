Return-Path: <netdev+bounces-150411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C009EA29C
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864541885731
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 23:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC0D1F63DF;
	Mon,  9 Dec 2024 23:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WejoR8/J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7888F19F119
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 23:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733786417; cv=none; b=AE22kRPG/BBErDW4mydmzTZDrBz8GQ36NDWmkGnCAoLR0ZjYpmzD85TdG8G5fNz2L0kvrzaEP6fPyZgnuB3VXf1S06c9YxIaVIyPeNVpUKksvIQ/Pdu/deAnTlUrp8ng98Mr1sA3ATQRE65+Z4r0FDr+8RrBaErnPkyWjvNnjnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733786417; c=relaxed/simple;
	bh=m+KZaSIulZOQmHbcnEHU9YX4N5c09zS4cnlOp0rv1lk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z9HWxHC3OACqhqoKh7DDEB8YOUWc9mETfnD25+tGjidUB3oUhRsU25agtBWPZTikhU6C73Rhrw9mMUeFTkSpS9KLBxM55XnhsHsGF/ptbRho0M/RfEexN+p6SDXhtHZO8+l1WwdHgi+rEc1ZHx25KhJdeZzdCs9H+PoARpYv434=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WejoR8/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5529C4CED1;
	Mon,  9 Dec 2024 23:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733786416;
	bh=m+KZaSIulZOQmHbcnEHU9YX4N5c09zS4cnlOp0rv1lk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WejoR8/JuzsxftWLivgrAcs+YOFeGpH0RWbfAseqQMidUVp0XRUAnCbLsxVZyKYxu
	 DXvbnQzC1fNhGON8KHg9rZACmWrwHgVXza0mun06AZChvNlKESuuRgYnWbJNwCdAKj
	 AL1dIQmt9Bwv6F5At45UmmNe2VSs1ZW0S1LDCoaVQEmYSSmX0pJLripjGj9t9PVfm8
	 OCI6DSbj38QnRGDJpets+PpSN2RdwSpBu0pEZsRwKFwl8b/RI3KwHiPEyAs0OnSM2L
	 7oF/sBS576fzxWykJ2ggHoGAIf02LtZywdYs4MT3uxDntNr2RXwqSDks7P/lRQYi1M
	 uPYyaxgcwa7cw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFAB380A95E;
	Mon,  9 Dec 2024 23:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/11] vxlan: Support user-defined reserved bits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173378643250.273075.13832548579412179113.git-patchwork-notify@kernel.org>
Date: Mon, 09 Dec 2024 23:20:32 +0000
References: <cover.1733412063.git.petrm@nvidia.com>
In-Reply-To: <cover.1733412063.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 horms@kernel.org, idosch@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 5 Dec 2024 16:40:49 +0100 you wrote:
> Currently the VXLAN header validation works by vxlan_rcv() going feature
> by feature, each feature clearing the bits that it consumes. If anything
> is left unparsed at the end, the packet is rejected.
> 
> Unfortunately there are machines out there that send VXLAN packets with
> reserved bits set, even if they are configured to not use the
> corresponding features. One such report is here[1], and we have heard
> similar complaints from our customers as well.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/11] vxlan: In vxlan_rcv(), access flags through the vxlan netdevice
    https://git.kernel.org/netdev/net-next/c/9234a37a495d
  - [net-next,v2,02/11] vxlan: vxlan_rcv() callees: Move clearing of unparsed flags out
    https://git.kernel.org/netdev/net-next/c/0f09ae907818
  - [net-next,v2,03/11] vxlan: vxlan_rcv() callees: Drop the unparsed argument
    https://git.kernel.org/netdev/net-next/c/fe3dcbcfae52
  - [net-next,v2,04/11] vxlan: vxlan_rcv(): Extract vxlan_hdr(skb) to a named variable
    https://git.kernel.org/netdev/net-next/c/e713130dfb4d
  - [net-next,v2,05/11] vxlan: Track reserved bits explicitly as part of the configuration
    https://git.kernel.org/netdev/net-next/c/e4f8647767cf
  - [net-next,v2,06/11] vxlan: Bump error counters for header mismatches
    https://git.kernel.org/netdev/net-next/c/752b1c8d8b40
  - [net-next,v2,07/11] vxlan: vxlan_rcv(): Drop unparsed
    https://git.kernel.org/netdev/net-next/c/bb16786ed6fd
  - [net-next,v2,08/11] vxlan: Add an attribute to make VXLAN header validation configurable
    https://git.kernel.org/netdev/net-next/c/6c11379b104e
  - [net-next,v2,09/11] selftests: net: lib: Rename ip_link_master() to ip_link_set_master()
    https://git.kernel.org/netdev/net-next/c/8653eb21d68c
  - [net-next,v2,10/11] selftests: net: lib: Add several autodefer helpers
    https://git.kernel.org/netdev/net-next/c/d76ccb2ec368
  - [net-next,v2,11/11] selftests: forwarding: Add a selftest for the new reserved_bits UAPI
    https://git.kernel.org/netdev/net-next/c/d84b5dccf3eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



