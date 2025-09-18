Return-Path: <netdev+bounces-224296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E58B83908
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45C504E2874
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 08:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D6E2FB973;
	Thu, 18 Sep 2025 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWVDYOv5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD12F5461
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184819; cv=none; b=UMFApX8/4a8GdWo0Epzney/7rNpqM1Hmf2AC3aOis4lOI/LO7N5PI326haF8ZdvdyAA08X2INuRzgadC47aW8dI00zE0vOVBVxb9vuIrIwXSKZlKuxyQKOsL1077/t8YmXRRZjz2zXY9Ql9zMH7LaJwmsKNxP4f/jdMYLwCxeQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184819; c=relaxed/simple;
	bh=Jd9287PjvPVaJPDGTGu1BO5hAK3Ccg03DTslvCmRaWU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m5kZRYnWVKmUVj5UHDcFXJClbY8EfB968rTCBpa4HnrcUmCxxFgA/oQx7lBfN9zwWr/D37miTuWYd5+pOm6WGq9pRaRKnJrGc2tXNvpwOYYaNQr9gQ4Mxcq9ca8GhgZjDC81Hy87NNCdh2cIIutp+N4ixegNcEmOiLLEJa7/kIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWVDYOv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E3DC4CEE7;
	Thu, 18 Sep 2025 08:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758184817;
	bh=Jd9287PjvPVaJPDGTGu1BO5hAK3Ccg03DTslvCmRaWU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tWVDYOv5disKHrCiEQvo3mfWPPmed42SzZ/MmYCM9GZhvf7BlHNw0KMorNv6hc8sU
	 oeqHZr6mGb3bsyeg5Frb1sIT4jLSF8ZTAMgKm5gH07nEDcG+4Zt03BguM2pXO7eiw/
	 guF96tnsh6kHx271JXMVHdeyKnMr5rbhtn0/r4MGH3KrH18Duf0KiYh9nFmkjvy+re
	 Q9HSftRRFNnQBGf/pqYjamib0eUveUu99qH692SECkGT/O5uQl8uvxP1i9aKP1U8KR
	 AbiFGIV+leMwBtFsBSvcQ6Le+Lh5gPd2vREKq057/V5jKOeLYBhOUeQGoT2R4TgmuJ
	 HwtafSa2x3Yrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADEF39D0C28;
	Thu, 18 Sep 2025 08:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10] udp: increase RX performance under stress
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175818481765.2322785.5338690827475365235.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 08:40:17 +0000
References: <20250916160951.541279-1-edumazet@google.com>
In-Reply-To: <20250916160951.541279-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, kuniyu@google.com, dsahern@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 16 Sep 2025 16:09:41 +0000 you wrote:
> This series is the result of careful analysis of UDP stack,
> to optimize the receive side, especially when under one or several
> UDP sockets are receiving a DDOS attack.
> 
> I have measured a 47 % increase of throughput when using
> IPv6 UDP packets with 120 bytes of payload, under DDOS.
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] ipv6: make ipv6_pinfo.saddr_cache a boolean
    https://git.kernel.org/netdev/net-next/c/3fbb2a6f3a70
  - [net-next,02/10] ipv6: make ipv6_pinfo.daddr_cache a boolean
    https://git.kernel.org/netdev/net-next/c/5489f333ef99
  - [net-next,03/10] ipv6: np->rxpmtu race annotation
    https://git.kernel.org/netdev/net-next/c/9fba1eb39e2f
  - [net-next,04/10] ipv6: reorganise struct ipv6_pinfo
    https://git.kernel.org/netdev/net-next/c/b76543b21fbc
  - [net-next,05/10] udp: refine __udp_enqueue_schedule_skb() test
    https://git.kernel.org/netdev/net-next/c/9aaec660b5be
  - [net-next,06/10] udp: update sk_rmem_alloc before busylock acquisition
    https://git.kernel.org/netdev/net-next/c/faf7b4aefd5b
  - [net-next,07/10] net: group sk_backlog and sk_receive_queue
    https://git.kernel.org/netdev/net-next/c/4effb335b5da
  - [net-next,08/10] udp: add udp_drops_inc() helper
    https://git.kernel.org/netdev/net-next/c/9db27c80622b
  - [net-next,09/10] udp: make busylock per socket
    https://git.kernel.org/netdev/net-next/c/3cd04c8f4afe
  - [net-next,10/10] udp: use skb_attempt_defer_free()
    https://git.kernel.org/netdev/net-next/c/6471658dc66c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



