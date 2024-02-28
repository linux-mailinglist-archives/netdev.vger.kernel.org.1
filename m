Return-Path: <netdev+bounces-75644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9999886AC63
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 11:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3521F22C66
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 10:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B151127B4B;
	Wed, 28 Feb 2024 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcTcAoAm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481C05A0E9
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709117434; cv=none; b=OXdjFSATsLbnhMUHZeEHE8Vn+ZT+c5zPY6sbDvEd+Dub2Yx2b7/a6qDYCOUf1TjvklTWNFXuVr/o88DWy3EoInwnBhmvzP21mPnPV4vUlz1AJWEdJMzRR47UlopMHNzihC0KeIofL3Lim+UgyVeiy5ds5XqhaC50wlxDKRfrMAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709117434; c=relaxed/simple;
	bh=f2hS6dwTPEXkS5+rF6yuPrl9v8otDBXWTW3zOQG+s+w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=liraoQM7hS1kZezYA7JsQq51TqZEJUcFNR+iMIgqjiVqdNriJ6MG2M/J+01sEhSY4juEzaVk82/3xKicix+LYbPyfYhl7+xtYlV1sZRyIBwt36WCToTWOK+6T872TTo7lJm7x/CercExab1Chl6mWqRFzoFYep+yYGjb4MeI3dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcTcAoAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1104C433F1;
	Wed, 28 Feb 2024 10:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709117433;
	bh=f2hS6dwTPEXkS5+rF6yuPrl9v8otDBXWTW3zOQG+s+w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HcTcAoAm6/fCYLHR+ROKWR5ZXftanBIARX6EhdyTBHGW49o6ybFQuBvKUfN5Y0sfQ
	 t+badYUsYRoYJcTpQ/vCUGJz9g+SSvLtyx5obr+hALVUMSyjbmD5/o15CbaThMK9J/
	 KF3UmyRCxQ2eOfpWE80soChN6ubrBj6+KYbJBZQajoT6Nap5Q2dOSj1Y+8Hav5a4Fi
	 XDOzn+m6Cs43T3LdheeGvilfOgqh2B4713m2P2MNnNQCCRkuUrhF4r8Dxgi3FO9KKQ
	 W4sTNYhJfG9A2so7g6++Gn8/zi5XHeSW6YqD78PdENdrcTzS8fXPbiabFkAopfn/jG
	 C4O6MKU5yzB6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B77A4D88FAF;
	Wed, 28 Feb 2024 10:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v10 00/10] introduce drop reasons for tcp receive
 path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170911743374.15474.6211464866179715497.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 10:50:33 +0000
References: <20240226032227.15255-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240226032227.15255-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, kuniyu@amazon.com,
 netdev@vger.kernel.org, kernelxing@tencent.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 26 Feb 2024 11:22:17 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> When I was debugging the reason about why the skb should be dropped in
> syn cookie mode, I found out that this NOT_SPECIFIED reason is too
> general. Thus I decided to refine it.
> 
> v10
> Link: https://lore.kernel.org/netdev/20240223193321.6549-1-kuniyu@amazon.com/
> 1. fix three nit problems (Kuniyuki)
> 2. add reviewed-by tag (Kuniyuki)
> 
> [...]

Here is the summary with links:
  - [net-next,v10,01/10] tcp: add a dropreason definitions and prepare for cookie check
    https://git.kernel.org/netdev/net-next/c/48e4704aedb9
  - [net-next,v10,02/10] tcp: directly drop skb in cookie check for ipv4
    https://git.kernel.org/netdev/net-next/c/65be4393f363
  - [net-next,v10,03/10] tcp: use drop reasons in cookie check for ipv4
    https://git.kernel.org/netdev/net-next/c/a4a69a3719ec
  - [net-next,v10,04/10] tcp: directly drop skb in cookie check for ipv6
    https://git.kernel.org/netdev/net-next/c/ed43e76cdcc4
  - [net-next,v10,05/10] tcp: use drop reasons in cookie check for ipv6
    https://git.kernel.org/netdev/net-next/c/253541a3c1e4
  - [net-next,v10,06/10] tcp: introduce dropreasons in receive path
    https://git.kernel.org/netdev/net-next/c/3d359faba191
  - [net-next,v10,07/10] tcp: add more specific possible drop reasons in tcp_rcv_synsent_state_process()
    https://git.kernel.org/netdev/net-next/c/e615e3a24ed6
  - [net-next,v10,08/10] tcp: add dropreasons in tcp_rcv_state_process()
    https://git.kernel.org/netdev/net-next/c/7d6ed9afde85
  - [net-next,v10,09/10] tcp: make the dropreason really work when calling tcp_rcv_state_process()
    https://git.kernel.org/netdev/net-next/c/b98256959305
  - [net-next,v10,10/10] tcp: make dropreason in tcp_child_process() work
    https://git.kernel.org/netdev/net-next/c/ee01defe25ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



