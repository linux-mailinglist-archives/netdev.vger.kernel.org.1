Return-Path: <netdev+bounces-173133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4D0A577F0
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 04:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5267F177653
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 03:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83559165EFC;
	Sat,  8 Mar 2025 03:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mV7oTwwp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575A71624DC;
	Sat,  8 Mar 2025 03:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405209; cv=none; b=dkJaymFC3mMbz6x1lJkSGdtUm0piD26qcR+ZXsoSZphkCJQLICHnmfgJx6CpTaJ/OBvMH3E+KgvzkPJvyCyqXVQ1OGk647pnnq2+8hSzAV4wwbXVR3g01fau9YBwTBlitS3MRp+RZo7eK/wSX6HIPXY6pBVPQ9DIjGzuzx8aiN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405209; c=relaxed/simple;
	bh=VbfFId+c8hU5TKBC8vVV3K3Ub0jULqeS8673sNKaj7g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sXuYwuXPkdQh8Od3VyT6K5xvcm3G4NyzxHDXa9aNLjOFJyebEwCqBPnLnazLCOGr3tAbmIKYhV6Yq4tUJJw+dg5lrCwZL6svmjg8Jfc6rmvmr7M05NlgLFmEaOlVb8C3pJOhJku4ryRvoS/AeuqXC+/Y75myZ92v0cqDAbLutGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mV7oTwwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0C3C4CEE8;
	Sat,  8 Mar 2025 03:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405208;
	bh=VbfFId+c8hU5TKBC8vVV3K3Ub0jULqeS8673sNKaj7g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mV7oTwwpvL0aeS+JSNZl3l8a9/aRCG7F9Js6RToq04XDgUGqYoGAPcje1iM9jtDNn
	 8KdCPVCgeiA9aadZfulZYr4hUzqfWPIyhUY0uZZqpO8yYKKqFDsIlNX3iQ1qBSIi9b
	 VLVPJMaSHVflnFMNfUrjcW+MmlWE0a+zhK/SfdfyreuWSia4jVQ+wyJBEXBtnk8MJX
	 RGCNk0ygocpcj0TgkwAu6AegZtA67CQDjTw0H2rO+59j0Vm7XTv//hUK+oVAG3B1+V
	 rc9BVSkzgtfG+38Ici/qeBxoWWQ7CwfbubBDbn6H1hqsKQ0P4FRe3OgtGN8lsPsrgd
	 CgtPosWoTw7Qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71901380CFFB;
	Sat,  8 Mar 2025 03:40:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/4] riscv: sophgo: Add ethernet support for
 SG2044
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140524199.2565853.4357984309163755989.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 03:40:41 +0000
References: <20250307011623.440792-1-inochiama@gmail.com>
In-Reply-To: <20250307011623.440792-1-inochiama@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, unicorn_wang@outlook.com, inochiama@outlook.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, clement.leger@bootlin.com,
 emil.renner.berthing@canonical.com, jan.petrous@oss.nxp.com,
 yong.liang.choong@linux.intel.com, jszhang@kernel.org,
 rmk+kernel@armlinux.org.uk, olteanv@gmail.com, 0x1207@gmail.com,
 romain.gantois@bootlin.com, fancer.lancer@gmail.com,
 joe@pf.is.s.u-tokyo.ac.jp, l.rubusch@gmail.com,
 bartosz.golaszewski@linaro.org, peppe.cavallaro@st.com, joabreu@synopsys.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 dlan@gentoo.org, looong.bin@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Mar 2025 09:16:13 +0800 you wrote:
> The ethernet controller of SG2044 is Synopsys DesignWare IP with
> custom clock. Add glue layer for it.
> 
> Changed from v6:
> - https://lore.kernel.org/netdev/20250305063920.803601-1-inochiama@gmail.com/
> 1. rebase against latest net-next/main
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/4] dt-bindings: net: Add support for Sophgo SG2044 dwmac
    https://git.kernel.org/netdev/net-next/c/114508a89ddc
  - [net-next,v7,2/4] net: stmmac: platform: Group GMAC4 compatible check
    https://git.kernel.org/netdev/net-next/c/f8add6654d3c
  - [net-next,v7,3/4] net: stmmac: platform: Add snps,dwmac-5.30a IP compatible string
    https://git.kernel.org/netdev/net-next/c/9ef17cafc36b
  - [net-next,v7,4/4] net: stmmac: Add glue layer for Sophgo SG2044 SoC
    https://git.kernel.org/netdev/net-next/c/a22221ef5dee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



