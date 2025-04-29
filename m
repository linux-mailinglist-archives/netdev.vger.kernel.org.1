Return-Path: <netdev+bounces-186867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A98EAA3A2A
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78CBF16F1C4
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 21:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72F126FA77;
	Tue, 29 Apr 2025 21:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7B2W2Cx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75119132103;
	Tue, 29 Apr 2025 21:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745963394; cv=none; b=RgqVPY510mlaV9ELY8tGlUAkVJe1vVR3/EHT1DON5/gm9RzdWaWG9UkYtVmu+mpa7iiUEFN/9vQzuvuS5J1MiODjagHsDc6UqN9K3W2Ww5Wirq0RIXJvO0OgdlCq9SslLWEMbPw8RlR6INDSV1oOcIfiUsD4LDDUS9RAj79DsOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745963394; c=relaxed/simple;
	bh=UjdCZlm7WDqcusIhWqtA1R5cnw9YVjL6XEiRR7s38DE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N3aMu0rmGHLGeFrcP+M1aZi/cG7SzRk/ONiK3cAH+SaxN7//s1wno9Kg/lFL/GEpJBmwwMT7LrQ26A07f1htpzsAL3UniljNQr34EWSBgDcOni36PAwMoufLLzGdqW0+QNFDMPzVlGU/P8uo/YBl/O1E030yduSG1qKwTji9OPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7B2W2Cx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF52C4CEEA;
	Tue, 29 Apr 2025 21:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745963393;
	bh=UjdCZlm7WDqcusIhWqtA1R5cnw9YVjL6XEiRR7s38DE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S7B2W2CxVfXVIXga/XZ/s1ih+xgEKADkxWQ/pNgSYjJasHsvyS44SQLnbh9hc+XXQ
	 sZIMGbYibbNXdJsTXvNDUpY7FcRkH3XIhL/kQ+OsoUlcGJSmDTfBAGeM4aVpXEYaws
	 hIE6GE+I340K1X20xw33PiR3bjam4jpjOvj/GFMv9R8vWQCMw0zzB+vVRxbzsri/5m
	 TynzfVg0vvL4bpwr9nRu8Ue6qaq7iNQb7Ox8ufY1bmS8Rw42y7Wt0CIMCmWdn2oYCa
	 HLwqSH36HjtLKGMMeO3qhaZE02MvyDvMmV3YDRWga7v/XL/PPTxAqQTEGu6uRJNyy3
	 o59MpG71+cyZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB01B3822D4E;
	Tue, 29 Apr 2025 21:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethernet: mtk_eth_soc: fix SER panic with 4GB+
 RAM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174596343260.1806681.7860771179526030169.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 21:50:32 +0000
References: <4adc2aaeb0fb1b9cdc56bf21cf8e7fa328daa345.1745715843.git.daniel@makrotopia.org>
In-Reply-To: <4adc2aaeb0fb1b9cdc56bf21cf8e7fa328daa345.1745715843.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: chad@monroe.io, nbd@nbd.name, bc-bocun.chen@mediatek.com,
 sean.wang@mediatek.com, lorenzo@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 27 Apr 2025 02:05:44 +0100 you wrote:
> From: Chad Monroe <chad@monroe.io>
> 
> If the mtk_poll_rx() function detects the MTK_RESETTING flag, it will
> jump to release_desc and refill the high word of the SDP on the 4GB RFB.
> Subsequently, mtk_rx_clean will process an incorrect SDP, leading to a
> panic.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethernet: mtk_eth_soc: fix SER panic with 4GB+ RAM
    https://git.kernel.org/netdev/net/c/6e0490fc36cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



