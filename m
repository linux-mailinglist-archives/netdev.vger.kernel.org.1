Return-Path: <netdev+bounces-114456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CEA942A7E
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77D61F21D20
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D3418C93B;
	Wed, 31 Jul 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNVu2VbV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD1E624;
	Wed, 31 Jul 2024 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418232; cv=none; b=lqWz/1u93AQ3HEp0cnNVguq3ZzMgDf+LtsoJAiZqpmjb7hyCwUAUzEbdcSnJOfj6o8R+46AtstvvDJh3wXbBeh7RdLrGm3L9dRkvp0MkznlLk2JFO3pbOdvym5wklYUupLol+8entqSkV7aglsSVhzMr1mp+xLT0ECRP5v8ZdZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418232; c=relaxed/simple;
	bh=hSYSX2i9J5Ny39VIH4B+nCpC1hMZVRlS0kYp0AaA30E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R5X+nJdWfGs5VJwEoEOApnDmOKFEZppyOda747z0OlbIauQswGBthRnuceQCdsNhV+HivpKR6UH4P0NYONqXxEHrNSZ9Qa/FOQhcV/oWdeyI13mKYKu0V3G+wUrGmrdPpQ9JznGcCY3Fie+K+hEfydExVLSIN4ZXhFMb5qzX8Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNVu2VbV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A133C4AF0C;
	Wed, 31 Jul 2024 09:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722418231;
	bh=hSYSX2i9J5Ny39VIH4B+nCpC1hMZVRlS0kYp0AaA30E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aNVu2VbVwtW8UHwTNL8I2seYvNLz1ykbHUSYnMQQUaAy6YlrNZs8CUvC3v6+A/knb
	 8LUrtlDhK9eJpr2ab6lUM1pvYXx5IgRCftPeSQKTcRasn3lQIFHhWK3tyk8GYtZdAM
	 5k89YlDPi0x1epuA91dCas7J86w9V+Mvr1CVTmOF/O3jAQv1/l07xU1Ho73ktcf3Kk
	 wpBbSaWQ+HGaEUqZBEfcNyCEWZV7hRYjagmYnEY2v2pEHo8JJj3kkBr9gLCe0oDy1O
	 BNZryoMaPoSiinwsRWYF2aFHqK7owsT4MQS1Iu0xTGC2CwisAxHf8i1o1gZLowDHto
	 U6j5ntoVH6WYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 687C1C6E398;
	Wed, 31 Jul 2024 09:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 1/2] net: dsa: vsc73xx: make RGMII delays
 configurable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172241823142.27092.8446004592094217593.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jul 2024 09:30:31 +0000
References: <20240729210200.279798-1-paweldembicki@gmail.com>
In-Reply-To: <20240729210200.279798-1-paweldembicki@gmail.com>
To: =?utf-8?q?Pawe=C5=82_Dembicki_=3Cpaweldembicki=40gmail=2Ecom=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linus.walleij@linaro.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 29 Jul 2024 23:01:59 +0200 you wrote:
> This patch switches hardcoded RGMII transmit/receive delay to
> a configurable value. Delay values are taken from the properties of
> the CPU port: 'tx-internal-delay-ps' and 'rx-internal-delay-ps'.
> 
> The default value is configured to 2.0 ns to maintain backward
> compatibility with existing code.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: dsa: vsc73xx: make RGMII delays configurable
    https://git.kernel.org/netdev/net-next/c/3b91b03271c5
  - [net-next,v3,2/2] dt-bindings: net: dsa: vsc73xx: add {rx,tx}-internal-delay-ps
    https://git.kernel.org/netdev/net-next/c/b735154aeb33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



