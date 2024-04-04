Return-Path: <netdev+bounces-84685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B134A897DBE
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 04:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07151C24013
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 02:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E702D7A8;
	Thu,  4 Apr 2024 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY+M4pcP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAE622EE4;
	Thu,  4 Apr 2024 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712197831; cv=none; b=lMidfqdPp7Jg5F1VCdn0zeebx5FK0YjcdoEMTJkJMKgFzWxPsxN4jx+AHr6T0el3jgxY1BHKg+jGPzJWbevXoHW5m7k/Xg8sqmXAgkPJmTxPCP3NwrAlvfiV1/u0y1PsWeJDDYr/WehZ9RY32nzgAugWlNMegrF1eNWmL1ek2KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712197831; c=relaxed/simple;
	bh=NOGCFUfoduMhXBNepIeFQKEbkMK3T2AAGEPJIWtjKCg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qCCgqi+g+OkhXFi9uow3eJtF9gJLuMNsCq3seoSpRoNGm/E12fFwEY+WAUFQXa3h+MLgSeLt0PwP+p9iDSPhKFwiLFDm2EWbN/Gdclgl4yCbs4R4QL+zrhvdjZmZdfHCAcf4QNPs01v4DyqHJOX5lJ3+8SXxcngvd8M1VETB75w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY+M4pcP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF758C43141;
	Thu,  4 Apr 2024 02:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712197831;
	bh=NOGCFUfoduMhXBNepIeFQKEbkMK3T2AAGEPJIWtjKCg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SY+M4pcPFW2CXEv0wuYaR8t+K4sqdo9z7HSP8ixAwl1bC2yLK5gugEg1H2t1YAYtJ
	 OYg2w6kH52DvqpGrxoiUKys42PmauGBrg+eAU9hd2ioJFMT4hyTZMTTeZXxLcPa46Y
	 EUQ5Fbe3LfRBznCZWI94gG3YuV62MFMeNrkj2D9CvbIlyhHs08AKJ2DCNUJwTDzeRx
	 1rye1lcgC5dWDRTl7r2hLqBUR494aG3dHY+jtYXZEvCFe5QRYG2zStevOfC4LcT+aJ
	 4f5BzTVekHtupgGBs/C3HS6Nv8CbKkhKkam30ctfufjcPpXG9tvXuwP5PzKT6BeMIF
	 vomu2K8J6mEQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E66AAD9A151;
	Thu,  4 Apr 2024 02:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] tcp: make trace of reset logic complete
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171219783094.25056.16795921330072816795.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 02:30:30 +0000
References: <20240401073605.37335-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240401073605.37335-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 rostedt@goodmis.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kernelxing@tencent.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Apr 2024 15:36:03 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Before this, we miss some cases where the TCP layer could send RST but
> we cannot trace it. So I decided to complete it :)
> 
> v4
> Link: https://lore.kernel.org/all/20240329034243.7929-1-kerneljasonxing@gmail.com/
> 1. rebased against latest net-next
> 2. remove {} and add skb test statement (Eric)
> 3. drop v3 patch [3/3] temporarily because 1) location is not that useful
> since we can use perf or something else to trace, 2) Eric said we could
> use drop_reason to show why we have to RST, which is good, but this seems
> not work well for those ->send_reset() logic. I need more time to
> investigate this part.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] trace: adjust TP_STORE_ADDR_PORTS_SKB() parameters
    https://git.kernel.org/netdev/net-next/c/9807080e2170
  - [net-next,v4,2/2] trace: tcp: fully support trace_tcp_send_reset
    https://git.kernel.org/netdev/net-next/c/19822a980e19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



