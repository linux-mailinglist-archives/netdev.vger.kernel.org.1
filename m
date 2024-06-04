Return-Path: <netdev+bounces-100485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 134F98FAE39
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DB91C20CD1
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 09:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A7B137778;
	Tue,  4 Jun 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LO91OopL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D13652
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491629; cv=none; b=KYThN5RIrzFhY1JkJw/JOPh41ge7+3tn9erg0X4RIoM6VyFsL2mtoa7BtOaVus0ictUIYIdp40h8cDc4jWCIY7mXNIcN1nM8Q5YPk9fj9tWxuoCNaCM0wO3dFjruo+YIMdSyTo4+M41kvqaQWdT7svsWlDfcHKTODGv7IJM2ps4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491629; c=relaxed/simple;
	bh=b8hAMV6DAs149s5kSMBZZVsY2ihfBJxGeXAEa40e+SA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TzQdpVjS765Jpn2f0/6y2Pv8zmSX1eW0SNTG+54z85wd521o5shYsp3aw/bWRA3bWt4COn9uO2AiEaxE/klVpmKWI89n/j6uus+oQYfzxGz9LHui2epHelHrNA+1Cn8VRAywOP0VedYNEl6qVAjT1w8GwhlVQ9V2kXGqmS3cRDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LO91OopL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76FF2C32782;
	Tue,  4 Jun 2024 09:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717491628;
	bh=b8hAMV6DAs149s5kSMBZZVsY2ihfBJxGeXAEa40e+SA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LO91OopLay657+evbImpnLeI41nBQGc9fW9w9l19JKWzXcH/QBS0QSyGka0k6EJI5
	 n4hoCUtm8d5IiS6JKt+VPqw3fpo1PY0ntviUoE9Br5eQ16+7w8Vuo9GjNGYwPfxl9c
	 RaXatFW8BX3XajKBvIaqg/09eYANZwema366k5Flv5mVPZ1ygbUXGBSkIqs3nAGTvq
	 cOxcWokoFcwPUuGai4bU4TpbivTlTxmOTxd333LUmW4Z/zlj1r8fAdxOKUaFUj8cEd
	 GvU2ic9/+Qgfm4mMLx1Gg1+wGMLhhCUGuUVjhB0XgMN+4sS9Ol1pDflWbsJH4BJuiJ
	 6lj51njpbwFLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66498DEFB90;
	Tue,  4 Jun 2024 09:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: count drops due to missing qdisc as
 dev->tx_drops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171749162841.1764.5078759869786870310.git-patchwork-notify@kernel.org>
Date: Tue, 04 Jun 2024 09:00:28 +0000
References: <20240529162527.3688979-1-kuba@kernel.org>
In-Reply-To: <20240529162527.3688979-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 29 May 2024 09:25:27 -0700 you wrote:
> Catching and debugging missing qdiscs is pretty tricky. When qdisc
> is deleted we replace it with a noop qdisc, which silently drops
> all the packets. Since the noop qdisc has a single static instance
> we can't count drops at the qdisc level. Count them as dev->tx_drops.
> 
>   ip netns add red
>   ip link add type veth peer netns red
>   ip            link set dev veth0 up
>   ip -netns red link set dev veth0 up
>   ip            a a dev veth0 10.0.0.1/24
>   ip -netns red a a dev veth0 10.0.0.2/24
>   ping -c 2 10.0.0.2
>   #  2 packets transmitted, 2 received, 0% packet loss, time 1031ms
>   ip -s link show dev veth0
>   #  TX:  bytes packets errors dropped carrier collsns
>   #        1314      17      0       0       0       0
> 
> [...]

Here is the summary with links:
  - [net-next] net: count drops due to missing qdisc as dev->tx_drops
    https://git.kernel.org/netdev/net-next/c/4fdb6b6063f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



