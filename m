Return-Path: <netdev+bounces-191521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C31C7ABBC3B
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 13:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B04189CF76
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 11:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C894274FCD;
	Mon, 19 May 2025 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+c+zc7m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A25274FC0
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747653608; cv=none; b=DwgP6FO9oAKsg/ETtQOcHcXpSAZ+9gN0xcvHyS4afYq7yB6mYujJz5688py28GMk7FJbORj+G2i9M0mNW9ZQ1ZL5/dVe6C2MXqImIaScuzRB2ahygyU26qX14G/DKDyCXi3w8ALyvetkql0fxaaJiWvLtQq2YZgpNPLec/7R/aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747653608; c=relaxed/simple;
	bh=3qnILqyJ0/1i28GJfDOCEnK/pZimUIVg0FTW0MURuhg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RIPIy/19aqHcxiPAcogwSPxR7fdpj+2bXxTa0XsOXCrTpplny2gPBSlADWD7wGbMOsEvL9rp0m3TxrYATlVJKjzP7WQGLzw3DZ2raJOmXuKRBFkfVtTNqmdvLD35z6FHvcqPjdLplTPCL97ABlHfG2daffX+VjaWyEO1qUnWPI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+c+zc7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EE5C4CEE4;
	Mon, 19 May 2025 11:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747653607;
	bh=3qnILqyJ0/1i28GJfDOCEnK/pZimUIVg0FTW0MURuhg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E+c+zc7m3qy/mMMLi8qS0T10LDbAajbWxumN60g5GgtG3LG4vbV3VOmiSTXB2sNus
	 JLByqG35DaKQ6mE9HTYJO65stULqxSwvtVPqRRM9CC2uBRYb/IaGLzYDH84YSC7y0j
	 pYiwjuIAYXIpCOAzWo7n3Gaamw0q1dg4Oo5EOwddz1JK6CcbVt/TcIbq1kV1Vu+60p
	 mdMfb8LKP/ZOPrqcbg7Syu88VKOgeFNAYGE4SR8uaHaLJtubSPtnUAzc8mWbiAAwCt
	 upNFDAH6jaalqYKMfYmgNwO6NMb3IFIKKYXlVZ8CFmqfQBFfnF6Cm4P1D34I0ur/68
	 u+6r9Qe4BAR2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADF7380AA70;
	Mon, 19 May 2025 11:20:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/10] MAINTAINERS: add Sabrina as official reviewer
 for ovpn
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174765364349.883795.6867259107757004381.git-patchwork-notify@kernel.org>
Date: Mon, 19 May 2025 11:20:43 +0000
References: <20250515111355.15327-2-antonio@openvpn.net>
In-Reply-To: <20250515111355.15327-2-antonio@openvpn.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, sd@queasysnail.net, andrew@lunn.ch

Hello:

This series was applied to netdev/net-next.git (main)
by Antonio Quartulli <antonio@openvpn.net>:

On Thu, 15 May 2025 13:13:46 +0200 you wrote:
> Sabrina put quite some effort in reviewing the ovpn module
> during its official submission to netdev.
> For this reason she obtain extensive knowledge of the module
> architecture and implementation.
> 
> Make her an official reviewer, so that I can be supported
> in reviewing and acking new patches.
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] MAINTAINERS: add Sabrina as official reviewer for ovpn
    https://git.kernel.org/netdev/net-next/c/8170a0c968f4
  - [net-next,02/10] MAINTAINERS: update git URL for ovpn
    https://git.kernel.org/netdev/net-next/c/142e17cfb09e
  - [net-next,03/10] ovpn: set skb->ignore_df = 1 before sending IPv6 packets out
    https://git.kernel.org/netdev/net-next/c/4e51141f1dce
  - [net-next,04/10] ovpn: don't drop skb's dst when xmitting packet
    https://git.kernel.org/netdev/net-next/c/4ca6438da456
  - [net-next,05/10] selftest/net/ovpn: fix crash in case of getaddrinfo() failure
    https://git.kernel.org/netdev/net-next/c/8624daf9f27d
  - [net-next,06/10] ovpn: fix ndo_start_xmit return value on error
    https://git.kernel.org/netdev/net-next/c/47e8e9d29eaa
  - [net-next,07/10] selftest/net/ovpn: extend coverage with more test cases
    https://git.kernel.org/netdev/net-next/c/944f8b6abab6
  - [net-next,08/10] ovpn: drop useless reg_state check in keepalive worker
    https://git.kernel.org/netdev/net-next/c/adcdaac57d3c
  - [net-next,09/10] ovpn: improve 'no route to host' debug message
    https://git.kernel.org/netdev/net-next/c/0ca74dfabdfe
  - [net-next,10/10] ovpn: fix check for skb_to_sgvec_nomark() return value
    https://git.kernel.org/netdev/net-next/c/40d48527a587

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



