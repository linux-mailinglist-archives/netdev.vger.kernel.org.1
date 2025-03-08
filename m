Return-Path: <netdev+bounces-173144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41887A57817
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 04:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E393B659E
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 03:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3296C17A5A4;
	Sat,  8 Mar 2025 03:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNGImwl5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFF117A31C
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 03:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405805; cv=none; b=PO3Og88/5H4fs9sIK61oSXxcXi0Fb26m3RDJsBvQ9EJM2lqkib/HivPj7qSi8ALp0rYb9l9TR1pARKDismOKmHWR3sZ440ioQ8kij7MrPzoniYQ60IDE2bODMenrASH85gk55348G4Ypsds9n4ALiiTBf3+9AIqsR/q32RBWXL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405805; c=relaxed/simple;
	bh=6pX5wgcT8yxGzQhgd5SpYimdD5lIbz9rmfrxc1jnpTY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UtPu8KvD1hy26kLj5zCEhIPrzCFovVLbux0XbWGkO4xHOvZYuxpryKBGeDBK486fZV3Nvr3VVj04B7gxgFm5h1BPVDmO27DFhvLigg6FXorORKaM/hCoXLw0K64vvY69PVVZXAkKyijYqyy/vPnEWKepJNcezh4TB7UjH5odjvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNGImwl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C25C4CEE4;
	Sat,  8 Mar 2025 03:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405804;
	bh=6pX5wgcT8yxGzQhgd5SpYimdD5lIbz9rmfrxc1jnpTY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rNGImwl5TIHsxq3YMdg39BWEVoYcwsNU4kb/yk9FkiWVgpNFXWrxMpSE7HM0mV4Si
	 JZWi9tMSMDZoLAXtPG+La1yZbz1PfvxFrWmoUdY8P0wuoMIlhmebE8xpL9fOQlfm1t
	 Smj/GMm0gygpEp+73iIoHOz9sr+K54pKFtcF1y3IbWUtb1aPx/hs0nH89l2N9k4/BR
	 wlnzRnoF50/nevjqPMbICkm/fzonKROk4bICeIXDKCu/NJHpMrR0tFjWyVUtrn7BMo
	 GaiSli+H2pwlKv5A8uuLhfYi8rDlPazCkMwwN5OvvQvhRvDN8/TJ+LvKiK8MOh9es7
	 yb7GS6EoSscUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCC2380CFFB;
	Sat,  8 Mar 2025 03:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mctp i3c: Copy headers if cloned
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140583824.2568613.9874744418079754263.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 03:50:38 +0000
References: <20250306-matt-i3c-cow-head-v1-1-d5e6a5495227@codeconstruct.com.au>
In-Reply-To: <20250306-matt-i3c-cow-head-v1-1-d5e6a5495227@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: jk@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 06 Mar 2025 18:24:18 +0800 you wrote:
> Use skb_cow_head() prior to modifying the tx skb. This is necessary
> when the skb has been cloned, to avoid modifying other shared clones.
> 
> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
> Fixes: c8755b29b58e ("mctp i3c: MCTP I3C driver")
> ---
>  drivers/net/mctp/mctp-i3c.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> [...]

Here is the summary with links:
  - [net] net: mctp i3c: Copy headers if cloned
    https://git.kernel.org/netdev/net/c/26db9c9ee19c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



