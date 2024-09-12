Return-Path: <netdev+bounces-127614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9E6975DDA
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566D11F231EE
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 00:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E1727448;
	Thu, 12 Sep 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9k55ivj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE1926ACC;
	Thu, 12 Sep 2024 00:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726099835; cv=none; b=YCmXrni84wv//9O57mSEzEhoED2jjnbrZypWfsBlX/aCHdelhGjSKBtAPrGn1guzMb+NXJpsHDSW+NiseQ/QkaX2AgukFBfPub6MaB32L82gTZKCWkZg6afxAe4lG9mY8IMGOg4f3lRE+Q77z2iCqUsf5G7ggNgopTZSXgit8Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726099835; c=relaxed/simple;
	bh=1PkcicRtJ2yph9ZFp4DEh0CdMcGUQWxsDsmLfvFfO5E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fb2sGjQ8ox/oEGbelIvkXF831kJe/rFQVMg8DWVQo9iVxIXlas1evz26JoPfCLbh4oRDQC5/mgKFg6eUnOFNB2AOhFE6v4dyUGnKc07aWZuoh08OXHSrLWhI3ntn36l2/rmtnQo7dtEZraYIXF4lgHYoFx1NV1WqsUDGmNuWi7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9k55ivj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB172C4CECC;
	Thu, 12 Sep 2024 00:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726099833;
	bh=1PkcicRtJ2yph9ZFp4DEh0CdMcGUQWxsDsmLfvFfO5E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a9k55ivjr8e+6bTTsLhhwmE6TxMC+9ZpM11mpOh1FEkn6JVGPWLJZwd6wgulXw4L5
	 InpGeqsaKEkA/wlclLTm6MCntv7/OdVzwtDE09deAb0XazNyVdps+a4ZywNb8qdJGY
	 hMwT8oSXIYkXmRgwB56RF5hHpOd+pucDCo68NqT4LITcQHUAtL/mJijkttk1cXDavw
	 7tOLz8Smk+pX9+7OOV/4bqZV/YmAti8NJ2sMZGbOLh4oOcOV0BGdTQ24SenEMxNg1x
	 zQ+fzhea6u+l8VYtelYYGlNZSWhV7MAKNrGvY3b7WC7OmLUqlZ1ln2PBkPvCLNQxpx
	 lw0rMVteWgyMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C7E3806656;
	Thu, 12 Sep 2024 00:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net-next] net: gianfar: fix NVMEM mac address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172609983475.1114191.546174782933434370.git-patchwork-notify@kernel.org>
Date: Thu, 12 Sep 2024 00:10:34 +0000
References: <20240910220913.14101-1-rosenp@gmail.com>
In-Reply-To: <20240910220913.14101-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, jacob.e.keller@intel.com, horms@kernel.org,
 sd@queasysnail.net, chunkeey@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Sep 2024 15:09:13 -0700 you wrote:
> If nvmem loads after the ethernet driver, mac address assignments will
> not take effect. of_get_ethdev_address returns EPROBE_DEFER in such a
> case so we need to handle that to avoid eth_hw_addr_random.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>  v2: use goto instead of return
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net-next] net: gianfar: fix NVMEM mac address
    https://git.kernel.org/netdev/net-next/c/b2d9544070d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



