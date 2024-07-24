Return-Path: <netdev+bounces-112779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 555E593B28F
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 16:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49441F2191F
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 14:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB9B158D7F;
	Wed, 24 Jul 2024 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klSKhw7j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455FB1E877
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830832; cv=none; b=QFuWU3Y5fSHaXGZnXVQTRBRyOk2gKqRPAkWFhWIpjZv0BjZvTwaVQs/0Z3DKII3F2djmiQAe/5R3jgKxnO9zj48Vz8U1G7D6bX/19dKWxFnySb00JvExBEFMmZm3kt26k79g3x/akdi/tqq2W6hUtNZLTMA57SP2tXxYibf+Hyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830832; c=relaxed/simple;
	bh=xoU6yGBJO0F+R4D2MqvABJRZQ+4XGsV/J3BMUh74UbE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qxJq2lEhl9kIGPxxrEDG0QSv9o8DGSyywXDWVciI8V0ZnfHfjWVADi5Zy+9Jdp2mVQMJ0aHuoOv1r+26zREMODQbpLVukwZx0ycOTo9ZuVy4gfY7YhwAVo3u+KfD5T24Qjayp1mxyhxe4zpj0jcrNPAU3Cr4vXrPzv3c5+UcmB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klSKhw7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5471C32786;
	Wed, 24 Jul 2024 14:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721830832;
	bh=xoU6yGBJO0F+R4D2MqvABJRZQ+4XGsV/J3BMUh74UbE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=klSKhw7j7hdr1dmlvaxOkySmcawtbO13JC+v77IaNPiNycVdmaFu3diZbb4JLmcfx
	 DXR8MXqujY2lYaYh8GVpkIUuT9vGlT0Fjqp6ymxDV6Atzne3nWsgg204Cgyx4F394I
	 do05CDw655l6tfS42i82KADzpkk+90oDI/MK/K/NSTRLUNjh1ueQc5Gw4MguF4Fxhw
	 D/hIX2IwnD4PLhvguU7+6n3ziWBCTnqmkRq4QxaWxNj4gA4l4GhxuHU86py2BoPb/6
	 0o3kTKmC4PPZQvru7Kc4ZuLC65Ou/G0BjHY1UMQd0uTMiQIhU8nKDZcmeAApFg3MRW
	 bLUwom9VRIYUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1EC2C43619;
	Wed, 24 Jul 2024 14:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: nexthop: Initialize all fields in dumped nexthops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172183083185.11114.3597522848172663609.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jul 2024 14:20:31 +0000
References: <8b06dd4ec057d912ca3947bacf15529272dea796.1721749627.git.petrm@nvidia.com>
In-Reply-To: <8b06dd4ec057d912ca3947bacf15529272dea796.1721749627.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, dsahern@kernel.org,
 mlxsw@nvidia.com, idosch@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 23 Jul 2024 18:04:16 +0200 you wrote:
> struct nexthop_grp contains two reserved fields that are not initialized by
> nla_put_nh_group(), and carry garbage. This can be observed e.g. with
> strace (edited for clarity):
> 
>     # ip nexthop add id 1 dev lo
>     # ip nexthop add id 101 group 1
>     # strace -e recvmsg ip nexthop get id 101
>     ...
>     recvmsg(... [{nla_len=12, nla_type=NHA_GROUP},
>                  [{id=1, weight=0, resvd1=0x69, resvd2=0x67}]] ...) = 52
> 
> [...]

Here is the summary with links:
  - [net] net: nexthop: Initialize all fields in dumped nexthops
    https://git.kernel.org/netdev/net/c/6d745cd0e972

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



