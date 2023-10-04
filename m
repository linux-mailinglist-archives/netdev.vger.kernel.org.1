Return-Path: <netdev+bounces-38072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A9C7B8E06
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 22:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9FB801C2084B
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622F9125CD;
	Wed,  4 Oct 2023 20:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpNozK2T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469B222EE3
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 20:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B027FC433C8;
	Wed,  4 Oct 2023 20:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696451426;
	bh=mdDX07PCg9576DleQyl2CYXvWPdBHOjEh3zc5XJe1gg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QpNozK2TBgVwFAxoyMxA4s/bPvwW+g46RiuKu2xeB+/FmGEo3325gSpAJOLrhscrz
	 DzFRRqOtiHtO4mzRsVzVjGMI7i0wo8iWFsvCONfuNiYGLg2CdHWjH2Ij9vucO3gb4h
	 KaAv8DqQn9afT7+eVhsXqDTiPyIHENWJZbaFu6/IyNBQF20wxtC7iora0XH15jBYEt
	 snyC+fbRMaQKM2p6jFckBXbFqwuCiMck6g6nmbdzSjeoe+OKzrjq/o40E2EuuE22yf
	 y2s1A/foU9nqLb3kEJLPi/FZ7z4UHshcdbcXvmlJFE0IFfq5iui0xgQonyDG/3rCrW
	 a8xYTDPqEvpPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94C5AC395EC;
	Wed,  4 Oct 2023 20:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: dwmac-stm32: fix resume on STM32 MCU
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169645142659.7929.1401837139446302985.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 20:30:26 +0000
References: <20230927175749.1419774-1-ben.wolsieffer@hefring.com>
In-Reply-To: <20230927175749.1419774-1-ben.wolsieffer@hefring.com>
To: Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc: linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, christophe.roullier@st.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Sep 2023 13:57:49 -0400 you wrote:
> The STM32MP1 keeps clk_rx enabled during suspend, and therefore the
> driver does not enable the clock in stm32_dwmac_init() if the device was
> suspended. The problem is that this same code runs on STM32 MCUs, which
> do disable clk_rx during suspend, causing the clock to never be
> re-enabled on resume.
> 
> This patch adds a variant flag to indicate that clk_rx remains enabled
> during suspend, and uses this to decide whether to enable the clock in
> stm32_dwmac_init() if the device was suspended.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: dwmac-stm32: fix resume on STM32 MCU
    https://git.kernel.org/netdev/net/c/6f195d6b0da3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



