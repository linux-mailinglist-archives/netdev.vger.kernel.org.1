Return-Path: <netdev+bounces-192221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B23E1ABEFC6
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3A2175D9B
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBFA23FC66;
	Wed, 21 May 2025 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxYFVS1q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA37B23FC49
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 09:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819793; cv=none; b=lwX78DcBTsiLC31WfzdLDvzQVTDOzhGd5lTtq+Q1maB6h/bL9siK1ANMkXvho/ICGxecNX8YBroNZJ2tQtptBkd41c15w1HtBYUKZH2lJZfJhKJcgYwDPWn8i48lYo22JHIqhZdWrnrtiMbhN+Cex0Jd6ThYAWxcwrTLuNHWeEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819793; c=relaxed/simple;
	bh=sF9a+wM1sobRohGTbaBEmApO7Aas8GZ4IJ8Z5xj7F+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iR/O6SqPQCzCUkw6eqcEdaMZO/f0eqLcJ9R3cDZSPH+ga+/ch4clmI0eJBUi+Xrp3bTWrTHH/nFZfaS1gBxxUjPDejFaGzTxGWNoclNQk0ionDM2C6zsYmMPziQ9NxHXZFXpSqa/Y2BH0UYdYEOndPcCcnWwCaMG3sRhgmik/6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxYFVS1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD6CC4CEE4;
	Wed, 21 May 2025 09:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747819793;
	bh=sF9a+wM1sobRohGTbaBEmApO7Aas8GZ4IJ8Z5xj7F+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BxYFVS1qOP2ihWHG2LDN+IZlsweeBQsDYTII+kglQVCrThUlsyZTBFvMiF1hGe/a+
	 4UEV8jmOiA+Csm3qYE53rE1BikX7jlLHyfaUcA1xN822Nszwpj94thfi5XAEl4Ikqf
	 IEtah404oYTj647eHJXT4v5fYvIJiWKIa7fY4Z7Xxt4m/q9Gcc8A1EmOqnmFgZ/7zN
	 JK9O83qbgNgT7YSdsTwnAUNRLG5suIT7r513jdQ8sItcaQmTt3tsBkLFI16xNmLc3v
	 GBmFCsQU71ysGQbzjtIlV5zF33rYjDtkKiS5hDiRfOHSsxmdXdPpJ8AIyfpC7xibHa
	 hAW497KPJzPFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EE9380CEEF;
	Wed, 21 May 2025 09:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] xsk: Bring back busy polling support in XDP_COPY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174781982901.1645073.14019094768551753670.git-patchwork-notify@kernel.org>
Date: Wed, 21 May 2025 09:30:29 +0000
References: <20250516213638.1889546-1-skhawaja@google.com>
In-Reply-To: <20250516213638.1889546-1-skhawaja@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, willemb@google.com,
 stfomichev@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 16 May 2025 21:36:38 +0000 you wrote:
> Commit 5ef44b3cb43b ("xsk: Bring back busy polling support") fixed the
> busy polling support in xsk for XDP_ZEROCOPY after it was broken in
> commit 86e25f40aa1e ("net: napi: Add napi_config"). The busy polling
> support with XDP_COPY remained broken since the napi_id setup in
> xsk_rcv_check was removed.
> 
> Bring back the setup of napi_id for XDP_COPY so socket level SO_BUSYPOLL
> can be used to poll the underlying napi.
> 
> [...]

Here is the summary with links:
  - [net,v2] xsk: Bring back busy polling support in XDP_COPY
    https://git.kernel.org/netdev/net/c/b95ed5517354

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



