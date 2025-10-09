Return-Path: <netdev+bounces-228350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7B1BC8643
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 12:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC1544E2746
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 10:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF9F2D47F2;
	Thu,  9 Oct 2025 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzuJ//5w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ECE2C0F89
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760004019; cv=none; b=tKmvuNC6QQ/+uxOh1bC8xKuKoNIdtv/2SfaQ96zYeiuuo7Pq6wEj90+gfaf7pluViTPvLRCpTBnXkPZBy2Vslf5ccSLwVvy5S1NU0xI0E+xUQHnWb+kxysMXRjdFHsO4fRSYkYpv/hhldORVxgouR4Uh6dLgvW14eNRVgF9Kx3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760004019; c=relaxed/simple;
	bh=/FMNOio2kgZUnwe9wv0S7z6c9P9m0/EWaSEG49umOCg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fRg1i87OLJ5/m2EWXt5nnsFVHnHicsdcFuoGFWcDBxr2tUSbYhMlHDrfEBOIPuG1WozAqHvh7G9zUOT58vOkMKgxGeS/aDSUh2PYPA73ecB760fIwaKlF5Qdu9z4lHANRRkuhK0cV7Cd901VtTzMKw8NhLD9JFVR1kCEpPOkt+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzuJ//5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEDDC4CEE7;
	Thu,  9 Oct 2025 10:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760004018;
	bh=/FMNOio2kgZUnwe9wv0S7z6c9P9m0/EWaSEG49umOCg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rzuJ//5wTl7wy1YUEkOg8ySHd+ncbSJPP2qmNtruuM/Ld+HAxnWZFCRsYuf/tXRzd
	 4pNcEYB5OscupXk3jFQ2z6iYEz+3yLbn/LAp8zAP/r+rG9ffHaO0AhiKj5rOWRkk8Y
	 t/F4oaloggcoheqEPL6HJJTM6uLKmwUREORd5yX0O1vzc0EXYG5TuHsNUSdA3wYJHL
	 JgTw4DaJXEJkAKpLwlIMR4VnhQzZC1tDYi3nglpSiuHffgyy1K1aPw0akqgVyx6XGv
	 Wnry/VXrox/9CbhUppj3qKK7uXKAmAugkg/w+aFL+u7KWtX9SpEUmakjg+utX6ruG9
	 ZqOPN5OKNU9aA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BC63A549B6;
	Thu,  9 Oct 2025 10:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: airoha: Fix loopback mode configuration for
 GDM2 port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176000400701.3862460.565450618627786510.git-patchwork-notify@kernel.org>
Date: Thu, 09 Oct 2025 10:00:07 +0000
References: <20251008-airoha-loopback-mode-fix-v2-1-045694fe7f60@kernel.org>
In-Reply-To: <20251008-airoha-loopback-mode-fix-v2-1-045694fe7f60@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 08 Oct 2025 11:27:43 +0200 you wrote:
> Add missing configuration for loopback mode in airhoha_set_gdm2_loopback
> routine.
> 
> Fixes: 9cd451d414f6e ("net: airoha: Add loopback support for GDM2")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v2:
> - Use human readable marcos to configure loopback mode register
> - Link to v1: https://lore.kernel.org/r/20251005-airoha-loopback-mode-fix-v1-1-d017f78acf76@kernel.org
> 
> [...]

Here is the summary with links:
  - [net,v2] net: airoha: Fix loopback mode configuration for GDM2 port
    https://git.kernel.org/netdev/net/c/fea8cdf6738a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



