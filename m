Return-Path: <netdev+bounces-242272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65902C8E35D
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D253B51A6
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C4E32D43C;
	Thu, 27 Nov 2025 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RO0NRAZl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC7C32ABEF;
	Thu, 27 Nov 2025 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764245445; cv=none; b=dFeFAv42Re+B7Qf/P8hcmNzpiK632whWs2AyFzB1VOYD/jImuqxPMh+u24lDV8XBL3vN85VxO6XDTbTeOQZutjSrAT6OGyP0iuOUwrDkXWhFnBbowRu3lO6qKagGcT/+KUhHWYDOsIuzAdtO1+d9u1qdTYHL81Qf4bI/3kz4/pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764245445; c=relaxed/simple;
	bh=uhnsNrqtMtQkysk9EvtLzQf+itpVm8Usek2r6BnT+ak=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kBw+adTTueb2eW6Z2ZC5BsjzQbumQe4FhUIgQRrN3ecTHWjx068wTRPRzz+1WXtpEwYjtwv7EHPM5PJg90jWIgxuEUrKH0j7mr9E18rtAVlII1msd7oeIx38Li26D2HNnrTz/yyWDUX3ZXJQKpY0j75jsYJUw3OrGvsvfBJqg9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RO0NRAZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C802DC4CEF8;
	Thu, 27 Nov 2025 12:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764245444;
	bh=uhnsNrqtMtQkysk9EvtLzQf+itpVm8Usek2r6BnT+ak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RO0NRAZl45XA5ot75mAHnDowIjR04X6kevxTP/ht/X0iW+aJV/HSqd1DkqPUzJ/38
	 fgQjlsjNIbmzTKhnimVO/Q4XPHv+9aOkw4qaBvEhSfjfRSKhGp9awCsJls/EpcBN//
	 0wkqkJQhuGucl1fTvtcmKfQaJovPFZWhWvsqnEH+Ibw64NhrYhNTHCVTGSIvhqQLEo
	 bM6DopBszbn9uoufcaoFKgkt25IZ3o8eR7khWLioY+8QJxSjMJRT9Ew2DA4SXydBKQ
	 CIoq1Ylo/saAP8rponTA2pcglH4509X+vLM0zaAk3aH5Raam+16WKfpx2KmYSXlmVm
	 1qQALIu6z0POQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710E4380CFEF;
	Thu, 27 Nov 2025 12:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: dwmac: Disable flushing frames on
 Rx
 Buffer Unavailable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176424540625.2550562.3416257212075007570.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 12:10:06 +0000
References: <20251126-a10_ext_fix-v1-1-d163507f646f@altera.com>
In-Reply-To: <20251126-a10_ext_fix-v1-1-d163507f646f@altera.com>
To: G@codeaurora.org, Thomas@codeaurora.org,
	Rohan <rohan.g.thomas@altera.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 matthew.gerlach@altera.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 26 Nov 2025 00:37:12 +0800 you wrote:
> From: Rohan G Thomas <rohan.g.thomas@altera.com>
> 
> In Store and Forward mode, flushing frames when the receive buffer is
> unavailable, can cause the MTL Rx FIFO to go out of sync. This results
> in buffering of a few frames in the FIFO without triggering Rx DMA
> from transferring the data to the system memory until another packet
> is received. Once the issue happens, for a ping request, the packet is
> forwarded to the system memory only after we receive another packet
> and hece we observe a latency equivalent to the ping interval.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: dwmac: Disable flushing frames on Rx Buffer Unavailable
    https://git.kernel.org/netdev/net-next/c/45d100ee0d6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



