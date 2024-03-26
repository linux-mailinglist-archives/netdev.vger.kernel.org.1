Return-Path: <netdev+bounces-81975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 489B588BFE7
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9E71F63326
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 10:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4243746E;
	Tue, 26 Mar 2024 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxb16ArK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EC36139;
	Tue, 26 Mar 2024 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711450231; cv=none; b=hEzd2ztheQ0arJQLTkA3ecGwnHCnWu6kYEDMKGteSjIKNoxaXWHqWQ9DiwOqIZPUFUejStCPG4yFLFqqT3WzHjq+1uTM+ErF5LJXFKSFyRy3hz7XdEfTXTe7U+V4/zNMLyjEm5IpJvgDq5g/L4XJ7QadpxGr3wDPhp3iLCjKqTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711450231; c=relaxed/simple;
	bh=n5KohEPCq0GhrwtD0Eq9zR1JQFlf93My+mDTkF/qH/Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EQLVvC+SsG9GfV4IZ1QzubsWgjqSpz8GItTzE7tvRYLJkLfo+AHniNavwlfWJxmDmXyNSn91FOxHK21mwTIkUODHMloBrGpXboSEFegbJMqSjq8pcXcbaVr/4n1BF/tpw81m0vVmid+0k10bJoWg8pMSQ3z+e4kVypAKkfMpHw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxb16ArK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2279FC43390;
	Tue, 26 Mar 2024 10:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711450231;
	bh=n5KohEPCq0GhrwtD0Eq9zR1JQFlf93My+mDTkF/qH/Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oxb16ArKfmn/G1M1GzuCdsY1VJ/mnQDzdkXksRVuskGERE8zt3/o9vyQDeegb3S2U
	 unWNhm2WIv39Py/k+jKN7AcfFwT/Azj0IEZ090AlWMMGuIS/1iL3is9t/Y6nTcOVid
	 A6ga9MpgH6ZqEZvNjMYLyV6AG+tSi2IrHUKIDR4Sr+paipaTZo7eYvQ1PB1XU2cc4c
	 ItTxQcV3PT5vtZmRNhJxKkqvDS7RCVslowjLLtNPz0xi2JlZToC7daGU8dL7yuANM0
	 iIOsFA3E/c0E87h88Vza7tQlPSZDpbdbik80vOOcPfkR5s6FgcfNQypewijlZma8E7
	 78I80KfJvdoQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0DD9AD2D0EC;
	Tue, 26 Mar 2024 10:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] trace: use TP_STORE_ADDRS macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171145023104.5244.17207851427768482622.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 10:50:31 +0000
References: <20240325034347.19522-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240325034347.19522-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 rostedt@goodmis.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernelxing@tencent.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 25 Mar 2024 11:43:44 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Using the macro for other tracepoints use to be more concise.
> No functional change.
> 
> Jason Xing (3):
>   trace: move to TP_STORE_ADDRS related macro to net_probe_common.h
>   trace: use TP_STORE_ADDRS() macro in inet_sk_error_report()
>   trace: use TP_STORE_ADDRS() macro in inet_sock_set_state()
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] trace: move to TP_STORE_ADDRS related macro to net_probe_common.h
    https://git.kernel.org/netdev/net-next/c/b3af9045b482
  - [net-next,2/3] trace: use TP_STORE_ADDRS() macro in inet_sk_error_report()
    https://git.kernel.org/netdev/net-next/c/a24c855a5ef2
  - [net-next,3/3] trace: use TP_STORE_ADDRS() macro in inet_sock_set_state()
    https://git.kernel.org/netdev/net-next/c/646700ce23f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



