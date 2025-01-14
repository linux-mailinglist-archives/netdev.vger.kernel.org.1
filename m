Return-Path: <netdev+bounces-158275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665D0A114E7
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356E2169A29
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C8A2236F6;
	Tue, 14 Jan 2025 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quIcSx7c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4EB2236EA
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895619; cv=none; b=sQDp6GYbA5FnVnBRfT/DmjCKm+9QaPHrfyhVnakhW5X50vvZxmoqR+/mzr87/pmqPaarysTPX5kZPhGgU7hxRNdWAc637NyIiGnKSL5SL1AeIVg/SWc4jsRo6bh3RjlihFrw0kjUKVUnNf/NEzuF9VkcsvcyuNmamQTGj7YKRiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895619; c=relaxed/simple;
	bh=D5byHkrsv5SQKGj+WNn8RIZStWX8kI1/PrV5PEzZm0A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gfq/hUKZ9CmQobazE+U0Ks7Q2U0wvGkglr2Z6UwnHGMie6TpmGeSFKayoSUyg/5q9kM2Bp/CU0sVZv7etaFwpU9dB4x3o6QkHKDxAtj1hhNHPww91a9x0GjabLzMtJ8Ehk42/rFci0cAkrbry11TaRI30MSoZhoxHJE0/PrdDZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quIcSx7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6275C4CEE1;
	Tue, 14 Jan 2025 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736895618;
	bh=D5byHkrsv5SQKGj+WNn8RIZStWX8kI1/PrV5PEzZm0A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=quIcSx7cgD9A0L0E/uqHwoCdImsh9ACOP++R5pFgHKNafz+KOv0mwHJEPYQF3bW6G
	 qnrNyhNrh2e8RFl2eINBY/KgYhslh8JU+ltk3f6fm0YPtImVEsc6ZbQ/sBK7cb5nPI
	 26Lv8hjZku8e0P0a+/bNrvuu34V7B2pih16SKkl61kqTWyKnIPnA+UoXymheUljAVV
	 E67N09LHwf/AZSXnPqEE83eVvbs4jrd7FgOrEPM4Zsiu341YhtkZ7tw1Y1m735oaYl
	 fsbp4J+yy4b0dTugw/+xhTPAgE5rvf2BPDUwv/Wkqpo++RfTl3i4Wq3OdyaXAQ3r2C
	 XeG0w/NzVljeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE4F380AA5F;
	Tue, 14 Jan 2025 23:00:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: Enforce ETS Qdisc priomap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173689564173.170851.2258072492624534440.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 23:00:41 +0000
References: <20250112-airoha_ets_priomap-v1-1-fb616de159ba@kernel.org>
In-Reply-To: <20250112-airoha_ets_priomap-v1-1-fb616de159ba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, dcaratti@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 12 Jan 2025 19:32:45 +0100 you wrote:
> EN7581 SoC supports fixed QoS band priority where WRR queues have lowest
> priorities with respect to SP ones.
> E.g: WRR0, WRR1, .., WRRm, SP0, SP1, .., SPn
> 
> Enforce ETS Qdisc priomap according to the hw capabilities.
> 
> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: Enforce ETS Qdisc priomap
    https://git.kernel.org/netdev/net-next/c/b56e4d660a96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



