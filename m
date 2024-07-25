Return-Path: <netdev+bounces-113032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ADC93C640
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 17:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFEC11F21EDB
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 15:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C951219D089;
	Thu, 25 Jul 2024 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfgBCTKv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C6519D068;
	Thu, 25 Jul 2024 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721920750; cv=none; b=Snl/7LL/nJvygR+OXOFG+zaKDmAeAjP5J6hWGvmvGCOnwG+SerIeRCohh14LuI5ojidHq424pugNH0RzPW9mG/VkRhEQQTNLoW7+IwV7aUXMgvQnTvgcBZr2jy/+p8DS62RDs0PYoBDjpLI7fdeR4zdu3yLPcPrSnH39giNmTh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721920750; c=relaxed/simple;
	bh=lqJfRdonsEG8OP26FdvaqpluvyO5jM0D/S+FJgEgrzs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rhysX+uBXXgT+bj4836U5AR+uAZL0UhEdNREvo2WlqpwujmORK3CfaOAlPM7l4qZia3l+dXUXmANtOnTjXQccrFvfSvvWEwdcaej5d4HS16WuS/1rKl9c6Wu1khCwsdC5WBcvaF9LKEwXZrgE7XIF7tRqoV46xp1tvdWVe7g4sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfgBCTKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AD9FC4AF0B;
	Thu, 25 Jul 2024 15:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721920750;
	bh=lqJfRdonsEG8OP26FdvaqpluvyO5jM0D/S+FJgEgrzs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GfgBCTKvht5g7wYMn0igic+me7w0vwPjdZbIKOJ2uavC3DSwg/DCD7um6Lq57TUX/
	 5MAPqWFKxKpcOk60UAcVBek+ojYrcmRbKB7DyYBUEfe0DBvmglDrx7YcYeK8xVJgsB
	 CbT9HkTsaR1j11NoUHU8TpJXZG8kDNW3vtJJim4RtjFuk1ztsZq3nI+m950EkAKOd5
	 pTQ5M3Z3hKWvrAV9FKXHrTgu2BphcVV0i/wRjn7wYOMBFNWEqn9lFVf0iMX9bkkAZE
	 JlW/93gxa9543vMxYw5+2R1/t2Ht4RZo7BC8hrsFeTQeyRuk8LdKXITI3Vbj89UP+4
	 HZN9s6sB/f5lQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BDC4C43338;
	Thu, 25 Jul 2024 15:19:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-XXX] mISDN: Fix a use after free in hfcmulti_tx()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172192075024.10696.13020563710746306829.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jul 2024 15:19:10 +0000
References: <8be65f5a-c2dd-4ba0-8a10-bfe5980b8cfb@stanley.mountain>
In-Reply-To: <8be65f5a-c2dd-4ba0-8a10-bfe5980b8cfb@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: kkeil@suse.de, isdn@linux-pingi.de, quic_jjohnson@quicinc.com,
 kuba@kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jul 2024 11:08:18 -0500 you wrote:
> Don't dereference *sp after calling dev_kfree_skb(*sp).
> 
> Fixes: af69fb3a8ffa ("Add mISDN HFC multiport driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/isdn/hardware/mISDN/hfcmulti.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-XXX] mISDN: Fix a use after free in hfcmulti_tx()
    https://git.kernel.org/netdev/net/c/61ab751451f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



