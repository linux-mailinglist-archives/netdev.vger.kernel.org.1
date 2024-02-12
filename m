Return-Path: <netdev+bounces-70913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E04E851035
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 11:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92E5DB23A38
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 10:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3509717C68;
	Mon, 12 Feb 2024 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYpE8Hpj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111A717C79
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707732025; cv=none; b=BesIIsIKeaRISDtAxTu+e5lCO5j6IWqu16WBhCSaFrWMSrcmFxVY/qMj3ySk2/NX5BaHn5Fpj6rfcUaNv1jMmmWvPDBrbQNR6yfqQQJelInWe1aQyULU+f2YrXDEVa1lnNLEC+4mf+f0BjfyvJyw7RGWS0vD8tAMebKpDL4gaxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707732025; c=relaxed/simple;
	bh=Yd3/YfGJDhcDaD0rLAhY2zv5y6iBNoVKBolnScGsQlo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=awm69F1/PG3jwuTBcw2Nlf1BLC0kC/FJbsAa2SaMWHh5GPXOnf/+B77AyBfMA5zQXooLfGgV0BTjwEZ429TsmdAj3j53Y58pW9X9pYbpk3txndzASi2dn7cn5+VXFDYlrxBmiTl4oWZVw6M5932WAEVNyPfm49OUmTv8cttJ4Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYpE8Hpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D734AC43390;
	Mon, 12 Feb 2024 10:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707732024;
	bh=Yd3/YfGJDhcDaD0rLAhY2zv5y6iBNoVKBolnScGsQlo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qYpE8HpjYu4Ycxx26v29kfEw2BSA/byuuloM0JpyYySB2JBgMoktU5L2pOMfDG5lx
	 CEPEHo7qD5RnqxK/G0nyloag7QTOZlq3ctSJZ+zdJ+3ATcGv2cpttBLAh5UPMbooE2
	 j7QdH+sEVsI8XFcVoaqIZwXVPL0SEP4VRB+ouJrV0mT0AczPS1JlSV1z1+mFNfK8fP
	 HT2IB1iHdM3YNB5VCxSirCCCstVSZk1B8oU1xo6/BtwjNzltlY0tYEfVE87OqLVHBs
	 BX73QDI1R0B0+fPibzDyVMFwIjI2B0989JDdPbQ7qVz9N7wES4f8SBkNASMv1PiZLQ
	 jB24Z2eTDwYBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA97ED84BC3;
	Mon, 12 Feb 2024 10:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] net: more three misplaced fields
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170773202476.29579.8998701444714982941.git-patchwork-notify@kernel.org>
Date: Mon, 12 Feb 2024 10:00:24 +0000
References: <20240208144323.1248887-1-edumazet@google.com>
In-Reply-To: <20240208144323.1248887-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, namangulati@google.com, lixiaoyan@google.com,
 weiwan@google.com, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  8 Feb 2024 14:43:20 +0000 you wrote:
> We recently reorganized some structures for better data locality
> in networking fast paths.
> 
> This series moves three fields that were not correctly classified.
> 
> There probably more to come.
> 
> [...]

Here is the summary with links:
  - [net,1/3] tcp: move tp->scaling_ratio to tcp_sock_read_txrx group
    https://git.kernel.org/netdev/net/c/119ff04864a2
  - [net,2/3] tcp: move tp->tcp_usec_ts to tcp_sock_read_txrx group
    https://git.kernel.org/netdev/net/c/666a877deab2
  - [net,3/3] net-device: move lstats in net_device_read_txrx
    https://git.kernel.org/netdev/net/c/c353c7b7ffb7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



