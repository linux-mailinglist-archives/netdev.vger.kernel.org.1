Return-Path: <netdev+bounces-88939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E418A90CE
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 03:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3870283A5C
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 01:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E04A3A1D3;
	Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkjwnnTZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CAB39FD4
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713404428; cv=none; b=ZFtqek7UQSleeMceO4VE3z8RSsPI1pin1GjtWepDi0m96P8oTwI2XQag2YnmpLMgQC+P13997XO7G79fmbfupL+YEzNUf7fZqaRRSp5xtCm5BoTB6mW8MLCuEU9HwCmQZpvit+TttqB9S6Mp0ZQgsrPtIfJqWNcX9LUXVcN34NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713404428; c=relaxed/simple;
	bh=fEnJg/VUpA7V49HH8AN+j3ZQGLtnu/hHhPCWSR+PWFY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=de67hP8wxCxTUn5GpuEaE6CCpIH6lrUZzMNA6dHvNqSDGxDqARg77XecebppwBs5P5OCjYtcM01DHRG/wmDO1bViC7CgjYqEBT5df72rHT6gBHpQVZ39SQWRr/Oy0mScu8c/0KjuVU4GabOnXA9pHhgNYl+S8eJDuSulCfifv7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkjwnnTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D2B7C32782;
	Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713404428;
	bh=fEnJg/VUpA7V49HH8AN+j3ZQGLtnu/hHhPCWSR+PWFY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KkjwnnTZLuSV5ophKQlBB9RcP+cbAuivVvOYBpctjjvpUaiB8ESu373s5mRv5fQST
	 po5YdQlpiDWaUcwxsCzqGydIFLKvEYOSqJcC+FgSJXcf3LHjCQyr6ddq6EsF84Cw/a
	 yvjbwaAcXHx8H3pOcWJA7aR7tDSp8eyf2O9P1/BM93oD+MRkTInYsRFMGSj1jFGk4E
	 bc7F+a9/A53KeuS+zjpsOZ5iwx41anJAYzLrvpv5RqjpWchbT1G22r2dcHiuwydYzA
	 kORZ6RGQ+wlX/Qe8tz1lo9WaXZAEUV0keyHlrlUWJHEU+ZUZeHBNioGEixIJQmW9UJ
	 FEzu+uYVEEPng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BEC5C43616;
	Thu, 18 Apr 2024 01:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp_metrics: fix tcp_metrics_nl_dump() return value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171340442803.27861.7738710930912966565.git-patchwork-notify@kernel.org>
Date: Thu, 18 Apr 2024 01:40:28 +0000
References: <20240416161112.1199265-1-edumazet@google.com>
In-Reply-To: <20240416161112.1199265-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Apr 2024 16:11:12 +0000 you wrote:
> Change tcp_metrics_nl_dump() to return 0 at the end
> of a dump so that NLMSG_DONE can be appended
> to the current skb, saving one recvmsg() system call.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/tcp_metrics.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] tcp_metrics: fix tcp_metrics_nl_dump() return value
    https://git.kernel.org/netdev/net-next/c/ade1c9cc404a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



