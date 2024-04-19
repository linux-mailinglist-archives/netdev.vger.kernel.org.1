Return-Path: <netdev+bounces-89604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F7D8AAD98
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 13:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93147282E9C
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 11:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE517F49A;
	Fri, 19 Apr 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrPGFiTN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF41F2E405
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713525628; cv=none; b=ifMKGC5aHQ3RneB8v/kHY+UQYQI1JB4f+tddnsG6aN4Z7tWB/wMmhTcjUyLYQd85rdma5YqygExXZY9Pt1Y/0VX9t9P/ZFxBsYaiR4PLN+7ecW1x6PKpOAXkX3rxXDyCVn2z7PPjeXcymiBEkhw58Xs5Op9UowsmUiPLMG3fDX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713525628; c=relaxed/simple;
	bh=8Z8gjdr+9AI51TWYWLm8E0WVY950GKWOrNkqWtOgZPw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ola6fzQWz1/7T9/8v9hNUrLZh5YnsbmYAhlnj72D+YUuBmM6+gkZkmgn+C+Q0GCKISTLeaSvB5HIkFYGIcWGThy0kHsqrJ51JeYR0uTAvruUX6DhD3ezVJ2uwOp1izHdRkIksl2BNWAv0mflRIONVK3+HTGhFkvhWxKm07FBNmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrPGFiTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 812D8C32781;
	Fri, 19 Apr 2024 11:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713525627;
	bh=8Z8gjdr+9AI51TWYWLm8E0WVY950GKWOrNkqWtOgZPw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VrPGFiTNmrtEY968/Gy5caeZkFloNfDxgtwtVInrLdar3qICCs7yx7i9RRpr26Orf
	 IE7f58ceKltP2eEE9G+AuBAmyruYzM2c9fABpDaErLnhZyionEBh8Fm+nDyN8BVOAK
	 ckI2EIDEqgHNXdRnz3G14L5nuro+Lju0JdOUgmO4UsQT5SVzRNcgz6biB6FPEPBa+9
	 5AWQjiSj6y/CTiEyaXLRDtX+Xo61BAYvTfnz5sTfXcdc2NFndezbQYAvo0AvAfy/zm
	 bpJx083lFErrmD23qiQov9T8Pvuz5d3lqD7vqCxVp2EO92hvqnYyQ0deEcjSO+foGn
	 npX/hVKP6CkXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73B27C43616;
	Fri, 19 Apr 2024 11:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: xrs700x: fix missing initialisation of
 ds->phylink_mac_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171352562747.832.14564154491372727994.git-patchwork-notify@kernel.org>
Date: Fri, 19 Apr 2024 11:20:27 +0000
References: <E1rxPMP-007f9I-Qq@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rxPMP-007f9I-Qq@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, george.mccollister@gmail.com,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 18 Apr 2024 11:51:21 +0100 you wrote:
> The kernel build bot identified the following mistake in the recently
> merged 860a9bed2651 ("net: dsa: xrs700x: provide own phylink MAC
> operations") patch:
> 
> drivers/net/dsa/xrs700x/xrs700x.c:714:37: warning: 'xrs700x_phylink_mac_ops' defined but not used [-Wunused-const-variable=]
>      714 | static const struct phylink_mac_ops xrs700x_phylink_mac_ops = {
>          |                                     ^~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: xrs700x: fix missing initialisation of ds->phylink_mac_ops
    https://git.kernel.org/netdev/net-next/c/9fc31a9251de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



