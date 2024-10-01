Return-Path: <netdev+bounces-130787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B108798B878
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51BA71F2282C
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809A719E7EB;
	Tue,  1 Oct 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5rKgDTS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A46619DFAE;
	Tue,  1 Oct 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775632; cv=none; b=sHQDdMGirrK4E5L5LA6n1l+enoCSwq/WYdg/XvSeps1qNqNGr1zFuvUX6HGGdl977vcjgPndBFxEhtl4mH0OFRFKzgkuMazJ72i8mt+g95erugbfTflDetEeyFOtXjjJIBF4NpR6kUOcALc0Td5t0ulmWVL3pKNDC8l6L2uHuvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775632; c=relaxed/simple;
	bh=dp9zuSvgLkjQJzPrtRiNm7IV7jdhgyzfql+5VxHqXT0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KiCjWZFNHOmE/6FPSGVUdb6mC4EYEW/GR8o3NWYRbH6GuvRRNuStkw6Qat1meH1OJJ0oEFVycHiMJhmDJb979wK8QOhrS5PuB379n2HGPgkVrfrxplrSb4Q+uPMtmgXMiMyOAHLfoJfD0XsZh29OZpayCf1l+HfujeattYeeong=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5rKgDTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10F6C4CED2;
	Tue,  1 Oct 2024 09:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727775631;
	bh=dp9zuSvgLkjQJzPrtRiNm7IV7jdhgyzfql+5VxHqXT0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i5rKgDTSxAUl+QoMmjRnfREFZsOeJBOqc/uc6t3s/8uSS5D4yVXmAn8RKva3oeNtF
	 XiXLcNQzK0RmmsVJXimsasGqnqQaxAiDI2wONaNmUjc8F96KJrzvx+CG5gTFECxAUi
	 lSh7ayaJcFX5cJDxoxHTKkmia059Pwv4OKEkoM2FT1G4iKX8KJmUqg6DNByv2so0uY
	 VMX4IIJ1dwm95ge5wua1PCE4NJFIjZgQTCFpnBERYrFwwGE2pAh7nvTukUiWWtUswH
	 EJqmHgMlMCqLjIVgYpJcF/WWsTKE+jlck30OYfz3gUEt9H5b3idcCN32VrXyleEf1X
	 LGY24YIv2PnCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 349C2380DBF7;
	Tue,  1 Oct 2024 09:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: microchip: Make FDMA config symbol invisible
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172777563474.284947.11852763477400538855.git-patchwork-notify@kernel.org>
Date: Tue, 01 Oct 2024 09:40:34 +0000
References: <8e2bcd8899c417a962b7ee3f75b29f35b25d7933.1727171879.git.geert+renesas@glider.be>
In-Reply-To: <8e2bcd8899c417a962b7ee3f75b29f35b25d7933.1727171879.git.geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, daniel.machon@microchip.com, horatiu.vultur@microchip.com,
 jensemil.schulzostergaard@microchip.com, Steen.Hegelund@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 24 Sep 2024 11:59:09 +0200 you wrote:
> There is no need to ask the user about enabling Microchip FDMA
> functionality, as all drivers that use it select the FDMA symbol.
> Hence make the symbol invisible, unless when compile-testing.
> 
> Fixes: 30e48a75df9c6ead ("net: microchip: add FDMA library")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> [...]

Here is the summary with links:
  - net: microchip: Make FDMA config symbol invisible
    https://git.kernel.org/netdev/net/c/1910bd470a0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



