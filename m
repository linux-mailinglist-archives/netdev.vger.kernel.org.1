Return-Path: <netdev+bounces-143957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876F09C4D67
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 04:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7A5289E75
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 03:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765A4207A35;
	Tue, 12 Nov 2024 03:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2F4we61"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D00207A28
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 03:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731382824; cv=none; b=ASuN0NYvm9qV2jdwtQAQUjABb5zSe2kO2KBg3NhBe2KdKZV1KLddlDsG7pQvnSaFon75STPPrOgMUpL4uYNU7mQfufOgZWWoaM5Ze+RihHRryktO/Ee4rLJ3zrLUNF7qFTr00B3LAYIOipVMB1SLR1/iln5E94yyfyJ4Q2dRbZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731382824; c=relaxed/simple;
	bh=V7VQQqfcVsaUz2uGF/sfJOJoVoQke+P9vs80MW1rbag=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r5q6e39CWpxBEFiTzEoaW8y17kXnYT2WbDIAcPdr9nUDoU5VQC7HL27/15de3J4h97gGYoDR0/zoVPgScUanaWDs2MGa4ka8l44WGqwH/IKKXFTXxMbnJFOWJbLFr/2lY0LYkBMF3mhis3UKT96tkDTAdUOk1KhoYRwz37CuygU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2F4we61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2010CC4CED0;
	Tue, 12 Nov 2024 03:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731382824;
	bh=V7VQQqfcVsaUz2uGF/sfJOJoVoQke+P9vs80MW1rbag=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z2F4we618VtAA0+CLIH+4Cw2CUzGqtlD+6gWGoiRuPzMJcB/4mtWfscuCNSQDyA4m
	 4+McvoYBQzD/75XExUdS+nQsWeA1ujxaffeB+zg1NV8hcU/hpVLVVR3w7tYKkRktb2
	 Sp7ABDkTdhHGLdbgUmI9eFTGYg5+f/sKsT7AmupH+VbGwvl0+h7iIxXXz7p5LLjwul
	 nx+OrDEhtKU82sRYlEQLlBujaGNr71ZOpbHc87iqmCqwdVSo2aSK+IC4PeFuFkUKlx
	 TahgfdAWvvKATJ1V2kZ2a1yFoTP+loXyGwwbTZyPna8JnmxM++rGaJ3xACsPrQLS75
	 3S+TL6meLpxBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DC83809A80;
	Tue, 12 Nov 2024 03:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net: phylink: phylink_resolve() cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173138283399.71105.492066490377588135.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 03:40:33 +0000
References: <Zy411lVWe2SikuOs@shell.armlinux.org.uk>
In-Reply-To: <Zy411lVWe2SikuOs@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 8 Nov 2024 16:01:26 +0000 you wrote:
> Hi,
> 
> This series does a bit of clean-up in phylink_resolve() to make the code
> a little easier to follow.
> 
> Patch 1 moves the manual flow control setting in two of the switch
> cases to after the switch().
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net: phylink: move manual flow control setting
    https://git.kernel.org/netdev/net-next/c/8cc5f4cb94c0
  - [net-next,2/5] net: phylink: move MLO_AN_FIXED resolve handling to if() statement
    https://git.kernel.org/netdev/net-next/c/92abfcb4ced4
  - [net-next,3/5] net: phylink: move MLO_AN_PHY resolve handling to if() statement
    https://git.kernel.org/netdev/net-next/c/f0f46c2a3d8e
  - [net-next,4/5] net: phylink: remove switch() statement in resolve handling
    https://git.kernel.org/netdev/net-next/c/d1a16dbbd84e
  - [net-next,5/5] net: phylink: clean up phylink_resolve()
    https://git.kernel.org/netdev/net-next/c/bc08ce37d99a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



