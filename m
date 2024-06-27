Return-Path: <netdev+bounces-107156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A8291A24B
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 11:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0924B21248
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 09:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1315413AA47;
	Thu, 27 Jun 2024 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLrYW+xd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8676137757;
	Thu, 27 Jun 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479431; cv=none; b=K15/Ad9IiRv60KTrfAYgS8/7p4oufO9T+26YWC2icwc/b9NtmSqUguIkKDj3yHOz/pATQJUjIvpcCpdc8XsxwPLP+ThNJ0qg67/NcydqoPaEuH5EN+7Iel9+p9tBhDQSEXcroVT2iWlhsFaxhdpQU2kzGoUXyIAea4lKl3YvXDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479431; c=relaxed/simple;
	bh=GmpUEmL645flm8du5E63Ee5Mu3fSTAGYlBX8R7TSu3I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kw4FEJ3J4C4m+a7dsYw6/dSvuBM+82axB6sGmIHSkXLm8puvdfNCsTDXQ3Ue9cTjHyIkJMOWagHerewgoXqzFhTzaqRcaBdPln0sSBWO1lh2MPGKNlCeXKbpgcmS1x75PT7gKIVes2/uX3QbsThUE49njE1v0pcRo3tSohr7cXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLrYW+xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7006C4AF07;
	Thu, 27 Jun 2024 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719479430;
	bh=GmpUEmL645flm8du5E63Ee5Mu3fSTAGYlBX8R7TSu3I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KLrYW+xdFRd3GgfNr7aAnJjxkGKBQU0P35cLoR41YHPkoebKuhMaRvaZnA4fdqC0Y
	 GA19fPBmvv1XjNKQSM76SZn/+OMz+Qj6ran9KHYWWspwD5QJ+AVcr/npJOwl/sxtgv
	 CNQDKizSwWD85o8K7FGMYLB3/hBlNyP1G4Mo1OrDJor5rnLHVKAKzo+32t7DfJZolK
	 dt0M05o/lKchIwKakJCuJbD4r3CEUx4P5dQI3H7rNtUeu2hz2NpGqSfaNtXZrBzo25
	 HRhLNl/SDfQr2y9iE9KT2lGFl9TFCt8HmKp01N4J4TUjiWxQigBu4fsFSNElfQgwMn
	 CN46oJy/8JZzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9698CDE8DE0;
	Thu, 27 Jun 2024 09:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next,PATCH v3 0/2] Series to deliver Ethernet for STM32MP25
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171947943061.14380.1530245725990563660.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 09:10:30 +0000
References: <20240624071052.118042-1-christophe.roullier@foss.st.com>
In-Reply-To: <20240624071052.118042-1-christophe.roullier@foss.st.com>
To: Christophe Roullier <christophe.roullier@foss.st.com>
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

On Mon, 24 Jun 2024 09:10:50 +0200 you wrote:
> STM32MP25 is STM32 SOC with 2 GMACs instances.
>     GMAC IP version is SNPS 5.3x.
>     GMAC IP configure with 2 RX and 4 TX queue.
>     DMA HW capability register supported
>     RX Checksum Offload Engine supported
>     TX Checksum insertion supported
>     Wake-Up On Lan supported
>     TSO supported
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] dt-bindings: net: add STM32MP25 compatible in documentation for stm32
    https://git.kernel.org/netdev/net-next/c/3d94d1ac3792
  - [net-next,v3,2/2] net: stmmac: dwmac-stm32: stm32: add management of stm32mp25 for stm32
    https://git.kernel.org/netdev/net-next/c/5bcc1afd0219

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



