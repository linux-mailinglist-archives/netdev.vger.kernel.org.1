Return-Path: <netdev+bounces-181467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97567A85184
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 04:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4138C4649
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 02:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D1779FE;
	Fri, 11 Apr 2025 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hr+NHtrL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3B327C850;
	Fri, 11 Apr 2025 02:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744337999; cv=none; b=M/vDsSmaYA/80NkZ3Zs6VkRoAkDo5VWDrOGuJsZRlGHJ/DU6AvO1+x2bH3S0dQgWnQMojOc+mcCLqonB3MB/nXba9Dba/8fDjl828WuSXAlKI2XMZnHQpb6V7Rfj6M8ir5jKiQi5Pq9Cpe7S7GoNOsgYsPZS54RD/Q89C6340L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744337999; c=relaxed/simple;
	bh=PsZLh4T13NB7qk/vGmaAx9AKvVBCdru8kTy1pzKLr2U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LHL4zF6HENAL+3lAkbtVXLBw4NTkkNf/3fSto1i0hULIMws3d5Zt5KIhrHfB8ShoTac0kZMMDLeB0ZkV1g4uvYR+74HaKNZv+QsOalmoHkloFX6Jyh8/Vzk55FGCUUKMELaCSP6RPE14LjySg87Dx463OglliGXqMy5xRqc2ahc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hr+NHtrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08E3C4CEE9;
	Fri, 11 Apr 2025 02:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744337998;
	bh=PsZLh4T13NB7qk/vGmaAx9AKvVBCdru8kTy1pzKLr2U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hr+NHtrLXQEUOcnBalO/VKwv/a4JAqm/GcRUo6YbO4WMTMs1QkZoRGIYmXqrKh/x0
	 3ZRZPT/xCURwJM7sjvQGkCBdSpyOS+R9wzjrmCQOlGpgiAfytUunjnuAjRctHsX4Q0
	 vIDX3T7UFEBiS7iNE4zAGC/EgERDV35/wYZmjqCD/rtk38Tjuk1DNdfkrotTwILLt7
	 AnY3F1radXjsckAF88L/THDKQYncpfURWo/ydtQkgeq4ND9H4z/FtWE/ZVbPWsKiEx
	 AyS4/Oftr1OB4yCgdhYPoe2UwSYhKq0n9WJ5H85bvVtH2NseNmBQjXvEiarTn+6/xe
	 y7KBKvBtyYa8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FA1380CEF4;
	Fri, 11 Apr 2025 02:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] tcp: add a new TW_PAWS drop reason
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174433803599.3928161.6673282068202917345.git-patchwork-notify@kernel.org>
Date: Fri, 11 Apr 2025 02:20:35 +0000
References: <20250409112614.16153-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250409112614.16153-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: kuba@kernel.org, edumazet@google.com, mrpre@163.com, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, ncardwell@google.com,
 kuniyu@amazon.com, dsahern@kernel.org, steffen.klassert@secunet.com,
 sd@queasysnail.net, antony.antony@secunet.com, chopps@labn.net,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Apr 2025 19:26:03 +0800 you wrote:
> Devices in the networking path, such as firewalls, NATs, or routers, which
> can perform SNAT or DNAT, use addresses from their own limited address
> pools to masquerade the source address during forwarding, causing PAWS
> verification to fail more easily under TW status.
> 
> Currently, packet loss statistics for PAWS can only be viewed through MIB,
> which is a global metric and cannot be precisely obtained through tracing
> to get the specific 4-tuple of the dropped packet. In the past, we had to
> use kprobe ret to retrieve relevant skb information from
> tcp_timewait_state_process().
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] tcp: add TCP_RFC7323_TW_PAWS drop reason
    https://git.kernel.org/netdev/net-next/c/04271411121a
  - [net-next,v4,2/2] tcp: add LINUX_MIB_PAWS_TW_REJECTED counter
    https://git.kernel.org/netdev/net-next/c/c449d5f3a3d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



