Return-Path: <netdev+bounces-176219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F92BA69637
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169DA165911
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCB41E3785;
	Wed, 19 Mar 2025 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gwmk/3sC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6774A1E0DE6;
	Wed, 19 Mar 2025 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404798; cv=none; b=ksT125WKRGyZOl+Da9tUAP618o2E5PN2ld78fIfFP5Pv/zPqLk+dVMAVLN5hXFOV7s30LGHbktsdjaCuf3w6HJW0wu4o2mBBEL/vA9Z0pPbJgUh1ScMi+tmhl4tprUYCQsYZYeWxgXsfx9+scikKo1mgE78nJYEyyD0Dc4WYT9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404798; c=relaxed/simple;
	bh=LrltH36LcKzUeNqpvSJ0cSNyUs04mlDZqxOw+sb1OXc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aOTqHv2VZrPI67AtOU42DlBSDuqFZAbGiX3ENwT6koJbRrHWhALVd3TJ+FbJBEY2T48IHl+WX2bodtE5g69ueh8uxNqQ+VlFv02WvnedXXoerIv3GVRpRgkFutINaWo7ZbSXGIS/wPCXwODtRPf+WqaehlorfhFWsGGqZlXIa0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gwmk/3sC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4E2C4CEE4;
	Wed, 19 Mar 2025 17:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742404797;
	bh=LrltH36LcKzUeNqpvSJ0cSNyUs04mlDZqxOw+sb1OXc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gwmk/3sCXrryWVFn02KC6xjpk+pafHJkPHLPh/Zq5TEj0QR7BCneUeEc6Jc1jpNTN
	 KEEHR+DrxNT/D6DS6N38wBO+yj8ywpgpl4I2meuluRDkKjBzrC+0Ls5xAymsYS7pAF
	 PPdJ0EovZxtO61R9xfmGLHs5BmDaOfDQmn+CY+MQNE+w0enB0FHsICj2dIaf7gMdxC
	 ujBr2jVJbYOk6d5oUF22g+7kxmDYXqMSwc3vmmFmc8Qi8N8tO5DqM3Y8GdAzY8SBx1
	 MoI4Gjhad2t5bV1YP4VujVh7LGr+2BlRB4H4N9dnFMPA73Q1rbX/l3ecEiAqnc/quo
	 j3pL/y6P8ntig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE637380CFFE;
	Wed, 19 Mar 2025 17:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/7] net: stmmac: deprecate
 "snps,en-tx-lpi-clockgating" property
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174240483352.1121844.16892728893562053636.git-patchwork-notify@kernel.org>
Date: Wed, 19 Mar 2025 17:20:33 +0000
References: <Z9FVHEf3uUqtKzyt@shell.armlinux.org.uk>
In-Reply-To: <Z9FVHEf3uUqtKzyt@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 christophe.roullier@st.com, conor+dt@kernel.org, conor@kernel.org,
 davem@davemloft.net, devicetree@vger.kernel.org, kernel@esmil.dk,
 edumazet@google.com, peppe.cavallaro@st.com, kuba@kernel.org,
 joabreu@synopsys.com, krzk+dt@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 minda.chen@starfivetech.com, netdev@vger.kernel.org, palmer@dabbelt.com,
 pabeni@redhat.com, paul.walmsley@sifive.com, robh@kernel.org,
 samin.guo@starfivetech.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 12 Mar 2025 09:34:20 +0000 you wrote:
> On Sun, Mar 09, 2025 at 03:01:45PM +0000, Russell King (Oracle) wrote:
> Hi,
> 
> This series deprecates the "snps,en-tx-lpi-clockgating" property for
> stmmac.
> 
> MII Transmit clock gating, where the MAC hardware supports gating this
> clock, is a function of the connected PHY capabilities, which it
> reports through its status register.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/7] net: stmmac: allow platforms to use PHY tx clock stop capability
    https://git.kernel.org/netdev/net-next/c/0c1f1eb65425
  - [net-next,v2,2/7] net: stmmac: starfive: use PHY capability for TX clock stop
    https://git.kernel.org/netdev/net-next/c/5f250bd72a01
  - [net-next,v2,3/7] net: stmmac: stm32: use PHY capability for TX clock stop
    https://git.kernel.org/netdev/net-next/c/a5bc19e2abeb
  - [net-next,v2,4/7] riscv: dts: starfive: remove "snps,en-tx-lpi-clockgating" property
    https://git.kernel.org/netdev/net-next/c/637af286f9fc
  - [net-next,v2,5/7] ARM: dts: stm32: remove "snps,en-tx-lpi-clockgating" property
    https://git.kernel.org/netdev/net-next/c/50a84bbc7ec1
  - [net-next,v2,6/7] dt-bindings: deprecate "snps,en-tx-lpi-clockgating" property
    https://git.kernel.org/netdev/net-next/c/a62b7901d3a9
  - [net-next,v2,7/7] net: stmmac: deprecate "snps,en-tx-lpi-clockgating" property
    https://git.kernel.org/netdev/net-next/c/cf0a96de397e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



