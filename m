Return-Path: <netdev+bounces-199624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8613EAE0FF4
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 01:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBB44A29AD
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 23:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7A928DF0F;
	Thu, 19 Jun 2025 23:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYwjyQVa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFAD225797
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 23:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750375197; cv=none; b=SSPQYoa4J+f/5jMZE+AVUpbwDW2ad9rWY287PYXxuRwvIZYOHx5bkZAq/PqIVYZt31DvNhMFu/fgbD3fi/s3l7d3jJwHsB//EW3BRu44M14FEMQPm7HktM9TvXe1/Va6cxdSOzou3bsBPyl25Uc7mn/ZerzE8UtsNBvUZhsJ7HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750375197; c=relaxed/simple;
	bh=crbSgwAxruSL33sCUTYg7CFLR8H0mDnh/ClFnN3Pn8E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g5f9iwnfvpHr9WIL9Ug6VT1WuCq4RD6fAc8lwcgqImpqfTsUUhN3vG08+OrFee0W04fm1wj5p7GlZp1wV7fgk/HJRrWNvVXEfQC605bXjYksYZB/hkGDNPI8OLJEUYSHszHgK0ouTNkg7ZAeyltYfm1Oei8StR1jJMgL0EqCBU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYwjyQVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE4BC4CEEA;
	Thu, 19 Jun 2025 23:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750375196;
	bh=crbSgwAxruSL33sCUTYg7CFLR8H0mDnh/ClFnN3Pn8E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JYwjyQValxbWM7Z34eFOAfG3IH4tbWwt1MGuTm5tDU8xcXJ81cB0ZEvy1mkhuBPpw
	 lHqvB2PaZ5kvFJBNzm6eJxrQXn3n84sL9qmeD2HXkSxWTRbOyuMsqYhwreaTf7qqKt
	 f6nNxC4JxgledCY854/pdgzeq6gMv+4P+vYScV0WpnwBRgKEckTNc45vM0rxWC2S+t
	 BMtkhQ7yEgRsMdrSM+Z6Q4MpeG34yHAK+Mv4XxHGSZW8SDZoa6l6rbJQa5sYbkTE9G
	 QYGxj+Q0ub+f6inj9SLM3XcVsrVCglknCF4sDAAdonWIM7WER6AlJlHm89bUCWp/xB
	 hzG1L8ZMugO6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD7338111DD;
	Thu, 19 Jun 2025 23:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] neighbour: add support for NUD_PERMANENT
 proxy
 entries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175037522424.1016629.372655192167116510.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 23:20:24 +0000
References: <20250617141334.3724863-1-nico.escande@gmail.com>
In-Reply-To: <20250617141334.3724863-1-nico.escande@gmail.com>
To: Nicolas Escande <nico.escande@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 decot+git@google.com, kuniyu@google.com, gnaaman@drivenets.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Jun 2025 16:13:34 +0200 you wrote:
> As discussesd before in [0] proxy entries (which are more configuration
> than runtime data) should stay when the link (carrier) goes does down.
> This is what happens for regular neighbour entries.
> 
> So lets fix this by:
>   - storing in proxy entries the fact that it was added as NUD_PERMANENT
>   - not removing NUD_PERMANENT proxy entries when the carrier goes down
>     (same as how it's done in neigh_flush_dev() for regular neigh entries)
> 
> [...]

Here is the summary with links:
  - [net-next,v2] neighbour: add support for NUD_PERMANENT proxy entries
    https://git.kernel.org/netdev/net-next/c/c7d78566bbd3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



