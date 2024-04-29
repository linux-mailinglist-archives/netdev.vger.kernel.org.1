Return-Path: <netdev+bounces-92073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E968B548C
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 11:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B798B21106
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 09:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF06823778;
	Mon, 29 Apr 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfW1k0j2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF503D9E
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714384231; cv=none; b=itqz9ZHnP7dZ6d8lXwUACG20LNX3UU3eGOD38/uuXSvP2fQLkj9NHHkW7y5IDauNmn4/N8wCZzl8qTIXwYpxmsTlYMIdA68Z05DndMM+it6NNCAICtxiczJNlJW3RpNRgUGV0Biw3Vj7MZAH0/zAJgx/7uDXtA4Oz98mzn3qBDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714384231; c=relaxed/simple;
	bh=P3H3LuEAQrYhnPoqx6V1hG39zMtvVr72KrCDbWXwTLQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UEK6+IMCJR3x6gXcrRPM1mbuAgOSRRSDLqGYl8mGOEybBxBf/3QEftcplgDyQN4sQD9m0qKvyamuLg12ATN3dbAWJiFQmUwCwzDLRNXKqpXDLztuXp9CH+PMujq8DnE5RKmcLOuyHTMIuStI0xLE1SIzvDNnTYo5NEWZ1HdtSJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfW1k0j2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC5D0C113CD;
	Mon, 29 Apr 2024 09:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714384230;
	bh=P3H3LuEAQrYhnPoqx6V1hG39zMtvVr72KrCDbWXwTLQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KfW1k0j2JhDXs09+8smauJFRlkiZU2cDcwR4WWsha4Vleq0BVa12hIyXyBW7WXTTa
	 bz4h8Ds/E4CAr4x9lI3F4BIBWPFNHC38rJG7pe7qq98PoA+UkoCvT0w0f0x8Espcza
	 qZckEwTkRgZYik7DX2WUYr5mVjGbKlQsBV0UeIqCEop4cOYV2+S4q+kJsprNjp3+8Q
	 +Q9qacjVBblJeoJq2PryOO8pJN9AygYSVkfsxGXQT6DSnzWqFeCTct4OpwJSoXZQjV
	 jiFWuvZXN+Pn8hpZtrYtV2pqqXihg55iFErn5+gLQUMJ74bt+NhcpUg6hY+xTHjURC
	 V+Ny4aVDNxlNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0612C43619;
	Mon, 29 Apr 2024 09:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] mlxsw: Improve events processing performance
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171438423065.17054.9967031731622777238.git-patchwork-notify@kernel.org>
Date: Mon, 29 Apr 2024 09:50:30 +0000
References: <cover.1714134205.git.petrm@nvidia.com>
In-Reply-To: <cover.1714134205.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 amcohen@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 26 Apr 2024 14:42:21 +0200 you wrote:
> Amit Cohen writes:
> 
> Spectrum ASICs only support a single interrupt, it means that all the
> events are handled by one IRQ (interrupt request) handler.
> 
> Currently, we schedule a tasklet to handle events in EQ, then we also use
> tasklet for CQ, SDQ and RDQ. Tasklet runs in softIRQ (software IRQ)
> context, and will be run on the same CPU which scheduled it. It means that
> today we have one CPU which handles all the packets (both network packets
> and EMADs) from hardware.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] mlxsw: pci: Handle up to 64 Rx completions in tasklet
    https://git.kernel.org/netdev/net-next/c/e28d8aba4381
  - [net-next,2/5] mlxsw: pci: Ring RDQ and CQ doorbells once per several completions
    https://git.kernel.org/netdev/net-next/c/6b3d015cdb2a
  - [net-next,3/5] mlxsw: pci: Initialize dummy net devices for NAPI
    https://git.kernel.org/netdev/net-next/c/5d01ed2e9708
  - [net-next,4/5] mlxsw: pci: Reorganize 'mlxsw_pci_queue' structure
    https://git.kernel.org/netdev/net-next/c/c0d9267873bc
  - [net-next,5/5] mlxsw: pci: Use NAPI for event processing
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



