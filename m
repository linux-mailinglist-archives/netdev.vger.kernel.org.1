Return-Path: <netdev+bounces-76477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C840086DE4B
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 10:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8145F282596
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 09:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A237B6A345;
	Fri,  1 Mar 2024 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tl5jns5Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790DA69DEA;
	Fri,  1 Mar 2024 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285432; cv=none; b=ivONRxQcT3LWEk5D7UF65BqDL/QowIt19ydH2WR6WBzyzrVdD8u8XBppPKtj7d+g5tBeZMReWvrs1GQzEFxuWLcP6B8EjfuvqEbkBbBmuVoX9AH7rPA4MUU72SNmsb2U+DbJ4bjwp2NdC6ftmX+bi3T0xz/ra5ZpGAD1oB8z/BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285432; c=relaxed/simple;
	bh=TpiIC487q0AstORpwvTUdNDZ7Z2PIWOGZ4se6WsW4qY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WQvNqhNRqvd3gL4bOLQh8A6v4/kXNAh4uqvzepszBYcYq1qg01SolIIoVGV/ldZJMsDHQlrVXl/4+O5zu64896R6agcXg8c6L37kTPthURLuvvZmsvK6uvq1fzi5Ok2ZS3fhqXFRib8mPqvOBYsDqCSJP5vxFegDFRBgRcN6o6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tl5jns5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E83DCC43390;
	Fri,  1 Mar 2024 09:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709285432;
	bh=TpiIC487q0AstORpwvTUdNDZ7Z2PIWOGZ4se6WsW4qY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Tl5jns5YG73wbwINUVlg5Lc9oFCBSAbYUuUj3C0yEveZwPMLn60JHf6krDOY+VBf/
	 r6jp04vPBe1uuipDX+57/zMQuOkbi9xdyjxbGmTOVEgnWrEbeBCD1V6+zcvRK5lok/
	 VArLD3/USL6ZlQ+KcYiksyLT8Fz80xYzapNLo422pCOYIsKY+8FOqscIrgvGTPQIQD
	 +9N8ZXNL0fts6d2kkwvFjrsuQHTMVqEHr7NzvptZuEzM4OXoz3D9yMBGjQd9R5RcoL
	 k5SwZvsmB6VnquhzpEhGGVZfOO6VJiSFoBrRMM1VQal+zbDXzCPzUS2ImZVEH+nydl
	 Hkh1o6tVXUWrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB7DBD990AE;
	Fri,  1 Mar 2024 09:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/6] Support for ASP 2.2 and optimizations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170928543182.25294.16027114391338365355.git-patchwork-notify@kernel.org>
Date: Fri, 01 Mar 2024 09:30:31 +0000
References: <20240228225400.3509156-1-justin.chen@broadcom.com>
In-Reply-To: <20240228225400.3509156-1-justin.chen@broadcom.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, horms@kernel.org,
 bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 opendmb@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, rafal@milecki.pl, devicetree@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 28 Feb 2024 14:53:54 -0800 you wrote:
> ASP 2.2 adds some power savings during low power modes.
> 
> Also make various improvements when entering low power modes and
> reduce MDIO traffic by hooking up interrupts.
> 
> Justin Chen (6):
>   dt-bindings: net: brcm,unimac-mdio: Add asp-v2.2
>   dt-bindings: net: brcm,asp-v2.0: Add asp-v2.2
>   net: bcmasp: Add support for ASP 2.2
>   net: phy: mdio-bcm-unimac: Add asp v2.2 support
>   net: bcmasp: Keep buffers through power management
>   net: bcmasp: Add support for PHY interrupts
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/6] dt-bindings: net: brcm,unimac-mdio: Add asp-v2.2
    https://git.kernel.org/netdev/net-next/c/edac4b113297
  - [net-next,v3,2/6] dt-bindings: net: brcm,asp-v2.0: Add asp-v2.2
    https://git.kernel.org/netdev/net-next/c/5682a878e7f1
  - [net-next,v3,3/6] net: bcmasp: Add support for ASP 2.2
    https://git.kernel.org/netdev/net-next/c/1d472eb5b670
  - [net-next,v3,4/6] net: phy: mdio-bcm-unimac: Add asp v2.2 support
    https://git.kernel.org/netdev/net-next/c/9112fc0109fc
  - [net-next,v3,5/6] net: bcmasp: Keep buffers through power management
    https://git.kernel.org/netdev/net-next/c/4688f4f41cfa
  - [net-next,v3,6/6] net: bcmasp: Add support for PHY interrupts
    https://git.kernel.org/netdev/net-next/c/cc7f105e7604

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



