Return-Path: <netdev+bounces-121978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B043695F748
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671811F22D32
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46032198A27;
	Mon, 26 Aug 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGf04jGx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0A9198A11;
	Mon, 26 Aug 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691630; cv=none; b=PIeAs2+AxLrMiUQQ/WVqlrNI3XPb3Xnl0hKE+xIt+8sgmqUXVwOfufi9a121ydEYC8nkix5564csQRST6ns1v6oDqvqGKYjD3loVX9kPMW6JSN03uZ4yXsFrvMMWBRNpP0lAHcJ0QtMJh/bdoeX04n8TnFCskv8ZujAEGI6yrXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691630; c=relaxed/simple;
	bh=/IRM/2tvQX8CeHRsU7kn4NXZdqvz6QJqFRyF8qUf+u8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qTU5lz+WKcdHmvabcZttcvQ3ZmoKyZ0u+uXKSJKCScgeRTbGHDq2Zt1xubBe3DOYLLuSUHe7Vqo7Mr6hemRrGvhYaYBx2p8IDKdw+tYWKMqWH867OuosWdZZvdwPAKRGY2NZobPQ+e0YJGMFDr23qt+BP+fnq1Oh35uG7DoN2ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGf04jGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED5DC4FF73;
	Mon, 26 Aug 2024 17:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724691629;
	bh=/IRM/2tvQX8CeHRsU7kn4NXZdqvz6QJqFRyF8qUf+u8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jGf04jGxbP+XARELeB4KzXdodqH0LsPoq5a6+ZCqjgwkIRNOKrwFfoId6U2BTcVva
	 Uig5x3X5/8AgJad2fp8t7E+Dy6iptiDTIIuXcCgM/8w9tdfLZu6I1OZifpAj5VeyFC
	 Ch7+9jotqRYdhK8u7+teQs8RPM2ifF2ggjtIwhg5njOWOXa95TWJe8oNRDW+3VrQV5
	 jaobbZCnePzzV2vsAMWRnTWmkot1X0MHrerNquUMJ/BQycpKthEBwW9PJHatDL8g3m
	 +4rgAdSzSmui24Z+kuJm1wZb3mqnVYSSREjlEhr3Ofapdg2ys8ltvxwcAuendye7mx
	 D+hic/RnDPxMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D2F3822D6D;
	Mon, 26 Aug 2024 17:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/5] net: xilinx: axienet: Multicast fixes and
 improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172469162977.70473.13914203519128416707.git-patchwork-notify@kernel.org>
Date: Mon, 26 Aug 2024 17:00:29 +0000
References: <20240822154059.1066595-1-sean.anderson@linux.dev>
In-Reply-To: <20240822154059.1066595-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, edumazet@google.com,
 michal.simek@amd.com, andrew@lunn.ch, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Aug 2024 11:40:54 -0400 you wrote:
> This series has a few small patches improving the handling of multicast
> addresses. In particular, it makes the driver a whole lot less spammy,
> and adjusts things so we aren't in promiscuous mode when we have more
> than four multicast addresses (a common occurance on modern systems).
> 
> As the hardware has a 4-entry CAM, the ideal method would be to "pack"
> multiple addresses into one CAM entry. Something like:
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/5] net: xilinx: axienet: Always disable promiscuous mode
    (no matching commit)
  - [net-next,v3,2/5] net: xilinx: axienet: Fix dangling multicast addresses
    (no matching commit)
  - [net-next,v3,3/5] net: xilinx: axienet: Don't print if we go into promiscuous mode
    https://git.kernel.org/netdev/net-next/c/cd039e6787ff
  - [net-next,v3,4/5] net: xilinx: axienet: Don't set IFF_PROMISC in ndev->flags
    https://git.kernel.org/netdev/net-next/c/7a826fb3e4c6
  - [net-next,v3,5/5] net: xilinx: axienet: Support IFF_ALLMULTI
    https://git.kernel.org/netdev/net-next/c/749e67d5b297

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



