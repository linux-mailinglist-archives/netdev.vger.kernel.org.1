Return-Path: <netdev+bounces-194728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB26BACC283
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E65057A3736
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 08:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BF0271452;
	Tue,  3 Jun 2025 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5ewOc1I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6024F5E0;
	Tue,  3 Jun 2025 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748941195; cv=none; b=G/vYZ6XH9Lp6PtLG7dJNTQM/y4ulLYS0gZJALFL+jDoTZsEUppqfzVXGPuS2yVzGp9ksI7jz0dh1GpvK8unyq49hKubi1A62xw4+39DlWf7rALWeahd3vFSBWBoNpsa9KstMq/Qb7n6NBDKzV9YmpwTyRaK3QgVDFogiTLCAxVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748941195; c=relaxed/simple;
	bh=R50WQrCRCTILDFY9a5xYZZIKpDYGrHm9HaM9VrFd8qo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UmoGLTcRhxGwHn2HO9RLR9RwOmFIrdWTQUna0UvQppDZvIA35GgNf6tt84+Hit/be5D1mJ81WOxpaDc+tNeGn0BgZYlnqkc5CbokLdrM0qe2ZrYNo6uWh4VfJnIiISYgMRd5E9PXRKFwiFPbxKOPNgGmSRc6n/QImW+XDsFiKv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5ewOc1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F96C4CEED;
	Tue,  3 Jun 2025 08:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748941195;
	bh=R50WQrCRCTILDFY9a5xYZZIKpDYGrHm9HaM9VrFd8qo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s5ewOc1IzJzHNkzRDAsQZ2xHPKpi2YS6kSkA/5HltTiaLiQYKfkEyIeNuN/jxhCsW
	 s4B7+6SJeKjhbyKxZS5GYQuz62AkgQyCNTaU6bT8yUFr7Eci3zlYKpgUiUkqpmlqqK
	 fh2u+coWSQxSjBhqF+dhVz6oYRfaF+KrxvCQCPcxL2phWj++C2qSMpAY/HYENGXQ1L
	 9Vcgg7HDzZvCkwOi+/YrcJl5mfmS0JOi4jh4zN0ufHStOdEUZfcKDN6yBLPd7ZTsd0
	 whGJBEPoXFGu/LvWJpVXuukKUKoiKXI3jO/HNH6ekNyxoxzJ9iSQ4jwwOreAinckRm
	 cFzWJAyDlbW+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BE8380DBEC;
	Tue,  3 Jun 2025 09:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net v3] net: wwan: t7xx: Fix napi rx poll issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174894122801.1429658.207799656496074697.git-patchwork-notify@kernel.org>
Date: Tue, 03 Jun 2025 09:00:28 +0000
References: <20250530031648.5592-1-jinjian.song@fibocom.com>
In-Reply-To: <20250530031648.5592-1-jinjian.song@fibocom.com>
To: Jinjian Song <jinjian.song@fibocom.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com, corbet@lwn.net,
 linux-mediatek@lists.infradead.org, helgaas@kernel.org,
 danielwinkler@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 sreehari.kancharla@linux.intel.com, ilpo.jarvinen@linux.intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 30 May 2025 11:16:48 +0800 you wrote:
> When driver handles the napi rx polling requests, the netdev might
> have been released by the dellink logic triggered by the disconnect
> operation on user plane. However, in the logic of processing skb in
> polling, an invalid netdev is still being used, which causes a panic.
> 
> BUG: kernel NULL pointer dereference, address: 00000000000000f1
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> RIP: 0010:dev_gro_receive+0x3a/0x620
> [...]
> Call Trace:
>  <IRQ>
>  ? __die_body+0x68/0xb0
>  ? page_fault_oops+0x379/0x3e0
>  ? exc_page_fault+0x4f/0xa0
>  ? asm_exc_page_fault+0x22/0x30
>  ? __pfx_t7xx_ccmni_recv_skb+0x10/0x10 [mtk_t7xx (HASH:1400 7)]
>  ? dev_gro_receive+0x3a/0x620
>  napi_gro_receive+0xad/0x170
>  t7xx_ccmni_recv_skb+0x48/0x70 [mtk_t7xx (HASH:1400 7)]
>  t7xx_dpmaif_napi_rx_poll+0x590/0x800 [mtk_t7xx (HASH:1400 7)]
>  net_rx_action+0x103/0x470
>  irq_exit_rcu+0x13a/0x310
>  sysvec_apic_timer_interrupt+0x56/0x90
>  </IRQ>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: wwan: t7xx: Fix napi rx poll issue
    https://git.kernel.org/netdev/net/c/905fe0845bb2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



