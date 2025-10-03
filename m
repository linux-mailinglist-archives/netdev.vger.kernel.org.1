Return-Path: <netdev+bounces-227812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2DABB7D29
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 20:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 222A64EE06C
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 18:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B604A2DF136;
	Fri,  3 Oct 2025 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBs3pbsJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B592DF12B
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514423; cv=none; b=R1Sdu1SKR7MREJQYodnrNIJslA9Fd5FI3xS1iItqfnDBUKODUhYG9bOqjFGYfqKfr32LW3iX89rre6RZ45FSMqiG3OceHnehIxrAsbDXa+ifXXriuT4jrm8ZpUK0Xpruu6ehYC3zeCo8qejgJotuc5M4B9N6+xf0WmFytt3QJig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514423; c=relaxed/simple;
	bh=3dx5eI4il0St06QxrDb++DjweIwiK2sKsQ4gHUBCMIo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pEaQCOzUbu3IMPaulssaBD0wKbNKPvThfKs912xL38CzV+VgOhaoUqJ3IbeIMlFtBvB21lWQS5aGRA3EXQ7Df6U+OIWf1jdrGv/XfKFkBsSKal/klCO2sJvPRrI1hpkIULCYtiLn4SIlcwj2PQl53gcP/GbbBxLTokb6jHRZeNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBs3pbsJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4ACC4CEF5;
	Fri,  3 Oct 2025 18:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759514423;
	bh=3dx5eI4il0St06QxrDb++DjweIwiK2sKsQ4gHUBCMIo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oBs3pbsJ6m7fXwO0h3WKAnL4IpPvR2oFO9qebybDD5H48WG6xhRgMr7s93OprD8g7
	 UoC/TeBz4ssJgS3mHTfjvoOg7xUrn4tRpPb8yvTQPbl4jzEkvVtZF4ijYrbKlS49/c
	 LXy+GTdEk3SlrENI63wkWDZ+dxQathYm2BuTIazRItkdKBWwJNh7atwRc+JptkQGlQ
	 De778qUxnLBEe+5/s0ME+vXzJXwkhrXw9i079MnJlE7UUWXlwAGFYydHGj2qj1tGEO
	 taItaXpgTiwRpkF1hiX6rd4UgZMP1MAEUAl4kUb4l1lDih9zE6lujGW7sNmVWmTxvM
	 n73neQgG1DqIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCBF39D0C1A;
	Fri,  3 Oct 2025 18:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: psp: don't assume reply skbs will have a
 socket
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175951441449.20895.2740639730759580288.git-patchwork-notify@kernel.org>
Date: Fri, 03 Oct 2025 18:00:14 +0000
References: <20251001022426.2592750-1-kuba@kernel.org>
In-Reply-To: <20251001022426.2592750-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, daniel.zahka@gmail.com,
 willemb@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Sep 2025 19:24:26 -0700 you wrote:
> Rx path may be passing around unreferenced sockets, which means
> that skb_set_owner_edemux() may not set skb->sk and PSP will crash:
> 
>   KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
>   RIP: 0010:psp_reply_set_decrypted (./include/net/psp/functions.h:132 net/psp/psp_sock.c:287)
>     tcp_v6_send_response.constprop.0 (net/ipv6/tcp_ipv6.c:979)
>     tcp_v6_send_reset (net/ipv6/tcp_ipv6.c:1140 (discriminator 1))
>     tcp_v6_do_rcv (net/ipv6/tcp_ipv6.c:1683)
>     tcp_v6_rcv (net/ipv6/tcp_ipv6.c:1912)
> 
> [...]

Here is the summary with links:
  - [net-next] net: psp: don't assume reply skbs will have a socket
    https://git.kernel.org/netdev/net/c/7a0f94361ffd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



