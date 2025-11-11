Return-Path: <netdev+bounces-237404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D38EC4AC8E
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C60A18816C6
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 01:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66480341AC7;
	Tue, 11 Nov 2025 01:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oup1VJi+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E64A2DE6EF;
	Tue, 11 Nov 2025 01:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824651; cv=none; b=eNzKqBY9D6PrFW0FsbK84qKNAYrrFf1P3eiOyzJlorhPLHvX1lvdZFntfhRa1PTuu7C8FdyQbAenrfjxrvXhEF6JIDUldw4G3iUdeSkjSM5fuYK45AxjfjDSVlniU/1giPQL3ynBAAaL2aWA2fmZdiTKVyiRRXyLUXDrCxJfRq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824651; c=relaxed/simple;
	bh=HrZb5jpUnCxROQGuuROnL3P/s67nLZ04T0l4pc3iJt0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pIWinDEFjeV/UvnGjjXVVLi66MC89HqVuVgA/6BiiUsoXMTDwWsm2xZ7ShrxO8PV/VfpzhAAO/7S1u1ewg2mGiyVFlqJzxAeHpeLbjMb0Llzle2OdtB+XWQdAxRSgEFdiY349kks8RhDLF5AuFFJ5al7qEP3wcCmL/RDTFzLeZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oup1VJi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3A4C19424;
	Tue, 11 Nov 2025 01:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762824650;
	bh=HrZb5jpUnCxROQGuuROnL3P/s67nLZ04T0l4pc3iJt0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oup1VJi+6v6e7L9G9TMYYymkg4m7O8kar0BcFlZLlA9uSeoq0ngVpIv12+5gKxRd8
	 D3FNBJCyeKHFg+hEzQl4/n4VQfqZsyXQEHzeLXvmGNBbYpcBjZ26d9JspLUuEtW0Ly
	 F3mLUw0Ftz0j0dukgu8kgzJ0K3g1pY77mtWsiCk6VG6I9k8SirfYZ4UrMmHVHhdMFr
	 j7BQqtKmDuHNLOW3kh9stx8D6IRiRmnMWPgsS6R6FmaxIEuaccdlw02+O9e6BCaYD/
	 C36kviTBVhC4/a03cbtN5bfv2TAqKr57P9xGX7ggzyUlZ9sBDbUbm+nrBepxxwQeBS
	 ARxahVMn9+kvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFD4380CFD7;
	Tue, 11 Nov 2025 01:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] net: dsa: b53: add support for BCM5389/97/98
 and
 BCM63XX ARL formats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176282462024.2841507.15060077817611607078.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 01:30:20 +0000
References: <20251107080749.26936-1-jonas.gorski@gmail.com>
In-Reply-To: <20251107080749.26936-1-jonas.gorski@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Nov 2025 09:07:41 +0100 you wrote:
> Currently b53 assumes that all switches apart from BCM5325/5365 use the
> same ARL formats, but there are actually multiple formats in use.
> 
> Older switches use a format apparently introduced with BCM5387/BCM5389,
> while newer chips use a format apparently introduced with BCM5395.
> 
> Note that these numbers are not linear, BCM5397/BCM5398 use the older
> format.
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] net: dsa: b53: b53_arl_read{,25}(): use the entry for comparision
    https://git.kernel.org/netdev/net-next/c/a6e4fd38bf2f
  - [net-next,2/8] net: dsa: b53: move reading ARL entries into their own function
    https://git.kernel.org/netdev/net-next/c/4a291fe72267
  - [net-next,3/8] net: dsa: b53: move writing ARL entries into their own functions
    https://git.kernel.org/netdev/net-next/c/bf6e9d2ae1db
  - [net-next,4/8] net: dsa: b53: provide accessors for accessing ARL_SRCH_CTL
    https://git.kernel.org/netdev/net-next/c/1716be6db04a
  - [net-next,5/8] net: dsa: b53: split reading search entry into their own functions
    https://git.kernel.org/netdev/net-next/c/e0c476f325a8
  - [net-next,6/8] net: dsa: b53: move ARL entry functions into ops struct
    https://git.kernel.org/netdev/net-next/c/a7e73339ad46
  - [net-next,7/8] net: dsa: b53: add support for 5389/5397/5398 ARL entry format
    https://git.kernel.org/netdev/net-next/c/300f78e8b6b7
  - [net-next,8/8] net: dsa: b53: add support for bcm63xx ARL entry format
    https://git.kernel.org/netdev/net-next/c/2b3013ac0302

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



