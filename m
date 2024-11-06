Return-Path: <netdev+bounces-142195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941B39BDBB5
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 03:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C09F283B91
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A9A18D623;
	Wed,  6 Nov 2024 02:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPawd+Fx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0677718C329;
	Wed,  6 Nov 2024 02:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730858422; cv=none; b=CJl0qi/d3GnEsJYACmvKpB7lxQSEkW3twriM0dIyBFl8tg5N4xMpeaan8LOxoHBYiPK2ne/VL5BSZzXl3OxCWIsJKfgdv3yDnuzn+pHQjdOS8qhyEKqOl8fc0pJatJk3Jqqc06RKpcY2tkqAgfIpDk3lHcveCxpi80nApcf1Imk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730858422; c=relaxed/simple;
	bh=iDGn6cF39S+5ch2f8pg8ENjGiBRJzy0HvH23scQjhcQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e8X4E536GbaDYL/6gWMtGoivPleveb0DNwUkbM5SCbTku6rr7Sqh8g6VIFwtN9J7gGqtBrHbA0WfuGKB98eCWucWxFnwCESQXLDAUl4HxNcg1YW12pasLv/jY+N4k/YtvhuepdsK645J4RW/EgHfiP+bKEvnRXuwld4kbC6fYjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPawd+Fx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97164C4CECF;
	Wed,  6 Nov 2024 02:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730858421;
	bh=iDGn6cF39S+5ch2f8pg8ENjGiBRJzy0HvH23scQjhcQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QPawd+Fx9U769Oe0hH0VRncvrDRfzDHq5qBMs7pShUOKH+0Xrzmx7OoJrTTJhcUHC
	 0IcO6mQpKWVUE/z//2UqZH8lE+UtMZ1hjJBN1Pr8lRj+IiNIQ09LKwmGie5eMkYDSJ
	 81PsQJu7PSsylnThW2p8U557I2VQVL8yKTS6m0lSL8oFBLXwVLgu93t1bOHpPFvPkC
	 tlaNXJONb9+I5Djpm7cB71PiAlh+EAQu/xrUCbKEvfsY+FXGBzEzxDJc1hCmtTUmKN
	 VIJZrX09TUDyPoR6T7HA4PQHyQWAgAcNXVPM0wrUYf92G5ZXj5EGyvuCq9pJ3Hxlfp
	 yNpo92C769Brg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE12A3809A80;
	Wed,  6 Nov 2024 02:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/2] Add the dwmac driver support for T-HEAD
 TH1520 SoC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173085843050.764350.5609116722213276708.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 02:00:30 +0000
References: <20241103-th1520-gmac-v7-0-ef094a30169c@tenstorrent.com>
In-Reply-To: <20241103-th1520-gmac-v7-0-ef094a30169c@tenstorrent.com>
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 alexandre.torgue@foss.st.com, peppe.cavallaro@st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, emil.renner.berthing@canonical.com,
 jszhang@kernel.org, guoren@kernel.org, wefu@redhat.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 andrew+netdev@lunn.ch, drew@pdp7.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, krzysztof.kozlowski@linaro.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 03 Nov 2024 08:57:58 -0800 you wrote:
> This series adds support for dwmac gigabit ethernet in the T-Head TH1520
> RISC-V SoC used on boards like BeagleV Ahead and the LicheePi 4A.
> 
> The gigabit ethernet on these boards does need pinctrl support to mux
> the necessary pads. The pinctrl-th1520 driver, pinctrl binding, and
> related dts patches are in linux-next. However, they are not yet in
> net-next/main.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/2] dt-bindings: net: Add T-HEAD dwmac support
    https://git.kernel.org/netdev/net-next/c/f920ce04c399
  - [net-next,v7,2/2] net: stmmac: Add glue layer for T-HEAD TH1520 SoC
    https://git.kernel.org/netdev/net-next/c/33a1a01e3afa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



