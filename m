Return-Path: <netdev+bounces-194346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C721AC8CCE
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 13:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE231C00721
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 11:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DEF22D4C5;
	Fri, 30 May 2025 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwnaEq0C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEABA22CBFA
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603995; cv=none; b=c0InkZtORXkJB+m1SYyw4LqMo6D2pQ7x+1/kXqDIjcmgKDLTJA2R1/DeYZGxwUVSPOOjFLUDNT3Rf1+fSuQQ4ZivcFYr+LyWUDUqmQOXRpYssnM3/mOf77see58JKYvj8jh2SVSO8+zvtI7qkMCgIX6DJTBZk3EXSEa6V2XSfjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603995; c=relaxed/simple;
	bh=x7f95YtyZEYmjhWLyE+KnGIvzMemSq8uBVk2hA01wjM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tNW8RHbBgbDPBU/FzSPl9dDiI7HBe3l8JPpzp7Ro+uub67+Nv0GdhaXnn+yJHZQGvL8xMCc5XHZM6coRxumUPUsdd0zFpOr1WAaPnzQGTEohs/x4G9BJELDbNYi6ma365BPRXkQO7WvTXYpcA5Qq9s8eVaSG/xJbIDUXb6/oyu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwnaEq0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D09C4CEF6;
	Fri, 30 May 2025 11:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748603994;
	bh=x7f95YtyZEYmjhWLyE+KnGIvzMemSq8uBVk2hA01wjM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EwnaEq0CmOPrVwM/Eu2xEL2cZ99mLRYWNAm066rzAWQhdIKQTFKJYx53CX6btcljr
	 e4SJi1vRb5Sd31LaE63iYBI3lZ7acXx+25MQEGXqyjzwML3ZxmE/M0awQgpkCE36BN
	 udFzhj+9W7Kae1/eqyiYeC/y6GejpAcQif230I1hZo3AlUAQgjZckw1q7UfpilP+WQ
	 v+n7dh7eW5Xay4YlHaVQmVoR/fnqdty/LYnU0VchzXdMHhb3DA2dGQsW+5VRG3JQEO
	 Fr3nsOrhNuobqoF0jXq83Iju5RZFOJL2FsdOIlVx1SPSrochmzELCEPqoth26SpLn3
	 6HoNx+bde6Cmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB04B39F1DF1;
	Fri, 30 May 2025 11:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: aqc111: debug info before sanitation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174860402775.3921812.15582215660588005007.git-patchwork-notify@kernel.org>
Date: Fri, 30 May 2025 11:20:27 +0000
References: <20250528110419.1017471-1-oneukum@suse.com>
In-Reply-To: <20250528110419.1017471-1-oneukum@suse.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: netdev@vger.kernel.org, n.zhandarovich@fintech.ru, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 28 May 2025 13:03:54 +0200 you wrote:
> If we sanitize error returns, the debug statements need
> to come before that so that we don't lose information.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> Fixes: 405b0d610745 ("net: usb: aqc111: fix error handling of usbnet read calls")
> ---
>  drivers/net/usb/aqc111.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - net: usb: aqc111: debug info before sanitation
    https://git.kernel.org/netdev/net/c/d3faab9b5a6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



