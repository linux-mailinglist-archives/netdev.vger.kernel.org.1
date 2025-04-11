Return-Path: <netdev+bounces-181466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F09A85182
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 04:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D511B60D0D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 02:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D900E27C15D;
	Fri, 11 Apr 2025 02:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akrZyh+b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD4127C150;
	Fri, 11 Apr 2025 02:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744337997; cv=none; b=Qq4pYFghppwrH+Z8a8W7yWF24sxYSkiEL0/l7Wsz6aRLKI/zpxwa8bB2EGiwPIrYx6KtVCBZPuNXYNmF7dbhT9du8J7Q/hcdxitlGQCOu87p2o9CHO5MA97eCzYUVYPfwRLvrZMmdK1FD0Zi+xPOVK4lZ2ZltDaq6T0m/gCzgpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744337997; c=relaxed/simple;
	bh=MaDBQUJ39NJ3k0g1HOnImqpof9YtKoiA/SAsdnLXRQ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bLPC+1xx9a3Zc2yG9Y6/2GGjXexZB3PptrjQJiVu6afx01hhwpgKEoMuXQ3Iu/tocb/QXqmmD4EGpud5S2VDMe4b3L09wwLo0ajImnSA1hm93DiCgW2OzJXf5og0RWtW1rc+CdkruvKerZ73UGUOsGPngtryd5SFqbpAa8Iia8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akrZyh+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25578C4CEDD;
	Fri, 11 Apr 2025 02:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744337997;
	bh=MaDBQUJ39NJ3k0g1HOnImqpof9YtKoiA/SAsdnLXRQ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=akrZyh+blouXJ7qAYcQoXUORDUY+I+R8IhitJ6exphecLPy/ydZF7iwmee5NedCtt
	 ODIaiQyzwI/mXoTB4emlg1b2SnE5xqTVMvyYtjqpj9vwhZdJ8e1i36I7IgYUsSpbzj
	 grWELFJ+eXPyMwmTk1rVMKExRUuJ1x673+9Z2yHaUXp0xqYaA6Oi7hlFJhFG2Wj9T8
	 kg46fy8zH3s4FE3/NZCY4H5ewrXCpIDlmgNZ9aeVZJfHosLocsEfF1wCmDzcp9ewGi
	 SdjKlmha0KllCWGzTvsABeB+KGrwXVtV6IRQAc+JzIsxxodqtCoa2A/QJaCBp2u2kL
	 JImEUGUZqQopQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0D5380CEF4;
	Fri, 11 Apr 2025 02:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] trace: add tracepoint for
 tcp_sendmsg_locked()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174433803449.3928161.5782548272969070176.git-patchwork-notify@kernel.org>
Date: Fri, 11 Apr 2025 02:20:34 +0000
References: <20250408-tcpsendmsg-v3-0-208b87064c28@debian.org>
In-Reply-To: <20250408-tcpsendmsg-v3-0-208b87064c28@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: dsahern@kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@amazon.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, song@kernel.org,
 yonghong.song@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernel-team@meta.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 08 Apr 2025 11:32:00 -0700 you wrote:
> Meta has been using BPF programs to monitor tcp_sendmsg() for years,
> indicating significant interest in observing this important
> functionality. Adding a proper tracepoint provides a stable API for all
> users who need visibility into TCP message transmission.
> 
> David Ahern is using a similar functionality with a custom patch[1]. So,
> this means we have more than a single use case for this request, and it
> might be a good idea to have such feature upstream.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: pass const to msg_data_left()
    https://git.kernel.org/netdev/net-next/c/b1e904999542
  - [net-next,v3,2/2] trace: tcp: Add tracepoint for tcp_sendmsg_locked()
    https://git.kernel.org/netdev/net-next/c/0f08335ade71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



