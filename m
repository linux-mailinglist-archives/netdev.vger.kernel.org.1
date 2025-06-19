Return-Path: <netdev+bounces-199402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F009AE0285
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8097E3B2EB7
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17382236F0;
	Thu, 19 Jun 2025 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0Na4gce"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1D02236EB
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750328379; cv=none; b=aXID6jxlxM9qU0IrbrT21goUv/EoUCwYa/tL1T2Pxew8vbUM5YZHj3XcrNtYOvWtVjxnS8LwfxBlk10+zTGvO04obt9p5aRV60nSUSubGm58EFdb6MOHR7gKXS6D4BXgO6Cv0du1g4yG+tQlgHt2hSEf+MbhR8iVRvlPTp1//l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750328379; c=relaxed/simple;
	bh=ZHFs1DNZJ7MegEL4vY6HVJ/GAoi/z934NysqJeGxZSQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l5poxucqhFB5tF1PVA9LKJo5nlYVBl2dV/5Wyp/4JOXCLgv/4sOXjA+orG9Zn7SCQyoTVwzROV0QAED8NVuu8mnieuJRaZxhJrvEXKOpXLUE+Q5Aiz9VZey1+2F9EfAc156fzbb4+JclMHfowT+g9QJIxeG1XWMFK+Ic5Vzhtjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0Na4gce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537AAC4CEEA;
	Thu, 19 Jun 2025 10:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750328378;
	bh=ZHFs1DNZJ7MegEL4vY6HVJ/GAoi/z934NysqJeGxZSQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h0Na4gce1a044SwveUjP9mGjralW3KWD3JNfZ54/S6X7V80Zt5MRoezT/XUEhlvzy
	 +aGr1xsOhFR0M8t0FT/1Bvi6xksvEbtek94YloUYz8UOx8B3P6J63O/+lDlKOOH+Nj
	 2/1bruZnCC8pOohL0IUS8oaSLYk6fxzzriKH+hq6SwlCulWdVTnbTHP/7OJTM0X2S/
	 P/XVdYDECZ5TZp/VVbmAzgsPLnMQzrd8bZMkCVwyQrBM/qMBfNAmSNw+WvtE5+M2mV
	 R7bt5Q5jaflD0IfgUK2QEUl1whicZELTEPD3nGhFw9ETLgt7rxARapleub88c5kQTN
	 IPj1Eu/lVj3TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2693806649;
	Thu, 19 Jun 2025 10:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: Simplify link-local address generation for
 IPv6 GRE.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175032840651.446896.1939844731953767667.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 10:20:06 +0000
References: 
 <a9144be9c7ec3cf09f25becae5e8fdf141fde9f6.1750075076.git.gnault@redhat.com>
In-Reply-To: 
 <a9144be9c7ec3cf09f25becae5e8fdf141fde9f6.1750075076.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, horms@kernel.org,
 dsahern@kernel.org, idosch@idosch.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 16 Jun 2025 13:58:29 +0200 you wrote:
> Since commit 3e6a0243ff00 ("gre: Fix again IPv6 link-local address
> generation."), addrconf_gre_config() has stopped handling IP6GRE
> devices specially and just calls the regular addrconf_addr_gen()
> function to create their link-local IPv6 addresses.
> 
> We can thus avoid using addrconf_gre_config() for IP6GRE devices and
> use the normal IPv6 initialisation path instead (that is, jump directly
> to addrconf_dev_config() in addrconf_init_auto_addrs()).
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: Simplify link-local address generation for IPv6 GRE.
    https://git.kernel.org/netdev/net-next/c/d3623dd5bd4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



