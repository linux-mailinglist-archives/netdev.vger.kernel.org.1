Return-Path: <netdev+bounces-54266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD27806618
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 05:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BD4AB210D7
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B677F4E9;
	Wed,  6 Dec 2023 04:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UirVpZOe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F91FD2F0
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 04:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB8ACC433C7;
	Wed,  6 Dec 2023 04:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701836423;
	bh=M8X/zU2PLXgp9qIXpfrbukBhAlOSHPuVDtXrgSoU/cQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UirVpZOeubCPjqLg+SyoKwpin3r/ZIGsaseZzRC7jeC5Ub615a0D2dPiLSFUfbcmi
	 +fVoBd5taIyFDHmWpMdsyWYZVhDu8VgLwgdliTi2cHg4P2Y4tFzsnjC/K226cH+Aor
	 +Lacan3/u8UiEBackQLRNfVz7HkJFCtFasWumDixYLe1Uq8hVyRIgX0lX5ZljYh/tV
	 Bve1Y29cT1u+Q932A8QH2yVlUoh2aJJraClI6qVkdmj4Jy30rZMytCX7omyiZ+pVfR
	 SXVjyR3NbjoE7I4gc91pLLf25uZN/QWqsQGy+bleBu0BMXsITffmrEvnOtLNfGbgmw
	 5f5c0tLCNjzOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B018FC41671;
	Wed,  6 Dec 2023 04:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] tcp: fix mid stream window clamp.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170183642371.10645.3978834572556644900.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 04:20:23 +0000
References: <705dad54e6e6e9a010e571bf58e0b35a8ae70503.1701706073.git.pabeni@redhat.com>
In-Reply-To: <705dad54e6e6e9a010e571bf58e0b35a8ae70503.1701706073.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, ntspring@fb.com,
 david@gibson.dropbear.id.au, sbrivio@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 Dec 2023 17:08:05 +0100 you wrote:
> After the blamed commit below, if the user-space application performs
> window clamping when tp->rcv_wnd is 0, the TCP socket will never be
> able to announce a non 0 receive window, even after completely emptying
> the receive buffer and re-setting the window clamp to higher values.
> 
> Refactor tcp_set_window_clamp() to address the issue: when the user
> decreases the current clamp value, set rcv_ssthresh according to the
> same logic used at buffer initialization, but ensuring reserved mem
> provisioning.
> 
> [...]

Here is the summary with links:
  - [v2,net] tcp: fix mid stream window clamp.
    https://git.kernel.org/netdev/net/c/58d3aade20cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



