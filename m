Return-Path: <netdev+bounces-236948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC4AC4258C
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 04:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE1204E2166
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 03:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8E72D12F1;
	Sat,  8 Nov 2025 03:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiMXcRUM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C892D0C90
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 03:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762571444; cv=none; b=qDSsfmOPHqThrHOfqyqVeEWNMg5Ur+tOlnghbgBwxZjkHpO1QorKcb5RQMM35xCxETALnbI4+Vo4UUHuEJ7KnoR5qwHDA6f96vaDbi/HV8R/AVRQzYsZLppNNFr/tZdFz1kRl9RPnRi83n3VaczV84w0JZ5f2Aqbf5Jgf7XC0JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762571444; c=relaxed/simple;
	bh=RgT6fz4rsAsKpzGGcx6XZ4OZUggbuRVm2WqwFLKLzgI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kXlNbjjSi4UmBktkcxxHdk3tWKoGP1uqwjXT5SuUNpIRnjc0JbZCcYetPM7bxEwHH8IDEzz4vJfnhVzeP7G3DIPCB7V4eU3MY3wqA6VeQQxH3SuhutoXQfCfaFTLbDrPp0JSEDPh2DWRngV2qCIUR5cX0dEDK7/M6BIbKQipg84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiMXcRUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9FFC4CEF5;
	Sat,  8 Nov 2025 03:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762571443;
	bh=RgT6fz4rsAsKpzGGcx6XZ4OZUggbuRVm2WqwFLKLzgI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hiMXcRUMrsZa4dpQUMUkhFr69S20fQaqL1AhXgdCHcMhgcDmpCTcMWis5ed1yNgRF
	 2iU2u0fRtjfcTblwYGgHjDINgU+p6blBpvh/+pgJD9aCDBGspzIGCUtddfZbPQkAip
	 EK0s75oGK2xOsjlwIrGVzrAX/F7kqP3Vi2FOs+2hR4Sjtykm/ZNMpgImNhPAF5M/Ej
	 S1e+mBDupmsFEbtkHMxi5z9titmZSAAbiUeiE26JJGvWlcRKb0xSZ6stMzXegY7b0J
	 JhhwbBIkseRygsS4MxdJAnLfWM4K0/tU4IdJEXqjR4xidoosn+bGsYq0nu3zgLJuNN
	 VNlHW1s6mtPjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF043A40FCA;
	Sat,  8 Nov 2025 03:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: use skb_attempt_defer_free() in
 napi_consume_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176257141548.1234263.6312416246637557441.git-patchwork-notify@kernel.org>
Date: Sat, 08 Nov 2025 03:10:15 +0000
References: <20251106202935.1776179-1-edumazet@google.com>
In-Reply-To: <20251106202935.1776179-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Nov 2025 20:29:32 +0000 you wrote:
> There is a lack of NUMA awareness and more generally lack
> of slab caches affinity on TX completion path.
> 
> Modern drivers are using napi_consume_skb(), hoping to cache sk_buff
> in per-cpu caches so that they can be recycled in RX path.
> 
> Only use this if the skb was allocated on the same cpu,
> otherwise use skb_attempt_defer_free() so that the skb
> is freed on the original cpu.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: allow skb_release_head_state() to be called multiple times
    https://git.kernel.org/netdev/net-next/c/1fcf572211da
  - [net-next,2/3] net: fix napi_consume_skb() with alien skbs
    https://git.kernel.org/netdev/net-next/c/e20dfbad8aab
  - [net-next,3/3] net: increase skb_defer_max default to 128
    https://git.kernel.org/netdev/net-next/c/b61785852ed0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



