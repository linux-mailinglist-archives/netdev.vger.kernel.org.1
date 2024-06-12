Return-Path: <netdev+bounces-102790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF8D904AFC
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 07:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6851F23363
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 05:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDABC36AF8;
	Wed, 12 Jun 2024 05:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0llf8ES"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBC179D8;
	Wed, 12 Jun 2024 05:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718170831; cv=none; b=JPvSCok8NBI4PFFVFBKYxB3SFpBDFe/O+VEHXGUSBVzqUgHvVJAjiOMZXpFyynORoFin78TJUt9JgP3EYJt9jT+z5EFuAxOWeteMysJ6BY2istkOSTE2OhikwalVfYmOiU1/LnjXUvqm8mAZHva/UflK7pDtDEvdmjr1ojAqxio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718170831; c=relaxed/simple;
	bh=z5DKGdkQHd6N4C5R0TvXcMTfbPbCS6uuyB3zQ/QDn24=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CMehYYXxZAWjVk4aZcyerRl9CWXWbbAtXo8q6gFmiYEuDrUGLIziRz9uNg7XXKEjqhjbp5cKpN9B9YEEEZap/UriqBGzp2Gqi5FP+2A0/Gpugff8uXm/mBEDnMqD6PPSgMrvWCrxZxhmA62C8Ir8B33hObXr2m11N0Uj3WghewA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0llf8ES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0509AC32786;
	Wed, 12 Jun 2024 05:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718170831;
	bh=z5DKGdkQHd6N4C5R0TvXcMTfbPbCS6uuyB3zQ/QDn24=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B0llf8ES9k8QfWvbjirSJ+bEiP2L0vVMIDIFZvmAUl70BL6OxphJJHQLaTcoFvAB0
	 zNypUlDZuPtNNhnCkbuVCLZJR9bFtejkFtMCGzt3iokIKxQ+3ML8QeZe0IBa2PXaUk
	 g1jNhG23NLUXo11ukTFqWXphaRYHMseC/NOZTH+8YmAnqX+euU7JL0gWZAx3dXAmjw
	 /Q+84ehJzLxGMJ8DlQyjRNYKO4him0tUKoXakwOPG1Pli3K6W30eE0hkFv2UTmVCxy
	 M6LflOjnt+ZIkFzNaW8D7aBA6clV0aVmOy5j2UZTooZoLugJ8Yy+4FRkMUdbUji4k0
	 hmTn0KWEqpRGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0465C54BB2;
	Wed, 12 Jun 2024 05:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/6] net/tcp: TCP-AO and TCP-MD5 tracepoints
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171817083091.28312.7398867679773366981.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 05:40:30 +0000
References: <20240607-tcp_ao-tracepoints-v4-0-88dc245c1f39@gmail.com>
In-Reply-To: <20240607-tcp_ao-tracepoints-v4-0-88dc245c1f39@gmail.com>
To: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, corbet@lwn.net,
 mnassiri@ciena.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, 0x7f454c46@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 07 Jun 2024 00:25:54 +0100 you wrote:
> Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
> ---
> Changes in v4:
> - Fix the build for CONFIG_TCP_MD5SIG=n (Matthieu Baerts, netdev dashboard)
> - Link to v3: https://lore.kernel.org/r/20240606-tcp_ao-tracepoints-v3-0-13621988c09f@gmail.com
> 
> Changes in v3:
> - Unexported tcp_inbound_ao_hash() and made static (Eric Dumazet)
> - Link to v2: https://lore.kernel.org/r/20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/6] net/tcp: Use static_branch_tcp_{md5,ao} to drop ifdefs
    https://git.kernel.org/netdev/net-next/c/3966a668bfee
  - [net-next,v4,2/6] net/tcp: Add a helper tcp_ao_hdr_maclen()
    https://git.kernel.org/netdev/net-next/c/72863087f635
  - [net-next,v4,3/6] net/tcp: Move tcp_inbound_hash() from headers
    https://git.kernel.org/netdev/net-next/c/811efc06e5f3
  - [net-next,v4,4/6] net/tcp: Add tcp-md5 and tcp-ao tracepoints
    https://git.kernel.org/netdev/net-next/c/96be3dcd013d
  - [net-next,v4,5/6] net/tcp: Remove tcp_hash_fail()
    https://git.kernel.org/netdev/net-next/c/78b1b27db91c
  - [net-next,v4,6/6] Documentation/tcp-ao: Add a few lines on tracepoints
    https://git.kernel.org/netdev/net-next/c/efe46fb18e78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



