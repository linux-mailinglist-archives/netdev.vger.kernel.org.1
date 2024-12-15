Return-Path: <netdev+bounces-152021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A55019F263A
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4091885C24
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 21:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536F41B6D1A;
	Sun, 15 Dec 2024 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuEpZfBc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F08A41;
	Sun, 15 Dec 2024 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734297612; cv=none; b=lrV6fmS6xS8hskuckkrNZQRSmaRMrPuOBrK18Ue5vfbfPXH2diYP9HkACdk04kGDxB6Uip+sJvAmGr0hji8JKKbDy+iJD105BQ6jspdG9M7KPUt5XARRletZizgU6wF1LxkJHHzxnRYsXRB23pNNtAlmfZXs2YSLDIvXLAjZD2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734297612; c=relaxed/simple;
	bh=P4sc5AT5pgeRG2PGVcnMVCqnHvnlH//RUGpPaeFWg1o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eHcBrEjPO7270OXIW5f0d24/XchfFdP0fg/CHGgdUnY2VLCvMGMBUY5Pi8VUwidlGitwpIdb+mvs98fQrSV89LXRzex++dI7UMZAQ9UjwtkGj8E7VWlZoEouELLquW0FtkuHMjIsqbs/yYRXU5zoSz84SWFk3HZ6vQwcQPaWmPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuEpZfBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B341C4CECE;
	Sun, 15 Dec 2024 21:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734297611;
	bh=P4sc5AT5pgeRG2PGVcnMVCqnHvnlH//RUGpPaeFWg1o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EuEpZfBcuhJj0JtY5jZUgV0h/CRjqTm5KhSqpqvSUZIEc/z6tH6Jg2cLo2Mc287zZ
	 uf2e+zUa5lo3comUAeIi36lcZsKLcuTpuCR+/GQUD174bwu4/6sJqjgh1ova1UPvQP
	 Tt3A+GdX0ynI0q9z0JOESVXaTF8SjAkUQals/7JHm92QsAG7/keN6HX5RMo5YPu+8u
	 OPBiMAgQKMI5k0HSSc69OKZVsqTfm/AnYYPZbtiAvarlqsKpOOVH8uSHuf8o4F93oD
	 RDtygRoj15Wa1tZkZ3Qp7NH2WW3LwWz2J5bFtffZhagwZYVZMKn868PFtj/ZheMvnu
	 lVQzhPlcxnB9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4243806656;
	Sun, 15 Dec 2024 21:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: phy: dp83822: Add support for GPIO2
 clock output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173429762851.3583630.14158888213694105867.git-patchwork-notify@kernel.org>
Date: Sun, 15 Dec 2024 21:20:28 +0000
References: <20241212-dp83822-gpio2-clk-out-v3-0-e4af23490f44@liebherr.com>
In-Reply-To: <20241212-dp83822-gpio2-clk-out-v3-0-e4af23490f44@liebherr.com>
To: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, afd@ti.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dimitri.fedrau@liebherr.com,
 dima.fedrau@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 12 Dec 2024 09:44:05 +0100 you wrote:
> The DP83822 has several clock configuration options for pins GPIO1, GPIO2
> and GPIO3. Clock options include:
>   - MAC IF clock
>   - XI clock
>   - Free-Running clock
>   - Recovered clock
> This patch adds support for GPIO2, the support for GPIO1 and GPIO3 can be
> easily added if needed. Code and device tree bindings are derived from
> dp83867 which has a similar feature.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] dt-bindings: net: dp83822: Add support for GPIO2 clock output
    https://git.kernel.org/netdev/net-next/c/a2d8af57452e
  - [net-next,v3,2/2] net: phy: dp83822: Add support for GPIO2 clock output
    https://git.kernel.org/netdev/net-next/c/53e3b540952c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



