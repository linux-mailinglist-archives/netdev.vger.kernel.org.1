Return-Path: <netdev+bounces-141764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA249BC316
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743111F22B11
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC58944384;
	Tue,  5 Nov 2024 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDGeyF+c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847EC433D0;
	Tue,  5 Nov 2024 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730773225; cv=none; b=AS0fuf5w+Uvh/j4PZ32ene1Bxl5Vt6iYVhRoOA+ifKmYdeIG2SoWS7Obh/VSs7/Daza+0z49XRg8uyvhJ5UCF8p9st6Ah00x1g3vo6jzE9hoVfkJgq2AauOEGSwsBsnOtxTBzwcZS5plekPZfShIxWui6XOza382YCwoO421I6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730773225; c=relaxed/simple;
	bh=UYzXNmnPFRBT+WCFO8GxtuO8k0BxHoZse64rUvgLUiQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X2iDJJsXN01AgfpXsUEtXLXrdRM/Kvw/0fVbxbEPg2H3CsAZRsP2MOR0UmTmfWIQ91dimgH0+4IpuAsIxUso8RxyTdMqMUAdO2YjgUYVnxQ3Xha7ljO8Mmwfo+MnGRgCRr5BZOGSFlRxzY6wQ8sxhZ2TBzG1bu3YcwoK6iFvTtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDGeyF+c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0421AC4CECE;
	Tue,  5 Nov 2024 02:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730773225;
	bh=UYzXNmnPFRBT+WCFO8GxtuO8k0BxHoZse64rUvgLUiQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NDGeyF+cp1fe1TtsA6lDxUVzkSkxgpIiwGWTFXCgHV8vcVPITcL+Vr8cPvHMlO59f
	 sjwH3GW5TTXR46OR5uOxWs/OR20ghwv5g3oIK1M8zN/etcgZgBsB7l24q9SjHGhcEL
	 pGbpHduqLI26N9J8jqzHvdEZpzb25kwSxRwuB1UcgLDcBPiyKrfggwAl004mp20CRo
	 ZtWwHAkhya4a/qw+QWJCQg3+GH2Rjt66q8KRS2gJLSqS4m7nwzS6lpWcveZUmJVtVY
	 GwfOM9eyjCS37wdRtIJ+w1bPeIy2+RAhtbU8+ONIcJc02afifzf9CxRqsD84eBwalD
	 UhgFAWowrhroQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB9183809A80;
	Tue,  5 Nov 2024 02:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ena: Remove deadcode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173077323349.89867.16402117123804329088.git-patchwork-notify@kernel.org>
Date: Tue, 05 Nov 2024 02:20:33 +0000
References: <20241102220142.80285-1-linux@treblig.org>
In-Reply-To: <20241102220142.80285-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: shayagr@amazon.com, akiyano@amazon.com, darinzon@amazon.com,
 ndagan@amazon.com, saeedb@amazon.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  2 Nov 2024 22:01:42 +0000 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> ena_com_get_dev_basic_stats() has been unused since 2017's
> commit d81db2405613 ("net/ena: refactor ena_get_stats64 to be atomic
> context safe")
> 
> ena_com_get_offload_settings() has been unused since the original
> commit of ENA back in 2016 in
> commit 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic
> Network Adapters (ENA)")
> 
> [...]

Here is the summary with links:
  - [net-next] net: ena: Remove deadcode
    https://git.kernel.org/netdev/net-next/c/6a7d68f72797

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



