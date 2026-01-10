Return-Path: <netdev+bounces-248651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC80D0CBF4
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 02:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B919730486A5
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 01:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760FE239086;
	Sat, 10 Jan 2026 01:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5pvintR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514E1234984;
	Sat, 10 Jan 2026 01:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768009421; cv=none; b=Zi7xFyesdG1fw6TNf2r7YscoR77aJ/KG9G6a1klcDWUVzrcPb24d2iaRrW4ZsH+loRzkMmCg24y90VhE1D4fxre3wh/mcZolj3e6RW8oKMiiNKl7Yr+aCz/3j6h7Zk9k76rlczEJL2FexuVO6zUoZklaZjZLFhGq/RT0i3nQ0b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768009421; c=relaxed/simple;
	bh=cl5jRiYV3kNHVdEZfbTnum5lCpQivb1iKFoKtYMyqVU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RaxoDRSNJ97MC/OuspAMhNIqXmPd9UVk8cpxxkGW87Cpgp4WJHqaFrbeE5ZQconb4OgRqQjMV7Th/qj2jbrr9sJHCNt6sajzcDa5UI4YS2Ncn/AgEN9kkD24VfeeT/vF2TcbtFV3P8zdZDWFZRfAqlMQN01znQrp6PIxwqkizd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5pvintR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8045C4CEF1;
	Sat, 10 Jan 2026 01:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768009420;
	bh=cl5jRiYV3kNHVdEZfbTnum5lCpQivb1iKFoKtYMyqVU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i5pvintRKRVYeAWSh9dsiUf6pjBI2UULnfXgnyhJQaE2lHLFxheKUnVbs/uyF+b+v
	 Z8D1tnEEpDKf7/ynfT+O9Tt3EWtRFlyhlXFC7mu0ZplSSxlbnfnZFEZZmHffXqgPMU
	 aRvIo8Eqklv+IXqGCxggs9v+uL1ZxRJgrKoR5T27x67NipIWc4YRwIWX8O27ctZeJu
	 JwabJMAK/35OqNcRKjHgTZUtFZEdIFW5+Z2JyO8IV1kbWo2R/oGDZtoRICUyRgb9B6
	 xczg/NuI+T+X2uHa9UEXxjV9cNJLIVzC9fkSPDWSWRC2pneUWcaxRl0ePzoegU1rZ8
	 PWkwod7d/HTeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B6B423AA9F46;
	Sat, 10 Jan 2026 01:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: rockchip-dwmac: Allow
 "dma-coherent"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176800921652.446502.5954901087399203743.git-patchwork-notify@kernel.org>
Date: Sat, 10 Jan 2026 01:40:16 +0000
References: <20260108225318.1325114-2-robh@kernel.org>
In-Reply-To: <20260108225318.1325114-2-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 heiko@sntech.de, david.wu@rock-chips.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Jan 2026 16:53:18 -0600 you wrote:
> The GMAC is coherent on RK3576, so allow the "dma-coherent" property.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [net-next] dt-bindings: net: rockchip-dwmac: Allow "dma-coherent"
    https://git.kernel.org/netdev/net-next/c/72dc44679b14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



