Return-Path: <netdev+bounces-231503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5414BF9AAB
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 04:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA5AD4F9F65
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 02:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0006F21A421;
	Wed, 22 Oct 2025 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psWWBkHO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC47C21771C;
	Wed, 22 Oct 2025 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761098427; cv=none; b=gaEPTRD2aJwf8yzatkD23eKvSgIdbEbW22BZzbc8lWV+hkF1Evp/8OUkwjzLwQzV4kn8MKinS+XPxnaD9P7CMoqgVzUpp5w3HsYgpm9MpWhVSeVQV/4fBE3NnXhTMmJWx5uRNUFehLeQ0BuwusbeYrD2mIVFOAVd/HGi2WoAcag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761098427; c=relaxed/simple;
	bh=v0O4fWziTO6/a681AJmwCA/4NN5ljtFphVVfNcPUhGU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rX/y/rFzlZoi+ogvHNl0noxSEIILfNykwOnnBYYw757yk28m5SS0beINobBbFtISKBVC69ZfqKkSQG6bmV7993qTCuVOxwsppdhG6vGHSND5WDmzAyjXUZGfqzYBrWTev7YXPDbhypNRQra3eJZlaUj15RleZK5dwIaLg82WGPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psWWBkHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDB1C4CEFD;
	Wed, 22 Oct 2025 02:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761098427;
	bh=v0O4fWziTO6/a681AJmwCA/4NN5ljtFphVVfNcPUhGU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=psWWBkHOO/d8io68ad/QYVBLr5a2TgCPCIO35Ge590bmE8w6a35wKZ2tbylSDcaIL
	 VUCTmW6zwFMvEpAo01MXwa9eJ/WMfFYYHtqGUAeLdjVUqH/XV2jwDLNgCsOTSXoEUE
	 Vr+/dmK6TEnmeuDsmQn9BdbnVAcSaUtM/AW+FauuUsTYriQKOdKhFEGeMerT3cDTI2
	 GC3Z2tN2kQAT1aqte3YRvdMaMBRijHcpsySme7OrGvk8lY0loJHrcA3f7Is3EO/enW
	 Rcd57x7c1imJKV8TExvBE1Tb63gfY5x8LEFwHMQEe0cvYobEspbRpA4daAGavYiq+L
	 ebyoDzckGcUww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3F03A55FAA;
	Wed, 22 Oct 2025 02:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: dlink: use dev_kfree_skb_any instead of
 dev_kfree_skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176109840874.1307287.10859562608584734988.git-patchwork-notify@kernel.org>
Date: Wed, 22 Oct 2025 02:00:08 +0000
References: <20251019075540.55697-1-yyyynoom@gmail.com>
In-Reply-To: <20251019075540.55697-1-yyyynoom@gmail.com>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 19 Oct 2025 16:55:40 +0900 you wrote:
> Replace `dev_kfree_skb()` with `dev_kfree_skb_any()` in `start_xmit()`
> which can be called from netpoll (hard IRQ) and from other contexts.
> 
> Also, `np->link_status` can be changed at any time by interrupt handler.
> 
>   <idle>-0       [011] dNh4.  4541.754603: start_xmit <-netpoll_start_xmit
>   <idle>-0       [011] dNh4.  4541.754622: <stack trace>
>  => [FTRACE TRAMPOLINE]
>  => start_xmit
>  => netpoll_start_xmit
>  => netpoll_send_skb
>  => write_msg
>  => console_flush_all
>  => console_unlock
>  => vprintk_emit
>  => _printk
>  => rio_interrupt
>  => __handle_irq_event_percpu
>  => handle_irq_event
>  => handle_fasteoi_irq
>  => __common_interrupt
>  => common_interrupt
>  => asm_common_interrupt
>  => mwait_idle
>  => default_idle_call
>  => do_idle
>  => cpu_startup_entry
>  => start_secondary
>  => common_startup_64
> 
> [...]

Here is the summary with links:
  - [net,v2] net: dlink: use dev_kfree_skb_any instead of dev_kfree_skb
    https://git.kernel.org/netdev/net/c/5523508258d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



