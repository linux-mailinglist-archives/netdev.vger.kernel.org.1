Return-Path: <netdev+bounces-78597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A73DF875D69
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 06:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36FCDB22B9F
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 05:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EC43BBCC;
	Fri,  8 Mar 2024 05:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XrQ3uRuG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10012EAE6
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709874038; cv=none; b=nlh4jxPskNdlqV8XURM96F9lh13o04NciTNIomEJeLCEPytGg6iiPgexrXXViFXYdn+ISPGSMhy7XvQF8I1cbW06a1UTeKQys5ngovHPSfDNPI13heZEygL+bIBt4aa3ejBtAXvbI4aManvDxIzk9N1jhvbHgrBVOpAZTqal2Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709874038; c=relaxed/simple;
	bh=G9HMGrLAaE31UmJzFZh/zPn++ccxlDN8gr1yRlfk97s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ElnWbEAYMJpv8eB4smYqr3D1GwD3bkRI6s8Xj4hRzE0b5Jlqcnnr/nZtNUXagtM+3t5YMtqYOLaV8EdZKvlxvHsjVjwrQt/2Tluxw6w7nm5rR/XZsd8RbhkJIj8PRVTvJhxr9cXYdE1zscSSdWxpaWkdS23mHTsIcknFzQtDOKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XrQ3uRuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9BB8C3277C;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709874037;
	bh=G9HMGrLAaE31UmJzFZh/zPn++ccxlDN8gr1yRlfk97s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XrQ3uRuGNkwhgwIvFfrxQ+4fCdbmNIlpvsyM/fVpWPmZj67nc+Qk56/4dVmJhxHjE
	 7lPyG5q6iZQsZHyaatsEQfjRQx2SXT6nOONSP/jFBFZn7QWKUMZcfGPG7tJbt+Ic1i
	 p+9ihp8uL1GPrITDUOLou8dcYxpNMian0MU3oFeT1Cmdwz9Z3hfESei40Y/yKST4qw
	 NUkbdKvofR64+NJPYvKqwVqjMc7A7coMokmECV8Q0XUOAqOA7GYFfG1x5GT2bwxUX+
	 AKXDEUtMYOjuCYLlH0ukw4HGdJJgOrUlEOFCGDnQTM2VkHRVVMKZTZco7Wwj+19cCN
	 utUKyR3AN5d4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A81FFD84BBF;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netlink: let core handle error cases in dump
 operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170987403768.8362.10923358472253703912.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 05:00:37 +0000
References: <20240306102426.245689-1-edumazet@google.com>
In-Reply-To: <20240306102426.245689-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Mar 2024 10:24:26 +0000 you wrote:
> After commit b5a899154aa9 ("netlink: handle EMSGSIZE errors
> in the core"), we can remove some code that was not 100 % correct
> anyway.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/core/rtnetlink.c    | 5 +----
>  net/ipv4/devinet.c      | 4 ----
>  net/ipv4/fib_frontend.c | 7 +------
>  net/ipv6/addrconf.c     | 7 +------
>  4 files changed, 3 insertions(+), 20 deletions(-)

Here is the summary with links:
  - [net-next] netlink: let core handle error cases in dump operations
    https://git.kernel.org/netdev/net-next/c/02e24903e5a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



