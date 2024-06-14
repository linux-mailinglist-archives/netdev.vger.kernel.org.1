Return-Path: <netdev+bounces-103527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A2E9086E5
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 11:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817781F22ABB
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 09:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AB7191496;
	Fri, 14 Jun 2024 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOCG+U8d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B709118C32B;
	Fri, 14 Jun 2024 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355638; cv=none; b=ef5wSaGd/wJMKL8QRkyIuwkv7c899dz0bSSgZj1ezlZTk0s6IpHEexPhgLBP23Yvmt7S3KTw42wniYo65HR3zG3hjtkIcNihJVRMuSpBufncwUDiCuK8lDTt+BTkzqVhC/Jx/b8CooWumOBcSGBaLc0IcyUcL6NTGmzZcc5Yrvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355638; c=relaxed/simple;
	bh=epfSrd8hbeGIbDDSU+mnrqQJEh9H0kdbYyucSYP1AJg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M71FJp25qo7utPrezpMMr4Hprcj3GMhrvJD5YHNaYb0mUryctkz0ujIxqng+zyvTb9qbh6nFQeOqf+z7vwgJ2wTBtnZskbUv/xh4y51RuQ9FL6FWQxhx6H+fn0nDxhbdCfH70aNENVC9MVE1ioQtNm573ry9dun3vBoAG/1L+8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOCG+U8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35B17C4AF1C;
	Fri, 14 Jun 2024 09:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718355638;
	bh=epfSrd8hbeGIbDDSU+mnrqQJEh9H0kdbYyucSYP1AJg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WOCG+U8duy/bkqurFvsSKh0My/oFop7YfeUJkN+aaf6/beCzhfsIsqrTwpS6pVbd3
	 5nTzKeD8zeGmU/U5c696MGdf8WOJOAzrqYMWRnZ4KMS7D7kOHZ0uyM6Y0aOV1bmJ1z
	 Iw5PDoHyu8y9nKXUhP9ixiw/TO9pDkwURGPcjUhTJAcnjifM1EAJojtP3eOl7f2YDx
	 eqUC4A+telnroweMhhtdCsinFhj6jdeAUBExBM7pul7ahVd53sb5H9GtIqxgCmW2Ag
	 qWTSAAAKedKLuL2qfhwwNkJJKWgbnczG8MaLP5gTbkRNZ99fh1S+atdtb+1jWxhbZd
	 5Bxgw5L3ROP0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 240A4C43616;
	Fri, 14 Jun 2024 09:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next,PATCH v7 0/8] Series to deliver Ethernet for STM32MP13
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171835563814.26751.8950769573761217764.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jun 2024 09:00:38 +0000
References: <20240611083606.733453-1-christophe.roullier@foss.st.com>
In-Reply-To: <20240611083606.733453-1-christophe.roullier@foss.st.com>
To: Christophe ROULLIER <christophe.roullier@foss.st.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 richardcochran@gmail.com, joabreu@synopsys.com, lgirdwood@gmail.com,
 broonie@kernel.org, marex@denx.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 11 Jun 2024 10:35:58 +0200 you wrote:
> STM32MP13 is STM32 SOC with 2 GMACs instances
>     GMAC IP version is SNPS 4.20.
>     GMAC IP configure with 1 RX and 1 TX queue.
>     DMA HW capability register supported
>     RX Checksum Offload Engine supported
>     TX Checksum insertion supported
>     Wake-Up On Lan supported
>     TSO supported
> Rework dwmac glue to simplify management for next stm32 (integrate RFC from Marek)
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/8] dt-bindings: net: add STM32MP13 compatible in documentation for stm32
    https://git.kernel.org/netdev/net-next/c/8a9044e5169b
  - [net-next,v7,2/8] net: stmmac: dwmac-stm32: Separate out external clock rate validation
    https://git.kernel.org/netdev/net-next/c/582ac134963e
  - [net-next,v7,3/8] net: stmmac: dwmac-stm32: Separate out external clock selector
    https://git.kernel.org/netdev/net-next/c/63b0aa8ea73f
  - [net-next,v7,4/8] net: stmmac: dwmac-stm32: Extract PMCR configuration
    https://git.kernel.org/netdev/net-next/c/92704f8c0e7a
  - [net-next,v7,5/8] net: stmmac: dwmac-stm32: Clean up the debug prints
    https://git.kernel.org/netdev/net-next/c/c60a54b52026
  - [net-next,v7,6/8] net: stmmac: dwmac-stm32: Fix Mhz to MHz
    https://git.kernel.org/netdev/net-next/c/cbfad55322ce
  - [net-next,v7,7/8] net: stmmac: dwmac-stm32: Mask support for PMCR configuration
    https://git.kernel.org/netdev/net-next/c/4f37dc467ffe
  - [net-next,v7,8/8] net: stmmac: dwmac-stm32: add management of stm32mp13 for stm32
    https://git.kernel.org/netdev/net-next/c/50bbc0393114

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



