Return-Path: <netdev+bounces-128024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD4D9777B5
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 06:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F924287324
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 04:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D631BF7F9;
	Fri, 13 Sep 2024 04:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgOE955W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389C52F34;
	Fri, 13 Sep 2024 04:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726200629; cv=none; b=e18d2N2bSjizhdmcR5cPuSAY/qVjTgJ+EumcEIdJwzTSb+S+WZarF5rZlu2VrpbPse4uDE25fUxTqnVsa+jvvYo0qfcfLjhhmu09oHDjTa6KQEhIu/0zyqAzJC62F0KnWcpmhjApQtoQ6KUEveBdhSggAmXgrgDfU0yjKGSvJDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726200629; c=relaxed/simple;
	bh=5vIHCYXtzn7UxwQSbmW8xK3PQ6Dn29GIwu2v6TdB7ws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B9IPg4RZOcJ/GisE20hul6nd+vC0sO1Xs0gAJVRafFxlP01tjnThy7yJ8Co4FgP5Su4wciMPNF3H364DpDfg1o7GpXoAbEVOIiOItl7dcu+XRWLuOKnopIdhj/PkKbOMFL94YnZ51GvNTKdpNXEVu/7TmwufIYh79/8rZ8gMJCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgOE955W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88E9C4CEC0;
	Fri, 13 Sep 2024 04:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726200628;
	bh=5vIHCYXtzn7UxwQSbmW8xK3PQ6Dn29GIwu2v6TdB7ws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MgOE955WRhcYj3BbUFC3HVrQJDSF2Yz7XBk8cCS4JRQ+plE8PrpyuVUbjguf/dcVA
	 vr2EtxJl+wbqxX1hq6OCFDRSp4D48ode766C9+nwHXo+V9bQISE294hoarTXioRgtp
	 EtoqW41/NMQr7Ttj0F677UHibNohHmMYG0cC7clY9XKtBd4sQYatumSmD7H1MvHR6N
	 kaCHVMpDu4lo8M5+X+UwJSXNiGES7t6pDsrr9mxtJHtyLW+2T+H5xlHIPppXTu7lYo
	 eeJ4Lk4xCaa9KZDKhU6+qwJIvdqS2pdlh++IZCXon0IHLT6+Fv18SerjRy9Jps/9ON
	 3JNtIOn5zKx8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E1D3806644;
	Fri, 13 Sep 2024 04:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] memory-provider: fix compilation issue without
 SYSFS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172620063003.1811461.5245926285155991709.git-patchwork-notify@kernel.org>
Date: Fri, 13 Sep 2024 04:10:30 +0000
References: <20240913032824.2117095-1-almasrymina@google.com>
In-Reply-To: <20240913032824.2117095-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, matttbe@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Sep 2024 03:28:24 +0000 you wrote:
> When CONFIG_SYSFS is not set, the kernel fails to compile:
> 
>      net/core/page_pool_user.c:368:45: error: implicit declaration of function 'get_netdev_rx_queue_index' [-Werror=implicit-function-declaration]
>       368 |                 if (pool->slow.queue_idx == get_netdev_rx_queue_index(rxq)) {
>           |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> When CONFIG_SYSFS is not set, get_netdev_rx_queue_index() is not defined
> as well.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] memory-provider: fix compilation issue without SYSFS
    https://git.kernel.org/netdev/net-next/c/52fa3b6532ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



