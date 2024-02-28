Return-Path: <netdev+bounces-75523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1878586A657
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 03:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81C4283423
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 02:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932E5442C;
	Wed, 28 Feb 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmkFQzS6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA271CF81
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709086231; cv=none; b=pyGLnniUNz7e31/n13WkvZo8FHMp38HriTfu1PXIPD5sSVqqYbU1EGxtyt2vVyOM6pugf5YmbY5Stg05NwQTMuDAv5o7jzmQfINqeZaa/xTXsHO55AoS5r+g8taCp+MExie9xeySXa1VgQZOU5PJ435pHJW6wK3pLem9pI5kz/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709086231; c=relaxed/simple;
	bh=0dieHDWLgbmCHOaOJlDgKsBUWc53+jRQCGWSZ3nll+s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SGgVsRxF0scQZLTURgSjnafgtVuQgXFNqN0mehRP07EZcb0RfTjJbuaX9LDjrwEWvVzIp4NTxOuFtGYb/5JVkGIk9g4ToUVAjAN0dUm2O43LFhbmMAM3aeHomnl+oZDe+Rxe30UeFo6hoDZe+23B7ZW5jqv9RCpDVyZLmHK5IM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmkFQzS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4B93C433C7;
	Wed, 28 Feb 2024 02:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709086230;
	bh=0dieHDWLgbmCHOaOJlDgKsBUWc53+jRQCGWSZ3nll+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lmkFQzS6n8eP8+XHhwRWBMGGWf2DiM6qq7bZ9ONzqB9D6eEiCdYpyRLkkXNIPYdHi
	 WXtD5SxpjjiixHbXiIeisJ0Qo2kMxireznvMJh3HyzcAWnm687zSdNOecE4PS7ATEx
	 6O7fSiea3m5QajNAhqBjON67aq9oDVVVMSLMMujg7+uCVGJl28Ru2zuCW0Q5/ansWH
	 XmyWjNuRCyCKNTaNxps12hvHnkf3ltTL5ECMT5Kh5hdlCeYJmeb1rzpYmNSjDavFic
	 rGOTSYrc3PGke9FFFSZdDQGtKdrnPXgMBFwPh5w1Yn2r730H395oVSsm/rGCBPL1Ga
	 S2IWAZYwBan3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0D2FD88FB0;
	Wed, 28 Feb 2024 02:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: raw: remove useless input parameter in
 rawv6_err
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170908623065.25524.13714200763658232141.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 02:10:30 +0000
References: <20240224084121.2479603-1-shaozhengchao@huawei.com>
In-Reply-To: <20240224084121.2479603-1-shaozhengchao@huawei.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 weiyongjun1@huawei.com, yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 Feb 2024 16:41:21 +0800 you wrote:
> The input parameter 'opt' in rawv6_err() is not used. Therefore, remove it.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  net/ipv6/raw.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] ipv6: raw: remove useless input parameter in rawv6_err
    https://git.kernel.org/netdev/net-next/c/d75fe63a0708

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



