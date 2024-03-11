Return-Path: <netdev+bounces-79270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15825878900
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 20:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C1A2816D4
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 19:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A579F55E72;
	Mon, 11 Mar 2024 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEn3l/E5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7916E5579F;
	Mon, 11 Mar 2024 19:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710185962; cv=none; b=EPwmJcdg0Mho97XCtQ00UzK46lF3kb2pyZ2N27Vm73UR8qEGPhmFaYoBhpwESYX3eOisisJikcn+pB2IGHJ+EgAbLwxxOaVLHhef8mzM0puIfz9oGcSUWdrDUZ95rpQhWqKD5hzWYGgP380MUrSPeM0quazKXDi/DaZhYJ5T9mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710185962; c=relaxed/simple;
	bh=RxFF2//vLuW1+4v7hEe9axSby27a7ZHrxc8sIlCocZk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hToFR3tizzgtT7Ap+REjuGE11OKfJoV0Ga41vFP8pdppuAf6X8Ket3cRkWxJhPOSu5RfPYGMQV1RWAlVJ6Zd4S99JJoimyPnVCg7DRBrRV2PsPyBvlBS31BAstXy2KGHEiGHXWhlkmFgb2TiQl5sjiM5NP24Gl7dEXrEOOhz1tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEn3l/E5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29E26C43601;
	Mon, 11 Mar 2024 19:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710185962;
	bh=RxFF2//vLuW1+4v7hEe9axSby27a7ZHrxc8sIlCocZk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MEn3l/E5kTFDtiG36YggELNTNkmcui+sOaC9uL1aKDHvJbSWZK1g5l4bo3MMdH2JD
	 w3BwfvBb/t6+9VIT2mlIoLH1A0ef8dCB/EW12WFF6dB0RpPzdLBI9EuR46WM6HtjHL
	 k9KUGHbxCAcrjEn/dNtaLBtWcMjkCIRD3QPl3o8Nl+DorfcZQsXgII74ZyUbmQGlVD
	 pBgNGeJ1WmRin4ZpU75uC3XBeLYnKuIrbLonzKuvgF6f2E1X53rheezcColrfdPUCY
	 xkkwT+XOe5H6bfp+rqucms4sAvIPPrYyQ0PSVsM5g+OPdCRSltIwOotEiuPKmjK1Ic
	 NU1LyWIqBLqWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05E76D9505A;
	Mon, 11 Mar 2024 19:39:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] annotate data-races around sysctl_tcp_wmem[0]
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171018596201.1144.18058014960608498774.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 19:39:22 +0000
References: <20240308112504.29099-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240308112504.29099-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: edumazet@google.com, dsahern@kernel.org, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, mptcp@lists.linux.dev, netdev@vger.kernel.org,
 kernelxing@tencent.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  8 Mar 2024 19:25:02 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Adding simple READ_ONCE() can avoid reading the sysctl knob meanwhile
> someone is trying to change it.
> 
> Jason Xing (2):
>   mptcp: annotate a data-race around sysctl_tcp_wmem[0]
>   tcp: annotate a data-race around sysctl_tcp_wmem[0]
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] mptcp: annotate a data-race around sysctl_tcp_wmem[0]
    https://git.kernel.org/netdev/net-next/c/9eb430d40e44
  - [net-next,2/2] tcp: annotate a data-race around sysctl_tcp_wmem[0]
    https://git.kernel.org/netdev/net-next/c/683a67da9561

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



