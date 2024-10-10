Return-Path: <netdev+bounces-134159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E11C6998362
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92CFC1F22F53
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0621BE864;
	Thu, 10 Oct 2024 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boS0Pb9M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979E01BE857;
	Thu, 10 Oct 2024 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728555626; cv=none; b=LLSs/+wuXQ81ySALzibKzDT5LiIwQX9YcWk4MXDqqgee9IS7jnbOW/GuBQMdNDePSQJ1+GSOG5ACZSPjxxCEfNwZAmA62R13X65hDIa9JcALlbSGx3K/SgPFbYdluDJi/ntmLW6An24gvAKcRTl6rih0lqXelzOvPCo1uWh3CDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728555626; c=relaxed/simple;
	bh=vmLa9cWj0DTxvO3cFR3xMZnKt8WhNEdEBVpdLPCArLA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=URUiKCA3DGphVQ4ZwUkP/VMAGLuzyIfP42XDTWayMmdGlWRTe9mPLMnatjWNH8VWiJMM6xkldwzRNXJEBQGIXvepkiMdF0c2xxcKOl5eAsm+kobH0+ZeQ+CQux9P2f0sLuviJXPIZdMpAak5rA7LFzg8WIw4kJpF9L0CiWeJkLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boS0Pb9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262BBC4CEC5;
	Thu, 10 Oct 2024 10:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728555626;
	bh=vmLa9cWj0DTxvO3cFR3xMZnKt8WhNEdEBVpdLPCArLA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=boS0Pb9Mr4m1o1AHvon2IWJ4sKR8dDnlsl5x7y0z4pVNZzssdzma4dXXxz2fS7Ooe
	 wOzHo1uJWUBWeWx4Ryvc6qYv/exAXCjhrtt421OcRjIoB3C3SYyPTww2xTsN5CZRMh
	 bZ+D/fHyf3Ohn7GhGS/Yak/yL49JJiafNdsFrN3vHljE0hCIck9/sz2ZU3/jExfDCl
	 pQSyBujOyHxV0fv1ty2m9c0u1ymmHH7mtSdm7H/MUHTmkvHFVAvI3IX8XjVZuUEJzk
	 T2Cj1lePN1PiSzqOPuU3l2QEShNhupfXnuZTXAsMVXJRXMCG+BPiJn+ZO5oeSF8eQp
	 I4ja9xqucXAXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2363803263;
	Thu, 10 Oct 2024 10:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Remove likely from
 l3mdev_master_ifindex_by_index
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172855563051.1965704.10127497741628036159.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 10:20:30 +0000
References: <20241008163205.3939629-1-leitao@debian.org>
In-Reply-To: <20241008163205.3939629-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kernel-team@meta.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  8 Oct 2024 09:32:04 -0700 you wrote:
> The likely() annotation in l3mdev_master_ifindex_by_index() has been
> found to be incorrect 100% of the time in real-world workloads (e.g.,
> web servers).
> 
> Annotated branches shows the following in these servers:
> 
> 	correct incorrect  %        Function                  File              Line
> 	      0 169053813 100 l3mdev_master_ifindex_by_index l3mdev.h             81
> 
> [...]

Here is the summary with links:
  - [net-next] net: Remove likely from l3mdev_master_ifindex_by_index
    https://git.kernel.org/netdev/net-next/c/9e542ff8b79a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



