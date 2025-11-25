Return-Path: <netdev+bounces-241505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 203C0C84B4A
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 12:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 24D6034FD55
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87BC315D2A;
	Tue, 25 Nov 2025 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaPS1q62"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE5B283FF5;
	Tue, 25 Nov 2025 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069650; cv=none; b=emumLxX9qqbodefseg5g6Vqx1FagIgBoxK408UCAe6HFSO92aD3f80HTzJFJh/RFaTAkrPz1OirEi73Zqh74OH3HVwpC86LU0r2XRu7xx+qppoX+KZC4ZY+4fmJKlsvPRBg+BgWXJ04BrIoxpQEfng8mIwo404vxcE56wmKZUPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069650; c=relaxed/simple;
	bh=XYrx8RmeHb7aOA0CRDqH8AU6e14CroGHa3JB6p/8Hwo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QPD6CwQkA3RRZiJaawSG56vyfvN07+TPo/9IUuUvd9ncrJxfUSMTjKTI8oJdYoONCKrJX5vLMVM2rSPHoTrQ80mjZx8wgVwEL+hwmdXRNnFmMxci6kftvKGed95S656OVYbkS8yPl1z6PValJla8Sqck9SFQKmCxYp1qO5PXr3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaPS1q62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE6AC4CEF1;
	Tue, 25 Nov 2025 11:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764069650;
	bh=XYrx8RmeHb7aOA0CRDqH8AU6e14CroGHa3JB6p/8Hwo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oaPS1q62knOE86v73tj8F0OwlgiXC8DDnxnXWuNNzxJtIfVDndEWU/Jgc2boBDHp0
	 apzOhF0F+qhrSLQDUdm+bd3rsX/F7jW42rnqF23lz6pC9y3pDoMmHWw2ig4JJOscqM
	 ijQKpXH8HCa7VRENGJpMkSCulaWc7lQS21dbllP3L63hl9bLBNkh20h0+JwSRgxQHw
	 e0jEjaAVyRPlNyHC8t2UsHZuw6QEM4ID2Icky2NBPwqs/SI6DU5RaJ+SumF/2vGlyQ
	 LEzOAeij94Uk3Dx1LLLtRPMdeiQ2/STxu5IvTp5YPI3VId+UP6u/JfXrnOyK7JkQFy
	 JbI8tJKJ8ByJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4C33A8D14D;
	Tue, 25 Nov 2025 11:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] dt-bindings: net: aspeed: add AST2700 MDIO
 compatible
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176406961249.690498.6624376735038476395.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 11:20:12 +0000
References: <20251120-aspeed_mdio_ast2700-v2-1-0d722bfb2c54@aspeedtech.com>
In-Reply-To: <20251120-aspeed_mdio_ast2700-v2-1-0d722bfb2c54@aspeedtech.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
 andrew@aj.id.au, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, conor.dooley@microchip.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 20 Nov 2025 11:52:03 +0800 you wrote:
> Add "aspeed,ast2700-mdio" compatible to the binding schema with a fallback
> to "aspeed,ast2600-mdio".
> 
> Although the MDIO controller on AST2700 is functionally the same as the
> one on AST2600, it's good practice to add a SoC-specific compatible for
> new silicon. This allows future driver updates to handle any 2700-specific
> integration issues without requiring devicetree changes or complex
> runtime detection logic.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] dt-bindings: net: aspeed: add AST2700 MDIO compatible
    https://git.kernel.org/netdev/net-next/c/e3daf0e7fe97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



