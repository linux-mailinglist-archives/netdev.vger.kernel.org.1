Return-Path: <netdev+bounces-198845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91986ADE041
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 03:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26C2189BB73
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BB92556E;
	Wed, 18 Jun 2025 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrCPCSsw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7686846F;
	Wed, 18 Jun 2025 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750208421; cv=none; b=TfGQwsu9m5d7A4PEFtpyXFcmi9oQj2mlp70aI9CClEp0NiGqzlwIFfr5X5m4IUs9wrqz5bCqpQC9o0yZv1qCtF4lmSjrNbva6MDEE34Xphy1igmRXq2jeE7vRDkKiLCPYNc7wL7VSXMoop9Wd7/QeS0dIJsf/D6NcNn3gtTP3Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750208421; c=relaxed/simple;
	bh=icy7HhtAW5NBNUvvYil+osovRI3CO4xZ3q0yIv7TOYA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QojXavwkmR8hIpV9R44QqMPLXNRn5qx7UVpaAWOxkuhwoXxTsxqQCM2inC1pGAXqT+hBV2B/r9FPZOOT8RKtF1k1Yf1elMgU07BVdM9n/65NnUu6TVqimMyFfzPb5ZRjoaeLUedzbiJQqn8Lcy0OufenkduCkchxhRJa1goBDBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrCPCSsw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB4EC4CEE3;
	Wed, 18 Jun 2025 01:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750208421;
	bh=icy7HhtAW5NBNUvvYil+osovRI3CO4xZ3q0yIv7TOYA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nrCPCSsw0ztzC57F0Wfp6nQ7zbsQ7HJ9pzCgP1JiIjyybNzWddO7XXluc2UeBtT4/
	 TkKYpJDGHizsuVhPbMnBvn9dSLJsVjoIvMCCB7Ju6PNqGJFdB4QfHmOnpPFh2WxdWy
	 RHbKFINSavCq//TlEs3nmsAl8hycMjHp3OGWgXjoLSmAuyS2FYDPYbNmTi2onTVF9i
	 K88zBUIeB/PD/FDF8zU+AA5Paz6g7loLoqYp4m2gic5rXz62i9f8SvzBp3rWJZNCtm
	 Jg1Xnn+JxcE/EcIoyO+HRpjmdEVbhWuokiAE0wmmm3dNFxa+x+7Tl/dMV1QLSbQ1J4
	 V6sXRueufN7oA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD3138111DD;
	Wed, 18 Jun 2025 01:00:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 00/14] net: dsa: b53: fix BCM5325 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175020844975.3753357.15459722703742480869.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 01:00:49 +0000
References: <20250614080000.1884236-1-noltari@gmail.com>
In-Reply-To: <20250614080000.1884236-1-noltari@gmail.com>
To: =?utf-8?q?=C3=81lvaro_Fern=C3=A1ndez_Rojas_=3Cnoltari=40gmail=2Ecom=3E?=@codeaurora.org
Cc: jonas.gorski@gmail.com, florian.fainelli@broadcom.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vivien.didelot@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dgcbueu@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Jun 2025 09:59:46 +0200 you wrote:
> These patches get the BCM5325 switch working with b53.
> 
> The existing brcm legacy tag only works with BCM63xx switches.
> We need to add a new legacy tag for BCM5325 and BCM5365 switches, which
> require including the FCS and length.
> 
> I'm not really sure that everything here is correct since I don't work for
> Broadcom and all this is based on the public datasheet available for the
> BCM5325 and my own experiments with a Huawei HG556a (BCM6358).
> 
> [...]

Here is the summary with links:
  - [net-next,v4,01/14] net: dsa: tag_brcm: legacy: reorganize functions
    https://git.kernel.org/netdev/net-next/c/a4daaf063f82
  - [net-next,v4,02/14] net: dsa: tag_brcm: add support for legacy FCS tags
    https://git.kernel.org/netdev/net-next/c/ef07df397a62
  - [net-next,v4,03/14] net: dsa: b53: support legacy FCS tags
    https://git.kernel.org/netdev/net-next/c/c3cf059a4d41
  - [net-next,v4,04/14] net: dsa: b53: detect BCM5325 variants
    https://git.kernel.org/netdev/net-next/c/0cbec9aef5a8
  - [net-next,v4,05/14] net: dsa: b53: add support for FDB operations on 5325/5365
    https://git.kernel.org/netdev/net-next/c/c45655386e53
  - [net-next,v4,06/14] net: dsa: b53: prevent FAST_AGE access on BCM5325
    https://git.kernel.org/netdev/net-next/c/9b6c767c312b
  - [net-next,v4,07/14] net: dsa: b53: prevent SWITCH_CTRL access on BCM5325
    https://git.kernel.org/netdev/net-next/c/22ccaaca4344
  - [net-next,v4,08/14] net: dsa: b53: fix IP_MULTICAST_CTRL on BCM5325
    https://git.kernel.org/netdev/net-next/c/044d5ce2788b
  - [net-next,v4,09/14] net: dsa: b53: prevent DIS_LEARNING access on BCM5325
    https://git.kernel.org/netdev/net-next/c/800728abd9f8
  - [net-next,v4,10/14] net: dsa: b53: prevent BRCM_HDR access on older devices
    https://git.kernel.org/netdev/net-next/c/e17813968b08
  - [net-next,v4,11/14] net: dsa: b53: prevent GMII_PORT_OVERRIDE_CTRL access on BCM5325
    https://git.kernel.org/netdev/net-next/c/37883bbc45a8
  - [net-next,v4,12/14] net: dsa: b53: fix unicast/multicast flooding on BCM5325
    https://git.kernel.org/netdev/net-next/c/651c9e71ffe4
  - [net-next,v4,13/14] net: dsa: b53: fix b53_imp_vlan_setup for BCM5325
    https://git.kernel.org/netdev/net-next/c/c00df1018791
  - [net-next,v4,14/14] net: dsa: b53: ensure BCM5325 PHYs are enabled
    https://git.kernel.org/netdev/net-next/c/966a83df36c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



